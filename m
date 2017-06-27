Received: from eggs.gnu.org ([2001:4830:134:3::10]:54222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPtlh-0008UD-0p
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPsYS-0006ch-Kd
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:31 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPsYS-0006YH-9J
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:28 -0400
Received: by mail-lf0-x244.google.com with SMTP id g21so3065977lfk.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:37:28 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 27 Jun 2017 17:37:16 +0200
Message-Id: <1498577836-25883-8-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v2 7/7] xilinx_spips: allow mmio execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: frederic.konrad@adacore.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This allows to execute from the lqspi area.

When the request_ptr is called the device loads 1024bytes from the SPI device.
Then this code can be executed by the guest.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/ssi/xilinx_spips.c | 74 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index da8adfa..e833028 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -496,6 +496,18 @@ static const MemoryRegionOps spips_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
+{
+    XilinxSPIPS *s = &q->parent_obj;
+
+    if (q->lqspi_cached_addr != ~0ULL) {
+        /* Invalidate the current mapped mmio */
+        memory_region_invalidate_mmio_ptr(&s->mmlqspi, q->lqspi_cached_addr,
+                                          LQSPI_CACHE_SIZE);
+        q->lqspi_cached_addr = ~0ULL;
+    }
+}
+
 static void xilinx_qspips_write(void *opaque, hwaddr addr,
                                 uint64_t value, unsigned size)
 {
@@ -505,7 +517,7 @@ static void xilinx_qspips_write(void *opaque, hwaddr addr,
     addr >>= 2;
 
     if (addr == R_LQSPI_CFG) {
-        q->lqspi_cached_addr = ~0ULL;
+        xilinx_qspips_invalidate_mmio_ptr(q);
     }
 }
 
@@ -517,27 +529,20 @@ static const MemoryRegionOps qspips_ops = {
 
 #define LQSPI_CACHE_SIZE 1024
 
-static uint64_t
-lqspi_read(void *opaque, hwaddr addr, unsigned int size)
+static void lqspi_load_cache(void *opaque, hwaddr addr)
 {
-    int i;
     XilinxQSPIPS *q = opaque;
     XilinxSPIPS *s = opaque;
-    uint32_t ret;
-
-    if (addr >= q->lqspi_cached_addr &&
-            addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
-        uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
-        ret = cpu_to_le32(*(uint32_t *)retp);
-        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
-                   (unsigned)ret);
-        return ret;
-    } else {
-        int flash_addr = (addr / num_effective_busses(s));
-        int slave = flash_addr >> LQSPI_ADDRESS_BITS;
-        int cache_entry = 0;
-        uint32_t u_page_save = s->regs[R_LQSPI_STS] & ~LQSPI_CFG_U_PAGE;
-
+    int i;
+    int flash_addr = ((addr & ~(LQSPI_CACHE_SIZE - 1))
+                   / num_effective_busses(s));
+    int slave = flash_addr >> LQSPI_ADDRESS_BITS;
+    int cache_entry = 0;
+    uint32_t u_page_save = s->regs[R_LQSPI_STS] & ~LQSPI_CFG_U_PAGE;
+
+    if (addr < q->lqspi_cached_addr ||
+            addr > q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
+        xilinx_qspips_invalidate_mmio_ptr(q);
         s->regs[R_LQSPI_STS] &= ~LQSPI_CFG_U_PAGE;
         s->regs[R_LQSPI_STS] |= slave ? LQSPI_CFG_U_PAGE : 0;
 
@@ -589,12 +594,43 @@ lqspi_read(void *opaque, hwaddr addr, unsigned int size)
         xilinx_spips_update_cs_lines(s);
 
         q->lqspi_cached_addr = flash_addr * num_effective_busses(s);
+    }
+}
+
+static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
+                                    unsigned *offset)
+{
+    XilinxQSPIPS *q = opaque;
+    hwaddr offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
+
+    lqspi_load_cache(opaque, offset_within_the_region);
+    *size = LQSPI_CACHE_SIZE;
+    *offset = offset_within_the_region;
+    return q->lqspi_buf;
+}
+
+static uint64_t
+lqspi_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XilinxQSPIPS *q = opaque;
+    uint32_t ret;
+
+    if (addr >= q->lqspi_cached_addr &&
+            addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
+        uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
+        ret = cpu_to_le32(*(uint32_t *)retp);
+        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
+                   (unsigned)ret);
+        return ret;
+    } else {
+        lqspi_load_cache(opaque, addr);
         return lqspi_read(opaque, addr, size);
     }
 }
 
 static const MemoryRegionOps lqspi_ops = {
     .read = lqspi_read,
+    .request_ptr = lqspi_request_mmio_ptr,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-- 
2.7.4
