Received: from eggs.gnu.org ([2001:4830:134:3::10]:50108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRB-0007Q6-MQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRA-0002y5-R7
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:37 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRA-0002xX-Lk
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:36 -0400
Received: by mail-pf0-x241.google.com with SMTP id n23so18100700pfb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:17 -0700
Message-Id: <20170604173509.29684-18-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 17/69] target/s390x: Use unwind data for
 helper_mvcle
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
index 49cfc9b..8a095ad 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -544,6 +544,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1];
     uint64_t dest = env->regs[r1];
     uint64_t srclen = env->regs[r3 + 1];
@@ -572,12 +573,12 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
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
index fb2d6ff..b42acae 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2882,7 +2882,6 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_mvcle(cc_op, cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
