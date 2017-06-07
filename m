Received: from eggs.gnu.org ([2001:4830:134:3::10]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt2-0002Zi-1f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt1-0001vp-0Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:48 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOt0-0001vi-TA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:46 -0400
Received: by mail-qk0-x243.google.com with SMTP id y201so11028236qka.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:25 -0700
Message-Id: <20170607003119.14778-17-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 16/70] target/s390x: Use unwind data for
 helper_mvcl
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
 target/s390x/mem_helper.c | 7 ++++---
 target/s390x/translate.c  | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2acc984..49cfc9b 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -501,6 +501,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 /* move long */
 uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
+    uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
     uint64_t dest = get_address_31fix(env, r1);
     uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
@@ -522,12 +523,12 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     }
 
     for (; destlen && srclen; src++, dest++, destlen--, srclen--) {
-        v = cpu_ldub_data(env, src);
-        cpu_stb_data(env, dest, v);
+        v = cpu_ldub_data_ra(env, src, ra);
+        cpu_stb_data_ra(env, dest, v, ra);
     }
 
     for (; destlen; dest++, destlen--) {
-        cpu_stb_data(env, dest, pad);
+        cpu_stb_data_ra(env, dest, pad, ra);
     }
 
     env->regs[r1 + 1] = destlen;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4ae949a..e3c5ba1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2876,7 +2876,6 @@ static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
-    potential_page_fault(s);
     gen_helper_mvcl(cc_op, cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
-- 
2.9.4
