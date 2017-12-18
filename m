Received: from eggs.gnu.org ([2001:4830:134:3::10]:40915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9V-0005rX-P6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9U-00083w-4M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:33 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9T-00082u-S4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:32 -0500
Received: by mail-pf0-x241.google.com with SMTP id m26so9933642pfj.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:16 -0800
Message-Id: <20171218172425.18200-3-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/11] target/arm: Decode aa64 armv8.1
 scalar three same extra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         |   4 ++
 target/arm/advsimd_helper.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c  |  90 ++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs    |   2 +-
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/advsimd_helper.c

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2485fc322d..d103f3d8bf 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -366,8 +366,12 @@ DEF_HELPER_FLAGS_1(neon_rbit_u8, TCG_CALL_NO_RWG_SE, i32, i32)
 
 DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
+DEF_HELPER_4(neon_qrdmlah_s16, i32, env, i32, i32, i32)
+DEF_HELPER_4(neon_qrdmlsh_s16, i32, env, i32, i32, i32)
 DEF_HELPER_3(neon_qdmulh_s32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
+DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
+DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
 
 DEF_HELPER_1(neon_narrow_u8, i32, i64)
 DEF_HELPER_1(neon_narrow_u16, i32, i64)
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
new file mode 100644
index 0000000000..b91d181741
--- /dev/null
+++ b/target/arm/advsimd_helper.c
@@ -0,0 +1,109 @@
+/*
+ *  ARM AdvSIMD Vector Operations
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+
+
+#define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
+
+/* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
+static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
+                                int16_t src2, int16_t src3)
+{
+    /* Simplify:
+     * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16
+     * = ((a3 << 15) + (e1 * e2) + (1 << 14)) >> 15
+     */
+    int32_t ret = (int32_t)src1 * src2;
+    ret = ((int32_t)src3 << 15) + ret + (1 << 14);
+    ret >>= 15;
+    if (ret != (int16_t)ret) {
+        SET_QC();
+        ret = (ret < 0 ? -0x8000 : 0x7fff);
+    }
+    return ret;
+}
+
+uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
+                                  uint32_t src2, uint32_t src3)
+{
+    uint16_t e1 = inl_qrdmlah_s16(env, src1, src2, src3);
+    uint16_t e2 = inl_qrdmlah_s16(env, src1 >> 16, src2 >> 16, src3 >> 16);
+    return deposit32(e1, 16, 16, e2);
+}
+
+/* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
+static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
+                                int16_t src2, int16_t src3)
+{
+    /* Similarly, using subtraction:
+     * = ((a3 << 16) - ((e1 * e2) << 1) + (1 << 15)) >> 16
+     * = ((a3 << 15) - (e1 * e2) + (1 << 14)) >> 15
+     */
+    int32_t ret = (int32_t)src1 * src2;
+    ret = ((int32_t)src3 << 15) - ret + (1 << 14);
+    ret >>= 15;
+    if (ret != (int16_t)ret) {
+        SET_QC();
+        ret = (ret < 0 ? -0x8000 : 0x7fff);
+    }
+    return ret;
+}
+
+uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
+                                  uint32_t src2, uint32_t src3)
+{
+    uint16_t e1 = inl_qrdmlsh_s16(env, src1, src2, src3);
+    uint16_t e2 = inl_qrdmlsh_s16(env, src1 >> 16, src2 >> 16, src3 >> 16);
+    return deposit32(e1, 16, 16, e2);
+}
+
+/* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
+uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
+                                  int32_t src2, int32_t src3)
+{
+    /* Simplify similarly to int_qrdmlah_s16 above.  */
+    int64_t ret = (int64_t)src1 * src2;
+    ret = ((int64_t)src3 << 31) + ret + (1 << 30);
+    ret >>= 31;
+    if (ret != (int32_t)ret) {
+        SET_QC();
+        ret = (ret < 0 ? INT32_MIN : INT32_MAX);
+    }
+    return ret;
+}
+
+/* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
+uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
+                                  int32_t src2, int32_t src3)
+{
+    /* Simplify similarly to int_qrdmlsh_s16 above.  */
+    int64_t ret = (int64_t)src1 * src2;
+    ret = ((int64_t)src3 << 31) - ret + (1 << 30);
+    ret >>= 31;
+    if (ret != (int32_t)ret) {
+        SET_QC();
+        ret = (ret < 0 ? INT32_MIN : INT32_MAX);
+    }
+    return ret;
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d8702b10f5..0b090fe086 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7822,6 +7822,95 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s, uint32_t insn
     tcg_temp_free_ptr(fpst);
 }
 
