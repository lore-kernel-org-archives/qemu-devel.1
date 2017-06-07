Received: from eggs.gnu.org ([2001:4830:134:3::10]:34501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu4-0003sA-10
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu2-0002RU-WF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:52 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu2-0002RL-R9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:50 -0400
Received: by mail-qk0-x244.google.com with SMTP id c206so15446540qkb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:14 -0700
Message-Id: <20170607003119.14778-66-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 65/70] target/s390x: implement TRANSLATE
 ONE/TWO TO ONE/TWO
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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-29-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  9 +++++++++
 target/s390x/mem_helper.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 30 ++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 5871568..11a545e 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -95,6 +95,7 @@ DEF_HELPER_FLAGS_3(tp, TCG_CALL_NO_WG, i32, env, i64, i32)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
+DEF_HELPER_5(trXX, i32, env, i32, i32, i32, i32)
 DEF_HELPER_4(cksm, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7db5133..9976d29 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -870,6 +870,15 @@
 /* TRANSLATE EXTENDED */
     C(0xb2a5, TRE,     RRE,   Z,   0, r2, r1_P, 0, tre, 0)
 
+/* TRANSLATE ONE TO ONE */
+    C(0xb993, TROO,    RRF_c, E2,  0, 0, 0, 0, trXX, 0)
+/* TRANSLATE ONE TO TWO */
+    C(0xb992, TROT,    RRF_c, E2,  0, 0, 0, 0, trXX, 0)
+/* TRANSLATE TWO TO ONE */
+    C(0xb991, TRTO,    RRF_c, E2,  0, 0, 0, 0, trXX, 0)
+/* TRANSLATE TWO TO TWO */
+    C(0xb990, TRTT,    RRF_c, E2,  0, 0, 0, 0, trXX, 0)
+
 /* UNPACK */
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index fa2bfbb..be89cc4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1196,6 +1196,51 @@ uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
     return do_helper_trt(env, len, array, trans, GETPC());
 }
 
+/* Translate one/two to one/two */
+uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
+                      uint32_t tst, uint32_t sizes)
+{
+    uintptr_t ra = GETPC();
+    int dsize = (sizes & 1) ? 1 : 2;
+    int ssize = (sizes & 2) ? 1 : 2;
+    uint64_t tbl = get_address(env, 1) & ~7;
+    uint64_t dst = get_address(env, r1);
+    uint64_t len = get_length(env, r1 + 1);
+    uint64_t src = get_address(env, r2);
+    uint32_t cc = 3;
+    int i;
+
+    check_alignment(env, len, ssize, ra);
+
+    /* Lest we fail to service interrupts in a timely manner, */
+    /* limit the amount of work we're willing to do.   */
+    for (i = 0; i < 0x2000; i++) {
+        uint16_t sval = cpu_ldusize_data_ra(env, src, ssize, ra);
+        uint64_t tble = tbl + (sval * dsize);
+        uint16_t dval = cpu_ldusize_data_ra(env, tble, dsize, ra);
+        if (dval == tst) {
+            cc = 1;
+            break;
+        }
+        cpu_stsize_data_ra(env, dst, dval, dsize, ra);
+
+        len -= ssize;
+        src += ssize;
+        dst += dsize;
+
+        if (len == 0) {
+            cc = 0;
+            break;
+        }
+    }
+
+    set_address(env, r1, dst);
+    set_length(env, r1 + 1, len);
+    set_address(env, r2, src);
+
+    return cc;
+}
+
 void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
                   uint32_t r1, uint32_t r3)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2253ce6..9f3443e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4340,6 +4340,36 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_trXX(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 sizes = tcg_const_i32(s->insn->opc & 3);
+    TCGv_i32 tst = tcg_temp_new_i32();
+    int m3 = get_field(s->fields, m3);
+
+    /* XXX: the C bit in M3 should be considered as 0 when the
+       ETF2-enhancement facility is not installed.  */
+    if (m3 & 1) {
+        tcg_gen_movi_i32(tst, -1);
+    } else {
+        tcg_gen_extrl_i64_i32(tst, regs[0]);
+        if (s->insn->opc & 3) {
+            tcg_gen_ext8u_i32(tst, tst);
+        } else {
+            tcg_gen_ext16u_i32(tst, tst);
+        }
+    }
+    gen_helper_trXX(cc_op, cpu_env, r1, r2, tst, sizes);
+
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    tcg_temp_free_i32(sizes);
+    tcg_temp_free_i32(tst);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_ts(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 t1 = tcg_const_i32(0xff);
-- 
2.9.4
