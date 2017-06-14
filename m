Received: from eggs.gnu.org ([2001:4830:134:3::10]:54029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHH-00014g-Ut
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHH-0008VM-2c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:32 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLEHG-0008Ux-UD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:30 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so2208233qtg.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:48:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 12:48:20 -0700
Message-Id: <20170614194821.8754-5-rth@twiddle.net>
In-Reply-To: <20170614194821.8754-1-rth@twiddle.net>
References: <20170614194821.8754-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 4/5] target/s390x: Exit after changing PSW
 mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com

Exit to cpu loop so we reevaluate cpu_s390x_hw_interrupts.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c |  2 +-
 target/s390x/translate.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a48e451..232af9e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1207,7 +1207,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             tcg_temp_free(tmp);
 
             /* Allow interrupts to be recognized right away.  */
-            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            tcg_gen_movi_i64(cpu_pc, ctx->pc);
             return EXIT_PC_UPDATED_NOCHAIN;
 
         case 0x36:
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 95f91d4..c9e3b81 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1174,6 +1174,8 @@ typedef enum {
     /* We are exiting the TB, but have neither emitted a goto_tb, nor
        updated the PC for the next instruction to be executed.  */
     EXIT_PC_STALE,
+    /* We are exiting the TB to the main loop.  */
+    EXIT_PC_STALE_NOCHAIN,
     /* We are ending the TB with a noreturn function call, e.g. longjmp.
        No following code will be executed.  */
     EXIT_NORETURN,
@@ -3796,7 +3798,8 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, 56, 8);
-    return NO_EXIT;
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_stap(DisasContext *s, DisasOps *o)
@@ -4044,7 +4047,9 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
     } else {
         tcg_gen_ori_i64(psw_mask, psw_mask, i2 << 56);
     }
-    return NO_EXIT;
+
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_stura(DisasContext *s, DisasOps *o)
@@ -5794,6 +5799,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     case EXIT_NORETURN:
         break;
     case EXIT_PC_STALE:
+    case EXIT_PC_STALE_NOCHAIN:
         update_psw_addr(&dc);
         /* FALLTHRU */
     case EXIT_PC_UPDATED:
@@ -5805,14 +5811,14 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (do_debug) {
             gen_exception(EXCP_DEBUG);
-        } else if (use_exit_tb(&dc)) {
+        } else if (use_exit_tb(&dc) || status == EXIT_PC_STALE_NOCHAIN) {
             tcg_gen_exit_tb(0);
         } else {
             tcg_gen_lookup_and_goto_ptr(psw_addr);
         }
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
     gen_tb_end(tb, num_insns);
-- 
2.9.4
