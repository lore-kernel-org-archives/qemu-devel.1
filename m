Received: from eggs.gnu.org ([2001:4830:134:3::10]:45472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsR-00022i-DD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsQ-0001b0-I0
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsQ-0001aR-DW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:22 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so27542180qtb.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:36 -0700
Message-Id: <20170524192246.15905-24-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 23/33] target/s390x: Use unwind data for
 helper_lctlg
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
 target/s390x/mem_helper.c | 8 ++++----
 target/s390x/translate.c  | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ff12777..68e3817 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -848,20 +848,20 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
 #if !defined(CONFIG_USER_ONLY)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     S390CPU *cpu = s390_env_get_cpu(env);
     bool PERchanged = false;
-    int i;
     uint64_t src = a2;
-    uint64_t val;
+    uint32_t i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        val = cpu_ldq_data(env, src);
+        uint64_t val = cpu_ldq_data_ra(env, src, ra);
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
         env->cregs[i] = val;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
-                   i, src, env->cregs[i]);
+                   i, src, val);
         src += sizeof(uint64_t);
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index fed9f17..65ae573 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2552,7 +2552,6 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
