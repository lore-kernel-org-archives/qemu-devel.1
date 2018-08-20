Received: from eggs.gnu.org ([2001:4830:134:3::10]:52033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqll-0003Ht-Ez
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqlb-0003qP-Gb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:14 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqlR-0003Nr-Qq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:05 -0400
Received: by mail-oi0-x232.google.com with SMTP id q11-v6so28135827oic.12
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:57 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:06 -0500
Message-Id: <1534796770-10295-7-git-send-email-minyard@acm.org>
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 06/10] i2c:pm_smbus: Add interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Add the necessary code so that interrupts actually work from
the pm_smbus device.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c         | 14 +++++++++++++-
 hw/i2c/smbus_ich9.c       | 19 ++++++++++++++++++-
 include/hw/i2c/pm_smbus.h |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 9e11d47..664a6b1 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -214,6 +214,12 @@ static void smb_transaction_start(PMSMBus *s)
     s->smb_stat |= STS_HOST_BUSY;
 }
 
+static bool
+smb_irq_value(PMSMBus *s)
+{
+    return ((s->smb_stat & ~STS_HOST_BUSY) != 0) && (s->smb_ctl & CTL_INTREN);
+}
+
 static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
@@ -309,7 +315,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
     }
 
  out:
-    return;
+    if (s->set_irq) {
+        s->set_irq(s, smb_irq_value(s));
+    }
 }
 
 static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
@@ -365,6 +373,10 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
                   addr, val);
 
+    if (s->set_irq) {
+        s->set_irq(s, smb_irq_value(s));
+    }
+
     return val;
 }
 
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index c8b8413..316c2a4 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -40,15 +40,18 @@
 typedef struct ICH9SMBState {
     PCIDevice dev;
 
+    bool irq_enabled;
+
     PMSMBus smb;
 } ICH9SMBState;
 
 static const VMStateDescription vmstate_ich9_smbus = {
     .name = "ich9_smb",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
+        VMSTATE_BOOL_V(irq_enabled, ICH9SMBState, 3),
         VMSTATE_STRUCT(smb, ICH9SMBState, 2, pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
@@ -110,11 +113,25 @@ static void ich9_smb_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
+static void ich9_smb_set_irq(PMSMBus *pmsmb, bool enabled)
+{
+    ICH9SMBState *s = pmsmb->opaque;
+
+    if (enabled == s->irq_enabled) {
+        return;
+    }
+
+    s->irq_enabled = enabled;
+    pci_set_irq(&s->dev, enabled);
+}
+
 I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base)
 {
     PCIDevice *d =
         pci_create_simple_multifunction(bus, devfn, true, TYPE_ICH9_SMB_DEVICE);
     ICH9SMBState *s = ICH9_SMB_DEVICE(d);
+    s->smb.set_irq = ich9_smb_set_irq;
+    s->smb.opaque = s;
     return s->smb.smbus;
 }
 
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index b1e1970..cfe596f 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -23,6 +23,8 @@ typedef struct PMSMBus {
 
     /* Set by the user. */
     bool i2c_enable;
+    void (*set_irq)(struct PMSMBus *s, bool enabled);
+    void *opaque;
 
     /* Internally used by pm_smbus. */
 
-- 
2.7.4
