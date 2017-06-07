Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt1-0002Yq-3d
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOsz-0001vU-HF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:47 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOsz-0001vQ-DT
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:45 -0400
Received: by mail-qt0-x244.google.com with SMTP id x58so19242283qtc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:24 -0700
Message-Id: <20170607003119.14778-16-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 15/70] target/s390x: Use unwind data for
 helper_stam
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
 target/s390x/mem_helper.c | 3 ++-
 target/s390x/translate.c  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 88e817a..2acc984 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -485,10 +485,11 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 /* store access registers r1 to r3 in memory at a2 */
 void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     int i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data(env, a2, env->aregs[i]);
+        cpu_stl_data_ra(env, a2, env->aregs[i], ra);
         a2 += 4;
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 16477fc..4ae949a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3867,7 +3867,6 @@ static ExitStatus op_stam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_stam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
