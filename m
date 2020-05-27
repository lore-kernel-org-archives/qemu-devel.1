Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EFB20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AXEXHJwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EFB20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoot-00084Z-6u
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolm-0001CL-KT; Wed, 27 May 2020 01:38:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolk-0001eP-Tg; Wed, 27 May 2020 01:38:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03q5ZCNz9sSw; Wed, 27 May 2020 15:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557895;
 bh=X5fEee/H/+vjeon4K7GwbpFEEkKSFFv14BcGu5OJURw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AXEXHJwa1Oo8tLScRhq+ReihYcpaMLqrjqbOmDlcuL57dZsY3JvLz0OY+Jm6Y4Jou
 FNCVkRZ/2oZwv/BqVsQjVsjKSuuPfXGgl4lOEdWDhRPxGv80ObQunHw6nTonQO3tgf
 TcKUazt98kebUHjX42gnG4vyzbpaWCVRmQmOByCM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/15] target/ppc: Add support for scv and rfscv instructions
Date: Wed, 27 May 2020 15:37:58 +1000
Message-Id: <20200527053809.356168-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

POWER9 adds scv and rfscv instructions and the system call vectored
interrupt. Linux does not support this instruction yet but it has
been tested with a modified kernel that runs on real hardware.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200507115328.789175-1-npiggin@gmail.com>
[dwg: Corrected an overlong line]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 linux-user/ppc/cpu_loop.c       |  1 +
 target/ppc/cpu.h                |  7 ++-
 target/ppc/excp_helper.c        | 98 ++++++++++++++++++++++++---------
 target/ppc/helper.h             |  1 +
 target/ppc/translate.c          | 53 +++++++++++++++++-
 target/ppc/translate_init.inc.c |  3 +-
 6 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 5b27f8603e..df71e15a25 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -267,6 +267,7 @@ void cpu_loop(CPUPPCState *env)
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case POWERPC_EXCP_SYSCALL:  /* System call exception                 */
+        case POWERPC_EXCP_SYSCALL_VECTORED:
             cpu_abort(cs, "Syscall exception while in user mode. "
                       "Aborting\n");
             break;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7db7882f52..c1005b04a0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -127,8 +127,9 @@ enum {
     POWERPC_EXCP_SDOOR_HV = 100,
     /* ISA 3.00 additions */
     POWERPC_EXCP_HVIRT    = 101,
+    POWERPC_EXCP_SYSCALL_VECTORED = 102, /* scv exception                     */
     /* EOL                                                                   */
-    POWERPC_EXCP_NB       = 102,
+    POWERPC_EXCP_NB       = 103,
     /* QEMU exceptions: used internally during code translation              */
     POWERPC_EXCP_STOP         = 0x200, /* stop translation                   */
     POWERPC_EXCP_BRANCH       = 0x201, /* branch instruction                 */
@@ -478,6 +479,7 @@ typedef struct ppc_v3_pate_t {
 /* Facility Status and Control (FSCR) bits */
 #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
 #define FSCR_TAR        (63 - 55) /* Target Address Register */
+#define FSCR_SCV        (63 - 51) /* System call vectored */
 /* Interrupt cause mask and position in FSCR. HFSCR has the same format */
 #define FSCR_IC_MASK    (0xFFULL)
 #define FSCR_IC_POS     (63 - 7)
@@ -487,6 +489,7 @@ typedef struct ppc_v3_pate_t {
 #define FSCR_IC_TM          5
 #define FSCR_IC_EBB         7
 #define FSCR_IC_TAR         8
+#define FSCR_IC_SCV        12
 
 /* Exception state register bits definition                                  */
 #define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    */
@@ -554,6 +557,8 @@ enum {
     POWERPC_FLAG_VSX      = 0x00080000,
     /* Has Transaction Memory (ISA 2.07)                                     */
     POWERPC_FLAG_TM       = 0x00100000,
+    /* Has SCV (ISA 3.00)                                                    */
+    POWERPC_FLAG_SCV      = 0x00200000,
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index ace8620026..14d3902982 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -67,6 +67,18 @@ static inline void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 8), env->nip);
 }
 
+static inline void dump_syscall_vectored(CPUPPCState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
+                  " r3=%016" PRIx64 " r4=%016" PRIx64 " r5=%016" PRIx64
+                  " r6=%016" PRIx64 " r7=%016" PRIx64 " r8=%016" PRIx64
+                  " nip=" TARGET_FMT_lx "\n",
+                  ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
+                  ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
+                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
+                  ppc_dump_gpr(env, 8), env->nip);
+}
+
 static inline void dump_hcall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "hypercall r3=%016" PRIx64
@@ -185,7 +197,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1, asrr0, asrr1, lev, ail;
+    int srr0, srr1, asrr0, asrr1, lev = -1, ail;
     bool lpes0;
 
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
@@ -421,6 +433,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         }
         break;
+    case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
+        lev = env->error_code;
+        dump_syscall_vectored(env);
+        env->nip += 4;
+        new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
+        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+        break;
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
     case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable          */
     case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
@@ -724,12 +743,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         break;
     }
 
-    /* Save PC */
-    env->spr[srr0] = env->nip;
-
-    /* Save MSR */
-    env->spr[srr1] = msr;
-
     /* Sanity check */
     if (!(env->msr_mask & MSR_HVB)) {
         if (new_msr & MSR_HVB) {
@@ -742,14 +755,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         }
     }
 
