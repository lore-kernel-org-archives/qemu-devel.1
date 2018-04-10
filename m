Received: from eggs.gnu.org ([2001:4830:134:3::10]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5uBP-0007Fx-6Y
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5uBK-0007Wj-Nh
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5uBK-0007WS-DL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:34 -0400
Date: Tue, 10 Apr 2018 10:23:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180410142332.GA22989@flamenco>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-7-git-send-email-cota@braap.org>
	<a95ec4d4-72f7-486d-4123-a7bd4740cf03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95ec4d4-72f7-486d-4123-a7bd4740cf03@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/17] target/mips: convert to
 DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Tue, Apr 10, 2018 at 13:56:25 +1000, Richard Henderson wrote:
> Ok, well, there are existing bugs within the MIPS translation here, and we
> might as well fix them within this patch set.
> 
> (1) The description for BS_STOP says we want to stop, but (what will become)
> mips_tr_tb_stop calls goto_tb.
> 
> That's not correct, since we use that after e.g. helper_mtc0_hwrena,
> MIPS_HFLAG_HWRENA_ULR is included in tb->flags, and therefore the next TB is
> not fixed but depends on the actual value stored into hwrena.
> 
> We should instead use lookup_and_goto_ptr, which does a full lookup of the
> processor state every time through.

I thought I understood what you meant here but the corresponding change
doesn't seem to work; without the change I can boot a guest in ~1m20s;
with it, boot-up gets stuck -- or at the very least, it's so slow that
I'm giving up after 3+ minutes. The change I made:

--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20339,7 +20339,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } else {
         switch (ctx.is_jmp) {
         case DISAS_STOP:
-            gen_goto_tb(&ctx, 0, ctx.pc);
+            tcg_gen_lookup_and_goto_ptr();
             break;

So I'm afraid I don't understand what the change should be, then.

> (2) The BS_EXCP in generate_exception_err should map to DISAS_NORETURN, because
> we do not return after raising an exception.
> 
> (3) Otherwise, the use of BS_EXCP has nothing to do with an exception; e.g.
> 
> >         case 0:
> >             save_cpu_state(ctx, 1);
> >             gen_helper_mtc0_status(cpu_env, arg);
> >             /* BS_STOP isn't good enough here, hflags may have changed. */
> >             gen_save_pc(ctx->pc + 4);
> >             ctx->bstate = BS_EXCP;
> >             rn = "Status";
> >             break;
> 
> where we are in fact relying on (what will become) mips_tr_tb_stop to emit
> exit_tb.  It would be better to name these uses DISAS_EXIT, which would match
> e.g. target/arm.

Thanks for this -- delta with (2) and (3) below.

		Emilio
---
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 99ecfa1..4183ec2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1463,6 +1463,7 @@ typedef struct DisasContext {
 
 #define DISAS_STOP       DISAS_TARGET_0
 #define DISAS_EXCP       DISAS_TARGET_1
+#define DISAS_EXIT       DISAS_TARGET_2
 
 static const char * const regnames[] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
@@ -1635,7 +1636,7 @@ static inline void generate_exception_err(DisasContext *ctx, int excp, int err)
     gen_helper_raise_exception_err(cpu_env, texcp, terr);
     tcg_temp_free_i32(terr);
     tcg_temp_free_i32(texcp);
-    ctx->is_jmp = DISAS_EXCP;
+    ctx->is_jmp = DISAS_NORETURN;
 }
 
 static inline void generate_exception(DisasContext *ctx, int excp)
@@ -5333,7 +5334,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                after reading count. DISAS_STOP isn't sufficient, we need to
                ensure we break completely out of translated code.  */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -6026,7 +6027,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Status";
             break;
         case 1:
@@ -6063,7 +6064,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
              * DISAS_STOP isn't sufficient, we need to ensure we break out of
              * translated code to check for pending interrupts.  */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Cause";
             break;
         default:
@@ -6219,7 +6220,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Debug";
             break;
         case 1:
@@ -6401,7 +6402,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
         gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXCP;
+        ctx->is_jmp = DISAS_EXIT;
     }
     return;
 
@@ -6685,7 +6686,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                after reading count. DISAS_STOP isn't sufficient, we need to
                ensure we break completely out of translated code.  */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -7365,7 +7366,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Status";
             break;
         case 1:
@@ -7402,7 +7403,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
              * DISAS_STOP isn't sufficient, we need to ensure we break out of
              * translated code to check for pending interrupts.  */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Cause";
             break;
         default:
@@ -7547,7 +7548,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXCP;
+            ctx->is_jmp = DISAS_EXIT;
             rn = "Debug";
             break;
         case 1:
@@ -7727,7 +7728,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
         gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXCP;
+        ctx->is_jmp = DISAS_EXIT;
     }
     return;
 
@@ -10763,7 +10764,7 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
            after reading count. DISAS_STOP isn't sufficient, we need to ensure
            we break completely out of translated code.  */
         gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXCP;
+        ctx->is_jmp = DISAS_EXIT;
         break;
     case 3:
         gen_helper_rdhwr_ccres(t0, cpu_env);
@@ -13585,7 +13586,7 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 /* DISAS_STOP isn't sufficient, we need to ensure we break out
                    of translated code to check for pending interrupts.  */
                 gen_save_pc(ctx->pc + 4);
-                ctx->is_jmp = DISAS_EXCP;
+                ctx->is_jmp = DISAS_EXIT;
                 tcg_temp_free(t0);
             }
             break;
@@ -19710,7 +19711,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                     /* DISAS_STOP isn't sufficient, we need to ensure we break
                        out of translated code to check for pending interrupts */
                     gen_save_pc(ctx->pc + 4);
-                    ctx->is_jmp = DISAS_EXCP;
+                    ctx->is_jmp = DISAS_EXIT;
                     break;
                 default:            /* Invalid */
                     MIPS_INVAL("mfmc0");
@@ -20346,6 +20347,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             gen_goto_tb(&ctx, 0, ctx.pc);
             break;
         case DISAS_EXCP:
+        case DISAS_EXIT:
             tcg_gen_exit_tb(0);
             break;
         case DISAS_NORETURN:
