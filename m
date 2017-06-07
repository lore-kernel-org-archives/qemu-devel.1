Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt2-0002aV-Ux
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt2-0001wK-3I
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:48 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOt1-0001w8-Ui
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so26595514qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:26 -0700
Message-Id: <20170607003119.14778-18-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 17/70] target/s390x: Use unwind data for
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
index e3c5ba1..eaa3adc 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2887,7 +2887,6 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_mvcle(cc_op, cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
