Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTu-00058l-Eq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTr-00041x-Vf
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:21 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ecXTr-00041G-Mh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:19 -0500
Received: by mail-wr0-x241.google.com with SMTP id 100so1708218wrb.7
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:17:19 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 Jan 2018 14:17:04 +0000
Message-Id: <20180119141707.11733-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
References: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v3 1/4] target/arm: implement SHA-512
 instructions
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

This implements emulation of the new SHA-512 instructions that have
been added as an optional extensions to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/cpu.h           |  1 +
 target/arm/crypto_helper.c | 99 +++++++++++++++++++-
 target/arm/helper.h        |  5 +
 target/arm/translate-a64.c | 99 ++++++++++++++++++++
 4 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 96316700dd6f..295529366c0a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1340,6 +1340,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
+    ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 3b6df3f41a42..15c22c82ca5e 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -1,7 +1,7 @@
 /*
  * crypto_helper.c - emulate v8 Crypto Extensions instructions
  *
- * Copyright (C) 2013 - 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2013 - 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -463,3 +463,100 @@ void HELPER(crypto_sha256su1)(CPUARMState *env, uint32_t rd, uint32_t rn,
     env->vfp.regs[rd] = make_float64(d.l[0]);
     env->vfp.regs[rd + 1] = make_float64(d.l[1]);
 }
+
+/*
+ * The SHA-512 logical functions (same as above but using 64-bit operands)
+ */
+
+static uint64_t cho512(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & (y ^ z)) ^ z;
+}
+
+static uint64_t maj512(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & y) | ((x | y) & z);
+}
+
+static uint64_t S0_512(uint64_t x)
+{
+    return ror64(x, 28) ^ ror64(x, 34) ^ ror64(x, 39);
+}
+
+static uint64_t S1_512(uint64_t x)
+{
+    return ror64(x, 14) ^ ror64(x, 18) ^ ror64(x, 41);
+}
+
+static uint64_t s0_512(uint64_t x)
+{
+    return ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7);
+}
+
+static uint64_t s1_512(uint64_t x)
+{
+    return ror64(x, 19) ^ ror64(x, 61) ^ (x >> 6);
+}
+
+void HELPER(crypto_sha512h)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                            uint32_t rm)
+{
+    uint64_t d0 = float64_val(env->vfp.regs[rd]);
+    uint64_t d1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d1 += S1_512(m1) + cho512(m1, n0, n1);
+    d0 += S1_512(d1 + m0) + cho512(d1 + m0, m1, n0);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_sha512h2)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                             uint32_t rm)
+{
+    uint64_t d0 = float64_val(env->vfp.regs[rd]);
+    uint64_t d1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d1 += S0_512(m0) + maj512(n0, m1, m0);
+    d0 += S0_512(d1) + maj512(d1, m0, m1);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_sha512su0)(CPUARMState *env, uint32_t rd, uint32_t rn)
+{
+    uint64_t d0 = float64_val(env->vfp.regs[rd]);
+    uint64_t d1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+
+    d0 += s0_512(d1);
+    d1 += s0_512(n0);
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
+
+void HELPER(crypto_sha512su1)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                              uint32_t rm)
+{
+    uint64_t d0 = float64_val(env->vfp.regs[rd]);
+    uint64_t d1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t n0 = float64_val(env->vfp.regs[rn]);
+    uint64_t n1 = float64_val(env->vfp.regs[rn + 1]);
+    uint64_t m0 = float64_val(env->vfp.regs[rm]);
+    uint64_t m1 = float64_val(env->vfp.regs[rm + 1]);
+
+    d0 += s1_512(n0) + m0;
+    d1 += s1_512(n1) + m1;
+
+    env->vfp.regs[rd] = make_float64(d0);
+    env->vfp.regs[rd + 1] = make_float64(d1);
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 066729e8ad8e..efa75440ce81 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -534,6 +534,11 @@ DEF_HELPER_4(crypto_sha256h2, void, env, i32, i32, i32)
 DEF_HELPER_3(crypto_sha256su0, void, env, i32, i32)
 DEF_HELPER_4(crypto_sha256su1, void, env, i32, i32, i32)
 
+DEF_HELPER_4(crypto_sha512h, void, env, i32, i32, i32)
+DEF_HELPER_4(crypto_sha512h2, void, env, i32, i32, i32)
+DEF_HELPER_3(crypto_sha512su0, void, env, i32, i32)
+DEF_HELPER_4(crypto_sha512su1, void, env, i32, i32, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ba94f7d0456a..ec17391f4ff4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11111,6 +11111,103 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     tcg_temp_free_i32(tcg_rn_regno);
 }
 
+/* Crypto three-reg SHA512
+ *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
+ * +-----------------------+------+---+---+-----+--------+------+------+
+ * | 1 1 0 0 1 1 1 0 0 1 1 |  Rm  | 1 | O | 0 0 | opcode |  Rn  |  Rd  |
+ * +-----------------------+------+---+---+-----+--------+------+------+
+ */
+static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
+{
+    int opcode = extract32(insn, 10, 2);
+    int o =  extract32(insn, 14, 1);
+    int rm = extract32(insn, 16, 5);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno;
+    CryptoThreeOpEnvFn *genfn;
+
+    if (o != 0) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (opcode) {
+    case 0: /* SHA512H */
+        genfn = gen_helper_crypto_sha512h;
+        break;
+    case 1: /* SHA512H2 */
+        genfn = gen_helper_crypto_sha512h2;
+        break;
+    case 2: /* SHA512SU1 */
+        genfn = gen_helper_crypto_sha512su1;
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA512)) {
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
+    tcg_rm_regno = tcg_const_i32(rm << 1);
+
+    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_rm_regno);
+
+    tcg_temp_free_i32(tcg_rd_regno);
+    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_i32(tcg_rm_regno);
+}
+
+/* Crypto two-reg SHA512
+ *  31                                     12  11  10  9    5 4    0
+ * +-----------------------------------------+--------+------+------+
+ * | 1 1 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 0 0 | opcode |  Rn  |  Rd  |
+ * +-----------------------------------------+--------+------+------+
+ */
+static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
+{
+    int opcode = extract32(insn, 10, 2);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    TCGv_i32 tcg_rd_regno, tcg_rn_regno;
+    CryptoTwoOpEnvFn *genfn;
+
+    switch (opcode) {
+    case 0: /* SHA512SU0 */
+        genfn = gen_helper_crypto_sha512su0;
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA512)) {
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
+
+    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno);
+
+    tcg_temp_free_i32(tcg_rd_regno);
+    tcg_temp_free_i32(tcg_rn_regno);
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11140,6 +11237,8 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
+    { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
+    { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
