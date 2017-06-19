Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GK-0008Rc-Hv
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GJ-0002IS-Lv
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:56 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GJ-0002I4-Fo
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:55 -0400
Received: by mail-pg0-x241.google.com with SMTP id f127so17441853pgc.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:38 -0700
Message-Id: <20170619181839.25249-12-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/12] target/s390x: Exit after changing PSW mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Exit to cpu loop so we reevaluate cpu_s390x_hw_interrupts.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8c055b7..6403542 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1173,6 +1173,8 @@ typedef enum {
     /* We are exiting the TB, but have neither emitted a goto_tb, nor
        updated the PC for the next instruction to be executed.  */
     EXIT_PC_STALE,
+    /* We are exiting the TB to the main loop.  */
+    EXIT_PC_STALE_NOCHAIN,
     /* We are ending the TB with a noreturn function call, e.g. longjmp.
        No following code will be executed.  */
     EXIT_NORETURN,
@@ -3795,7 +3797,8 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, 56, 8);
-    return NO_EXIT;
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_stap(DisasContext *s, DisasOps *o)
@@ -4038,7 +4041,9 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
     } else {
         tcg_gen_ori_i64(psw_mask, psw_mask, i2 << 56);
     }
-    return NO_EXIT;
+
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_stura(DisasContext *s, DisasOps *o)
@@ -5788,6 +5793,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     case EXIT_NORETURN:
         break;
     case EXIT_PC_STALE:
+    case EXIT_PC_STALE_NOCHAIN:
         update_psw_addr(&dc);
         /* FALLTHRU */
     case EXIT_PC_UPDATED:
@@ -5799,14 +5805,14 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
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
