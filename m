Received: from eggs.gnu.org ([2001:4830:134:3::10]:33989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtS-0002yN-Sy
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtQ-000253-8W
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:14 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtQ-00024v-36
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:12 -0400
Received: by mail-qt0-x244.google.com with SMTP id x58so19243132qtc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:45 -0700
Message-Id: <20170607003119.14778-37-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 36/70] target/s390x: End the TB after EXECUTE
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

This split will be required for implementing EXECUTE properly.
Do this now as a separate step to aid comparison of before and
after TB listings.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 54 ++++++++++++++++++++++++++++-------------------
 target/s390x/translate.c  |  6 +++++-
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4b96c27..d57d5b1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1234,6 +1234,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t insn = cpu_lduw_code(env, addr);
     uint8_t opc = insn >> 8;
+    uint32_t cc;
 
     /* Or in the contents of R1[56:63].  */
     insn |= r1 & 0xff;
@@ -1263,42 +1264,46 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         b2 = extract64(insn, 28, 4);
         d1 = extract64(insn, 32, 12);
         d2 = extract64(insn, 16, 12);
+
+        cc = env->cc_op;
         switch (opc & 0xf) {
         case 0x2:
             do_helper_mvc(env, l, get_address(env, 0, b1, d1),
                           get_address(env, 0, b2, d2), 0);
-            return;
+            break;
         case 0x4:
-            env->cc_op = do_helper_nc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
-            return;
+            cc = do_helper_nc(env, l, get_address(env, 0, b1, d1),
+                              get_address(env, 0, b2, d2), 0);
+            break;
         case 0x5:
-            env->cc_op = do_helper_clc(env, l, get_address(env, 0, b1, d1),
-                                       get_address(env, 0, b2, d2), 0);
-            return;
+            cc = do_helper_clc(env, l, get_address(env, 0, b1, d1),
+                               get_address(env, 0, b2, d2), 0);
+            break;
         case 0x6:
-            env->cc_op = do_helper_oc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
-            return;
+            cc = do_helper_oc(env, l, get_address(env, 0, b1, d1),
+                              get_address(env, 0, b2, d2), 0);
+            break;
         case 0x7:
-            env->cc_op = do_helper_xc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
-            return;
+            cc = do_helper_xc(env, l, get_address(env, 0, b1, d1),
+                              get_address(env, 0, b2, d2), 0);
+            break;
         case 0xc:
             do_helper_tr(env, l, get_address(env, 0, b1, d1),
                          get_address(env, 0, b2, d2), 0);
-            return;
+            break;
         case 0xd:
-            env->cc_op = do_helper_trt(env, l, get_address(env, 0, b1, d1),
-                                       get_address(env, 0, b2, d2), 0);
-            return;
+            cc = do_helper_trt(env, l, get_address(env, 0, b1, d1),
+                               get_address(env, 0, b2, d2), 0);
+            break;
+        default:
+            goto abort;
         }
     } else if (opc == 0x0a) {
         /* supervisor call */
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
         helper_exception(env, EXCP_SVC);
-        return;
+        g_assert_not_reached();
     } else if (opc == 0xbf) {
         uint32_t r1, r3, b2, d2;
 
@@ -1306,10 +1311,15 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         r3 = extract64(insn, 48, 4);
         b2 = extract64(insn, 44, 4);
         d2 = extract64(insn, 32, 12);
-        env->cc_op = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
-        return;
+        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
+    } else {
+ abort:
+        cpu_abort(CPU(cpu),
+                  "EXECUTE on instruction prefix 0x%x not implemented\n",
+                  opc);
+        g_assert_not_reached();
     }
 
-    cpu_abort(CPU(cpu), "EXECUTE on instruction prefix 0x%x not implemented\n",
-              opc);
+    env->cc_op = cc;
+    env->psw.addr += ilen;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5c7e5c1..b6b9d75 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1168,6 +1168,8 @@ typedef enum {
        the PC (for whatever reason), so there's no need to do it again on
        exiting the TB.  */
     EXIT_PC_UPDATED,
+    /* We have updated the PC and CC values.  */
+    EXIT_PC_CC_UPDATED,
     /* We are exiting the TB, but have neither emitted a goto_tb, nor
        updated the PC for the next instruction to be executed.  */
     EXIT_PC_STALE,
@@ -2221,7 +2223,7 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
         tcg_temp_free_i64(v1);
     }
 
-    return NO_EXIT;
+    return EXIT_PC_CC_UPDATED;
 }
 
 static ExitStatus op_fieb(DisasContext *s, DisasOps *o)
@@ -5494,6 +5496,8 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
         update_cc_op(&dc);
+        /* FALLTHRU */
+    case EXIT_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (do_debug) {
             gen_exception(EXCP_DEBUG);
-- 
2.9.4
