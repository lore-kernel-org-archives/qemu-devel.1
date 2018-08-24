Received: from eggs.gnu.org ([2001:4830:134:3::10]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVq-00056Y-UK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVp-0007nc-Ev
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ftFVe-0007ZW-OA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:34 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:04:20 +0100
Message-Id: <20180824170422.5783-2-peter.maydell@linaro.org>
In-Reply-To: <20180824170422.5783-1-peter.maydell@linaro.org>
References: <20180824170422.5783-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] memory: Remove old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Now that all the users of old_mmio MemoryRegion accessors
have been converted, we can remove the core code support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/memory.txt |  2 --
 include/exec/memory.h |  5 ----
 memory.c              | 64 ++-----------------------------------------
 3 files changed, 2 insertions(+), 69 deletions(-)

diff --git a/docs/devel/memory.txt b/docs/devel/memory.txt
index c1dee1252c2..4fff0d56031 100644
--- a/docs/devel/memory.txt
+++ b/docs/devel/memory.txt
@@ -342,5 +342,3 @@ various constraints can be supplied to control how these callbacks are called:
  - .impl.unaligned specifies that the *implementation* supports unaligned
    accesses; if false, unaligned accesses will be emulated by two aligned
    accesses.
- - .old_mmio eases the porting of code that was formerly using
-   cpu_register_io_memory(). It should not be used in new code.
diff --git a/include/exec/memory.h b/include/exec/memory.h
index eb4f2fb249c..f43a0d7e36a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -201,11 +201,6 @@ struct MemoryRegionOps {
          */
         bool unaligned;
     } impl;
-
-    /* If .read and .write are not present, old_mmio may be used for
-     * backwards compatibility with old mmio registration
-     */
-    const MemoryRegionMmio old_mmio;
 };
 
 enum IOMMUMemoryRegionAttr {
diff --git a/memory.c b/memory.c
index 9b73892768d..fa915a88c08 100644
--- a/memory.c
+++ b/memory.c
@@ -396,32 +396,6 @@ static int get_cpu_index(void)
     return -1;
 }
 
-static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
-                                                       hwaddr addr,
-                                                       uint64_t *value,
-                                                       unsigned size,
-                                                       unsigned shift,
-                                                       uint64_t mask,
-                                                       MemTxAttrs attrs)
-{
-    uint64_t tmp;
-
-    tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
-    if (mr->subpage) {
-        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
-        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
-        hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
-    }
-    *value |= (tmp & mask) << shift;
-    return MEMTX_OK;
-}
-
 static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
                                                 hwaddr addr,
                                                 uint64_t *value,
@@ -475,32 +449,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     return r;
 }
 
-static MemTxResult memory_region_oldmmio_write_accessor(MemoryRegion *mr,
-                                                        hwaddr addr,
-                                                        uint64_t *value,
-                                                        unsigned size,
-                                                        unsigned shift,
-                                                        uint64_t mask,
-                                                        MemTxAttrs attrs)
-{
-    uint64_t tmp;
-
-    tmp = (*value >> shift) & mask;
-    if (mr->subpage) {
-        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
-        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
-        hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
-    }
-    mr->ops->old_mmio.write[ctz32(size)](mr->opaque, addr, tmp);
-    return MEMTX_OK;
-}
-
 static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
                                                 hwaddr addr,
                                                 uint64_t *value,
@@ -1394,16 +1342,12 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_accessor,
                                          mr, attrs);
-    } else if (mr->ops->read_with_attrs) {
+    } else {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_with_attrs_accessor,
                                          mr, attrs);
-    } else {
-        return access_with_adjusted_size(addr, pval, size, 1, 4,
-                                         memory_region_oldmmio_read_accessor,
-                                         mr, attrs);
     }
 }
 
@@ -1475,17 +1419,13 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          mr->ops->impl.max_access_size,
                                          memory_region_write_accessor, mr,
                                          attrs);
-    } else if (mr->ops->write_with_attrs) {
+    } else {
         return
             access_with_adjusted_size(addr, &data, size,
                                       mr->ops->impl.min_access_size,
                                       mr->ops->impl.max_access_size,
                                       memory_region_write_with_attrs_accessor,
                                       mr, attrs);
-    } else {
-        return access_with_adjusted_size(addr, &data, size, 1, 4,
-                                         memory_region_oldmmio_write_accessor,
-                                         mr, attrs);
     }
 }
 
-- 
2.18.0
