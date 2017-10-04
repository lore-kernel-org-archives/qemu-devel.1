Received: from eggs.gnu.org ([2001:4830:134:3::10]:38369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzoe3-0008LS-Lv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzoe2-0002uZ-UT
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:47 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:48046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzoe2-0002ts-QP
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:46 -0400
Received: by mail-qt0-x22a.google.com with SMTP id z50so16036423qtj.4
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:25 -0400
Message-Id: <20171004184325.24157-13-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 12/12] target/arm: Decode aa32 armv8.3
 2-reg-index
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
 target/arm/translate.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 48f30e2621..50ef2f1f21 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7693,6 +7693,53 @@ static int disas_neon_insn_cp8_3same(DisasContext *s, uint32_t insn)
     return 0;
 }
 
+/* ARMv8.3 reclaims a portion of the CDP2 coprocessor 8 space.  */
+
+static int disas_neon_insn_cp8_index(DisasContext *s, uint32_t insn)
+{
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
+    if (!s->vfp_enabled || !arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
+        return 1;
+    }
+
+    q = extract32(insn, 6, 1);
+    size = extract32(insn, 23, 1);
+
+    if (size == 0) { /* FIXME: fp16 support */
+        return 1;
+    }
+
+    VFP_DREG_D(rd, insn);
+    VFP_DREG_N(rn, insn);
+    VFP_DREG_M(rm, insn);
+    if ((rd | rn) & q) {
+        return 1;
+    }
+
+    /* This entire space is VCMLA (indexed).  */
+    rot = extract32(insn, 20, 2);
+    opr_sz = (1 + q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                       vfp_reg_offset(1, rn),
+                       vfp_reg_offset(1, rm), fpst,
+                       opr_sz, opr_sz, rot, gen_helper_gvec_fcmlas_idx);
+    tcg_temp_free_ptr(fpst);
+    return 0;
+}
+
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -8414,6 +8461,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             return;
+        } else if ((insn & 0x0f000f10) == 0x0e000800) {
+            /* ARMv8.3 neon cdp2 coprocessor 8 extension.  */
+            if (disas_neon_insn_cp8_index(s, insn)) {
+                goto illegal_op;
+            }
+            return;
         } else if ((insn & 0x0fe00000) == 0x0c400000) {
             /* Coprocessor double register transfer.  */
             ARCH(5TE);
-- 
2.13.6
