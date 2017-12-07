Received: from eggs.gnu.org ([2001:4830:134:3::10]:51460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN405-00045Q-C3
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN403-0006UT-VP
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:37 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:41102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN403-0006Sp-OB
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:35 -0500
Received: by mail-pf0-x243.google.com with SMTP id j28so5666700pfk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:35 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:14 -0600
Message-Id: <1512683181-8420-8-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 07/14] i2c:pm_smbus: Add the ability to force
 block transfer enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

The PIIX4 hardware has block transfer buffer always enabled in
the hardware, but the i801 does not.  Add a parameter to pm_smbus_init
to force on the block transfer so the PIIX4 handler can enable this
by default, as it was disabled by default before.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/piix4.c           | 2 +-
 hw/i2c/pm_smbus.c         | 5 ++++-
 hw/i2c/smbus_ich9.c       | 2 +-
 hw/isa/vt82c686.c         | 2 +-
 include/hw/i2c/pm_smbus.h | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 18c1ffa..7018235 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -514,7 +514,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
     pci_conf[0x90] = s->smb_io_base | 1;
     pci_conf[0x91] = s->smb_io_base >> 8;
     pci_conf[0xd2] = 0x09;
-    pm_smbus_init(DEVICE(dev), &s->smb);
+    pm_smbus_init(DEVICE(dev), &s->smb, true);
     memory_region_set_enabled(&s->smb.io, pci_conf[0xd2] & 1);
     memory_region_add_subregion(pci_address_space_io(dev),
                                 s->smb_io_base, &s->smb.io);
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 2fb00d0..2afc5e1 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -401,11 +401,14 @@ const VMStateDescription pmsmb_vmstate = {
     }
 };
 
-void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
+void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk)
 {
     smb->op_done = true;
     smb->reset = pm_smbus_reset;
     smb->smbus = i2c_init_bus(parent, "i2c");
+    if (force_aux_blk) {
+        smb->smb_auxctl |= AUX_BLK;
+    }
     memory_region_init_io(&smb->io, OBJECT(parent), &pm_smbus_ops, smb,
                           "pm-smbus", 64);
 }
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index d029816..ce5ea9e 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -89,7 +89,7 @@ static void ich9_smbus_realize(PCIDevice *d, Error **errp)
     pci_set_byte(d->config + ICH9_SMB_HOSTC, 0);
     /* TODO bar0, bar1: 64bit BAR support*/
 
-    pm_smbus_init(&d->qdev, &s->smb);
+    pm_smbus_init(&d->qdev, &s->smb, false);
     pci_register_bar(d, ICH9_SMB_SMB_BASE_BAR, PCI_BASE_ADDRESS_SPACE_IO,
                      &s->smb.io);
 }
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index c129985..78b7468 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -370,7 +370,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error **errp)
     pci_conf[0x90] = s->smb_io_base | 1;
     pci_conf[0x91] = s->smb_io_base >> 8;
     pci_conf[0xd2] = 0x90;
-    pm_smbus_init(&s->dev.qdev, &s->smb);
+    pm_smbus_init(&s->dev.qdev, &s->smb, false);
     memory_region_add_subregion(get_system_io(), s->smb_io_base, &s->smb.io);
 
     apm_init(dev, &s->apm, NULL, s);
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index cfe596f..471345e 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -33,7 +33,7 @@ typedef struct PMSMBus {
     bool op_done;
 } PMSMBus;
 
-void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
+void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
 
 extern const VMStateDescription pmsmb_vmstate;
 
-- 
2.7.4
