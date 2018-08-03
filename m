Received: from eggs.gnu.org ([2001:4830:134:3::10]:44702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flXBW-0007l0-1Q
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flXBV-0004ES-4h
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:19:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flXBU-00048j-R6
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:19:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 11:19:43 +0100
Message-Id: <20180803101943.23722-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/intc/apic: Switch away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Switch the apic away from using the old_mmio MemoryRegionOps
accessor functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think this is the last old_mmio user. We can clean up the
core code once all the on-list patches get into master.
---
 hw/intc/apic.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6fda52b86cf..97ffdd820f2 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -650,31 +650,17 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static uint32_t apic_mem_readb(void *opaque, hwaddr addr)
-{
-    return 0;
-}
-
-static uint32_t apic_mem_readw(void *opaque, hwaddr addr)
-{
-    return 0;
-}
-
-static void apic_mem_writeb(void *opaque, hwaddr addr, uint32_t val)
-{
-}
-
-static void apic_mem_writew(void *opaque, hwaddr addr, uint32_t val)
-{
-}
-
-static uint32_t apic_mem_readl(void *opaque, hwaddr addr)
+static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
     DeviceState *dev;
     APICCommonState *s;
     uint32_t val;
     int index;
 
+    if (size < 4) {
+        return 0;
+    }
+
     dev = cpu_get_current_apic();
     if (!dev) {
         return 0;
@@ -765,11 +751,17 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static void apic_mem_writel(void *opaque, hwaddr addr, uint32_t val)
+static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
 {
     DeviceState *dev;
     APICCommonState *s;
     int index = (addr >> 4) & 0xff;
+
+    if (size < 4) {
+        return;
+    }
+
     if (addr > 0xfff || !index) {
         /* MSI and MMIO APIC are at the same memory location,
          * but actually not on the global bus: MSI is on PCI bus
@@ -880,10 +872,12 @@ static void apic_post_load(APICCommonState *s)
 }
 
 static const MemoryRegionOps apic_io_ops = {
-    .old_mmio = {
-        .read = { apic_mem_readb, apic_mem_readw, apic_mem_readl, },
-        .write = { apic_mem_writeb, apic_mem_writew, apic_mem_writel, },
-    },
+    .read = apic_mem_read,
+    .write = apic_mem_write,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
