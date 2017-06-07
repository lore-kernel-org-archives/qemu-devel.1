Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOte-0003I0-6p
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtd-0002BS-2C
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtc-0002BG-UC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:25 -0400
Received: by mail-qk0-x242.google.com with SMTP id y201so11029183qka.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:55 -0700
Message-Id: <20170607003119.14778-47-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 46/70] target/s390x: implement COMPARE AND
 SIGNAL
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

These functions differ from COMPARE by generating an exception for a
QNaN input. Use the non quiet version of floatXX_compare.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-10-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/fpu_helper.c  | 27 +++++++++++++++++++++++++++
 target/s390x/helper.h      |  3 +++
 target/s390x/insn-data.def |  6 ++++++
 target/s390x/translate.c   | 21 +++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e604e9f..26f124f 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -585,6 +585,33 @@ uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
     return RET128(ret);
 }
 
+/* 32-bit FP compare and signal */
+uint32_t HELPER(keb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
+{
+    int cmp = float32_compare(f1, f2, &env->fpu_status);
+    handle_exceptions(env, GETPC());
+    return float_comp_to_cc(env, cmp);
+}
+
+/* 64-bit FP compare and signal */
+uint32_t HELPER(kdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
+{
+    int cmp = float64_compare(f1, f2, &env->fpu_status);
+    handle_exceptions(env, GETPC());
+    return float_comp_to_cc(env, cmp);
+}
+
+/* 128-bit FP compare and signal */
+uint32_t HELPER(kxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
+                     uint64_t bh, uint64_t bl)
+{
+    int cmp = float128_compare(make_float128(ah, al),
+                               make_float128(bh, bl),
+                               &env->fpu_status);
+    handle_exceptions(env, GETPC());
+    return float_comp_to_cc(env, cmp);
+}
+
 /* 32-bit FP multiply and add */
 uint64_t HELPER(maeb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c6fbc3b..86e2bc1 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -49,6 +49,9 @@ DEF_HELPER_FLAGS_3(lexb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(ceb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_3(cdb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_5(cxb, TCG_CALL_NO_WG_SE, i32, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(keb, TCG_CALL_NO_WG, i32, env, i64, i64)
+DEF_HELPER_FLAGS_3(kdb, TCG_CALL_NO_WG, i32, env, i64, i64)
+DEF_HELPER_FLAGS_5(kxb, TCG_CALL_NO_WG, i32, env, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_3(cgeb, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(cgdb, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_4(cgxb, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f92bfde..39fcce5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -154,6 +154,12 @@
     C(0xb349, CXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, cxb, 0)
     C(0xed09, CEB,     RXE,   Z,   e1, m2_32u, 0, 0, ceb, 0)
     C(0xed19, CDB,     RXE,   Z,   f1_o, m2_64, 0, 0, cdb, 0)
+/* COMPARE AND SIGNAL */
+    C(0xb308, KEBR,    RRE,   Z,   e1, e2, 0, 0, keb, 0)
+    C(0xb318, KDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, kdb, 0)
+    C(0xb348, KXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, kxb, 0)
+    C(0xed08, KEB,     RXE,   Z,   e1, m2_32u, 0, 0, keb, 0)
+    C(0xed18, KDB,     RXE,   Z,   f1_o, m2_64, 0, 0, kdb, 0)
 /* COMPARE IMMEDIATE */
     C(0xc20d, CFI,     RIL_a, EI,  r1, i2, 0, 0, 0, cmps32)
     C(0xc20c, CGFI,    RIL_a, EI,  r1, i2, 0, 0, 0, cmps64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b3cc349..0a35eed 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2374,6 +2374,27 @@ static ExitStatus op_iske(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static ExitStatus op_keb(DisasContext *s, DisasOps *o)
+{
+    gen_helper_keb(cc_op, cpu_env, o->in1, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_kdb(DisasContext *s, DisasOps *o)
+{
+    gen_helper_kdb(cc_op, cpu_env, o->in1, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_kxb(DisasContext *s, DisasOps *o)
+{
+    gen_helper_kxb(cc_op, cpu_env, o->out, o->out2, o->in1, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_laa(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
-- 
2.9.4