-    /* If any alternate SRR register are defined, duplicate saved values */
-    if (asrr0 != -1) {
-        env->spr[asrr0] = env->spr[srr0];
-    }
-    if (asrr1 != -1) {
-        env->spr[asrr1] = env->spr[srr1];
-    }
-
     /*
      * Sort out endianness of interrupt, this differs depending on the
      * CPU, the HV mode, etc...
@@ -784,14 +789,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     }
 #endif
 
-    /* Jump to handler */
-    vector = env->excp_vectors[excp];
-    if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
-    }
-    vector |= env->excp_prefix;
-
     /*
      * AIL only works if there is no HV transition and we are running
      * with translations enabled
@@ -800,10 +797,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         ((new_msr & MSR_HVB) && !(msr & MSR_HVB))) {
         ail = 0;
     }
-    /* Handle AIL */
-    if (ail) {
-        new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
-        vector |= ppc_excp_vector_offset(cs, ail);
+
+    vector = env->excp_vectors[excp];
+    if (vector == (target_ulong)-1ULL) {
+        cpu_abort(cs, "Raised an exception without defined vector %d\n",
+                  excp);
+    }
+
+    vector |= env->excp_prefix;
+
+    /* If any alternate SRR register are defined, duplicate saved values */
+    if (asrr0 != -1) {
+        env->spr[asrr0] = env->nip;
+    }
+    if (asrr1 != -1) {
+        env->spr[asrr1] = msr;
     }
 
 #if defined(TARGET_PPC64)
@@ -823,6 +831,37 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     }
 #endif
 
+    if (excp != POWERPC_EXCP_SYSCALL_VECTORED) {
+        /* Save PC */
+        env->spr[srr0] = env->nip;
+
+        /* Save MSR */
+        env->spr[srr1] = msr;
+
+        /* Handle AIL */
+        if (ail) {
+            new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
+            vector |= ppc_excp_vector_offset(cs, ail);
+        }
+
+#if defined(TARGET_PPC64)
+    } else {
+        /* scv AIL is a little different */
+        if (ail) {
+            new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
+        }
+        if (ail == AIL_C000_0000_0000_4000) {
+            vector |= 0xc000000000003000ull;
+        } else {
+            vector |= 0x0000000000017000ull;
+        }
+        vector += lev * 0x20;
+
+        env->lr = env->nip;
+        env->ctr = msr;
+#endif
+    }
+
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1160,6 +1199,11 @@ void helper_rfid(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
 }
 
+void helper_rfscv(CPUPPCState *env)
+{
+    do_rfi(env, env->lr, env->ctr);
+}
+
 void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a95c010391..2dfa1c6942 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -15,6 +15,7 @@ DEF_HELPER_1(rfmci, void, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_2(pminsn, void, env, i32)
 DEF_HELPER_1(rfid, void, env)
+DEF_HELPER_1(rfscv, void, env)
 DEF_HELPER_1(hrfid, void, env)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 338529879f..4ce3d664b5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -173,6 +173,7 @@ struct DisasContext {
     bool vsx_enabled;
     bool spe_enabled;
     bool tm_enabled;
+    bool scv_enabled;
     bool gtse;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
@@ -4030,6 +4031,24 @@ static void gen_rfid(DisasContext *ctx)
 #endif
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static void gen_rfscv(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    /* Restore CPU state */
+    CHK_SV;
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
+    gen_helper_rfscv(cpu_env);
+    gen_sync_exception(ctx);
+#endif
+}
+#endif
+
 static void gen_hrfid(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -4048,6 +4067,7 @@ static void gen_hrfid(DisasContext *ctx)
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
 #else
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
+#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
 #endif
 static void gen_sc(DisasContext *ctx)
 {
@@ -4057,6 +4077,23 @@ static void gen_sc(DisasContext *ctx)
     gen_exception_err(ctx, POWERPC_SYSCALL, lev);
 }
 
+#if defined(TARGET_PPC64)
+#if !defined(CONFIG_USER_ONLY)
+static void gen_scv(DisasContext *ctx)
+{
+    uint32_t lev;
+
+    if (unlikely(!ctx->scv_enabled)) {
+        gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_SCV);
+        return;
+    }
+
+    lev = (ctx->opcode >> 5) & 0x7F;
+    gen_exception_err(ctx, POWERPC_SYSCALL_VECTORED, lev);
+}
+#endif
+#endif
+
 /***                                Trap                                   ***/
 
 /* Check for unconditional traps (always or never) */
@@ -7049,6 +7086,12 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
+#if !defined(CONFIG_USER_ONLY)
+/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
+GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
+#endif
 GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
@@ -7056,7 +7099,9 @@ GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 #endif
-GEN_HANDLER(sc, 0x11, 0xFF, 0xFF, 0x03FFF01D, PPC_FLOW),
+/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
+GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
+GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(tw, 0x1F, 0x04, 0x00, 0x00000001, PPC_FLOW),
 GEN_HANDLER(twi, 0x03, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 #if defined(TARGET_PPC64)
@@ -7835,6 +7880,12 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     } else {
         ctx->vsx_enabled = false;
     }
+    if ((env->flags & POWERPC_FLAG_SCV)
+        && (env->spr[SPR_FSCR] & (1ull << FSCR_SCV))) {
+        ctx->scv_enabled = true;
+    } else {
+        ctx->scv_enabled = false;
+    }
 #if defined(TARGET_PPC64)
     if ((env->flags & POWERPC_FLAG_TM) && msr_tm) {
         ctx->tm_enabled = !!msr_tm;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d8adc1bd49..38cb773ab4 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -3382,6 +3382,7 @@ static void init_excp_POWER9(CPUPPCState *env)
 
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_HVIRT]    = 0x00000EA0;
+    env->excp_vectors[POWERPC_EXCP_SYSCALL_VECTORED] = 0x00000000;
 #endif
 }
 
@@ -9030,7 +9031,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_lpcr;
-- 
2.26.2


