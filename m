Received: from eggs.gnu.org ([2001:4830:134:3::10]:35424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecbJk-0007cS-FK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecbJj-0008F9-8T
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:23:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ecbJi-0008Ei-W0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:23:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id f3so5345893wmc.1
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:23:06 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 Jan 2018 18:22:46 +0000
Message-Id: <20180119182248.10821-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v4 2/4] target/arm: implement SHA-3 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This implements emulation of the new SHA-3 instructions that have
been added as an optional extensions to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/cpu.h           |   1 +
 target/arm/translate-a64.c | 157 ++++++++++++++++++--
 2 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 32a18510e70b..d0b19e0cbc88 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1373,6 +1373,7 @@ enum arm_features {
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fe08f3198dac..787b94047286 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11145,8 +11145,8 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
     CryptoThreeOpFn *genfn;
+    int feature;
 
     if (o != 0) {
         unallocated_encoding(s);
@@ -11155,20 +11155,24 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 
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
+        genfn = NULL;
+        break;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA512)) {
+    if (!arm_dc_feature(s, feature)) {
         unallocated_encoding(s);
         return;
     }
@@ -11177,15 +11181,42 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
+    if (genfn) {
+        TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
-    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
+        tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+        tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+        tcg_rm_ptr = vec_full_reg_ptr(s, rm);
 
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_ptr(tcg_rm_ptr);
+        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
+
+        tcg_temp_free_ptr(tcg_rd_ptr);
+        tcg_temp_free_ptr(tcg_rn_ptr);
+        tcg_temp_free_ptr(tcg_rm_ptr);
+    } else {
+        TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
+        int pass;
+
+        tcg_op1 = tcg_temp_new_i64();
+        tcg_op2 = tcg_temp_new_i64();
+        tcg_res[0] = tcg_temp_new_i64();
+        tcg_res[1] = tcg_temp_new_i64();
+
+        for (pass = 0; pass < 2; pass++) {
+            read_vec_element(s, tcg_op1, rn, pass, MO_64);
+            read_vec_element(s, tcg_op2, rm, pass, MO_64);
+
+            tcg_gen_rotli_i64(tcg_res[pass], tcg_op2, 1);
+            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
+        }
+        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
+        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+
+        tcg_temp_free(tcg_op1);
+        tcg_temp_free(tcg_op2);
+        tcg_temp_free(tcg_res[0]);
+        tcg_temp_free(tcg_res[1]);
+    }
 }
 
 /* Crypto two-reg SHA512
@@ -11229,6 +11260,106 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     tcg_temp_free_ptr(tcg_rn_ptr);
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
+    TCGv_i64 tcg_op1, tcg_op2, tcg_op3, tcg_res[2];
+    int pass;
+
+    if (op0 > 1 || !arm_dc_feature(s, ARM_FEATURE_V8_SHA3)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    tcg_op1 = tcg_temp_new_i64();
+    tcg_op2 = tcg_temp_new_i64();
+    tcg_op3 = tcg_temp_new_i64();
+    tcg_res[0] = tcg_temp_new_i64();
+    tcg_res[1] = tcg_temp_new_i64();
+
+    for (pass = 0; pass < 2; pass++) {
+        read_vec_element(s, tcg_op1, rn, pass, MO_64);
+        read_vec_element(s, tcg_op2, rm, pass, MO_64);
+        read_vec_element(s, tcg_op3, ra, pass, MO_64);
+
+        if (op0 == 0) {
+            /* EOR3 */
+            tcg_gen_xor_i64(tcg_res[pass], tcg_op2, tcg_op3);
+        } else {
+            /* BCAX */
+            tcg_gen_andc_i64(tcg_res[pass], tcg_op2, tcg_op3);
+        }
+        tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
+    }
+    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
+    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+
+    tcg_temp_free(tcg_op1);
+    tcg_temp_free(tcg_op2);
+    tcg_temp_free(tcg_op3);
+    tcg_temp_free(tcg_res[0]);
+    tcg_temp_free(tcg_res[1]);
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
+    TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
+    int pass;
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
+    tcg_op1 = tcg_temp_new_i64();
+    tcg_op2 = tcg_temp_new_i64();
+    tcg_res[0] = tcg_temp_new_i64();
+    tcg_res[1] = tcg_temp_new_i64();
+
+    for (pass = 0; pass < 2; pass++) {
+        read_vec_element(s, tcg_op1, rn, pass, MO_64);
+        read_vec_element(s, tcg_op2, rm, pass, MO_64);
+
+        tcg_gen_xor_i64(tcg_res[pass], tcg_op1, tcg_op2);
+        tcg_gen_rotri_i64(tcg_res[pass], tcg_res[pass], imm6);
+    }
+    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
+    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+
+    tcg_temp_free(tcg_op1);
+    tcg_temp_free(tcg_op2);
+    tcg_temp_free(tcg_res[0]);
+    tcg_temp_free(tcg_res[1]);
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11260,6 +11391,8 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
+    { 0xce000000, 0xff808000, disas_crypto_four_reg },
+    { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
