Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qay-00042z-9w
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007Wa-9O
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007Uw-SW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:55 +0100
Message-Id: <20190311191602.25796-5-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] target/hppa: add TLB trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

To ease TLB debugging add a few trace events, which are disabled
by default so that there's no performance impact.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 Makefile.objs            |  1 +
 target/hppa/mem_helper.c | 20 ++++++++++++++++++--
 target/hppa/op_helper.c  |  2 ++
 target/hppa/trace-events | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 target/hppa/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index ef65a6c12e..4df63e1633 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -183,6 +183,7 @@ trace-events-subdirs += qapi
 trace-events-subdirs += qom
 trace-events-subdirs += scsi
 trace-events-subdirs += target/arm
+trace-events-subdirs += target/hppa
 trace-events-subdirs += target/i386
 trace-events-subdirs += target/mips
 trace-events-subdirs += target/ppc
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 07ecfaf092..26da953185 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qom/cpu.h"
+#include "trace.h"
 
 #ifdef CONFIG_USER_ONLY
 int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
@@ -43,9 +44,11 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
     for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
         hppa_tlb_entry *ent = &env->tlb[i];
         if (ent->va_b <= addr && addr <= ent->va_e) {
+            trace_hppa_tlb_find_entry(env, ent + i, ent->entry_valid, ent->va_b, ent->va_e, ent->pa);
             return ent;
         }
     }
+    trace_hppa_tlb_find_entry_not_found(env, addr);
     return NULL;
 }
 
@@ -55,6 +58,8 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
     unsigned i, n = 1 << (2 * ent->page_size);
     uint64_t addr = ent->va_b;
 
+    trace_hppa_tlb_flush_ent(env, ent, ent->va_b, ent->va_e, ent->pa);
+
     for (i = 0; i < n; ++i, addr += TARGET_PAGE_SIZE) {
         /* Do not flush MMU_PHYS_IDX.  */
         tlb_flush_page_by_mmuidx(cs, addr, 0xf);
@@ -169,6 +174,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
  egress:
     *pphys = phys;
     *pprot = prot;
+    trace_hppa_tlb_get_physical_address(env, ret, prot, addr, phys);
     return ret;
 }
 
@@ -198,6 +204,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType type, int mmu_idx, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -213,9 +220,10 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
         break;
     }
 
-    excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx,
+    excp = hppa_get_physical_address(env, addr, mmu_idx,
                                      a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
+        trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
         /* Failure.  Raise the indicated exception.  */
         cs->exception_index = excp;
         if (cpu->env.psw & PSW_Q) {
@@ -226,6 +234,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
         cpu_loop_exit_restore(cs, retaddr);
     }
 
+    trace_hppa_tlb_fill_success(env, addr & TARGET_PAGE_MASK,
+            phys & TARGET_PAGE_MASK, size, type, mmu_idx);
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
@@ -259,6 +269,7 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     empty->va_b = addr & TARGET_PAGE_MASK;
     empty->va_e = empty->va_b + TARGET_PAGE_SIZE - 1;
     empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
+    trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
 }
 
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
@@ -280,6 +291,8 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     ent->d = extract32(reg, 28, 1);
     ent->t = extract32(reg, 29, 1);
     ent->entry_valid = 1;
+    trace_hppa_tlb_itlbp(env, ent, ent->access_id, ent->u, ent->ar_pl2,
+                         ent->ar_pl1, ent->ar_type, ent->b, ent->d, ent->t);
 }
 
 /* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
@@ -299,6 +312,7 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
     CPUState *src = CPU(hppa_env_get_cpu(env));
     CPUState *cpu;
+    trace_hppa_tlb_ptlb(env);
     run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
 
     CPU_FOREACH(cpu) {
@@ -314,7 +328,7 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
     CPUState *src = CPU(hppa_env_get_cpu(env));
-
+    trace_hppa_tlb_ptlbe(env);
     memset(env->tlb, 0, sizeof(env->tlb));
     tlb_flush_by_mmuidx(src, 0xf);
 }
@@ -335,8 +349,10 @@ target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
+        trace_hppa_tlb_lpa_failed(env, addr);
         hppa_dynamic_excp(env, excp, GETPC());
     }
+    trace_hppa_tlb_lpa_success(env, addr, phys);
     return phys;
 }
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 268caaaa20..a05681d480 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -25,6 +25,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "fpu/softfloat.h"
+#include "trace.h"
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 {
@@ -165,6 +166,7 @@ target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     int prot, excp;
     hwaddr phys;
 
+    trace_hppa_tlb_probe(addr, level, want);
     /* Fail if the requested privilege level is higher than current.  */
     if (level < (env->iaoq_f & 3)) {
         return 0;
diff --git a/target/hppa/trace-events b/target/hppa/trace-events
new file mode 100644
index 0000000000..80dae5bd8b
--- /dev/null
+++ b/target/hppa/trace-events
@@ -0,0 +1,18 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# target/hppa/mem_helper.c
+disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
+disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%lx"
+disable hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
+disable hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
+disable hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
+disable hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
+disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
+disable hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
+disable hppa_tlb_ptlb(void *env) "env=%p"
+disable hppa_tlb_ptlbe(void *env) "env=%p"
+disable hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
+disable hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
+
+# target/hppa/op_helper.c
+disable hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"
-- 
2.20.1
