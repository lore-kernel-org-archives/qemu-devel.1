Received: from eggs.gnu.org ([2001:4830:134:3::10]:54947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06r-0005tC-H9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06q-0003yE-Ob
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:45 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06q-0003y4-LG
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so21454657qkh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:44 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:03 -0700
Message-Id: <20170523030312.6360-23-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 22/31] target/s390x: Use unwind data for
 helper_trt
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
index 4c6c6ee..902290c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -760,16 +760,17 @@ uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
 uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
                      uint64_t trans)
 {
+    uintptr_t ra = GETPC();
     uint32_t cc = 0;
-    int i;
+    uint32_t i;
 
     for (i = 0; i <= len; i++) {
-        uint8_t byte = cpu_ldub_data(env, array + i);
-        uint8_t sbyte = cpu_ldub_data(env, trans + byte);
+        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
+        uint8_t sbyte = cpu_ldub_data_ra(env, trans + byte, ra);
 
         if (sbyte != 0) {
             env->regs[1] = array + i;
-            env->regs[2] = (env->regs[2] & ~0xff) | sbyte;
+            env->regs[2] = deposit64(env->regs[2], 0, 8, sbyte);
             cc = (i == len) ? 2 : 1;
             break;
         }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ecef71c..531b5f1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4087,7 +4087,6 @@ static ExitStatus op_tre(DisasContext *s, DisasOps *o)
 static ExitStatus op_trt(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_trt(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
