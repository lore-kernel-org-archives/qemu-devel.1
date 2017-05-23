Received: from eggs.gnu.org ([2001:4830:134:3::10]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06h-0005jl-1g
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06g-0003re-CB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:35 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06g-0003rI-8Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so20683746qte.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:34 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:54 -0700
Message-Id: <20170523030312.6360-14-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 13/31] target/s390x: Use unwind data for
 helper_lam
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
index d1a7bcd..4ecec74 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -450,10 +450,11 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t v1, uint64_t addr)
 /* load access registers r1 to r3 from memory at a2 */
 void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     int i;
 
     for (i = r1;; i = (i + 1) % 16) {
-        env->aregs[i] = cpu_ldl_data(env, a2);
+        env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
         a2 += 4;
 
         if (i == r3) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f9d05b6..1fc58a1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2626,7 +2626,6 @@ static ExitStatus op_lam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_lam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
