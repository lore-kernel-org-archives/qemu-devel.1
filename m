Received: from eggs.gnu.org ([2001:4830:134:3::10]:35812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7SB-0003Yd-Np
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S9-0006UI-KT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:51 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7S9-0006Te-F5
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:49 -0500
Received: by mail-pl0-x244.google.com with SMTP id s13-v6so2119396plq.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:23 -0800
Message-Id: <20180228193125.20577-15-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 14/16] target/arm: Decode aa32 armv8.3
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
 target/arm/translate.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 45513c9d86..3ad8b4031c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7742,6 +7742,61 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     return 0;
 }
 
+/* Advanced SIMD two registers and a scalar extension.
+ *  31             24   23  22   20   16   12  11   10   9    8        3     0
+ * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
+ * | 1 1 1 1 1 1 1 0 | o1 | D | o2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
+ * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
+ *
+ */
+
+static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
+{
+    int rd, rn, rm, rot, size, opr_sz;
+    TCGv_ptr fpst;
+    bool q;
+
+    q = extract32(insn, 6, 1);
+    VFP_DREG_D(rd, insn);
+    VFP_DREG_N(rn, insn);
+    VFP_DREG_M(rm, insn);
+    if ((rd | rn) & q) {
+        return 1;
+    }
+
+    if ((insn & 0xff000f10) == 0xfe000800) {
+        /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
+        rot = extract32(insn, 20, 2);
+        size = extract32(insn, 23, 1);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
+            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+            return 1;
+        }
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
+                       opr_sz, opr_sz, rot,
+                       size ? gen_helper_gvec_fcmlas_idx
+                       : gen_helper_gvec_fcmlah_idx);
+    tcg_temp_free_ptr(fpst);
+    return 0;
+}
+
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -8492,6 +8547,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             return;
+        } else if ((insn & 0x0f000a00) == 0x0e000800
+                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
+            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
+                goto illegal_op;
+            }
+            return;
         } else if ((insn & 0x0fe00000) == 0x0c400000) {
             /* Coprocessor double register transfer.  */
             ARCH(5TE);
-- 
2.14.3
