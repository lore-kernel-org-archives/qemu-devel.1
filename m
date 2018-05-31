Received: from eggs.gnu.org ([2001:4830:134:3::10]:41724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUx-0000vp-Mw
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUr-0006UC-PP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUr-0006TM-H2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUq-0002tg-Fc
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:46 +0100
Message-Id: <20180531142357.904-15-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/25] Make address_space_access_valid() take a
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

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_access_valid().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-6-peter.maydell@linaro.org
---
 include/exec/memory.h      | 4 +++-
 include/sysemu/dma.h       | 3 ++-
 exec.c                     | 3 ++-
 target/s390x/diag.c        | 6 ++++--
 target/s390x/excp_helper.c | 3 ++-
 target/s390x/mmu_helper.c  | 3 ++-
 target/s390x/sigp.c        | 3 ++-
 7 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d594639d7c..3f2671f332 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1937,8 +1937,10 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @addr: address within that address space
  * @len: length of the area to be checked
  * @is_write: indicates the transfer direction
+ * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_write);
+bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len,
+                                bool is_write, MemTxAttrs attrs);
 
 /* address_space_map: map a physical memory region into a host virtual address
  *
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 0d73902634..5da3c4e3c5 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -77,7 +77,8 @@ static inline bool dma_memory_valid(AddressSpace *as,
                                     DMADirection dir)
 {
     return address_space_access_valid(as, addr, len,
-                                      dir == DMA_DIRECTION_FROM_DEVICE);
+                                      dir == DMA_DIRECTION_FROM_DEVICE,
+                                      MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int dma_memory_rw_relaxed(AddressSpace *as, dma_addr_t addr,
diff --git a/exec.c b/exec.c
index 1dc81cfe4a..22af4e8cb9 100644
--- a/exec.c
+++ b/exec.c
@@ -3480,7 +3480,8 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
-                                int len, bool is_write)
+                                int len, bool is_write,
+                                MemTxAttrs attrs)
 {
     FlatView *fv;
     bool result;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index ac2c40f363..d1d3433aa7 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -87,7 +87,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), false)) {
+                                        sizeof(IplParameterBlock), false,
+                                        MEMTXATTRS_UNSPECIFIED)) {
             s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
             return;
         }
@@ -116,7 +117,8 @@ out:
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), true)) {
+                                        sizeof(IplParameterBlock), true,
+                                        MEMTXATTRS_UNSPECIFIED)) {
             s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
             return;
         }
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index dfee221111..f0ce60cff2 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -120,7 +120,8 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
 
     /* check out of RAM access */
     if (!address_space_access_valid(&address_space_memory, raddr,
-                                    TARGET_PAGE_SIZE, rw)) {
+                                    TARGET_PAGE_SIZE, rw,
+                                    MEMTXATTRS_UNSPECIFIED)) {
         DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
                 (uint64_t)raddr, (uint64_t)ram_size);
         trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a25deef5dd..145b62a7ef 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -461,7 +461,8 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
             return ret;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
-                                        TARGET_PAGE_SIZE, is_write)) {
+                                        TARGET_PAGE_SIZE, is_write,
+                                        MEMTXATTRS_UNSPECIFIED)) {
             trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
             return -EFAULT;
         }
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index aff1530c82..c1f9245797 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -280,7 +280,8 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     cpu_synchronize_state(cs);
 
     if (!address_space_access_valid(&address_space_memory, addr,
-                                    sizeof(struct LowCore), false)) {
+                                    sizeof(struct LowCore), false,
+                                    MEMTXATTRS_UNSPECIFIED)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
-- 
2.17.1
