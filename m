Received: from eggs.gnu.org ([2001:4830:134:3::10]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1frwlg-0004DH-7j
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1frwle-0004lp-7w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:51:40 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Mon, 20 Aug 2018 22:51:04 -0400
Message-Id: <20180821025104.19604-8-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] target/s390x: implement CVB, CVBY and CVBG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Convert to Binary - counterparts of the already implemented Convert
to Decimal (CVD*) instructions.
Example from the Principles of Operation: 25594C becomes 63FA.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  4 +++
 target/s390x/int_helper.c       | 50 +++++++++++++++++++++++++++++++++
 target/s390x/translate.c        | 10 +++++++
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/cvb.c           | 18 ++++++++++++
 6 files changed, 84 insertions(+)
 create mode 100644 tests/tcg/s390x/cvb.c

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 97c60ca7bc..46baaee0ab 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_4(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(cvb, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9c7b434fca..1b29a5e044 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -284,6 +284,10 @@
     D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_32u, 0, 0, ct, 0, 1)
     D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_32u, 0, 0, ct, 0, 1)
 
+/* CONVERT TO BINARY */
+    C(0x4f00, CVB,     RX_a,  Z,   0, a2, new, r1_32, cvb, 0)
+    C(0xe306, CVBY,    RXY_a, LD,  0, a2, new, r1_32, cvb, 0)
+    C(0xe30e, CVBG,    RXY_a, Z,   0, a2, r1, 0, cvb, 0)
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index abf77a94e6..66c6dc8b3a 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -118,6 +119,55 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     return ret;
 }
 
+static void general_operand_exception(CPUS390XState *env, uintptr_t ra)
+{
+#ifndef CONFIG_USER_ONLY
+    LowCore *lowcore;
+
+    lowcore = cpu_map_lowcore(env);
+    lowcore->data_exc_code = 0;
+    cpu_unmap_lowcore(lowcore);
+#endif
+    s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+}
+
+uint64_t HELPER(cvb)(CPUS390XState *env, uint64_t src, uint32_t n)
+{
+    int i, j;
+    uintptr_t ra = GETPC();
+    int64_t dec, sign = 0, digit, val = 0, pow10 = 0;
+
+    for (i = 0; i < n; i++) {
+        dec = cpu_ldq_data_ra(env, src + (n - i - 1) * 8, ra);
+        for (j = 0; j < 16; j++, dec >>= 4) {
+            if (i == 0 && j == 0) {
+                sign = dec & 0xf;
+                if (sign < 0xa) {
+                    general_operand_exception(env, ra);
+                }
+                continue;
+            }
+            digit = dec & 0xf;
+            if (digit > 0x9) {
+                general_operand_exception(env, ra);
+            }
+            if (i == 0 && j == 1) {
+                if (sign == 0xb || sign == 0xd) {
+                    val = -digit;
+                    pow10 = -10;
+                } else {
+                    val = digit;
+                    pow10 = 10;
+                }
+            } else {
+                val += digit * pow10;
+                pow10 *= 10;
+            }
+        }
+    }
+    return val;
+}
+
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f58b36b789..b3cbfead5d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2115,6 +2115,16 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
+{
+    uint64_t n = ((s->fields->op == 0xE3) && (s->fields->op2 == 0x0E)) ?
+        /* CVBG */      2 :
+        /* CVB, CVBY */ 1;
+
+    gen_helper_cvb(o->out, cpu_env, o->in2, tcg_const_i32(n));
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 151dc075aa..990dfb26ff 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -6,3 +6,4 @@ TESTS+=ipm
 TESTS+=exrl-trt
 TESTS+=exrl-trtr
 TESTS+=pack
+TESTS+=cvb
diff --git a/tests/tcg/s390x/cvb.c b/tests/tcg/s390x/cvb.c
new file mode 100644
index 0000000000..3a72e132aa
--- /dev/null
+++ b/tests/tcg/s390x/cvb.c
@@ -0,0 +1,18 @@
+#include <stdint.h>
+#include <unistd.h>
+
+int main(void)
+{
+    uint64_t data = 0x000000000025594cull;
+    uint64_t result = 0;
+
+    asm volatile(
+        "    cvb %[result],%[data]\n"
+        : [result] "+r" (result)
+        : [data] "m" (data));
+    if (result != 0x63fa) {
+        write(1, "bad result\n", 11);
+        return 1;
+    }
+    return 0;
+}
-- 
2.18.0
