Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtU-00033u-0K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtS-00025o-SW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:16 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtS-00025i-OA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:14 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so26596343qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:47 -0700
Message-Id: <20170607003119.14778-39-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 38/70] target/s390x: Re-implement a few
 EXECUTE target insns directly
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

While the previous patch is required for proper conformance,
the vast majority of target insns are MVC and XC for implementing
memmove and memset respectively.  The next most common are CLC,
TR, and SVC.

Implementing these (and a few others for which we already have
an implementation) directly is faster than going through full
translation to a TB.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 66 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3a77edc..e35571e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -200,31 +200,30 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 }
 
 /* memmove */
-static void do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
-                          uint64_t src, uintptr_t ra)
+static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
+                              uint64_t src, uintptr_t ra)
 {
     uint32_t i;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
 
+    /* mvc and memmove do not behave the same when areas overlap! */
     /* mvc with source pointing to the byte after the destination is the
        same as memset with the first source byte */
     if (dest == src + 1) {
         fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1, ra);
-        return;
-    }
-
-    /* mvc and memmove do not behave the same when areas overlap! */
-    if (dest < src || src + l < dest) {
+    } else if (dest < src || src + l < dest) {
         fast_memmove(env, dest, src, l + 1, ra);
-        return;
+    } else {
+        /* slow version with byte accesses which always work */
+        for (i = 0; i <= l; i++) {
+            uint8_t x = cpu_ldub_data_ra(env, src + i, ra);
+            cpu_stb_data_ra(env, dest + i, x, ra);
+        }
     }
 
-    /* slow version with byte accesses which always work */
-    for (i = 0; i <= l; i++) {
-        cpu_stb_data_ra(env, dest + i, cpu_ldub_data_ra(env, src + i, ra), ra);
-    }
+    return env->cc_op;
 }
 
 void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
@@ -692,8 +691,8 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     }
 }
 
-static void do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
-                         uint64_t trans, uintptr_t ra)
+static uint32_t do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
+                             uint64_t trans, uintptr_t ra)
 {
     uint32_t i;
 
@@ -702,12 +701,14 @@ static void do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
         uint8_t new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
         cpu_stb_data_ra(env, array + i, new_byte, ra);
     }
+
+    return env->cc_op;
 }
 
 void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
                 uint64_t trans)
 {
-    return do_helper_tr(env, len, array, trans, GETPC());
+    do_helper_tr(env, len, array, trans, GETPC());
 }
 
 uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
@@ -1221,6 +1222,41 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         g_assert_not_reached();
     }
 
+    /* The very most common cases can be sped up by avoiding a new TB.  */
+    if ((opc & 0xf0) == 0xd0) {
+        typedef uint32_t (*dx_helper)(CPUS390XState *, uint32_t, uint64_t,
+                                      uint64_t, uintptr_t);
+        static const dx_helper dx[16] = {
+            [0x2] = do_helper_mvc,
+            [0x4] = do_helper_nc,
+            [0x5] = do_helper_clc,
+            [0x6] = do_helper_oc,
+            [0x7] = do_helper_xc,
+            [0xc] = do_helper_tr,
+            [0xd] = do_helper_trt,
+        };
+        dx_helper helper = dx[opc & 0xf];
+
+        if (helper) {
+            uint32_t l = extract64(insn, 48, 8);
+            uint32_t b1 = extract64(insn, 44, 4);
+            uint32_t d1 = extract64(insn, 32, 12);
+            uint32_t b2 = extract64(insn, 28, 4);
+            uint32_t d2 = extract64(insn, 16, 12);
+            uint64_t a1 = get_address(env, 0, b1, d1);
+            uint64_t a2 = get_address(env, 0, b2, d2);
+
+            env->cc_op = helper(env, l, a1, a2, 0);
+            env->psw.addr += ilen;
+            return;
+        }
+    } else if (opc == 0x0a) {
+        env->int_svc_code = extract64(insn, 48, 8);
+        env->int_svc_ilen = ilen;
+        helper_exception(env, EXCP_SVC);
+        g_assert_not_reached();
+    }
+
     /* Record the insn we want to execute as well as the ilen to use
        during the execution of the target insn.  This will also ensure
        that ex_value is non-zero, which flags that we are in a state
-- 
2.9.4
