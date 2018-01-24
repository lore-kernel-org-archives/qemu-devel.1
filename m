Received: from eggs.gnu.org ([2001:4830:134:3::10]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURJ-0004SS-C2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURH-0001eC-AO
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:45 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURH-0001dt-2e
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:43 -0500
Received: by mail-pg0-x242.google.com with SMTP id n17so3805629pgf.10
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:26:42 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:25:49 -0800
Message-Id: <20180124232625.30105-10-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/45] target/hppa: Add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_cpu.h |  2 +-
 target/hppa/cpu.h            | 23 +++++++++++----
 linux-user/main.c            |  4 +--
 linux-user/signal.c          |  4 +--
 target/hppa/gdbstub.c        | 12 ++++----
 target/hppa/mem_helper.c     |  2 +-
 target/hppa/translate.c      | 70 ++++++++++++++++++++++++++++++--------------
 7 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index e50522eae9..7b78bbea80 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -33,7 +33,7 @@ static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
 
 static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
 {
-    env->cr27 = newtls;
+    env->cr[27] = newtls;
 }
 
 #endif
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 24c728c0d2..c92c564a7f 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -123,6 +123,20 @@
 #define PSW_SM_W         0
 #endif
 
+#define CR_RC            0
+#define CR_SCRCCR        10
+#define CR_SAR           11
+#define CR_IVA           14
+#define CR_EIEM          15
+#define CR_IT            16
+#define CR_IIASQ         17
+#define CR_IIAOQ         18
+#define CR_IIR           19
+#define CR_ISR           20
+#define CR_IOR           21
+#define CR_IPSW          22
+#define CR_EIRR          23
+
 typedef struct CPUHPPAState CPUHPPAState;
 
 #if TARGET_REGISTER_BITS == 32
@@ -142,10 +156,6 @@ struct CPUHPPAState {
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
-    target_ureg sar;
-    target_ureg cr26;
-    target_ureg cr27;
-
     target_ureg psw;         /* All psw bits except the following:  */
     target_ureg psw_n;       /* boolean */
     target_sreg psw_v;       /* in most significant bit */
@@ -163,11 +173,12 @@ struct CPUHPPAState {
     target_ureg iaoq_f;      /* front */
     target_ureg iaoq_b;      /* back, aka next instruction */
 
-    target_ureg ior;         /* interrupt offset register */
-
     uint32_t fr0_shadow;     /* flags, c, ca/cq, rm, d, enables */
     float_status fp_status;
 
+    target_ureg cr[32];      /* control registers */
+    target_ureg cr_back[2];  /* back of cr17/cr18 */
+
     /* Those resources are used only in QEMU core */
     CPU_COMMON
 };
diff --git a/linux-user/main.c b/linux-user/main.c
index 42f4c66ce6..90ae447368 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3781,14 +3781,14 @@ void cpu_loop(CPUHPPAState *env)
             info.si_signo = TARGET_SIGSEGV;
             info.si_errno = 0;
             info.si_code = TARGET_SEGV_ACCERR;
-            info._sifields._sigfault._addr = env->ior;
+            info._sifields._sigfault._addr = env->cr[CR_IOR];
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_UNALIGN:
             info.si_signo = TARGET_SIGBUS;
             info.si_errno = 0;
             info.si_code = 0;
-            info._sifields._sigfault._addr = env->ior;
+            info._sifields._sigfault._addr = env->cr[CR_IOR];
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ILL:
diff --git a/linux-user/signal.c b/linux-user/signal.c
index f85f0dd780..40d5d849f0 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6440,7 +6440,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
         __put_user(env->fr[i], &sc->sc_fr[i]);
     }
 
-    __put_user(env->sar, &sc->sc_sar);
+    __put_user(env->cr[CR_SAR], &sc->sc_sar);
 }
 
 static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
@@ -6461,7 +6461,7 @@ static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
 
     __get_user(env->iaoq_f, &sc->sc_iaoq[0]);
     __get_user(env->iaoq_b, &sc->sc_iaoq[1]);
-    __get_user(env->sar, &sc->sc_sar);
+    __get_user(env->cr[CR_SAR], &sc->sc_sar);
 }
 
 /* No, this doesn't look right, but it's copied straight from the kernel.  */
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 228d282fe9..fc27aec073 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -36,7 +36,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         val = env->gr[n];
         break;
     case 32:
-        val = env->sar;
+        val = env->cr[CR_SAR];
         break;
     case 33:
         val = env->iaoq_f;
@@ -45,10 +45,10 @@ int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         val = env->iaoq_b;
         break;
     case 59:
-        val = env->cr26;
+        val = env->cr[26];
         break;
     case 60:
-        val = env->cr27;
+        val = env->cr[27];
         break;
     case 64 ... 127:
         val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
@@ -89,7 +89,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gr[n] = val;
         break;
     case 32:
-        env->sar = val;
+        env->cr[CR_SAR] = val;
         break;
     case 33:
         env->iaoq_f = val;
@@ -98,10 +98,10 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->iaoq_b = val;
         break;
     case 59:
-        env->cr26 = val;
+        env->cr[26] = val;
         break;
     case 60:
