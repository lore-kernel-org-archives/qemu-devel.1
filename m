Received: from eggs.gnu.org ([2001:4830:134:3::10]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOU-0001xL-27
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOT-0001lz-4d
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOT-0001le-0Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:29 -0400
Received: by mail-qk0-x243.google.com with SMTP id o4so4542592qkb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:53 -0700
Message-Id: <20170502192300.2124-19-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 18/25] target/s390: Use
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
Cc: cota@braap.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c6217..f7c2123 100644
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
@@ -5426,8 +5431,10 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
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
2.9.3
