Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfs0-0006yN-Ap
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfry-0004d5-TO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:56 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfry-0004ce-KJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:54 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so18376370wmd.5
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:26:54 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 17:26:40 +0000
Message-Id: <20180122172643.29742-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v5 1/4] target/arm: implement SHA-512
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
 target/arm/cpu.h           |   1 +
 target/arm/crypto_helper.c |  75 ++++++++++++-
 target/arm/helper.h        |   5 +
 target/arm/translate-a64.c | 110 ++++++++++++++++++++
 4 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a923e42d8bf..32a18510e70b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1372,6 +1372,7 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
+    ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 9ca0bdead7bb..fb45948e9f13 100644
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
@@ -419,3 +419,76 @@ void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
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
+
+    rd[1] += S1_512(rm[1]) + cho512(rm[1], rn[0], rn[1]);
+    rd[0] += S1_512(rd[1] + rm[0]) + cho512(rd[1] + rm[0], rm[1], rn[0]);
+}
+
+void HELPER(crypto_sha512h2)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+
+    rd[1] += S0_512(rm[0]) + maj512(rn[0], rm[1], rm[0]);
+    rd[0] += S0_512(rd[1]) + maj512(rd[1], rm[0], rm[1]);
+}
+
+void HELPER(crypto_sha512su0)(void *vd, void *vn)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+
+    rd[0] += s0_512(rd[1]);
+    rd[1] += s0_512(rn[0]);
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
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5dec2e62626b..81d460702867 100644
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 10eef870fee2..888f5a39a283 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11132,6 +11132,114 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
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
@@ -11161,6 +11269,8 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
+    { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
+    { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
