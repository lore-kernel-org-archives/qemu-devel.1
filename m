Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFc-0004nL-NH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFX-0003wa-4m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:08 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFX-0003w9-0m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so9854424qtc.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:53:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:26 -0700
Message-Id: <20170605165233.4135-20-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 19/26] target/s390: Use
 tcg_gen_lookup_and_goto_ptr
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

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4c48c59..628fb86 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -608,11 +608,16 @@ static void gen_op_calc_cc(DisasContext *s)
     set_cc_static(s);
 }
 
-static int use_goto_tb(DisasContext *s, uint64_t dest)
+static bool use_exit_tb(DisasContext *s)
 {
-    if (unlikely(s->singlestep_enabled) ||
-        (s->tb->cflags & CF_LAST_IO) ||
-        (s->tb->flags & FLAG_MASK_PER)) {
+    return (s->singlestep_enabled ||
+            (s->tb->cflags & CF_LAST_IO) ||
+            (s->tb->flags & FLAG_MASK_PER));
+}
+
+static bool use_goto_tb(DisasContext *s, uint64_t dest)
+{
+    if (unlikely(use_exit_tb(s))) {
         return false;
     }
 #ifndef CONFIG_USER_ONLY
@@ -5461,8 +5466,10 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (do_debug) {
             gen_exception(EXCP_DEBUG);
-        } else {
+        } else if (use_exit_tb(&dc)) {
             tcg_gen_exit_tb(0);
+        } else {
+            tcg_gen_lookup_and_goto_ptr(psw_addr);
         }
         break;
     default:
-- 
2.9.4
