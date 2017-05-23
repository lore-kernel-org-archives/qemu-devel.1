Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06g-0005iU-0W
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06f-0003qb-4L
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:34 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06f-0003qI-0z
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so20679535qta.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:32 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:53 -0700
Message-Id: <20170523030312.6360-13-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 12/31] target/s390x: Use unwind data for
 helper_mvst
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
index 9ef9f4a..d1a7bcd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -384,6 +384,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
 /* string copy (c is string terminator) */
 uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
 
     c = c & 0xff;
@@ -393,8 +394,8 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
     for (len = 0; len < 0x2000; ++len) {
-        uint8_t v = cpu_ldub_data(env, s + len);
-        cpu_stb_data(env, d + len, v);
+        uint8_t v = cpu_ldub_data_ra(env, s + len, ra);
+        cpu_stb_data_ra(env, d + len, v, ra);
         if (v == c) {
             /* Complete.  Set CC=1 and advance R1.  */
             env->cc_op = 1;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a1edc79..f9d05b6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2928,7 +2928,6 @@ static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_mvst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_mvst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
