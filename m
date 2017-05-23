Received: from eggs.gnu.org ([2001:4830:134:3::10]:54870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06j-0005m8-Ak
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06i-0003th-HK
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:37 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06i-0003tQ-D9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:36 -0400
Received: by mail-qt0-x242.google.com with SMTP id l39so20703927qtb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:36 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:56 -0700
Message-Id: <20170523030312.6360-16-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 15/31] target/s390x: Use unwind data for
 helper_mvcl
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
 target/s390x/mem_helper.c | 7 ++++---
 target/s390x/translate.c  | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d6d5047..b764c48 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -482,6 +482,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 /* move long */
 uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
+    uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
     uint64_t dest = get_address_31fix(env, r1);
     uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
@@ -503,12 +504,12 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     }
 
     for (; destlen && srclen; src++, dest++, destlen--, srclen--) {
-        v = cpu_ldub_data(env, src);
-        cpu_stb_data(env, dest, v);
+        v = cpu_ldub_data_ra(env, src, ra);
+        cpu_stb_data_ra(env, dest, v, ra);
     }
 
     for (; destlen; dest++, destlen--) {
-        cpu_stb_data(env, dest, pad);
+        cpu_stb_data_ra(env, dest, pad, ra);
     }
 
     env->regs[r1 + 1] = destlen;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index da7b5a6..ad2e632 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2876,7 +2876,6 @@ static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
-    potential_page_fault(s);
     gen_helper_mvcl(cc_op, cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
-- 
2.9.4
