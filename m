Received: from eggs.gnu.org ([2001:4830:134:3::10]:52347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduq-0004PK-AJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdti-0006Wb-73
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdth-0006SH-Gy
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtf-00078k-2O
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:35 +0100
Message-Id: <20180814181815.23348-6-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/45] accel/tcg: Pass read access type through
 to io_readx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The io_readx() function needs to know whether the load it is
doing is an MMU_DATA_LOAD or an MMU_INST_FETCH, so that it
can pass the right value to the cpu_transaction_failed()
function. Plumb this information through from the softmmu
code.

This is currently not often going to give the wrong answer,
because usually instruction fetches go via get_page_addr_code().
However once we switch over to handling execution from non-RAM by
creating single-insn TBs, the path for an insn fetch to generate
a bus error will be through cpu_ld*_code() and io_readx(),
so without this change we will generate a d-side fault when we
should generate an i-side fault.

We also have to pass the access type via a CPU struct global
down to unassigned_mem_read(), for the benefit of the targets
which still use the cpu_unassigned_access() hook (m68k, mips,
sparc, xtensa).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180710160013.26559-2-peter.maydell@linaro.org
---
 accel/tcg/softmmu_template.h | 11 +++++++----
 include/qom/cpu.h            |  6 ++++++
 accel/tcg/cputlb.c           |  5 +++--
 memory.c                     |  3 ++-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index badbf148803..f060a693d41 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -99,11 +99,12 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
                                               size_t mmu_idx, size_t index,
                                               target_ulong addr,
                                               uintptr_t retaddr,
-                                              bool recheck)
+                                              bool recheck,
+                                              MMUAccessType access_type)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
     return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
-                    DATA_SIZE);
+                    access_type, DATA_SIZE);
 }
 #endif
 
@@ -140,7 +141,8 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
         res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
-                                    tlb_addr & TLB_RECHECK);
+                                    tlb_addr & TLB_RECHECK,
+                                    READ_ACCESS_TYPE);
         res = TGT_LE(res);
         return res;
     }
@@ -207,7 +209,8 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
         res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
-                                    tlb_addr & TLB_RECHECK);
+                                    tlb_addr & TLB_RECHECK,
+                                    READ_ACCESS_TYPE);
         res = TGT_BE(res);
         return res;
     }
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index bd796579ee4..ecf6ed556a9 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -386,6 +386,12 @@ struct CPUState {
      */
     uintptr_t mem_io_pc;
     vaddr mem_io_vaddr;
+    /*
+     * This is only needed for the legacy cpu_unassigned_access() hook;
+     * when all targets using it have been converted to use
+     * cpu_transaction_failed() instead it can be removed.
+     */
+    MMUAccessType mem_io_access_type;
 
     int kvm_fd;
     struct KVMState *kvm_state;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 563fa30117e..51b1193044c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -789,7 +789,7 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx,
                          target_ulong addr, uintptr_t retaddr,
-                         bool recheck, int size)
+                         bool recheck, MMUAccessType access_type, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -831,6 +831,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
 
     cpu->mem_io_vaddr = addr;
+    cpu->mem_io_access_type = access_type;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
@@ -843,7 +844,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
             section->offset_within_address_space -
             section->offset_within_region;
 
-        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_LOAD,
+        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
                                mmu_idx, iotlbentry->attrs, r, retaddr);
     }
     if (locked) {
diff --git a/memory.c b/memory.c
index e9cd4469688..2ea16e7bfb0 100644
--- a/memory.c
+++ b/memory.c
@@ -1249,7 +1249,8 @@ static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
     printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
 #endif
     if (current_cpu != NULL) {
-        cpu_unassigned_access(current_cpu, addr, false, false, 0, size);
+        bool is_exec = current_cpu->mem_io_access_type == MMU_INST_FETCH;
+        cpu_unassigned_access(current_cpu, addr, false, is_exec, 0, size);
     }
     return 0;
 }
-- 
2.18.0
