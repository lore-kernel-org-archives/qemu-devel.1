Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduz-0004XY-FR
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtl-0006ZI-LI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtk-0006Y2-Ul
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtj-0007AV-Nh
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:39 +0100
Message-Id: <20180814181815.23348-10-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/45] accel/tcg: Return -1 for execution from
 MMIO regions in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that all the callers can handle get_page_addr_code() returning -1,
remove all the code which tries to handle execution from MMIO regions
or small-MMU-region RAM areas. This will mean that we can correctly
execute from these areas, rather than ending up either aborting QEMU
or delivering an incorrect guest exception.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180710160013.26559-6-peter.maydell@linaro.org
---
 accel/tcg/cputlb.c | 95 +++++-----------------------------------------
 1 file changed, 10 insertions(+), 85 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 51b1193044c..754795ff253 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -741,39 +741,6 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                             prot, mmu_idx, size);
 }
 
-static void report_bad_exec(CPUState *cpu, target_ulong addr)
-{
-    /* Accidentally executing outside RAM or ROM is quite common for
-     * several user-error situations, so report it in a way that
-     * makes it clear that this isn't a QEMU bug and provide suggestions
-     * about what a user could do to fix things.
-     */
-    error_report("Trying to execute code outside RAM or ROM at 0x"
-                 TARGET_FMT_lx, addr);
-    error_printf("This usually means one of the following happened:\n\n"
-                 "(1) You told QEMU to execute a kernel for the wrong machine "
-                 "type, and it crashed on startup (eg trying to run a "
-                 "raspberry pi kernel on a versatilepb QEMU machine)\n"
-                 "(2) You didn't give QEMU a kernel or BIOS filename at all, "
-                 "and QEMU executed a ROM full of no-op instructions until "
-                 "it fell off the end\n"
-                 "(3) Your guest kernel has a bug and crashed by jumping "
-                 "off into nowhere\n\n"
-                 "This is almost always one of the first two, so check your "
-                 "command line and that you are using the right type of kernel "
-                 "for this machine.\n"
-                 "If you think option (3) is likely then you can try debugging "
-                 "your guest with the -d debug options; in particular "
-                 "-d guest_errors will cause the log to include a dump of the "
-                 "guest register state at this point.\n\n"
-                 "Execution cannot continue; stopping here.\n\n");
-
-    /* Report also to the logs, with more detail including register dump */
-    qemu_log_mask(LOG_GUEST_ERROR, "qemu: fatal: Trying to execute code "
-                  "outside RAM or ROM at 0x" TARGET_FMT_lx "\n", addr);
-    log_cpu_state_mask(LOG_GUEST_ERROR, cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-}
-
 static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
 {
     ram_addr_t ram_addr;
@@ -963,7 +930,6 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     MemoryRegionSection *section;
     CPUState *cpu = ENV_GET_CPU(env);
     CPUIOTLBEntry *iotlbentry;
-    hwaddr physaddr, mr_offset;
 
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
@@ -977,65 +943,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page, and we must
-         * repeat the MMU check here. This tlb_fill() call might
-         * longjump out if this access should cause a guest exception.
-         */
-        int index;
-        target_ulong tlb_addr;
-
-        tlb_fill(cpu, addr, 0, MMU_INST_FETCH, mmu_idx, 0);
-
-        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
-            /* RAM access. We can't handle this, so for now just stop */
-            cpu_abort(cpu, "Unable to handle guest executing from RAM within "
-                      "a small MPU region at 0x" TARGET_FMT_lx, addr);
-        }
-        /*
-         * Fall through to handle IO accesses (which will almost certainly
-         * also result in failure)
+         * covers a smaller range than a target page. Return -1 to
+         * indicate that we cannot simply execute from RAM here;
+         * we will perform the necessary repeat of the MMU check
+         * when the "execute a single insn" code performs the
+         * load of the guest insn.
          */
+        return -1;
     }
 
     iotlbentry = &env->iotlb[mmu_idx][index];
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     if (memory_region_is_unassigned(mr)) {
-        qemu_mutex_lock_iothread();
-        if (memory_region_request_mmio_ptr(mr, addr)) {
-            qemu_mutex_unlock_iothread();
-            /* A MemoryRegion is potentially added so re-run the
-             * get_page_addr_code.
-             */
-            return get_page_addr_code(env, addr);
-        }
-        qemu_mutex_unlock_iothread();
-
-        /* Give the new-style cpu_transaction_failed() hook first chance
-         * to handle this.
-         * This is not the ideal place to detect and generate CPU
-         * exceptions for instruction fetch failure (for instance
-         * we don't know the length of the access that the CPU would
-         * use, and it would be better to go ahead and try the access
-         * and use the MemTXResult it produced). However it is the
-         * simplest place we have currently available for the check.
+        /*
+         * Not guest RAM, so there is no ram_addr_t for it. Return -1,
+         * and we will execute a single insn from this device.
          */
-        mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-        physaddr = mr_offset +
-            section->offset_within_address_space -
-            section->offset_within_region;
-        cpu_transaction_failed(cpu, physaddr, addr, 0, MMU_INST_FETCH, mmu_idx,
-                               iotlbentry->attrs, MEMTX_DECODE_ERROR, 0);
-
-        cpu_unassigned_access(cpu, addr, false, true, 0, 4);
-        /* The CPU's unassigned access hook might have longjumped out
-         * with an exception. If it didn't (or there was no hook) then
-         * we can't proceed further.
-         */
-        report_bad_exec(cpu, addr);
-        exit(1);
+        return -1;
     }
     p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
     return qemu_ram_addr_from_host_nofail(p);
-- 
2.18.0
