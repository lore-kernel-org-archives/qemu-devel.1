Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06s-0005uO-Pl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06r-0003yY-Sk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:46 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06r-0003yR-Ov
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:45 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so21454692qkh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:45 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:04 -0700
Message-Id: <20170523030312.6360-24-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 23/31] target/s390x: Use unwind data for
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 8 ++++----
 target/s390x/translate.c  | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 902290c..26960e4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -821,20 +821,20 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
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
index 531b5f1..886991e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2557,7 +2557,6 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
