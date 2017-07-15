Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuK-0006Rl-EN
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuJ-0000sL-CC
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQuJ-0000rj-6e
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:07 -0400
Received: by mail-pf0-x243.google.com with SMTP id e199so14641181pfh.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:31:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:47 -1000
Message-Id: <20170715173050.31018-6-rth@twiddle.net>
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 5/8] target/s390x: Implement TRTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Drop TRT from the set of insns handled internally by EXECUTE.
It's more important to adjust the existing helper to handle
both TRT and TRTR.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/mem_helper.c  | 20 +++++++++++++-------
 target/s390x/translate.c   |  9 +++++++++
 target/s390x/insn-data.def |  2 ++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 32314e0..4b02907 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -97,6 +97,7 @@ DEF_HELPER_FLAGS_3(tp, TCG_CALL_NO_WG, i32, env, i64, i32)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
+DEF_HELPER_4(trtr, i32, env, i32, i64, i64)
 DEF_HELPER_5(trXX, i32, env, i32, i32, i32, i32)
 DEF_HELPER_4(cksm, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index f6ca288..ab27e14 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1277,17 +1277,18 @@ uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
     return array + i;
 }
 
-static uint32_t do_helper_trt(CPUS390XState *env, uint32_t len, uint64_t array,
-                              uint64_t trans, uintptr_t ra)
+static inline uint32_t do_helper_trt(CPUS390XState *env, int len,
+                                     uint64_t array, uint64_t trans,
+                                     int inc, uintptr_t ra)
 {
-    uint32_t i;
+    int i;
 
     for (i = 0; i <= len; i++) {
-        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
+        uint8_t byte = cpu_ldub_data_ra(env, array + i * inc, ra);
         uint8_t sbyte = cpu_ldub_data_ra(env, trans + byte, ra);
 
         if (sbyte != 0) {
-            set_address(env, 1, array + i);
+            set_address(env, 1, array + i * inc);
             env->regs[2] = deposit64(env->regs[2], 0, 8, sbyte);
             return (i == len) ? 2 : 1;
         }
@@ -1299,7 +1300,13 @@ static uint32_t do_helper_trt(CPUS390XState *env, uint32_t len, uint64_t array,
 uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
                      uint64_t trans)
 {
-    return do_helper_trt(env, len, array, trans, GETPC());
+    return do_helper_trt(env, len, array, trans, 1, GETPC());
+}
+
+uint32_t HELPER(trtr)(CPUS390XState *env, uint32_t len, uint64_t array,
+                      uint64_t trans)
+{
+    return do_helper_trt(env, len, array, trans, -1, GETPC());
 }
 
 /* Translate one/two to one/two */
@@ -2119,7 +2126,6 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
             [0x6] = do_helper_oc,
             [0x7] = do_helper_xc,
             [0xc] = do_helper_tr,
-            [0xd] = do_helper_trt,
         };
         dx_helper helper = dx[opc & 0xf];
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d83f2b9..b46f4c8 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4447,6 +4447,15 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_trtr(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_trtr(cc_op, cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_trXX(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 1d34df03..ad84c74 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -916,6 +916,8 @@
     C(0xdc00, TR,      SS_a,  Z,   la1, a2, 0, 0, tr, 0)
 /* TRANSLATE AND TEST */
     C(0xdd00, TRT,     SS_a,  Z,   la1, a2, 0, 0, trt, 0)
+/* TRANSLATE AND TEST REVERSE */
+    C(0xd000, TRTR,    SS_a,  ETF3, la1, a2, 0, 0, trtr, 0)
 /* TRANSLATE EXTENDED */
     C(0xb2a5, TRE,     RRE,   Z,   0, r2, r1_P, 0, tre, 0)
 
-- 
2.9.4
