Received: from eggs.gnu.org ([2001:4830:134:3::10]:46063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8T-0003Tb-RL
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8S-0007ny-QD
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8S-0007mW-Ip
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:30 +0100
Message-Id: <20180501085939.6201-4-peter.maydell@linaro.org>
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 03/12] Make address_space_map() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_map().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h   | 3 ++-
 include/sysemu/dma.h    | 3 ++-
 exec.c                  | 6 ++++--
 target/ppc/mmu-hash64.c | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f416d1e985..1af4e3cd5b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1953,9 +1953,10 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
  * @addr: address within that address space
  * @plen: pointer to length of buffer; updated on return
  * @is_write: indicates the transfer direction
+ * @attrs: memory attributes
  */
 void *address_space_map(AddressSpace *as, hwaddr addr,
-                        hwaddr *plen, bool is_write);
+                        hwaddr *plen, bool is_write, MemTxAttrs attrs);
 
 /* address_space_unmap: Unmaps a memory region previously mapped by address_space_map()
  *
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index c228c66513..0d73902634 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -132,7 +132,8 @@ static inline void *dma_memory_map(AddressSpace *as,
     hwaddr xlen = *len;
     void *p;
 
-    p = address_space_map(as, addr, &xlen, dir == DMA_DIRECTION_FROM_DEVICE);
+    p = address_space_map(as, addr, &xlen, dir == DMA_DIRECTION_FROM_DEVICE,
+                          MEMTXATTRS_UNSPECIFIED);
     *len = xlen;
     return p;
 }
diff --git a/exec.c b/exec.c
index a0f27b7b8c..eb6471abfe 100644
--- a/exec.c
+++ b/exec.c
@@ -3494,7 +3494,8 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
 void *address_space_map(AddressSpace *as,
                         hwaddr addr,
                         hwaddr *plen,
-                        bool is_write)
+                        bool is_write,
+                        MemTxAttrs attrs)
 {
     hwaddr len = *plen;
     hwaddr l, xlat;
@@ -3581,7 +3582,8 @@ void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               int is_write)
 {
-    return address_space_map(&address_space_memory, addr, plen, is_write);
+    return address_space_map(&address_space_memory, addr, plen, is_write,
+                             MEMTXATTRS_UNSPECIFIED);
 }
 
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7e0adecfd9..4839dc22f0 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -431,7 +431,8 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
         return NULL;
     }
 
-    hptes = address_space_map(CPU(cpu)->as, base + pte_offset, &plen, false);
+    hptes = address_space_map(CPU(cpu)->as, base + pte_offset, &plen, false,
+                              MEMTXATTRS_UNSPECIFIED);
     if (plen < (n * HASH_PTE_SIZE_64)) {
         hw_error("%s: Unable to map all requested HPTEs\n", __func__);
     }
-- 
2.17.0
