Received: from eggs.gnu.org ([2001:4830:134:3::10]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06o-0005qs-5U
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06n-0003wt-BM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:42 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06n-0003wl-76
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:41 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so20683955qte.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:41 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:00 -0700
Message-Id: <20170523030312.6360-20-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 19/31] target/s390x: Use unwind data for
 helper_unpk
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
index da81b38..d37e691 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -660,6 +660,7 @@ uint64_t HELPER(cksm)(CPUS390XState *env, uint64_t r1,
 void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
                   uint64_t src)
 {
+    uintptr_t ra = GETPC();
     int len_dest = len >> 4;
     int len_src = len & 0xf;
     uint8_t b;
@@ -669,8 +670,8 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     src += len_src;
 
     /* last byte is special, it only flips the nibbles */
-    b = cpu_ldub_data(env, src);
-    cpu_stb_data(env, dest, (b << 4) | (b >> 4));
+    b = cpu_ldub_data_ra(env, src, ra);
+    cpu_stb_data_ra(env, dest, (b << 4) | (b >> 4), ra);
     src--;
     len_src--;
 
@@ -680,7 +681,7 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
         uint8_t cur_byte = 0;
 
         if (len_src > 0) {
-            cur_byte = cpu_ldub_data(env, src);
+            cur_byte = cpu_ldub_data_ra(env, src, ra);
         }
 
         len_dest--;
@@ -699,7 +700,7 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
         /* zone bits */
         cur_byte |= 0xf0;
 
-        cpu_stb_data(env, dest, cur_byte);
+        cpu_stb_data_ra(env, dest, cur_byte, ra);
     }
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 21c21a6..e8eefec 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4099,7 +4099,6 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
 static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_unpk(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return NO_EXIT;
-- 
2.9.4
