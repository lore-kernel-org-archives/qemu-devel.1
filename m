Received: from eggs.gnu.org ([2001:4830:134:3::10]:54742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06X-0005b4-SK
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06W-0003is-Ve
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06W-0003iZ-Sc
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so20703612qtb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:24 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:46 -0700
Message-Id: <20170523030312.6360-6-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 05/31] target/s390x: Use unwind data for
 helper_oc
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
 target/s390x/mem_helper.c | 18 +++++++++---------
 target/s390x/translate.c  |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e0a6fad..e75c2de0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -168,20 +168,20 @@ uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
                     uint64_t src)
 {
-    int i;
-    unsigned char x;
-    uint32_t cc = 0;
+    uintptr_t ra = GETPC();
+    uint8_t cc = 0;
+    uint32_t i;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
+
     for (i = 0; i <= l; i++) {
-        x = cpu_ldub_data(env, dest + i) | cpu_ldub_data(env, src + i);
-        if (x) {
-            cc = 1;
-        }
-        cpu_stb_data(env, dest + i, x);
+        uint8_t x = cpu_ldub_data_ra(env, dest + i, ra);
+        x |= cpu_ldub_data_ra(env, src + i, ra);
+        cc |= x;
+        cpu_stb_data_ra(env, dest + i, x, ra);
     }
-    return cc;
+    return cc != 0;
 }
 
 /* memmove */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a770407..6a51d56 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3082,7 +3082,6 @@ static ExitStatus op_negf128(DisasContext *s, DisasOps *o)
 static ExitStatus op_oc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_oc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
