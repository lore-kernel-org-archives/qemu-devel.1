Received: from eggs.gnu.org ([2001:4830:134:3::10]:50225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRN-0007bi-VE
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRN-0003EZ-4P
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:49 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRM-0003EA-VI
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:49 -0400
Received: by mail-pf0-x243.google.com with SMTP id f27so18146148pfe.0
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:26 -0700
Message-Id: <20170604173509.29684-27-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 26/69] target/s390x: Use unwind data for
 helper_stctl
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
 target/s390x/mem_helper.c | 10 ++++++----
 target/s390x/translate.c  |  2 --
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 614cdb2..b64c04e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -907,11 +907,12 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
 void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
-    int i;
+    uintptr_t ra = GETPC();
     uint64_t dest = a2;
+    uint32_t i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stq_data(env, dest, env->cregs[i]);
+        cpu_stq_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint64_t);
 
         if (i == r3) {
@@ -922,11 +923,12 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
 void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
-    int i;
+    uintptr_t ra = GETPC();
     uint64_t dest = a2;
+    uint32_t i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data(env, dest, env->cregs[i]);
+        cpu_stl_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint32_t);
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 26f6b37..669da89 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3612,7 +3612,6 @@ static ExitStatus op_stctg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stctg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -3624,7 +3623,6 @@ static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
