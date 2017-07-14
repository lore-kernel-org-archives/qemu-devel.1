Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJg-0003G5-VG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJc-00007h-LY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:44 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJc-00007Y-Fc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:40 -0400
Received: by mail-qk0-x243.google.com with SMTP id c18so129289qkb.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:40 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:14 -1000
Message-Id: <20170714001819.1660-4-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 3/8] target/alpha: Merge several flag bytes
 into ENV->FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The flags are arranged such that we can manipulate them either
a whole, or as individual bytes.  The computation within
cpu_get_tb_cpu_state is now reduced to a single load and mask.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/cpu.h       | 70 +++++++++++++++++--------------------
 hw/alpha/dp264.c         |  1 -
 linux-user/main.c        | 25 +++++++------
 target/alpha/cpu.c       |  7 ++--
 target/alpha/helper.c    | 12 +++----
 target/alpha/machine.c   | 10 ++----
 target/alpha/translate.c | 91 +++++++++++++++++++++++++++++++-----------------
 7 files changed, 117 insertions(+), 99 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index aa83417..e95be2b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -242,13 +242,11 @@ struct CPUAlphaState {
     uint8_t fpcr_dyn_round;
     uint8_t fpcr_flush_to_zero;
 
-    /* The Internal Processor Registers.  Some of these we assume always
-       exist for use in user-mode.  */
-    uint8_t ps;
-    uint8_t intr_flag;
-    uint8_t pal_mode;
-    uint8_t fen;
+    /* Mask of PALmode, Processor State et al.  Most of this gets copied
+       into the TranslatorBlock flags and controls code generation.  */
+    uint32_t flags;
 
+    /* The high 32-bits of the processor cycle counter.  */
     uint32_t pcc_ofs;
 
     /* These pass data from the exception logic in the translator and
@@ -398,24 +396,37 @@ enum {
 };
 
 /* Processor status constants.  */
-enum {
-    /* Low 3 bits are interrupt mask level.  */
-    PS_INT_MASK = 7,
+/* Low 3 bits are interrupt mask level.  */
+#define PS_INT_MASK   7u
 
-    /* Bits 4 and 5 are the mmu mode.  The VMS PALcode uses all 4 modes;
-       The Unix PALcode only uses bit 4.  */
-    PS_USER_MODE = 8
-};
+/* Bits 4 and 5 are the mmu mode.  The VMS PALcode uses all 4 modes;
+   The Unix PALcode only uses bit 4.  */
+#define PS_USER_MODE  8u
+
+/* CPUAlphaState->flags constants.  These are layed out so that we
+   can set or reset the pieces individually by assigning to the byte,
+   or manipulated as a whole.  */
+
+#define ENV_FLAG_PAL_SHIFT    0
+#define ENV_FLAG_PS_SHIFT     8
+#define ENV_FLAG_RX_SHIFT     16
+#define ENV_FLAG_FEN_SHIFT    24
+
+#define ENV_FLAG_PAL_MODE     (1u << ENV_FLAG_PAL_SHIFT)
+#define ENV_FLAG_PS_USER      (PS_USER_MODE << ENV_FLAG_PS_SHIFT)
+#define ENV_FLAG_RX_FLAG      (1u << ENV_FLAG_RX_SHIFT)
+#define ENV_FLAG_FEN          (1u << ENV_FLAG_FEN_SHIFT)
+
+#define ENV_FLAG_TB_MASK \
+    (ENV_FLAG_PAL_MODE | ENV_FLAG_PS_USER | ENV_FLAG_FEN)
 
 static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
 {
-    if (env->pal_mode) {
-        return MMU_KERNEL_IDX;
-    } else if (env->ps & PS_USER_MODE) {
-        return MMU_USER_IDX;
-    } else {
-        return MMU_KERNEL_IDX;
+    int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
+    if (env->flags & ENV_FLAG_PAL_MODE) {
+        ret = MMU_KERNEL_IDX;
     }
+    return ret;
 }
 
 enum {
@@ -482,31 +493,12 @@ QEMU_NORETURN void alpha_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
                                                int unused, unsigned size);
 #endif
 
-/* Bits in TB->FLAGS that control how translation is processed.  */
-enum {
-    TB_FLAGS_PAL_MODE = 1,
-    TB_FLAGS_FEN = 2,
-    TB_FLAGS_USER_MODE = 8,
-};
-
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *pflags)
 {
-    int flags = 0;
-
     *pc = env->pc;
     *cs_base = 0;
-
-    if (env->pal_mode) {
-        flags = TB_FLAGS_PAL_MODE;
-    } else {
-        flags = env->ps & PS_USER_MODE;
-    }
-    if (env->fen) {
-        flags |= TB_FLAGS_FEN;
-    }
-
-    *pflags = flags;
+    *pflags = env->flags & ENV_FLAG_TB_MASK;
 }
 
 #endif /* ALPHA_CPU_H */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 85405da..3b307ad 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -123,7 +123,6 @@ static void clipper_init(MachineState *machine)
 
     /* Start all cpus at the PALcode RESET entry point.  */
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i]->env.pal_mode = 1;
         cpus[i]->env.pc = palcode_entry;
         cpus[i]->env.palbr = palcode_entry;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index ad03c9e..2b38d39 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3037,16 +3037,13 @@ void cpu_loop(CPUAlphaState *env)
     abi_long sysret;
 
     while (1) {
+        bool arch_interrupt = true;
+
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
 
-        /* All of the traps imply a transition through PALcode, which
-           implies an REI instruction has been executed.  Which means
-           that the intr_flag should be cleared.  */
-        env->intr_flag = 0;
-
         switch (trapnr) {
         case EXCP_RESET:
             fprintf(stderr, "Reset requested. Exit\n");
@@ -3063,7 +3060,6 @@ void cpu_loop(CPUAlphaState *env)
             exit(EXIT_FAILURE);
             break;
         case EXCP_MMFAULT:
-            env->lock_addr = -1;
             info.si_signo = TARGET_SIGSEGV;
             info.si_errno = 0;
             info.si_code = (page_get_flags(env->trap_arg0) & PAGE_VALID
@@ -3072,7 +3068,6 @@ void cpu_loop(CPUAlphaState *env)
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_UNALIGN:
-            env->lock_addr = -1;
             info.si_signo = TARGET_SIGBUS;
             info.si_errno = 0;
             info.si_code = TARGET_BUS_ADRALN;
@@ -3081,7 +3076,6 @@ void cpu_loop(CPUAlphaState *env)
             break;
         case EXCP_OPCDEC:
         do_sigill:
-            env->lock_addr = -1;
             info.si_signo = TARGET_SIGILL;
             info.si_errno = 0;
             info.si_code = TARGET_ILL_ILLOPC;
@@ -3089,7 +3083,6 @@ void cpu_loop(CPUAlphaState *env)
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ARITH:
-            env->lock_addr = -1;
             info.si_signo = TARGET_SIGFPE;
             info.si_errno = 0;
             info.si_code = TARGET_FPE_FLTINV;
@@ -3100,7 +3093,6 @@ void cpu_loop(CPUAlphaState *env)
             /* No-op.  Linux simply re-enables the FPU.  */
             break;
         case EXCP_CALL_PAL:
-            env->lock_addr = -1;
             switch (env->error_code) {
             case 0x80:
                 /* BPT */
@@ -3197,10 +3189,11 @@ void cpu_loop(CPUAlphaState *env)
         case EXCP_DEBUG:
             info.si_signo = gdb_handlesig(cs, TARGET_SIGTRAP);
             if (info.si_signo) {
-                env->lock_addr = -1;
                 info.si_errno = 0;
                 info.si_code = TARGET_TRAP_BRKPT;
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            } else {
+                arch_interrupt = false;
             }
             break;
         case EXCP_INTERRUPT:
@@ -3208,6 +3201,7 @@ void cpu_loop(CPUAlphaState *env)
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
+            arch_interrupt = false;
             break;
         default:
             printf ("Unhandled trap: 0x%x\n", trapnr);
@@ -3215,6 +3209,15 @@ void cpu_loop(CPUAlphaState *env)
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
+
+        /* Most of the traps imply a transition through PALcode, which
+           implies an REI instruction has been executed.  Which means
+           that RX and LOCK_ADDR should be cleared.  But there are a
+           few exceptions for traps internal to QEMU.  */
+        if (arch_interrupt) {
+            env->flags &= ~ENV_FLAG_RX_FLAG;
+            env->lock_addr = -1;
+        }
     }
 }
 #endif /* TARGET_ALPHA */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 8186c9d..76150f4 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -276,14 +276,15 @@ static void alpha_cpu_initfn(Object *obj)
 
     alpha_translate_init();
 
+    env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
-    env->ps = PS_USER_MODE;
+    env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (FPCR_INVD | FPCR_DZED | FPCR_OVFD
                                | FPCR_UNFD | FPCR_INED | FPCR_DNOD
                                | FPCR_DYN_NORMAL));
+#else
+    env->flags = ENV_FLAG_PAL_MODE | ENV_FLAG_FEN;
 #endif
-    env->lock_addr = -1;
-    env->fen = 1;
 }
 
 static void alpha_cpu_class_init(ObjectClass *oc, void *data)
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a5c3088..34121f4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -81,7 +81,7 @@ void helper_store_fpcr(CPUAlphaState *env, uint64_t val)
 static uint64_t *cpu_alpha_addr_gr(CPUAlphaState *env, unsigned reg)
 {
 #ifndef CONFIG_USER_ONLY
-    if (env->pal_mode) {
+    if (env->flags & ENV_FLAG_PAL_MODE) {
         if (reg >= 8 && reg <= 14) {
             return &env->shadow[reg - 8];
         } else if (reg == 25) {
@@ -364,13 +364,13 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Remember where the exception happened.  Emulate real hardware in
        that the low bit of the PC indicates PALmode.  */
-    env->exc_addr = env->pc | env->pal_mode;
+    env->exc_addr = env->pc | (env->flags & ENV_FLAG_PAL_MODE);
 
     /* Continue execution at the PALcode entry point.  */
     env->pc = env->palbr + i;
 
     /* Switch to PALmode.  */
-    env->pal_mode = 1;
+    env->flags |= ENV_FLAG_PAL_MODE;
 #endif /* !USER_ONLY */
 }
 
@@ -381,14 +381,14 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     int idx = -1;
 
     /* We never take interrupts while in PALmode.  */
-    if (env->pal_mode) {
+    if (env->flags & ENV_FLAG_PAL_MODE) {
         return false;
     }
 
     /* Fall through the switch, collecting the highest priority
        interrupt that isn't masked by the processor status IPL.  */
     /* ??? This hard-codes the OSF/1 interrupt levels.  */
-    switch (env->ps & PS_INT_MASK) {
+    switch ((env->flags >> ENV_FLAG_PS_SHIFT) & PS_INT_MASK) {
     case 0 ... 3:
         if (interrupt_request & CPU_INTERRUPT_HARD) {
             idx = EXCP_DEV_INTERRUPT;
@@ -432,7 +432,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     int i;
 
     cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
-                env->pc, env->ps);
+                env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
     for (i = 0; i < 31; i++) {
         cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx " ", i,
                     linux_reg_names[i], cpu_alpha_load_gr(env, i));
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index a102645..0914ba5 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -48,11 +48,7 @@ static VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTL(lock_addr, CPUAlphaState),
     VMSTATE_UINTTL(lock_value, CPUAlphaState),
 
-    VMSTATE_UINT8(ps, CPUAlphaState),
-    VMSTATE_UINT8(intr_flag, CPUAlphaState),
-    VMSTATE_UINT8(pal_mode, CPUAlphaState),
-    VMSTATE_UINT8(fen, CPUAlphaState),
-
+    VMSTATE_UINT32(flags, CPUAlphaState),
     VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
 
     VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
@@ -74,8 +70,8 @@ static VMStateField vmstate_env_fields[] = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = vmstate_env_fields,
 };
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 48be19a..140d6f3 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -269,6 +269,27 @@ static TCGv dest_fpr(DisasContext *ctx, unsigned reg)
     }
 }
 
+static int get_flag_ofs(unsigned shift)
+{
+    int ofs = offsetof(CPUAlphaState, flags);
+#ifdef HOST_WORDS_BIGENDIAN
+    ofs += 3 - (shift / 8);
+#else
+    ofs += shift / 8;
+#endif
+    return ofs;
+}
+
+static void ld_flag_byte(TCGv val, unsigned shift)
+{
+    tcg_gen_ld8u_i64(val, cpu_env, get_flag_ofs(shift));
+}
+
+static void st_flag_byte(TCGv val, unsigned shift)
+{
+    tcg_gen_st8_i64(val, cpu_env, get_flag_ofs(shift));
+}
+
 static void gen_excp_1(int exception, int error_code)
 {
     TCGv_i32 tmp1, tmp2;
@@ -453,7 +474,7 @@ static ExitStatus gen_store_conditional(DisasContext *ctx, int ra, int rb,
 static bool in_superpage(DisasContext *ctx, int64_t addr)
 {
 #ifndef CONFIG_USER_ONLY
-    return ((ctx->tbflags & TB_FLAGS_USER_MODE) == 0
+    return ((ctx->tbflags & ENV_FLAG_PS_USER) == 0
             && addr >> TARGET_VIRT_ADDR_SPACE_BITS == -1
             && ((addr >> 41) & 3) == 2);
 #else
@@ -1125,16 +1146,15 @@ static void gen_msk_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 
 static void gen_rx(DisasContext *ctx, int ra, int set)
 {
-    TCGv_i32 tmp;
+    TCGv tmp;
 
     if (ra != 31) {
-        tcg_gen_ld8u_i64(ctx->ir[ra], cpu_env,
-                         offsetof(CPUAlphaState, intr_flag));
+        ld_flag_byte(ctx->ir[ra], ENV_FLAG_RX_SHIFT);
     }
 
-    tmp = tcg_const_i32(set);
-    tcg_gen_st8_i32(tmp, cpu_env, offsetof(CPUAlphaState, intr_flag));
-    tcg_temp_free_i32(tmp);
+    tmp = tcg_const_i64(set);
+    st_flag_byte(ctx->ir[ra], ENV_FLAG_RX_SHIFT);
+    tcg_temp_free(tmp);
 }
 
 static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
@@ -1168,7 +1188,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
 #ifndef CONFIG_USER_ONLY
     /* Privileged PAL code */
-    if (palcode < 0x40 && (ctx->tbflags & TB_FLAGS_USER_MODE) == 0) {
+    if (palcode < 0x40 && (ctx->tbflags & ENV_FLAG_PS_USER) == 0) {
         TCGv tmp;
         switch (palcode) {
         case 0x01:
@@ -1199,13 +1219,12 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             /* SWPIPL */
             /* Note that we already know we're in kernel mode, so we know
                that PS only contains the 3 IPL bits.  */
-            tcg_gen_ld8u_i64(ctx->ir[IR_V0], cpu_env,
-                             offsetof(CPUAlphaState, ps));
+            ld_flag_byte(ctx->ir[IR_V0], ENV_FLAG_PS_SHIFT);
 
             /* But make sure and store only the 3 IPL bits from the user.  */
             tmp = tcg_temp_new();
             tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
-            tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
+            st_flag_byte(tmp, ENV_FLAG_PS_SHIFT);
             tcg_temp_free(tmp);
 
             /* Allow interrupts to be recognized right away.  */
@@ -1214,9 +1233,9 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
         case 0x36:
             /* RDPS */
-            tcg_gen_ld8u_i64(ctx->ir[IR_V0], cpu_env,
-                             offsetof(CPUAlphaState, ps));
+            ld_flag_byte(ctx->ir[IR_V0], ENV_FLAG_PS_SHIFT);
             break;
+
         case 0x38:
             /* WRUSP */
             tcg_gen_st_i64(ctx->ir[IR_A0], cpu_env,
@@ -1259,11 +1278,11 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
         uint64_t exc_addr = ctx->pc;
         uint64_t entry = ctx->palbr;
 
-        if (ctx->tbflags & TB_FLAGS_PAL_MODE) {
+        if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
             exc_addr |= 1;
         } else {
             tcg_gen_movi_i64(tmp, 1);
-            tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, pal_mode));
+            st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
         }
 
         tcg_gen_movi_i64(tmp, exc_addr);
@@ -1293,14 +1312,11 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
 #ifndef CONFIG_USER_ONLY
 
-#define PR_BYTE         0x100000
 #define PR_LONG         0x200000
 
 static int cpu_pr_data(int pr)
 {
     switch (pr) {
-    case  0: return offsetof(CPUAlphaState, ps) | PR_BYTE;
-    case  1: return offsetof(CPUAlphaState, fen) | PR_BYTE;
     case  2: return offsetof(CPUAlphaState, pcc_ofs) | PR_LONG;
     case  3: return offsetof(CPUAlphaState, trap_arg0);
     case  4: return offsetof(CPUAlphaState, trap_arg1);
@@ -1350,14 +1366,19 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
         }
         break;
 
+    case 0: /* PS */
+        ld_flag_byte(va, ENV_FLAG_PS_SHIFT);
+        break;
+    case 1: /* FEN */
+        ld_flag_byte(va, ENV_FLAG_FEN_SHIFT);
+        break;
+
     default:
         /* The basic registers are data only, and unknown registers
            are read-zero, write-ignore.  */
         data = cpu_pr_data(regno);
         if (data == 0) {
             tcg_gen_movi_i64(va, 0);
-        } else if (data & PR_BYTE) {
-            tcg_gen_ld8u_i64(va, cpu_env, data & ~PR_BYTE);
         } else if (data & PR_LONG) {
             tcg_gen_ld32s_i64(va, cpu_env, data & ~PR_LONG);
         } else {
@@ -1417,14 +1438,19 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         tcg_gen_mov_i64(cpu_std_ir[regno], vb);
         break;
 
+    case 0: /* PS */
+        st_flag_byte(vb, ENV_FLAG_PS_SHIFT);
+        break;
+    case 1: /* FEN */
+        st_flag_byte(vb, ENV_FLAG_FEN_SHIFT);
+        break;
+
     default:
         /* The basic registers are data only, and unknown registers
            are read-zero, write-ignore.  */
         data = cpu_pr_data(regno);
         if (data != 0) {
-            if (data & PR_BYTE) {
-                tcg_gen_st8_i64(vb, cpu_env, data & ~PR_BYTE);
-            } else if (data & PR_LONG) {
+            if (data & PR_LONG) {
                 tcg_gen_st32_i64(vb, cpu_env, data & ~PR_LONG);
             } else {
                 tcg_gen_st_i64(vb, cpu_env, data);
@@ -2430,7 +2456,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x19:
         /* HW_MFPR (PALcode) */
 #ifndef CONFIG_USER_ONLY
-        REQUIRE_TB_FLAG(TB_FLAGS_PAL_MODE);
+        REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         va = dest_gpr(ctx, ra);
         ret = gen_mfpr(ctx, va, insn & 0xffff);
         break;
@@ -2452,7 +2478,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x1B:
         /* HW_LD (PALcode) */
 #ifndef CONFIG_USER_ONLY
-        REQUIRE_TB_FLAG(TB_FLAGS_PAL_MODE);
+        REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             TCGv addr = tcg_temp_new();
             vb = load_gpr(ctx, rb);
@@ -2674,7 +2700,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x1D:
         /* HW_MTPR (PALcode) */
 #ifndef CONFIG_USER_ONLY
-        REQUIRE_TB_FLAG(TB_FLAGS_PAL_MODE);
+        REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         vb = load_gpr(ctx, rb);
         ret = gen_mtpr(ctx, vb, insn & 0xffff);
         break;
@@ -2685,7 +2711,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x1E:
         /* HW_RET (PALcode) */
 #ifndef CONFIG_USER_ONLY
-        REQUIRE_TB_FLAG(TB_FLAGS_PAL_MODE);
+        REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         if (rb == 31) {
             /* Pre-EV6 CPUs interpreted this as HW_REI, loading the return
                address from EXC_ADDR.  This turns out to be useful for our
@@ -2695,12 +2721,13 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         } else {
             vb = load_gpr(ctx, rb);
         }
+        tcg_gen_movi_i64(cpu_lock_addr, -1);
         tmp = tcg_temp_new();
         tcg_gen_movi_i64(tmp, 0);
-        tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, intr_flag));
-        tcg_gen_movi_i64(cpu_lock_addr, -1);
+        st_flag_byte(tmp, ENV_FLAG_RX_SHIFT);
         tcg_gen_andi_i64(tmp, vb, 1);
-        tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, pal_mode));
+        st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
+        tcg_temp_free(tmp);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
         /* Allow interrupts to be recognized right away.  */
         ret = EXIT_PC_UPDATED_NOCHAIN;
@@ -2712,7 +2739,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x1F:
         /* HW_ST (PALcode) */
 #ifndef CONFIG_USER_ONLY
-        REQUIRE_TB_FLAG(TB_FLAGS_PAL_MODE);
+        REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             switch ((insn >> 12) & 0xF) {
             case 0x0:
@@ -2943,7 +2970,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     ctx.ir = cpu_std_ir;
 #else
     ctx.palbr = env->palbr;
-    ctx.ir = (ctx.tbflags & TB_FLAGS_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
+    ctx.ir = (ctx.tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
 #endif
 
     /* ??? Every TB begins with unset rounding mode, to be initialized on
-- 
2.9.4
