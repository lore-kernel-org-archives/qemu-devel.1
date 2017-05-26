Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbc-0000q0-Vt
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbc-0008Ox-4N
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:08 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbc-0008Or-0e
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so2853017qtb.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:17:07 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	u19sm1262380qtc.64.2017.05.26.14.17.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 14:17:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:31 -0700
Message-Id: <20170526211638.32301-20-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 19/26] target/s390: Use
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
