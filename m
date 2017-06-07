Received: from eggs.gnu.org ([2001:4830:134:3::10]:33819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtC-0002hy-Mv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtB-00020A-PD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:58 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtB-0001zv-Ll
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:57 -0400
Received: by mail-qk0-x243.google.com with SMTP id c206so15445036qkb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:34 -0700
Message-Id: <20170607003119.14778-26-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 25/70] target/s390x: Use unwind data for
 helper_lctl
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
 target/s390x/mem_helper.c | 9 +++++----
 target/s390x/translate.c  | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 68e3817..614cdb2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -878,18 +878,19 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
 void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     S390CPU *cpu = s390_env_get_cpu(env);
     bool PERchanged = false;
-    int i;
     uint64_t src = a2;
-    uint32_t val;
+    uint32_t i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        val = cpu_ldl_data(env, src);
+        uint32_t val = cpu_ldl_data_ra(env, src, ra);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
-        env->cregs[i] = (env->cregs[i] & 0xFFFFFFFF00000000ULL) | val;
+        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
+        HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%x\n", i, src, val);
         src += sizeof(uint32_t);
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2386c41..3a98c57 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2545,7 +2545,6 @@ static ExitStatus op_lctl(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
