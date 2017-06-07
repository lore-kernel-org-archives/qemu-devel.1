Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt4-0002bz-A8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt3-0001wj-CA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:50 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOt3-0001wd-8a
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:49 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so26595544qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:27 -0700
Message-Id: <20170607003119.14778-19-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 18/70] target/s390x: Use unwind data for
 helper_clcle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 6 +++---
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 8a095ad..f5a3044 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -595,12 +595,12 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1];
     uint64_t dest = get_address_31fix(env, r1);
     uint64_t srclen = env->regs[r3 + 1];
     uint64_t src = get_address_31fix(env, r3);
     uint8_t pad = a2 & 0xff;
-    uint8_t v1 = 0, v2 = 0;
     uint32_t cc = 0;
 
     if (!(destlen || srclen)) {
@@ -612,8 +612,8 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     }
 
     for (; destlen || srclen; src++, dest++, destlen--, srclen--) {
-        v1 = srclen ? cpu_ldub_data(env, src) : pad;
-        v2 = destlen ? cpu_ldub_data(env, dest) : pad;
+        uint8_t v1 = srclen ? cpu_ldub_data_ra(env, src, ra) : pad;
+        uint8_t v2 = destlen ? cpu_ldub_data_ra(env, dest, ra) : pad;
         if (v1 != v2) {
             cc = (v1 < v2) ? 1 : 2;
             break;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index eaa3adc..600b76d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1920,7 +1920,6 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_clcle(cc_op, cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
