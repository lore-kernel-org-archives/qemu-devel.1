Received: from eggs.gnu.org ([2001:4830:134:3::10]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd5-0003W9-4a
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd3-0005N5-T1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd3-0005L9-KL
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd2-0003y8-Ch
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:05 +0100
Message-Id: <20180622125713.15303-21-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/28] hw/misc/tz_mpc.c: Honour the BLK_LUT
 settings in translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The final part of the Memory Protection Controller we need to
implement is actually using the BLK_LUT data programmed by the
guest to determine whether to block the transaction or not.

Since this means we now change transaction mappings when
the guest writes to BLK_LUT, we must also call the IOMMU
notifiers at that point.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20180620132032.28865-5-peter.maydell@linaro.org
---
 hw/misc/tz-mpc.c     | 53 ++++++++++++++++++++++++++++++++++++++++++--
 hw/misc/trace-events |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index fded5922a21..8316079b4bf 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -72,6 +72,53 @@ static void tz_mpc_irq_update(TZMPC *s)
     qemu_set_irq(s->irq, s->int_stat && s->int_en);
 }
 
+static void tz_mpc_iommu_notify(TZMPC *s, uint32_t lutidx,
+                                uint32_t oldlut, uint32_t newlut)
+{
+    /* Called when the LUT word at lutidx has changed from oldlut to newlut;
+     * must call the IOMMU notifiers for the changed blocks.
+     */
+    IOMMUTLBEntry entry = {
+        .addr_mask = s->blocksize - 1,
+    };
+    hwaddr addr = lutidx * s->blocksize * 32;
+    int i;
+
+    for (i = 0; i < 32; i++, addr += s->blocksize) {
+        bool block_is_ns;
+
+        if (!((oldlut ^ newlut) & (1 << i))) {
+            continue;
+        }
+        /* This changes the mappings for both the S and the NS space,
+         * so we need to do four notifies: an UNMAP then a MAP for each.
+         */
+        block_is_ns = newlut & (1 << i);
+
+        trace_tz_mpc_iommu_notify(addr);
+        entry.iova = addr;
+        entry.translated_addr = addr;
+
+        entry.perm = IOMMU_NONE;
+        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
+        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
+
+        entry.perm = IOMMU_RW;
+        if (block_is_ns) {
+            entry.target_as = &s->blocked_io_as;
+        } else {
+            entry.target_as = &s->downstream_as;
+        }
+        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
+        if (block_is_ns) {
+            entry.target_as = &s->downstream_as;
+        } else {
+            entry.target_as = &s->blocked_io_as;
+        }
+        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
+    }
+}
+
 static void tz_mpc_autoinc_idx(TZMPC *s, unsigned access_size)
 {
     /* Auto-increment BLK_IDX if necessary */
@@ -237,6 +284,7 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hwaddr addr,
         s->blk_idx = value % s->blk_max;
         break;
     case A_BLK_LUT:
+        tz_mpc_iommu_notify(s, s->blk_idx, s->blk_lut[s->blk_idx], value);
         s->blk_lut[s->blk_idx] = value;
         tz_mpc_autoinc_idx(s, size);
         break;
@@ -383,9 +431,10 @@ static IOMMUTLBEntry tz_mpc_translate(IOMMUMemoryRegion *iommu,
     /* Look at the per-block configuration for this address, and
      * return a TLB entry directing the transaction at either
      * downstream_as or blocked_io_as, as appropriate.
-     * For the moment, always permit accesses.
+     * If the LUT cfg_ns bit is 1, only non-secure transactions
+     * may pass. If the bit is 0, only secure transactions may pass.
      */
-    ok = true;
+    ok = tz_mpc_cfg_ns(s, addr) == (iommu_idx == IOMMU_IDX_NS);
 
     trace_tz_mpc_translate(addr, flags,
                            iommu_idx == IOMMU_IDX_S ? "S" : "NS",
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 72bf9d57000..c956e1419b7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,7 @@ tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs wri
 tz_mpc_mem_blocked_read(uint64_t addr, unsigned size, bool secure) "TZ MPC blocked read: offset 0x%" PRIx64 " size %u secure %d"
 tz_mpc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, bool secure) "TZ MPC blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
 tz_mpc_translate(uint64_t addr, int flags, const char *idx, const char *res) "TZ MPC translate: addr 0x%" PRIx64 " flags 0x%x iommu_idx %s: %s"
+tz_mpc_iommu_notify(uint64_t addr) "TZ MPC iommu: notifying UNMAP/MAP for 0x%" PRIx64
 
 # hw/misc/tz-ppc.c
 tz_ppc_reset(void) "TZ PPC: reset"
-- 
2.17.1
