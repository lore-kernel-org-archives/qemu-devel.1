Received: from eggs.gnu.org ([2001:4830:134:3::10]:56905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiK-0004eQ-4J
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiI-0005mF-BR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:48 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZpiI-0005m8-6Q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:46 -0400
Received: by mail-qk0-x242.google.com with SMTP id d145so9052683qkc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:36:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 19:36:08 -0700
Message-Id: <20170725023611.9169-2-rth@twiddle.net>
In-Reply-To: <20170725023611.9169-1-rth@twiddle.net>
References: <20170725023611.9169-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/4] target/s390x: Add ilen to unwind data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Use ILEN_UNWIND to signal that we have in fact that
cpu_restore_state will have been called by the time
we arrive in do_program_interrupt.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h         | 9 ++++++---
 target/s390x/helper.c      | 7 +++++--
 target/s390x/misc_helper.c | 5 ++++-
 target/s390x/translate.c   | 9 ++++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7732d01784..c294e6012d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -43,7 +43,7 @@
 #include "fpu/softfloat.h"
 
 #define NB_MMU_MODES 3
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
@@ -475,7 +475,7 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
 }
 
 #ifndef CONFIG_USER_ONLY
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, int ilen);
 #endif
 
 S390CPU *cpu_s390x_init(const char *cpu_model);
@@ -1143,8 +1143,11 @@ uint32_t set_cc_nz_f128(float128 v);
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 #endif
-/* automatically detect the instruction length */
+/* Instruction length has been set by unwind info.  */
+#define ILEN_UNWIND                 0
+/* Automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
+
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index aef09e1234..6d67d6b5a1 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -166,13 +166,16 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 #else /* !CONFIG_USER_ONLY */
 
 /* Ensure to exit the TB after this call! */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, int ilen)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
-    env->int_pgm_ilen = ilen;
+    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
+    if (ilen != ILEN_UNWIND) {
+        env->int_pgm_ilen = ilen;
+    }
 }
 
 int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index b5081019c5..452b2bd902 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -95,7 +95,10 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
         CPUState *cs = CPU(cpu);
 
         env->int_pgm_code = code;
-        env->int_pgm_ilen = ilen;
+        /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
+        if (ilen != ILEN_UNWIND) {
+            env->int_pgm_ilen = ilen;
+        }
         cs->exception_index = EXCP_PGM;
         cpu_loop_exit(cs);
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 48b71f9604..9b0c35efa2 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -61,6 +61,8 @@ struct DisasContext {
     uint64_t pc, next_pc;
     uint32_t ilen;
     enum cc_op cc_op;
+    /* TCG op index of the current insn_start.  */
+    int insn_start_idx;
     bool singlestep_enabled;
 };
 
@@ -5656,6 +5658,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     }
     s->next_pc = s->pc + ilen;
     s->ilen = ilen;
+    tcg_set_insn_param(s->insn_start_idx, 2, ilen);
 
     /* We can't actually determine the insn format until we've looked up
        the full insn opcode.  Which we can't do without locating the
@@ -5890,7 +5893,10 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     gen_tb_start(tb);
 
     do {
-        tcg_gen_insn_start(dc.pc, dc.cc_op);
+        /* ??? Alternately, delay emitting insn_start until after we
+           have computed the insn length in extract_insn.  */
+        dc.insn_start_idx = tcg_op_buf_count();
+        tcg_gen_insn_start(dc.pc, dc.cc_op, 0);
         num_insns++;
 
         if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
@@ -5984,4 +5990,5 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
     if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
         env->cc_op = cc_op;
     }
+    env->int_pgm_ilen = data[2];
 }
-- 
2.13.3
