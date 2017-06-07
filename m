Received: from eggs.gnu.org ([2001:4830:134:3::10]:33916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtK-0002nl-W3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtJ-00023A-No
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtJ-00022v-JY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:05 -0400
Received: by mail-qk0-x243.google.com with SMTP id d14so12248156qkb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:40 -0700
Message-Id: <20170607003119.14778-32-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 31/70] target/s390x: Fix some helper_ex
 problems
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

(1) The OR of the low bits or R1 into INSN were not being done
consistently; it was forgotten along all but the SVC path.
(2) The setting of ILEN was wrong on SVC path for EXRL.
(3) The data load for ICM read too much.

Fix these by consolidating data load at the beginning, using
get_ilen to control the number of bytes loaded, and ORing in
the byte from R1.  Use extract64 from the full aligned insn
to extract arguments.

Pass in ILEN rather than RET as the more natural way to give
the required data along the SVC path.

Modify ENV->CC_OP directly rather than include it in the
functional interface.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h     |   2 +-
 target/s390x/mem_helper.c | 135 +++++++++++++++++++++++++---------------------
 target/s390x/translate.c  |   8 +--
 3 files changed, 78 insertions(+), 67 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ea35834..3819409 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -14,7 +14,7 @@ DEF_HELPER_4(srst, i64, env, i64, i64, i64)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
-DEF_HELPER_5(ex, i32, env, i32, i64, i64, i64)
+DEF_HELPER_4(ex, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_4(mvcle, i32, env, i32, i64, i32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a73d486..fa03129 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1245,76 +1245,87 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
    in other words: tricky...
    currently implemented by interpreting the cases it is most commonly used.
 */
-uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
-                    uint64_t addr, uint64_t ret)
+void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
-    uint16_t insn = cpu_lduw_code(env, addr);
-
-    HELPER_LOG("%s: v1 0x%lx addr 0x%lx insn 0x%x\n", __func__, v1, addr,
-               insn);
-    if ((insn & 0xf0ff) == 0xd000) {
-        uint32_t l, insn2, b1, b2, d1, d2;
-
-        l = v1 & 0xff;
-        insn2 = cpu_ldl_code(env, addr + 2);
-        b1 = (insn2 >> 28) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d1 = (insn2 >> 16) & 0xfff;
-        d2 = insn2 & 0xfff;
-        switch (insn & 0xf00) {
-        case 0x200:
+    uint64_t insn = cpu_lduw_code(env, addr);
+    uint8_t opc = insn >> 8;
+
+    /* Or in the contents of R1[56:63].  */
+    insn |= r1 & 0xff;
+
+    /* Load the rest of the instruction.  */
+    insn <<= 48;
+    switch (get_ilen(opc)) {
+    case 2:
+        break;
+    case 4:
+        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        break;
+    case 6:
+        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    HELPER_LOG("%s: addr 0x%lx insn 0x%" PRIx64 "\n", __func__, addr, insn);
+
+    if ((opc & 0xf0) == 0xd0) {
+        uint32_t l, b1, b2, d1, d2;
+
+        l = extract64(insn, 48, 8);
+        b1 = extract64(insn, 44, 4);
+        b2 = extract64(insn, 28, 4);
+        d1 = extract64(insn, 32, 12);
+        d2 = extract64(insn, 16, 12);
+        switch (opc & 0xf) {
+        case 0x2:
             do_helper_mvc(env, l, get_address(env, 0, b1, d1),
                           get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x400:
-            cc = do_helper_nc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x500:
-            cc = do_helper_clc(env, l, get_address(env, 0, b1, d1),
-                               get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x600:
-            cc = do_helper_oc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x700:
-            cc = do_helper_xc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0xc00:
+            return;
+        case 0x4:
+            env->cc_op = do_helper_nc(env, l, get_address(env, 0, b1, d1),
+                                      get_address(env, 0, b2, d2), 0);
+            return;
+        case 0x5:
+            env->cc_op = do_helper_clc(env, l, get_address(env, 0, b1, d1),
+                                       get_address(env, 0, b2, d2), 0);
+            return;
+        case 0x6:
+            env->cc_op = do_helper_oc(env, l, get_address(env, 0, b1, d1),
+                                      get_address(env, 0, b2, d2), 0);
+            return;
+        case 0x7:
+            env->cc_op = do_helper_xc(env, l, get_address(env, 0, b1, d1),
+                                      get_address(env, 0, b2, d2), 0);
+            return;
+        case 0xc:
             do_helper_tr(env, l, get_address(env, 0, b1, d1),
                          get_address(env, 0, b2, d2), 0);
-            return cc;
-        case 0xd00:
-            cc = do_helper_trt(env, l, get_address(env, 0, b1, d1),
-                               get_address(env, 0, b2, d2), 0);
-            break;
-        default:
-            goto abort;
+            return;
+        case 0xd:
+            env->cc_op = do_helper_trt(env, l, get_address(env, 0, b1, d1),
+                                       get_address(env, 0, b2, d2), 0);
+            return;
         }
-    } else if ((insn & 0xff00) == 0x0a00) {
+    } else if (opc == 0x0a) {
         /* supervisor call */
-        HELPER_LOG("%s: svc %ld via execute\n", __func__, (insn | v1) & 0xff);
-        env->psw.addr = ret - 4;
-        env->int_svc_code = (insn | v1) & 0xff;
-        env->int_svc_ilen = 4;
+        env->int_svc_code = extract64(insn, 48, 8);
+        env->int_svc_ilen = ilen;
         helper_exception(env, EXCP_SVC);
-    } else if ((insn & 0xff00) == 0xbf00) {
-        uint32_t insn2, r1, r3, b2, d2;
-
-        insn2 = cpu_ldl_code(env, addr + 2);
-        r1 = (insn2 >> 20) & 0xf;
-        r3 = (insn2 >> 16) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d2 = insn2 & 0xfff;
-        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
-    } else {
-    abort:
-        cpu_abort(CPU(cpu),
-                  "EXECUTE on instruction prefix 0x%x not implemented\n",
-                  insn);
+        return;
+    } else if (opc == 0xbf) {
+        uint32_t r1, r3, b2, d2;
+
+        r1 = extract64(insn, 52, 4);
+        r3 = extract64(insn, 48, 4);
+        b2 = extract64(insn, 44, 4);
+        d2 = extract64(insn, 32, 12);
+        env->cc_op = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
+        return;
     }
-    return cc;
+
+    cpu_abort(CPU(cpu), "EXECUTE on instruction prefix 0x%x not implemented\n",
+              opc);
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e99fbd9..c1162a1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2164,14 +2164,14 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
        MVC inside of memcpy, which needs a helper call anyway.  So
        perhaps this doesn't bear thinking about any further.  */
 
-    TCGv_i64 tmp;
+    TCGv_i32 ilen;
 
     update_psw_addr(s);
     gen_op_calc_cc(s);
 
-    tmp = tcg_const_i64(s->next_pc);
-    gen_helper_ex(cc_op, cpu_env, cc_op, o->in1, o->in2, tmp);
-    tcg_temp_free_i64(tmp);
+    ilen = tcg_const_i32(s->next_pc - s->pc);
+    gen_helper_ex(cpu_env, ilen, o->in1, o->in2);
+    tcg_temp_free_i32(ilen);
 
     return NO_EXIT;
 }
-- 
2.9.4
