Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA56-0002a9-W5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007D3-HZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4n-00076D-NG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 20-v6so10508612wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:38 +0200
Message-Id: <1534870966-9287-67-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 66/74] i2c: pm_smbus: Add interrupt handling
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

Add the necessary code so that interrupts actually work from
the pm_smbus device.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1534796770-10295-7-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c         | 14 +++++++++++++-
 hw/i2c/smbus_ich9.c       | 16 ++++++++++++++++
 include/hw/i2c/pm_smbus.h |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 32132be..6322f07 100644
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
index a66a114..522a703 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -40,6 +40,8 @@
 typedef struct ICH9SMBState {
     PCIDevice dev;
 
+    bool irq_enabled;
+
     PMSMBus smb;
 } ICH9SMBState;
 
@@ -109,11 +111,25 @@ static void ich9_smb_class_init(ObjectClass *klass, void *data)
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
index 99d5489..1afa3cf 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -23,6 +23,8 @@ typedef struct PMSMBus {
 
     /* Set by the user. */
     bool i2c_enable;
+    void (*set_irq)(struct PMSMBus *s, bool enabled);
+    void *opaque;
 
     /* Internally used by pm_smbus. */
 
-- 
1.8.3.1
