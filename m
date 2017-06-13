Received: from eggs.gnu.org ([2001:4830:134:3::10]:40012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP8-00037H-BL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP6-00043T-AW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKsP6-00043N-5A
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id x58so37622262qtc.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:27:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 13:26:58 -0700
Message-Id: <20170613202659.1920-3-rth@twiddle.net>
In-Reply-To: <20170613202659.1920-1-rth@twiddle.net>
References: <20170613202659.1920-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/3] target/s390x: rework PGM interrupt psw.addr
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can tell from the program interrupt code, whether a program interrupt
has to forward the address in the PGM new PSW
(suppressing/terminated/completed) to point at the next instruction, or
if it is nullifying and the PSW address does not have to be incremented.

So let's not modify the PSW address outside of the injection path and
handle this internally. We just have to handle instruction length
auto detection if no valid instruction length can be provided.

This should fix various program interrupt injection paths, where the
PSW was not properly forwarded.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170609142156.18767-3-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h         |  7 ++-----
 target/s390x/helper.c      | 44 +++++++++++++++++++++++++++++++++++---------
 target/s390x/misc_helper.c | 21 ++++++++-------------
 target/s390x/mmu_helper.c  |  6 +++---
 target/s390x/translate.c   |  3 +--
 5 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a4d31df..2954974 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -460,11 +460,6 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
 }
 
 #ifndef CONFIG_USER_ONLY
-/* In several cases of runtime exceptions, we havn't recorded the true
-   instruction length.  Use these codes when raising exceptions in order
-   to re-compute the length by examining the insn in memory.  */
-#define ILEN_LATER       0x20
-#define ILEN_LATER_INC   0x21
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 #endif
 
@@ -1133,6 +1128,8 @@ uint32_t set_cc_nz_f128(float128 v);
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 #endif
+/* automatically detect the instruction length */
+#define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a8d20c5..aef09e1 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -204,7 +204,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     if (raddr > ram_size) {
         DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
                 (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_LATER_INC);
+        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
         return 1;
     }
 
@@ -331,16 +331,42 @@ static void do_program_interrupt(CPUS390XState *env)
     LowCore *lowcore;
     int ilen = env->int_pgm_ilen;
 
-    switch (ilen) {
-    case ILEN_LATER:
-        ilen = get_ilen(cpu_ldub_code(env, env->psw.addr));
-        break;
-    case ILEN_LATER_INC:
+    if (ilen == ILEN_AUTO) {
         ilen = get_ilen(cpu_ldub_code(env, env->psw.addr));
+    }
+    assert(ilen == 2 || ilen == 4 || ilen == 6);
+
+    switch (env->int_pgm_code) {
+    case PGM_PER:
+        if (env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION) {
+            break;
+        }
+        /* FALL THROUGH */
+    case PGM_OPERATION:
+    case PGM_PRIVILEGED:
+    case PGM_EXECUTE:
+    case PGM_PROTECTION:
+    case PGM_ADDRESSING:
+    case PGM_SPECIFICATION:
+    case PGM_DATA:
+    case PGM_FIXPT_OVERFLOW:
+    case PGM_FIXPT_DIVIDE:
+    case PGM_DEC_OVERFLOW:
+    case PGM_DEC_DIVIDE:
+    case PGM_HFP_EXP_OVERFLOW:
+    case PGM_HFP_EXP_UNDERFLOW:
+    case PGM_HFP_SIGNIFICANCE:
+    case PGM_HFP_DIVIDE:
+    case PGM_TRANS_SPEC:
+    case PGM_SPECIAL_OP:
+    case PGM_OPERAND:
+    case PGM_HFP_SQRT:
+    case PGM_PC_TRANS_SPEC:
+    case PGM_ALET_SPEC:
+    case PGM_MONITOR:
+        /* advance the PSW if our exception is not nullifying */
         env->psw.addr += ilen;
         break;
-    default:
-        assert(ilen == 2 || ilen == 4 || ilen == 6);
     }
 
     qemu_log_mask(CPU_LOG_INT, "%s: code=0x%x ilen=%d\n",
@@ -737,6 +763,6 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     if (retaddr) {
         cpu_restore_state(cs, retaddr);
     }
-    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER);
+    program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
 }
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d6eda83..4daa016 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -54,19 +54,14 @@ void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
-    int t;
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = excp;
+    env->int_pgm_ilen = ILEN_AUTO;
 
     /* Use the (ultimate) callers address to find the insn that trapped.  */
     cpu_restore_state(cs, retaddr);
 
-    /* Advance past the insn.  */
-    t = cpu_ldub_code(env, env->psw.addr);
-    env->int_pgm_ilen = t = get_ilen(t);
-    env->psw.addr += t;
-
     cpu_loop_exit(cs);
 }
 
@@ -199,12 +194,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
     IplParameterBlock *iplb;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, ILEN_LATER_INC);
+        program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO);
         return;
     }
 
     if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
-        program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
         return;
     }
 
@@ -229,12 +224,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
         break;
     case 5:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
+            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), false)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_LATER_INC);
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return;
         }
         iplb = g_malloc0(sizeof(IplParameterBlock));
@@ -258,12 +253,12 @@ out:
         return;
     case 6:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
+            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), true)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_LATER_INC);
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return;
         }
         iplb = s390_ipl_get_iplb();
@@ -307,7 +302,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        program_interrupt(env, PGM_OPERATION, ILEN_LATER_INC);
+        program_interrupt(env, PGM_OPERATION, ILEN_AUTO);
     }
 }
 
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 501e390..a873dc4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -79,13 +79,13 @@ static void trigger_prot_fault(CPUS390XState *env, target_ulong vaddr,
         return;
     }
 
-    trigger_access_exception(env, PGM_PROTECTION, ILEN_LATER_INC, tec);
+    trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec);
 }
 
 static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
                                uint32_t type, uint64_t asc, int rw, bool exc)
 {
-    int ilen = ILEN_LATER;
+    int ilen = ILEN_AUTO;
     uint64_t tec;
 
     tec = vaddr | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ) | asc >> 46;
@@ -431,7 +431,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
     for (i = 0; i < nr_pages; i++) {
         /* Low-address protection? */
         if (lowprot && (addr < 512 || (addr >= 4096 && addr < 4096 + 512))) {
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_LATER_INC, 0);
+            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
             return -EACCES;
         }
         ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, true);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 95f91d4..d2917e4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -355,8 +355,7 @@ static void gen_program_exception(DisasContext *s, int code)
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_ilen));
     tcg_temp_free_i32(tmp);
 
-    /* Advance past instruction.  */
-    s->pc = s->next_pc;
+    /* update the psw */
     update_psw_addr(s);
 
     /* Save off cc.  */
-- 
2.9.4
