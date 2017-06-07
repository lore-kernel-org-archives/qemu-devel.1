Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt7-0002cs-Ow
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt6-0001y1-QU
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:53 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOt6-0001xr-Mz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:52 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so22861862qtb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:30 -0700
Message-Id: <20170607003119.14778-22-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 21/70] target/s390x: Use unwind data for
 helper_tr
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
 target/s390x/mem_helper.c | 25 +++++++++++++++----------
 target/s390x/translate.c  |  1 -
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 0701e10..b37a963 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -723,19 +723,24 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     }
 }
 
-void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
-                uint64_t trans)
+static void do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
+                         uint64_t trans, uintptr_t ra)
 {
-    int i;
+    uint32_t i;
 
     for (i = 0; i <= len; i++) {
-        uint8_t byte = cpu_ldub_data(env, array + i);
-        uint8_t new_byte = cpu_ldub_data(env, trans + byte);
-
-        cpu_stb_data(env, array + i, new_byte);
+        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
+        uint8_t new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
+        cpu_stb_data_ra(env, array + i, new_byte, ra);
     }
 }
 
+void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
+                uint64_t trans)
+{
+    return do_helper_tr(env, len, array, trans, GETPC());
+}
+
 uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
                      uint64_t len, uint64_t trans)
 {
@@ -1265,9 +1270,9 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
                               get_address(env, 0, b2, d2), 0);
             break;
         case 0xc00:
-            helper_tr(env, l, get_address(env, 0, b1, d1),
-                      get_address(env, 0, b2, d2));
-            break;
+            do_helper_tr(env, l, get_address(env, 0, b1, d1),
+                         get_address(env, 0, b2, d2), 0);
+            return cc;
         case 0xd00:
             cc = helper_trt(env, l, get_address(env, 0, b1, d1),
                             get_address(env, 0, b2, d2));
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 10262f5..e4da94d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4070,7 +4070,6 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 static ExitStatus op_tr(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_tr(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
