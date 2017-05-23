Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06d-0005gK-IB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06c-0003oJ-Me
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:31 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06c-0003o0-J9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:30 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so21494960qke.2
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:30 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:51 -0700
Message-Id: <20170523030312.6360-11-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 10/31] target/s390x: Use unwind data for
 helper_clst
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
 target/s390x/mem_helper.c | 5 +++--
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3c28f3a..7c9e7c7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -337,6 +337,7 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
 /* unsigned string compare (c is string terminator) */
 uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
 
     c = c & 0xff;
@@ -346,8 +347,8 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
     for (len = 0; len < 0x2000; ++len) {
-        uint8_t v1 = cpu_ldub_data(env, s1 + len);
-        uint8_t v2 = cpu_ldub_data(env, s2 + len);
+        uint8_t v1 = cpu_ldub_data_ra(env, s1 + len, ra);
+        uint8_t v2 = cpu_ldub_data_ra(env, s2 + len, ra);
         if (v1 == v2) {
             if (v1 == c) {
                 /* Equal.  CC=0, and don't advance the registers.  */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ba7d0f9..735aa82 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1939,7 +1939,6 @@ static ExitStatus op_clm(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_clst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_clst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
