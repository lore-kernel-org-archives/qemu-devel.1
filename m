Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA56-0002a6-Vh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007Cn-D6
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:31 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4n-00078P-Jl
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wm0-x243.google.com with SMTP id t25-v6so3485128wmi.3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:40 +0200
Message-Id: <1534870966-9287-69-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 68/74] i2c: pm_smbus: Add the ability to force
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

The PIIX4 hardware has block transfer buffer always enabled in
the hardware, but the i801 does not.  Add a parameter to pm_smbus_init
to force on the block transfer so the PIIX4 handler can enable this
by default, as it was disabled by default before.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1534796770-10295-9-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/piix4.c           | 2 +-
 hw/i2c/pm_smbus.c         | 5 ++++-
 hw/i2c/smbus_ich9.c       | 2 +-
 hw/isa/vt82c686.c         | 2 +-
 include/hw/i2c/pm_smbus.h | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6404af5..e330f24 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -512,7 +512,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
     pci_conf[0x90] = s->smb_io_base | 1;
     pci_conf[0x91] = s->smb_io_base >> 8;
     pci_conf[0xd2] = 0x09;
-    pm_smbus_init(DEVICE(dev), &s->smb);
+    pm_smbus_init(DEVICE(dev), &s->smb, true);
     memory_region_set_enabled(&s->smb.io, pci_conf[0xd2] & 1);
     memory_region_add_subregion(pci_address_space_io(dev),
                                 s->smb_io_base, &s->smb.io);
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 91ee444..685a237 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -402,11 +402,14 @@ static const MemoryRegionOps pm_smbus_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
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
index 522a703..2a8b49e 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -86,7 +86,7 @@ static void ich9_smbus_realize(PCIDevice *d, Error **errp)
     pci_set_byte(d->config + ICH9_SMB_HOSTC, 0);
     /* TODO bar0, bar1: 64bit BAR support*/
 
-    pm_smbus_init(&d->qdev, &s->smb);
+    pm_smbus_init(&d->qdev, &s->smb, false);
     pci_register_bar(d, ICH9_SMB_SMB_BASE_BAR, PCI_BASE_ADDRESS_SPACE_IO,
                      &s->smb.io);
 }
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index cff1946..7302f6d 100644
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
index 1afa3cf..060d3c6 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -33,6 +33,6 @@ typedef struct PMSMBus {
     bool op_done;
 } PMSMBus;
 
-void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
+void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
 
 #endif /* PM_SMBUS_H */
-- 
1.8.3.1
