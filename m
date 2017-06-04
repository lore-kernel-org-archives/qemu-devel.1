Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQt-0007Ba-Vt
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQt-0002hE-43
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:20 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZQs-0002gV-U9
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:19 -0400
Received: by mail-pg0-x244.google.com with SMTP id v14so3628859pgn.1
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:04 -0700
Message-Id: <20170604173509.29684-5-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 04/69] target/s390x: Use unwind data for
 helper_nc
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 31 ++++++++++++++++++-------------
 target/s390x/translate.c  |  1 -
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 90b62fa..7d6133b 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -119,23 +119,28 @@ static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
 }
 
 /* and on array */
-uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l, uint64_t dest,
-                    uint64_t src)
+static uint32_t do_helper_nc(CPUS390XState *env, uint32_t l, uint64_t dest,
+                             uint64_t src, uintptr_t ra)
 {
-    int i;
-    unsigned char x;
-    uint32_t cc = 0;
+    uint32_t i;
+    uint8_t c = 0;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
+
     for (i = 0; i <= l; i++) {
-        x = cpu_ldub_data(env, dest + i) & cpu_ldub_data(env, src + i);
-        if (x) {
-            cc = 1;
-        }
-        cpu_stb_data(env, dest + i, x);
+        uint8_t x = cpu_ldub_data_ra(env, src + i, ra);
+        x &= cpu_ldub_data_ra(env, dest + i, ra);
+        c |= x;
+        cpu_stb_data_ra(env, dest + i, x, ra);
     }
-    return cc;
+    return c != 0;
+}
+
+uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l, uint64_t dest,
+                    uint64_t src)
+{
+    return do_helper_nc(env, l, dest, src, GETPC());
 }
 
 /* xor on array */
@@ -1213,8 +1218,8 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
                        get_address(env, 0, b2, d2));
             break;
         case 0x400:
-            cc = helper_nc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
+            cc = do_helper_nc(env, l, get_address(env, 0, b1, d1),
+                              get_address(env, 0, b2, d2), 0);
             break;
         case 0x500:
             cc = helper_clc(env, l, get_address(env, 0, b1, d1),
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d6736e4..7e4cc6c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3043,7 +3043,6 @@ static ExitStatus op_nabsf128(DisasContext *s, DisasOps *o)
 static ExitStatus op_nc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_nc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
