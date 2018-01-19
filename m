Received: from eggs.gnu.org ([2001:4830:134:3::10]:58652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTv-00059y-VO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTu-000442-Au
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:23 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ecXTu-00043D-1q
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:22 -0500
Received: by mail-wr0-x242.google.com with SMTP id 36so1724573wrh.1
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:17:21 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 Jan 2018 14:17:05 +0000
Message-Id: <20180119141707.11733-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
References: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v3 2/4] target/arm: implement SHA-3 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This implements emulation of the new SHA-3 instructions that have
been added as an optional extensions to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/cpu.h           |   1 +
 target/arm/crypto_helper.c |  69 +++++++++++++
 target/arm/helper.h        |   5 +
 target/arm/translate-a64.c | 108 +++++++++++++++++++-
 4 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 295529366c0a..8e355398e3e0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1341,6 +1341,7 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 15c22c82ca5e..b51fb0bd2897 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -560,3 +560,72 @@ void HELPER(crypto_sha512su1)(CPUARMState *env, uint32_t rd, uint32_t rn,
     env->vfp.regs[rd] = make_float64(d0);
     env->vfp.regs[rd + 1] = make_float64(d1);
 }
+
+void HELPER(crypto_rax1)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                         uint32_t rm)
+{
+    uint64_t d0 = float64_val(env->vfp.regs[rd]);
+    uint64_t d1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d0 = n0 ^ rol64(m0, 1);
+    d1 = n1 ^ rol64(m1, 1);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_eor3)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                         uint32_t ra, uint32_t rm)
+{
+    uint64_t d0, d1;
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t a0 = float64_val(env->vfp.regs[ra]);
+    uint64_t a1 = float64_val(env->vfp.regs[ra + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d0 = n0 ^ a0 ^ m0;
+    d1 = n1 ^ a1 ^ m1;
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_bcax)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                         uint32_t ra, uint32_t rm)
+{
+    uint64_t d0, d1;
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t a0 = float64_val(env->vfp.regs[ra]);
+    uint64_t a1 = float64_val(env->vfp.regs[ra + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d0 = n0 ^ (~a0 & m0);
+    d1 = n1 ^ (~a1 & m1);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_xar)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                        uint32_t imm6, uint32_t rm)
+{
+    uint64_t d0, d1;
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d0 = ror64(n0 ^ m0, imm6);
+    d1 = ror64(n1 ^ m1, imm6);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index efa75440ce81..2053ea10b2a5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -539,6 +539,11 @@ DEF_HELPER_4(crypto_sha512h2, void, env, i32, i32, i32)
 DEF_HELPER_3(crypto_sha512su0, void, env, i32, i32)
 DEF_HELPER_4(crypto_sha512su1, void, env, i32, i32, i32)
 
+DEF_HELPER_4(crypto_rax1, void, env, i32, i32, i32)
+DEF_HELPER_5(crypto_eor3, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(crypto_bcax, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(crypto_xar, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ec17391f4ff4..c632f584aad6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -82,6 +82,8 @@ typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
+typedef void CryptoFourOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32,
+                               TCGv_i32);
 
 /* initialize TCG globals.  */
 void a64_translate_init(void)
@@ -11125,6 +11127,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno;
+    int feature;
     CryptoThreeOpEnvFn *genfn;
 
     if (o != 0) {
@@ -11134,20 +11137,24 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0: /* SHA512H */
+        feature = ARM_FEATURE_V8_SHA512;
         genfn = gen_helper_crypto_sha512h;
         break;
     case 1: /* SHA512H2 */
+        feature = ARM_FEATURE_V8_SHA512;
         genfn = gen_helper_crypto_sha512h2;
         break;
     case 2: /* SHA512SU1 */
+        feature = ARM_FEATURE_V8_SHA512;
         genfn = gen_helper_crypto_sha512su1;
         break;
-    default:
-        unallocated_encoding(s);
-        return;
+    case 3: /* RAX1 */
+        feature = ARM_FEATURE_V8_SHA3;
+        genfn = gen_helper_crypto_rax1;
+        break;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA512)) {
+    if (!arm_dc_feature(s, feature)) {
         unallocated_encoding(s);
         return;
     }
@@ -11208,6 +11215,97 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     tcg_temp_free_i32(tcg_rn_regno);
 }
 
+/* Crypto four-register
+ *  31               23 22 21 20  16 15  14  10 9    5 4    0
+ * +-------------------+-----+------+---+------+------+------+
+ * | 1 1 0 0 1 1 1 0 0 | Op0 |  Rm  | 0 |  Ra  |  Rn  |  Rd  |
+ * +-------------------+-----+------+---+------+------+------+
+ */
+static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
+{
+    int op0 = extract32(insn, 21, 2);
+    int rm = extract32(insn, 16, 5);
+    int ra = extract32(insn, 10, 5);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_ra_regno, tcg_rm_regno;
+    int feature;
+    CryptoFourOpEnvFn *genfn;
+
+    switch (op0) {
+    case 0: /* EOR3 */
+        feature = ARM_FEATURE_V8_SHA3;
+        genfn = gen_helper_crypto_eor3;
+        break;
+    case 1: /* BCAX */
+        feature = ARM_FEATURE_V8_SHA3;
+        genfn = gen_helper_crypto_bcax;
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
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    tcg_rd_regno = tcg_const_i32(rd << 1);
+    tcg_rn_regno = tcg_const_i32(rn << 1);
+    tcg_ra_regno = tcg_const_i32(ra << 1);
+    tcg_rm_regno = tcg_const_i32(rm << 1);
+
+    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_ra_regno, tcg_rm_regno);
+
+    tcg_temp_free_i32(tcg_rd_regno);
+    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_i32(tcg_ra_regno);
+    tcg_temp_free_i32(tcg_rm_regno);
+}
+
+/* Crypto XAR
+ *  31                   21 20  16 15    10 9    5 4    0
+ * +-----------------------+------+--------+------+------+
+ * | 1 1 0 0 1 1 1 0 1 0 0 |  Rm  |  imm6  |  Rn  |  Rd  |
+ * +-----------------------+------+--------+------+------+
+ */
+static void disas_crypto_xar(DisasContext *s, uint32_t insn)
+{
+    int rm = extract32(insn, 16, 5);
+    int imm6 = extract32(insn, 10, 6);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_imm6, tcg_rm_regno;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA3)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    tcg_rd_regno = tcg_const_i32(rd << 1);
+    tcg_rn_regno = tcg_const_i32(rn << 1);
+    tcg_imm6 = tcg_const_i32(imm6);
+    tcg_rm_regno = tcg_const_i32(rm << 1);
+
+    gen_helper_crypto_xar(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_imm6,
+                          tcg_rm_regno);
+
+    tcg_temp_free_i32(tcg_rd_regno);
+    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_i32(tcg_imm6);
+    tcg_temp_free_i32(tcg_rm_regno);
+
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11239,6 +11337,8 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
+    { 0xce000000, 0xff808000, disas_crypto_four_reg },
+    { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