-        env->cr27 = val;
+        env->cr[27] = val;
         break;
     case 64:
         env->fr[0] = deposit64(env->fr[0], 32, 32, val);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 2901f3e29c..1afaf89539 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -32,7 +32,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
     /* ??? Test between data page fault and data memory protection trap,
        which would affect si_code.  */
     cs->exception_index = EXCP_DMP;
-    cpu->env.ior = address;
+    cpu->env.cr[CR_IOR] = address;
     return 1;
 }
 #else
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 50d41b0c63..89b336c2c4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -328,8 +328,6 @@ static TCGv_reg cpu_psw_n;
 static TCGv_reg cpu_psw_v;
 static TCGv_reg cpu_psw_cb;
 static TCGv_reg cpu_psw_cb_msb;
-static TCGv_reg cpu_cr26;
-static TCGv_reg cpu_cr27;
 
 #include "exec/gen-icount.h"
 
@@ -339,9 +337,7 @@ void hppa_translate_init(void)
 
     typedef struct { TCGv_reg *var; const char *name; int ofs; } GlobalVar;
     static const GlobalVar vars[] = {
-        DEF_VAR(sar),
-        DEF_VAR(cr26),
-        DEF_VAR(cr27),
+        { &cpu_sar, "sar", offsetof(CPUHPPAState, cr[CR_SAR]) },
         DEF_VAR(psw_n),
         DEF_VAR(psw_v),
         DEF_VAR(psw_cb),
@@ -1867,7 +1863,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
         return DISAS_NORETURN;
 
     case 0xe0: /* SET_THREAD_POINTER */
-        tcg_gen_mov_reg(cpu_cr27, cpu_gr[26]);
+        tcg_gen_st_reg(cpu_gr[26], cpu_env, offsetof(CPUHPPAState, cr[27]));
         tcg_gen_mov_reg(cpu_iaoq_f, cpu_gr[31]);
         tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
         return DISAS_IAQ_N_UPDATED;
@@ -1948,34 +1944,39 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
     TCGv_reg tmp;
 
     switch (ctl) {
-    case 11: /* SAR */
+    case CR_SAR:
 #ifdef TARGET_HPPA64
         if (extract32(insn, 14, 1) == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
             tcg_gen_andi_reg(tmp, cpu_sar, 31);
             save_gpr(ctx, rt, tmp);
-            break;
+            goto done;
         }
 #endif
         save_gpr(ctx, rt, cpu_sar);
-        break;
-    case 16: /* Interval Timer */
+        goto done;
+    case CR_IT: /* Interval Timer */
+        /* FIXME: Respect PSW_S bit.  */
+        nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
-        tcg_gen_movi_tl(tmp, 0); /* FIXME */
+        tcg_gen_movi_reg(tmp, 0); /* FIXME */
         save_gpr(ctx, rt, tmp);
         break;
     case 26:
-        save_gpr(ctx, rt, cpu_cr26);
-        break;
     case 27:
-        save_gpr(ctx, rt, cpu_cr27);
         break;
     default:
         /* All other control registers are privileged.  */
-        return gen_illegal(ctx);
+        CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
+        break;
     }
 
+    tmp = get_temp(ctx);
+    tcg_gen_ld_reg(tmp, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
+    save_gpr(ctx, rt, tmp);
+
+ done:
     cond_free(&ctx->null_cond);
     return DISAS_NEXT;
 }
@@ -2011,20 +2012,45 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
 {
     unsigned rin = extract32(insn, 16, 5);
     unsigned ctl = extract32(insn, 21, 5);
+    TCGv_reg reg = load_gpr(ctx, rin);
     TCGv_reg tmp;
 
-    if (ctl == 11) { /* SAR */
+    if (ctl == CR_SAR) {
         tmp = tcg_temp_new();
-        tcg_gen_andi_reg(tmp, load_gpr(ctx, rin), TARGET_REGISTER_BITS - 1);
+        tcg_gen_andi_reg(tmp, reg, TARGET_REGISTER_BITS - 1);
         save_or_nullify(ctx, cpu_sar, tmp);
         tcg_temp_free(tmp);
-    } else {
-        /* All other control registers are privileged or read-only.  */
-        return gen_illegal(ctx);
+
+        cond_free(&ctx->null_cond);
+        return DISAS_NEXT;
     }
 
-    cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    /* All other control registers are privileged or read-only.  */
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
+
+    nullify_over(ctx);
+    switch (ctl) {
+    case CR_IT:
+        /* ??? modify interval timer offset */
+        break;
+
+    case CR_IIASQ:
+    case CR_IIAOQ:
+        /* FIXME: Respect PSW_Q bit */
+        /* The write advances the queue and stores to the back element.  */
+        tmp = get_temp(ctx);
+        tcg_gen_ld_reg(tmp, cpu_env,
+                       offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
+        tcg_gen_st_reg(tmp, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
+        tcg_gen_st_reg(reg, cpu_env,
+                       offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
+        break;
+
+    default:
+        tcg_gen_st_reg(reg, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
+        break;
+    }
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
-- 
2.14.3
