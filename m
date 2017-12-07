Received: from eggs.gnu.org ([2001:4830:134:3::10]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN402-000426-7K
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN401-0006QJ-7M
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:34 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN401-0006P2-0a
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:33 -0500
Received: by mail-pf0-x244.google.com with SMTP id u25so5674745pfg.5
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:32 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:13 -0600
Message-Id: <1512683181-8420-7-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 06/14] i2c:pm_smbus: Add interrupt handling
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

Add the necessary code so that interrupts actually work from
the pm_smbus device.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c         | 14 +++++++++++++-
 hw/i2c/smbus_ich9.c       | 17 +++++++++++++++++
 include/hw/i2c/pm_smbus.h |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index eb2df4d..2fb00d0 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -205,6 +205,12 @@ error:
     return;
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
@@ -300,7 +306,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
     }
 
  out:
-    return;
+    if (s->set_irq) {
+        s->set_irq(s, smb_irq_value(s));
+    }
 }
 
 static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
@@ -352,6 +360,10 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
                   addr, val);
 
+    if (s->set_irq) {
+        s->set_irq(s, smb_irq_value(s));
+    }
+
     return val;
 }
 
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 706b9ec..d029816 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -41,6 +41,8 @@
 typedef struct ICH9SMBState {
     PCIDevice dev;
 
+    bool irq_enabled;
+
     PMSMBus smb;
 } ICH9SMBState;
 
@@ -50,6 +52,7 @@ static const VMStateDescription vmstate_ich9_smbus = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
+        VMSTATE_BOOL(irq_enabled, ICH9SMBState),
         VMSTATE_STRUCT(smb, ICH9SMBState, 1, pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
@@ -111,11 +114,25 @@ static void ich9_smb_class_init(ObjectClass *klass, void *data)
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