+/* AdvSIMD scalar three same extra
+ *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
+ * +-----+---+-----------+------+---+------+---+--------+---+----+----+
+ * | 0 1 | U | 1 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
+ * +-----+---+-----------+------+---+------+---+--------+---+----+----+
+ */
+static void disas_simd_scalar_three_reg_same_extra(DisasContext *s,
+                                                   uint32_t insn)
+{
+    int rd = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int opcode = extract32(insn, 11, 4);
+    int rm = extract32(insn, 16, 5);
+    int size = extract32(insn, 22, 2);
+    bool u = extract32(insn, 29, 1);
+    TCGv_i32 ele1, ele2, ele3;
+    TCGv_i64 res;
+    int feature;
+
+    if (!u) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (opcode) {
+    case 0x0: /* SQRDMLAH (vector) */
+    case 0x1: /* SQRDMLSH (vector) */
+        if (size != 1 && size != 2) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_1_SIMD;
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!arm_dc_feature(s, feature)) {
+        unallocated_encoding(s);
+        return;
+    }
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    /* Do a single operation on the lowest element in the vector.
+     * We use the standard Neon helpers and rely on 0 OP 0 == 0
+     * with no side effects for all these operations.
+     * OPTME: special-purpose helpers would avoid doing some
+     * unnecessary work in the helper for the 16 bit cases.
+     */
+    ele1 = tcg_temp_new_i32();
+    ele2 = tcg_temp_new_i32();
+    ele3 = tcg_temp_new_i32();
+
+    read_vec_element_i32(s, ele1, rn, 0, size);
+    read_vec_element_i32(s, ele2, rm, 0, size);
+    read_vec_element_i32(s, ele3, rd, 0, size);
+
+    switch (opcode) {
+    case 0x0: /* SQRDMLAH */
+        if (size == 1) {
+            gen_helper_neon_qrdmlah_s16(ele3, cpu_env, ele1, ele2, ele3);
+        } else {
+            gen_helper_neon_qrdmlah_s32(ele3, cpu_env, ele1, ele2, ele3);
+        }
+        break;
+    case 0x1: /* SQRDMLSH */
+        if (size == 1) {
+            gen_helper_neon_qrdmlsh_s16(ele3, cpu_env, ele1, ele2, ele3);
+        } else {
+            gen_helper_neon_qrdmlsh_s32(ele3, cpu_env, ele1, ele2, ele3);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_temp_free_i32(ele1);
+    tcg_temp_free_i32(ele2);
+
+    res = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(res, ele3);
+    tcg_temp_free_i32(ele3);
+
+    write_fp_dreg(s, rd, res);
+    tcg_temp_free_i64(res);
+}
+
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -12344,6 +12433,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x2e000000, 0xbf208400, disas_simd_ext },
     { 0x5e200400, 0xdf200400, disas_simd_scalar_three_reg_same },
+    { 0x5e008400, 0xdf208400, disas_simd_scalar_three_reg_same_extra },
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5e300800, 0xdf3e0c00, disas_simd_scalar_pairwise },
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 847fb52ee0..c2d32988f9 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -5,7 +5,7 @@ obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += neon_helper.o iwmmxt_helper.o
+obj-y += neon_helper.o iwmmxt_helper.o advsimd_helper.o
 obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
 obj-y += crypto_helper.o
-- 
2.14.3
