Received: from eggs.gnu.org ([2001:4830:134:3::10]:45341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsE-0001nq-Do
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsD-00019J-Gg
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:10 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsD-00018m-Cm
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:09 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so27541525qtb.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:26 -0700
Message-Id: <20170524192246.15905-14-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 13/33] target/s390x: Use unwind data for
 helper_lam
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 3 ++-
 target/s390x/translate.c  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e4bfc6e..88e817a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -469,10 +469,11 @@ static uint32_t helper_icm(CPUS390XState *env, uint32_t r1, uint64_t address,
 /* load access registers r1 to r3 from memory at a2 */
 void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     int i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        env->aregs[i] = cpu_ldl_data(env, a2);
+        env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
         a2 += 4;
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 86e5567..dca2096 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2621,7 +2621,6 @@ static ExitStatus op_lam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_lam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
