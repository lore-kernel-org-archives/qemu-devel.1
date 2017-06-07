Received: from eggs.gnu.org ([2001:4830:134:3::10]:34384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtq-0003WV-DB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtp-0002G3-2J
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:38 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOto-0002Fr-Tx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:36 -0400
Received: by mail-qt0-x241.google.com with SMTP id w1so26596897qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:04 -0700
Message-Id: <20170607003119.14778-56-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 55/70] target/s390x: implement COMPARE
 LOGICAL LONG
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

From: Aurelien Jarno <aurelien@aurel32.net>

As CLCL and CLCLE mostly differ by their operands, use a common do_clcl
helper. Another difference is that CLCL is not interruptible.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-19-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 82 +++++++++++++++++++++++++++++++++-------------
 target/s390x/translate.c   | 21 ++++++++++++
 4 files changed, 83 insertions(+), 23 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a537e51..a06e276 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -6,6 +6,7 @@ DEF_HELPER_FLAGS_4(mvc, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvcin, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(clc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_3(mvcl, i32, env, i32, i32)
+DEF_HELPER_3(clcl, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(clm, TCG_CALL_NO_WG, i32, env, i32, i32, i64)
 DEF_HELPER_FLAGS_3(divs32, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7fb2e25..e30b1b9 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -216,6 +216,8 @@
     C(0xc60e, CLGFRL,  RIL_b, GIE, r1_o, mri2_32u, 0, 0, 0, cmpu64)
     C(0xc607, CLHRL,   RIL_b, GIE, r1_o, mri2_16u, 0, 0, 0, cmpu32)
     C(0xc606, CLGHRL,  RIL_b, GIE, r1_o, mri2_16u, 0, 0, 0, cmpu64)
+/* COMPARE LOGICAL LONG */
+    C(0x0f00, CLCL,    RR_a,  Z,   0, 0, 0, 0, clcl, 0)
 /* COMPARE LOGICAL LONG EXTENDED */
     C(0xa900, CLCLE,   RS_a,  Z,   0, a2, 0, 0, clcle, 0)
 /* COMPARE LOGICAL CHARACTERS UNDER MASK */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e30020c..4ed0b65 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -661,17 +661,14 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     return cc;
 }
 
-/* compare logical long extended memcompare insn with padding */
-uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
-                       uint32_t r3)
+/* compare logical long helper */
+static inline uint32_t do_clcl(CPUS390XState *env,
+                               uint64_t *src1, uint64_t *src1len,
+                               uint64_t *src3, uint64_t *src3len,
+                               uint8_t pad, uint64_t limit,
+                               uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
-    uint64_t src1len = get_length(env, r1 + 1);
-    uint64_t src1 = get_address(env, r1);
-    uint64_t src3len = get_length(env, r3 + 1);
-    uint64_t src3 = get_address(env, r3);
-    uint8_t pad = a2 & 0xff;
-    uint64_t len = MAX(src1len, src3len);
+    uint64_t len = MAX(*src1len, *src3len);
     uint32_t cc = 0;
 
     if (!len) {
@@ -679,9 +676,9 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     }
 
     /* Lest we fail to service interrupts in a timely manner, limit the
-       amount of work we're willing to do.  For now, let's cap at 8k.  */
-    if (len > 0x2000) {
-        len = 0x2000;
+       amount of work we're willing to do.  */
+    if (len > limit) {
+        len = limit;
         cc = 3;
     }
 
@@ -689,11 +686,11 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
         uint8_t v1 = pad;
         uint8_t v3 = pad;
 
-        if (src1len) {
-            v1 = cpu_ldub_data_ra(env, src1, ra);
+        if (*src1len) {
+            v1 = cpu_ldub_data_ra(env, *src1, ra);
         }
-        if (src3len) {
-            v3 = cpu_ldub_data_ra(env, src3, ra);
+        if (*src3len) {
+            v3 = cpu_ldub_data_ra(env, *src3, ra);
         }
 
         if (v1 != v3) {
@@ -701,16 +698,55 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
             break;
         }
 
-        if (src1len) {
-            src1++;
-            src1len--;
+        if (*src1len) {
+            *src1 += 1;
+            *src1len -= 1;
         }
-        if (src3len) {
-            src3++;
-            src3len--;
+        if (*src3len) {
+            *src3 += 1;
+            *src3len -= 1;
         }
     }
 
+    return cc;
+}
+
+
+/* compare logical long */
+uint32_t HELPER(clcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    uintptr_t ra = GETPC();
+    uint64_t src1len = extract64(env->regs[r1 + 1], 0, 24);
+    uint64_t src1 = get_address(env, r1);
+    uint64_t src3len = extract64(env->regs[r2 + 1], 0, 24);
+    uint64_t src3 = get_address(env, r2);
+    uint8_t pad = env->regs[r2 + 1] >> 24;
+    uint32_t cc;
+
+    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, -1, ra);
+
+    env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, src1len);
+    env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, src3len);
+    set_address(env, r1, src1);
+    set_address(env, r2, src3);
+
+    return cc;
+}
+
+/* compare logical long extended memcompare insn with padding */
+uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
+                       uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    uint64_t src1len = get_length(env, r1 + 1);
+    uint64_t src1 = get_address(env, r1);
+    uint64_t src3len = get_length(env, r3 + 1);
+    uint64_t src3 = get_address(env, r3);
+    uint8_t pad = a2;
+    uint32_t cc;
+
+    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, 0x2000, ra);
+
     set_length(env, r1 + 1, src1len);
     set_length(env, r3 + 1, src3len);
     set_address(env, r1, src1);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ecd0a91..2d47f1d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1920,6 +1920,27 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
+{
+    int r1 = get_field(s->fields, r1);
+    int r2 = get_field(s->fields, r2);
+    TCGv_i32 t1, t2;
+
+    /* r1 and r2 must be even.  */
+    if (r1 & 1 || r2 & 1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+
+    t1 = tcg_const_i32(r1);
+    t2 = tcg_const_i32(r2);
+    gen_helper_clcl(cc_op, cpu_env, t1, t2);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
-- 
2.9.4
