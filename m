Received: from eggs.gnu.org ([2001:4830:134:3::10]:35450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNT-00017d-Mc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-0002Xe-1c
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:64013)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNR-0002X9-Ps
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:29 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:13 +0100
Message-ID: <1501771515-22847-7-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 6/8] target/mips: Use BS_EXCP where interrupts
 are expected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

From: James Hogan <james.hogan@imgtec.com>

Commit e350d8ca3ac7 ("target/mips: optimize indirect branches") made
indirect branches able to directly find the next TB and jump straight to
it without breaking out of translated code and going around the main
execution loop. This breaks the assumption in target/mips/translate.c
that BS_STOP is sufficient to cause pending interrupts to be handled,
since interrupts are only checked in the main loop.

Fix a few of these assumptions by using gen_save_pc to update the saved
PC and using BS_EXCP instead of BS_STOP:

 - [D]MFC0 CP0_Count may trigger a timer interrupt which should be
   immediately handled.

 - [D]MTC0 CP0_Cause may trigger an interrupt (but in fact translation
   was only even being stopped in the DMTC0 case).

 - [D]MTC0 CP0_<any> when icount is used is assumed could potentially
   cause interrupts.

 - EI may trigger an interrupt which was pending. I specifically hit
   this case when running KVM nested in mipsel-softmmu. A timer
   interrupt while the 2nd guest was executing is caught by KVM which
   switches back to the normal Linux exception base and re-enables
   interrupts with EI. Since the above commit QEMU doesn't leave
   translated code until the nested KVM has already restored the KVM
   exception base and returned to the 2nd guest, at which point it is
   too late to check for pending interrupts and it gets stuck in an
   infinite loop of unhandled interrupts.

Something similar was needed for ARM in commit b29fd33db578
("target/arm: use DISAS_EXIT for eret handling").

Fixes: e350d8ca3ac7 ("target/mips: optimize indirect branches")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 88f518b..ba6b8f5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5334,8 +5334,10 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
-               after reading count.  */
-            ctx->bstate = BS_STOP;
+               after reading count. BS_STOP isn't sufficient, we need to ensure
+               we break completely out of translated code.  */
+            gen_save_pc(ctx->pc + 4);
+            ctx->bstate = BS_EXCP;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -6061,6 +6063,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_cause(cpu_env, arg);
+            /* Stop translation as we may have triggered an interrupt. BS_STOP
+             * isn't sufficient, we need to ensure we break out of translated
+             * code to check for pending interrupts.  */
+            gen_save_pc(ctx->pc + 4);
+            ctx->bstate = BS_EXCP;
             rn = "Cause";
             break;
         default:
@@ -6395,7 +6402,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
-        ctx->bstate = BS_STOP;
+        /* BS_STOP isn't sufficient, we need to ensure we break out of
+         * translated code to check for pending interrupts.  */
+        gen_save_pc(ctx->pc + 4);
+        ctx->bstate = BS_EXCP;
     }
     return;
 
@@ -6676,8 +6686,10 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
-               after reading count.  */
-            ctx->bstate = BS_STOP;
+               after reading count. BS_STOP isn't sufficient, we need to ensure
+               we break completely out of translated code.  */
+            gen_save_pc(ctx->pc + 4);
+            ctx->bstate = BS_EXCP;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -7398,8 +7410,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
                 gen_io_end();
             }
-            /* Stop translation as we may have triggered an intetrupt */
-            ctx->bstate = BS_STOP;
+            /* Stop translation as we may have triggered an intetrupt. BS_STOP
+             * isn't sufficient, we need to ensure we break out of translated
+             * code to check for pending interrupts.  */
+            gen_save_pc(ctx->pc + 4);
+            ctx->bstate = BS_EXCP;
             rn = "Cause";
             break;
         default:
@@ -7721,7 +7736,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
-        ctx->bstate = BS_STOP;
+        /* BS_STOP isn't sufficient, we need to ensure we break out of
+         * translated code to check for pending interrupts.  */
+        gen_save_pc(ctx->pc + 4);
+        ctx->bstate = BS_EXCP;
     }
     return;
 
@@ -13565,8 +13583,10 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, cpu_env);
                 gen_store_gpr(t0, rs);
-                /* Stop translation as we may have switched the execution mode */
-                ctx->bstate = BS_STOP;
+                /* BS_STOP isn't sufficient, we need to ensure we break out
+                   of translated code to check for pending interrupts.  */
+                gen_save_pc(ctx->pc + 4);
+                ctx->bstate = BS_EXCP;
                 tcg_temp_free(t0);
             }
             break;
@@ -19688,9 +19708,10 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                     save_cpu_state(ctx, 1);
                     gen_helper_ei(t0, cpu_env);
                     gen_store_gpr(t0, rt);
-                    /* Stop translation as we may have switched
-                       the execution mode.  */
-                    ctx->bstate = BS_STOP;
+                    /* BS_STOP isn't sufficient, we need to ensure we break out
+                       of translated code to check for pending interrupts.  */
+                    gen_save_pc(ctx->pc + 4);
+                    ctx->bstate = BS_EXCP;
                     break;
                 default:            /* Invalid */
                     MIPS_INVAL("mfmc0");
-- 
2.7.4
