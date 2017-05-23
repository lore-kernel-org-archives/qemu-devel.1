Received: from eggs.gnu.org ([2001:4830:134:3::10]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06t-0005vZ-Oz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06s-0003ym-Vt
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:47 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06s-0003ye-Rz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:46 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so20675329qtb.2
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:46 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:05 -0700
Message-Id: <20170523030312.6360-25-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 24/31] target/s390x: Use unwind data for
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 9 +++++----
 target/s390x/translate.c  | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 26960e4..b169e0e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -851,18 +851,19 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
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
index 886991e..4d964a8 100644
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
