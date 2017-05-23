Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06Z-0005cc-VL
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06Z-0003ka-57
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:27 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06Z-0003kF-0g
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:27 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so20674772qtb.2
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:26 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:48 -0700
Message-Id: <20170523030312.6360-8-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 07/31] target/s390x: Use unwind data for
 helper_clc
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
index 0295485..d04850b 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -215,26 +215,26 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 /* compare unsigned byte arrays */
 uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
 {
-    int i;
-    unsigned char x, y;
-    uint32_t cc;
+    uintptr_t ra = GETPC();
+    uint32_t cc = 0;
+    uint32_t i;
 
     HELPER_LOG("%s l %d s1 %" PRIx64 " s2 %" PRIx64 "\n",
                __func__, l, s1, s2);
+
     for (i = 0; i <= l; i++) {
-        x = cpu_ldub_data(env, s1 + i);
-        y = cpu_ldub_data(env, s2 + i);
+        uint8_t x = cpu_ldub_data_ra(env, s1 + i, ra);
+        uint8_t y = cpu_ldub_data_ra(env, s2 + i, ra);
         HELPER_LOG("%02x (%c)/%02x (%c) ", x, x, y, y);
         if (x < y) {
             cc = 1;
-            goto done;
+            break;
         } else if (x > y) {
             cc = 2;
-            goto done;
+            break;
         }
     }
-    cc = 0;
- done:
+
     HELPER_LOG("\n");
     return cc;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 66f3cd6..aefbc90 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1903,7 +1903,6 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
         tcg_gen_qemu_ld64(cc_dst, o->in2, get_mem_index(s));
         break;
     default:
-        potential_page_fault(s);
         vl = tcg_const_i32(l);
         gen_helper_clc(cc_op, cpu_env, vl, o->addr1, o->in2);
         tcg_temp_free_i32(vl);
-- 
2.9.4
