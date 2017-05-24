Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsQ-00021P-7E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsP-0001XY-7Z
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsP-0001We-1N
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so27575051qtb.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:35 -0700
Message-Id: <20170524192246.15905-23-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 22/33] target/s390x: Use unwind data for
 helper_trt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 28 ++++++++++++++++------------
 target/s390x/translate.c  |  1 -
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index fd6dbf7..ff12777 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -781,25 +781,29 @@ uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
     return array + i;
 }
 
-uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
-                     uint64_t trans)
+static uint32_t do_helper_trt(CPUS390XState *env, uint32_t len, uint64_t array,
+                              uint64_t trans, uintptr_t ra)
 {
-    uint32_t cc = 0;
-    int i;
+    uint32_t i;
 
     for (i = 0; i <= len; i++) {
-        uint8_t byte = cpu_ldub_data(env, array + i);
-        uint8_t sbyte = cpu_ldub_data(env, trans + byte);
+        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
+        uint8_t sbyte = cpu_ldub_data_ra(env, trans + byte, ra);
 
         if (sbyte != 0) {
             env->regs[1] = array + i;
-            env->regs[2] = (env->regs[2] & ~0xff) | sbyte;
-            cc = (i == len) ? 2 : 1;
-            break;
+            env->regs[2] = deposit64(env->regs[2], 0, 8, sbyte);
+            return (i == len) ? 2 : 1;
         }
     }
 
-    return cc;
+    return 0;
+}
+
+uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
+                     uint64_t trans)
+{
+    return do_helper_trt(env, len, array, trans, GETPC());
 }
 
 void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
@@ -1275,8 +1279,8 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
                          get_address(env, 0, b2, d2), 0);
             return cc;
         case 0xd00:
-            cc = helper_trt(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
+            cc = do_helper_trt(env, l, get_address(env, 0, b1, d1),
+                               get_address(env, 0, b2, d2), 0);
             break;
         default:
             goto abort;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 447ba07..fed9f17 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4082,7 +4082,6 @@ static ExitStatus op_tre(DisasContext *s, DisasOps *o)
 static ExitStatus op_trt(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_trt(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
