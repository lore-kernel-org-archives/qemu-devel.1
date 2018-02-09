Received: from eggs.gnu.org ([2001:4830:134:3::10]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sm-0000yd-8N
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sk-0001uv-Uh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:28 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sk-0001sW-MD
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:26 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sf-0002ZE-3o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:52 +0000
Message-Id: <20180209110314.11766-9-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/30] target/arm: implement SHA-512 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This implements emulation of the new SHA-512 instructions that have
been added as an optional extensions to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 20180207111729.15737-2-ard.biesheuvel@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |   1 +
 target/arm/helper.h        |   5 +++
 target/arm/crypto_helper.c |  90 ++++++++++++++++++++++++++++++++++++-
 target/arm/translate-a64.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3533bb8e9a..4d380fb3e5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1341,6 +1341,7 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
+    ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5dec2e6262..81d4607028 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -534,6 +534,11 @@ DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
+DEF_HELPER_FLAGS_3(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_2(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha512su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 9ca0bdead7..3d8d1fb5e7 100644
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
@@ -419,3 +419,91 @@ void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
     rd[0] = d.l[0];
     rd[1] = d.l[1];
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
+void HELPER(crypto_sha512h)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    uint64_t d0 = rd[0];
+    uint64_t d1 = rd[1];
+
+    d1 += S1_512(rm[1]) + cho512(rm[1], rn[0], rn[1]);
+    d0 += S1_512(d1 + rm[0]) + cho512(d1 + rm[0], rm[1], rn[0]);
+
+    rd[0] = d0;
+    rd[1] = d1;
+}
+
+void HELPER(crypto_sha512h2)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    uint64_t d0 = rd[0];
+    uint64_t d1 = rd[1];
+
+    d1 += S0_512(rm[0]) + maj512(rn[0], rm[1], rm[0]);
+    d0 += S0_512(d1) + maj512(d1, rm[0], rm[1]);
+
+    rd[0] = d0;
+    rd[1] = d1;
+}
+
+void HELPER(crypto_sha512su0)(void *vd, void *vn)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t d0 = rd[0];
+    uint64_t d1 = rd[1];
+
+    d0 += s0_512(rd[1]);
+    d1 += s0_512(rn[0]);
+
+    rd[0] = d0;
+    rd[1] = d1;
+}
+
+void HELPER(crypto_sha512su1)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+
+    rd[0] += s1_512(rn[0]) + rm[0];
+    rd[1] += s1_512(rn[1]) + rm[1];
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0830c3f1c8..095aa5dea4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11587,6 +11587,114 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     tcg_temp_free_ptr(tcg_rn_ptr);
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
+    int feature;
+    CryptoThreeOpFn *genfn;
+
+    if (o == 0) {
+        switch (opcode) {
+        case 0: /* SHA512H */
+            feature = ARM_FEATURE_V8_SHA512;
+            genfn = gen_helper_crypto_sha512h;
+            break;
+        case 1: /* SHA512H2 */
+            feature = ARM_FEATURE_V8_SHA512;
+            genfn = gen_helper_crypto_sha512h2;
+            break;
+        case 2: /* SHA512SU1 */
+            feature = ARM_FEATURE_V8_SHA512;
+            genfn = gen_helper_crypto_sha512su1;
+            break;
+        default:
+            unallocated_encoding(s);
+            return;
+        }
+    } else {
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
+    if (genfn) {
+        TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
+
+        tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+        tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+        tcg_rm_ptr = vec_full_reg_ptr(s, rm);
+
+        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
+
+        tcg_temp_free_ptr(tcg_rd_ptr);
+        tcg_temp_free_ptr(tcg_rn_ptr);
+        tcg_temp_free_ptr(tcg_rm_ptr);
+    } else {
+        g_assert_not_reached();
+    }
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
+    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
+    int feature;
+    CryptoTwoOpFn *genfn;
+
+    switch (opcode) {
+    case 0: /* SHA512SU0 */
+        feature = ARM_FEATURE_V8_SHA512;
+        genfn = gen_helper_crypto_sha512su0;
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
+    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+
+    genfn(tcg_rd_ptr, tcg_rn_ptr);
+
+    tcg_temp_free_ptr(tcg_rd_ptr);
+    tcg_temp_free_ptr(tcg_rn_ptr);
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11616,6 +11724,8 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
+    { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
+    { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.16.1
