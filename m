Received: from eggs.gnu.org ([2001:4830:134:3::10]:43659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWr-0003BC-7b
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWq-00055W-5f
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWp-00054u-VP
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:08 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWo-0001RJ-Ld
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:37 +0000
Message-Id: <20180302110640.28004-37-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/39] target/arm: Decode aa32 armv8.3 3-same
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180228193125.20577-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9169b6b367..45513c9d86 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7680,6 +7680,68 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
+/* Advanced SIMD three registers of the same length extension.
+ *  31           25    23  22    20   16   12  11   10   9    8        3     0
+ * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
+ * | 1 1 1 1 1 1 0 | op1 | D | op2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
+ * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
+ */
+static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
+{
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    int rd, rn, rm, rot, size, opr_sz;
+    TCGv_ptr fpst;
+    bool q;
+
+    q = extract32(insn, 6, 1);
+    VFP_DREG_D(rd, insn);
+    VFP_DREG_N(rn, insn);
+    VFP_DREG_M(rm, insn);
+    if ((rd | rn | rm) & q) {
+        return 1;
+    }
+
+    if ((insn & 0xfe200f10) == 0xfc200800) {
+        /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
+        size = extract32(insn, 20, 1);
+        rot = extract32(insn, 23, 2);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
+            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+            return 1;
+        }
+        fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
+    } else if ((insn & 0xfea00f10) == 0xfc800800) {
+        /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
+        size = extract32(insn, 20, 1);
+        rot = extract32(insn, 24, 1);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
+            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+            return 1;
+        }
+        fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
+    } else {
+        return 1;
+    }
+
+    if (s->fp_excp_el) {
+        gen_exception_insn(s, 4, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+        return 0;
+    }
+    if (!s->vfp_enabled) {
+        return 1;
+    }
+
+    opr_sz = (1 + q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                       vfp_reg_offset(1, rn),
+                       vfp_reg_offset(1, rm), fpst,
+                       opr_sz, opr_sz, rot, fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return 0;
+}
+
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -8424,6 +8486,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             }
+        } else if ((insn & 0x0e000a00) == 0x0c000800
+                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
+            if (disas_neon_insn_3same_ext(s, insn)) {
+                goto illegal_op;
+            }
+            return;
         } else if ((insn & 0x0fe00000) == 0x0c400000) {
             /* Coprocessor double register transfer.  */
             ARCH(5TE);
-- 
2.16.2
