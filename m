Received: from eggs.gnu.org ([2001:4830:134:3::10]:38336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzoe2-0008Jt-Ih
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzoe1-0002rs-Ns
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:46 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:51667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzoe1-0002rI-Jd
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:45 -0400
Received: by mail-qt0-x234.google.com with SMTP id q4so21062241qtq.8
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:24 -0400
Message-Id: <20171004184325.24157-12-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 11/12] target/arm: Decode aa32 armv8.3 3-same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ee1e364fb5..48f30e2621 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7630,6 +7630,69 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
+/* ARMv8.3 reclaims a portion of the LDC2/STC2 coprocessor 8 space.  */
+
+static int disas_neon_insn_cp8_3same(DisasContext *s, uint32_t insn)
+{
+    void (*fn_gvec_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+    int rd, rn, rm, rot, size, opr_sz;
+    TCGv_ptr fpst;
+    bool q;
+
+    /* FIXME: this access check should not take precedence over UNDEF
+     * for invalid encodings; we will generate incorrect syndrome information
+     * for attempts to execute invalid vfp/neon encodings with FP disabled.
+     */
+    if (s->fp_excp_el) {
+        gen_exception_insn(s, 4, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+        return 0;
+    }
+    if (!s->vfp_enabled) {
+        return 1;
+    }
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
+        return 1;
+    }
+
+    q = extract32(insn, 6, 1);
+    size = extract32(insn, 20, 1);
+    VFP_DREG_D(rd, insn);
+    VFP_DREG_N(rn, insn);
+    VFP_DREG_M(rm, insn);
+    if ((rd | rn | rm) & q) {
+        return 1;
+    }
+
+    if (size == 0) { /* FIXME: fp16 support */
+        return 1;
+    }
+
+    if (extract32(insn, 21, 1)) {
+        /* VCMLA */
+        rot = extract32(insn, 23, 2);
+        fn_gvec_ptr = gen_helper_gvec_fcmlas;
+    } else if (extract32(insn, 23, 1)) {
+        /* VCADD */
+        rot = extract32(insn, 24, 1);
+        fn_gvec_ptr = gen_helper_gvec_fcadds;
+    } else {
+        /* Assuming the register fields remain, only bit 24 remains undecoded:
+         * 1111_110x_0d0s_nnnn_dddd_1000_nqm0_mmmm
+         */
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
@@ -8345,6 +8408,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             }
+        } else if ((insn & 0x0e000f10) == 0x0c000800) {
+            /* ARMv8.3 neon ldc2/stc2 coprocessor 8 extension.  */
+            if (disas_neon_insn_cp8_3same(s, insn)) {
+                goto illegal_op;
+            }
+            return;
         } else if ((insn & 0x0fe00000) == 0x0c400000) {
             /* Coprocessor double register transfer.  */
             ARCH(5TE);
-- 
2.13.6
