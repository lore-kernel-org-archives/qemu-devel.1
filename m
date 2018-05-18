Received: from eggs.gnu.org ([2001:4830:134:3::10]:35986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3F-0000ek-5r
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3D-0007Ts-QD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3C-0007Rj-VM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3C-0004oM-3T
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:48 +0100
Message-Id: <20180518172009.14416-12-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/32] target/arm: Implement SVE load
 vector/predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 127 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  20 ++++++
 2 files changed, 147 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 67d6db313e..5ec18a6aac 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -42,6 +42,20 @@
  * Implement all of the translator functions referenced by the decoder.
  */
 
+/* Return the offset info CPUARMState of the predicate vector register Pn.
+ * Note for this purpose, FFR is P16.
+ */
+static inline int pred_full_reg_offset(DisasContext *s, int regno)
+{
+    return offsetof(CPUARMState, vfp.pregs[regno]);
+}
+
+/* Return the byte size of the whole predicate register, VL / 64.  */
+static inline int pred_full_reg_size(DisasContext *s)
+{
+    return s->sve_len >> 3;
+}
+
 /* Invoke a vector expander on two Zregs.  */
 static bool do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
                          int esz, int rd, int rn)
@@ -100,3 +114,116 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
 {
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
+
+/*
+ *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
+ */
+
+/* Subroutine loading a vector register at VOFS of LEN bytes.
+ * The load should begin at the address Rn + IMM.
+ */
+
+static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
+                   int rn, int imm)
+{
+    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
+    uint32_t len_remain = len % 8;
+    uint32_t nparts = len / 8 + ctpop8(len_remain);
+    int midx = get_mem_index(s);
+    TCGv_i64 addr, t0, t1;
+
+    addr = tcg_temp_new_i64();
+    t0 = tcg_temp_new_i64();
+
+    /* Note that unpredicated load/store of vector/predicate registers
+     * are defined as a stream of bytes, which equates to little-endian
+     * operations on larger quantities.  There is no nice way to force
+     * a little-endian load for aarch64_be-linux-user out of line.
+     *
+     * Attempt to keep code expansion to a minimum by limiting the
+     * amount of unrolling done.
+     */
+    if (nparts <= 4) {
+        int i;
+
+        for (i = 0; i < len_align; i += 8) {
+            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
+            tcg_gen_st_i64(t0, cpu_env, vofs + i);
+        }
+    } else {
+        TCGLabel *loop = gen_new_label();
+        TCGv_ptr tp, i = tcg_const_local_ptr(0);
+
+        gen_set_label(loop);
+
+        /* Minimize the number of local temps that must be re-read from
+         * the stack each iteration.  Instead, re-compute values other
+         * than the loop counter.
+         */
+        tp = tcg_temp_new_ptr();
+        tcg_gen_addi_ptr(tp, i, imm);
+        tcg_gen_extu_ptr_i64(addr, tp);
+        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
+
+        tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
+
+        tcg_gen_add_ptr(tp, cpu_env, i);
+        tcg_gen_addi_ptr(i, i, 8);
+        tcg_gen_st_i64(t0, tp, vofs);
+        tcg_temp_free_ptr(tp);
+
+        tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        tcg_temp_free_ptr(i);
+    }
+
+    /* Predicate register loads can be any multiple of 2.
+     * Note that we still store the entire 64-bit unit into cpu_env.
+     */
+    if (len_remain) {
+        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
+
+        switch (len_remain) {
+        case 2:
+        case 4:
+        case 8:
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
+            break;
+
+        case 6:
+            t1 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(addr, addr, 4);
+            tcg_gen_qemu_ld_i64(t1, addr, midx, MO_LEUW);
+            tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
+            tcg_temp_free_i64(t1);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
+    }
+    tcg_temp_free_i64(addr);
+    tcg_temp_free_i64(t0);
+}
+
+static bool trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int size = vec_full_reg_size(s);
+        int off = vec_full_reg_offset(s, a->rd);
+        do_ldr(s, off, size, a->rn, a->imm * size);
+    }
+    return true;
+}
+
+static bool trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int size = pred_full_reg_size(s);
+        int off = pred_full_reg_offset(s, a->rd);
+        do_ldr(s, off, size, a->rn, a->imm * size);
+    }
+    return true;
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 48dac9f71f..a2c4450e7c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -19,11 +19,17 @@
 # This file is processed by scripts/decodetree.py
 #
 
+###########################################################################
+# Named fields.  These are primarily for disjoint fields.
+
+%imm9_16_10     16:s6 10:3
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
 # instruction patterns.
 
+&rri            rd rn imm
 &rrr_esz        rd rn rm esz
 
 ###########################################################################
@@ -33,6 +39,12 @@
 # Three operand with unused vector element size
 @rd_rn_rm_e0    ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
 
+# Basic Load/Store with 9-bit immediate offset
+@pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
+                &rri imm=%imm9_16_10
+@rd_rn_i9       ........ ........ ...... rn:5 rd:5      \
+                &rri imm=%imm9_16_10
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -43,3 +55,11 @@ AND_zzz         00000100 00 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 ORR_zzz         00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 EOR_zzz         00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 BIC_zzz         00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
+
+### SVE Memory - 32-bit Gather and Unsized Contiguous Group
+
+# SVE load predicate register
+LDR_pri         10000101 10 ...... 000 ... ..... 0 ....         @pd_rn_i9
+
+# SVE load vector register
+LDR_zri         10000101 10 ...... 010 ... ..... .....          @rd_rn_i9
-- 
2.17.0
