Received: from eggs.gnu.org ([2001:4830:134:3::10]:54798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06c-0005f4-8z
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06b-0003n8-EA
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06b-0003mq-BM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:29 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so21473573qka.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:29 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:50 -0700
Message-Id: <20170523030312.6360-10-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 09/31] target/s390x: Use unwind data for
 helper_srst
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
 target/s390x/mem_helper.c | 3 ++-
 target/s390x/translate.c  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 5f38ac3..3c28f3a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -302,6 +302,7 @@ static inline uint64_t get_address_31fix(CPUS390XState *env, int reg)
 uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
                       uint64_t str)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
     uint8_t v, c = r0;
 
@@ -319,7 +320,7 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
             env->cc_op = 2;
             return end;
         }
-        v = cpu_ldub_data(env, str + len);
+        v = cpu_ldub_data_ra(env, str + len, ra);
         if (v == c) {
             /* Character found.  Set R1 to the location; R2 is unmodified.  */
             env->cc_op = 1;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 84f09b1..ba7d0f9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3977,7 +3977,6 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_srst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
