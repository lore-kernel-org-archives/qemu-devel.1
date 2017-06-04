Received: from eggs.gnu.org ([2001:4830:134:3::10]:50150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRF-0007T2-RL
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRF-00034M-0R
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:41 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRE-000335-Qn
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:40 -0400
Received: by mail-pf0-x241.google.com with SMTP id u26so18118824pfd.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:20 -0700
Message-Id: <20170604173509.29684-21-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 20/69] target/s390x: Use unwind data for
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
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 9 +++++----
 target/s390x/translate.c  | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d4ee364..0701e10 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -679,6 +679,7 @@ uint64_t HELPER(cksm)(CPUS390XState *env, uint64_t r1,
 void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
                   uint64_t src)
 {
+    uintptr_t ra = GETPC();
     int len_dest = len >> 4;
     int len_src = len & 0xf;
     uint8_t b;
@@ -688,8 +689,8 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     src += len_src;
 
     /* last byte is special, it only flips the nibbles */
-    b = cpu_ldub_data(env, src);
-    cpu_stb_data(env, dest, (b << 4) | (b >> 4));
+    b = cpu_ldub_data_ra(env, src, ra);
+    cpu_stb_data_ra(env, dest, (b << 4) | (b >> 4), ra);
     src--;
     len_src--;
 
@@ -699,7 +700,7 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
         uint8_t cur_byte = 0;
 
         if (len_src > 0) {
-            cur_byte = cpu_ldub_data(env, src);
+            cur_byte = cpu_ldub_data_ra(env, src, ra);
         }
 
         len_dest--;
@@ -718,7 +719,7 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
         /* zone bits */
         cur_byte |= 0xf0;
 
-        cpu_stb_data(env, dest, cur_byte);
+        cpu_stb_data_ra(env, dest, cur_byte, ra);
     }
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 76910bc..4978f19 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4094,7 +4094,6 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
 static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_unpk(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return NO_EXIT;
-- 
2.9.4
