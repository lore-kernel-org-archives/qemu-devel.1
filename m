Received: from eggs.gnu.org ([2001:4830:134:3::10]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTx-0005C1-WF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecXTw-00046N-9q
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:26 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ecXTw-000453-0i
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:17:24 -0500
Received: by mail-wr0-x243.google.com with SMTP id o7so1706507wro.8
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:17:23 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 Jan 2018 14:17:06 +0000
Message-Id: <20180119141707.11733-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
References: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v3 3/4] target/arm: implement SM3 instructions
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

This implements emulation of the new SM3 instructions that have
been added as an optional extension to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/cpu.h           |   1 +
 target/arm/crypto_helper.c | 143 ++++++++++++++++++++
 target/arm/helper.h        |   5 +
 target/arm/translate-a64.c | 100 +++++++++++---
 4 files changed, 227 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8e355398e3e0..917d15fa346c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1342,6 +1342,7 @@ enum arm_features {
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index b51fb0bd2897..6c601351b177 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -629,3 +629,146 @@ void HELPER(crypto_xar)(CPUARMState *env, uint32_t rd, uint32_t rn,
     env->vfp.regs[rd] = make_float64(d0);
     env->vfp.regs[rd + 1] = make_float64(d1);
 }
+
+void HELPER(crypto_sm3partw1)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                              uint32_t rm)
+{
+    union CRYPTO_STATE d = { .l = {
+        float64_val(env->vfp.regs[rd]),
+        float64_val(env->vfp.regs[rd + 1])
+    } };
+    union CRYPTO_STATE n = { .l = {
+        float64_val(env->vfp.regs[rn]),
+        float64_val(env->vfp.regs[rn + 1])
+    } };
+    union CRYPTO_STATE m = { .l = {
+        float64_val(env->vfp.regs[rm]),
+        float64_val(env->vfp.regs[rm + 1])
+    } };
+    uint32_t t;
+
+    t = CR_ST_WORD(d, 0) ^ CR_ST_WORD(n, 0) ^ ror32(CR_ST_WORD(m, 1), 17);
+    CR_ST_WORD(d, 0) = t ^ ror32(t, 17) ^ ror32(t, 9);
+
+    t = CR_ST_WORD(d, 1) ^ CR_ST_WORD(n, 1) ^ ror32(CR_ST_WORD(m, 2), 17);
+    CR_ST_WORD(d, 1) = t ^ ror32(t, 17) ^ ror32(t, 9);
+
+    t = CR_ST_WORD(d, 2) ^ CR_ST_WORD(n, 2) ^ ror32(CR_ST_WORD(m, 3), 17);
+    CR_ST_WORD(d, 2) = t ^ ror32(t, 17) ^ ror32(t, 9);
+
+    t = CR_ST_WORD(d, 3) ^ CR_ST_WORD(n, 3) ^ ror32(CR_ST_WORD(d, 0), 17);
+    CR_ST_WORD(d, 3) = t ^ ror32(t, 17) ^ ror32(t, 9);
+
+    env->vfp.regs[rd] = make_float64(d.l[0]);
+    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+}
+
+void HELPER(crypto_sm3partw2)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                              uint32_t rm)
+{
+    union CRYPTO_STATE d = { .l = {
+        float64_val(env->vfp.regs[rd]),
+        float64_val(env->vfp.regs[rd + 1])
+    } };
+    union CRYPTO_STATE n = { .l = {
+        float64_val(env->vfp.regs[rn]),
+        float64_val(env->vfp.regs[rn + 1])
+    } };
+    union CRYPTO_STATE m = { .l = {
+        float64_val(env->vfp.regs[rm]),
+        float64_val(env->vfp.regs[rm + 1])
+    } };
+    uint32_t t = CR_ST_WORD(n, 0) ^ ror32(CR_ST_WORD(m, 0), 25);
+
+    CR_ST_WORD(d, 0) ^= t;
+    CR_ST_WORD(d, 1) ^= CR_ST_WORD(n, 1) ^ ror32(CR_ST_WORD(m, 1), 25);
+    CR_ST_WORD(d, 2) ^= CR_ST_WORD(n, 2) ^ ror32(CR_ST_WORD(m, 2), 25);
+    CR_ST_WORD(d, 3) ^= CR_ST_WORD(n, 3) ^ ror32(CR_ST_WORD(m, 3), 25) ^
+                        ror32(t, 17) ^ ror32(t, 2) ^ ror32(t, 26);
+
+    env->vfp.regs[rd] = make_float64(d.l[0]);
+    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+}
+
+void HELPER(crypto_sm3ss1)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                           uint32_t ra, uint32_t rm)
+{
+    union CRYPTO_STATE d;
+    union CRYPTO_STATE a = { .l = {
+        float64_val(env->vfp.regs[ra]),
+        float64_val(env->vfp.regs[ra + 1])
+    } };
+    union CRYPTO_STATE n = { .l = {
+        float64_val(env->vfp.regs[rn]),
+        float64_val(env->vfp.regs[rn + 1])
+    } };
+    union CRYPTO_STATE m = { .l = {
+        float64_val(env->vfp.regs[rm]),
+        float64_val(env->vfp.regs[rm + 1])
+    } };
+
+    CR_ST_WORD(d, 0) = 0;
+    CR_ST_WORD(d, 1) = 0;
+    CR_ST_WORD(d, 2) = 0;
+    CR_ST_WORD(d, 3) = ror32(ror32(CR_ST_WORD(n, 3), 20) + CR_ST_WORD(m, 3) +
+                             CR_ST_WORD(a, 3), 25);
+
+    env->vfp.regs[rd] = make_float64(d.l[0]);
+    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+}
+
+void HELPER(crypto_sm3tt)(CPUARMState *env, uint32_t rd, uint32_t rn,
+                          uint32_t rm, uint32_t imm2, uint32_t opcode)
+{
+    union CRYPTO_STATE d = { .l = {
+        float64_val(env->vfp.regs[rd]),
+        float64_val(env->vfp.regs[rd + 1])
+    } };
+    union CRYPTO_STATE n = { .l = {
+        float64_val(env->vfp.regs[rn]),
+        float64_val(env->vfp.regs[rn + 1])
+    } };
+    union CRYPTO_STATE m = { .l = {
+        float64_val(env->vfp.regs[rm]),
+        float64_val(env->vfp.regs[rm + 1])
+    } };
+    uint32_t t;
+
+    assert(imm2 < 4);
+
+    if (opcode == 0 || opcode == 2) {
+        /* SM3TT1A, SM3TT2A */
+        t = par(CR_ST_WORD(d, 3), CR_ST_WORD(d, 2), CR_ST_WORD(d, 1));
+    } else if (opcode == 1) {
+        /* SM3TT1B */
+        t = maj(CR_ST_WORD(d, 3), CR_ST_WORD(d, 2), CR_ST_WORD(d, 1));
+    } else if (opcode == 3) {
+        /* SM3TT2B */
+        t = cho(CR_ST_WORD(d, 3), CR_ST_WORD(d, 2), CR_ST_WORD(d, 1));
+    } else {
+        g_assert_not_reached();
+    }
+
+    t += CR_ST_WORD(d, 0) + CR_ST_WORD(m, imm2);
+
+    CR_ST_WORD(d, 0) = CR_ST_WORD(d, 1);
+
+    if (opcode < 2) {
+        /* SM3TT1A, SM3TT1B */
+        t += CR_ST_WORD(n, 3) ^ ror32(CR_ST_WORD(d, 3), 20);
+
+        CR_ST_WORD(d, 1) = ror32(CR_ST_WORD(d, 2), 23);
+    } else {
+        /* SM3TT2A, SM3TT2B */
+        t += CR_ST_WORD(n, 3);
+        t ^= rol32(t, 9) ^ rol32(t, 17);
+
+        CR_ST_WORD(d, 1) = ror32(CR_ST_WORD(d, 2), 13);
+    }
+
+    CR_ST_WORD(d, 2) = CR_ST_WORD(d, 3);
+    CR_ST_WORD(d, 3) = t;
+
+    env->vfp.regs[rd] = make_float64(d.l[0]);
+    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2053ea10b2a5..913c551bf14b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -544,6 +544,11 @@ DEF_HELPER_5(crypto_eor3, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(crypto_bcax, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(crypto_xar, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(crypto_sm3ss1, void, env, i32, i32, i32, i32)
+DEF_HELPER_6(crypto_sm3tt, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_4(crypto_sm3partw1, void, env, i32, i32, i32)
+DEF_HELPER_4(crypto_sm3partw2, void, env, i32, i32, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c632f584aad6..9d805d4a7d26 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11130,28 +11130,39 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int feature;
     CryptoThreeOpEnvFn *genfn;
 
-    if (o != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA512H */
-        feature = ARM_FEATURE_V8_SHA512;
-        genfn = gen_helper_crypto_sha512h;
-        break;
-    case 1: /* SHA512H2 */
-        feature = ARM_FEATURE_V8_SHA512;
-        genfn = gen_helper_crypto_sha512h2;
-        break;
-    case 2: /* SHA512SU1 */
-        feature = ARM_FEATURE_V8_SHA512;
-        genfn = gen_helper_crypto_sha512su1;
-        break;
-    case 3: /* RAX1 */
-        feature = ARM_FEATURE_V8_SHA3;
-        genfn = gen_helper_crypto_rax1;
-        break;
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
+        case 3: /* RAX1 */
+            feature = ARM_FEATURE_V8_SHA3;
+            genfn = gen_helper_crypto_rax1;
+            break;
+        }
+    } else {
+        switch (opcode) {
+        case 0: /* SM3PARTW1 */
+            feature = ARM_FEATURE_V8_SM3;
+            genfn = gen_helper_crypto_sm3partw1;
+            break;
+        case 1: /* SM3PARTW2 */
+            feature = ARM_FEATURE_V8_SM3;
+            genfn = gen_helper_crypto_sm3partw2;
+            break;
+        default:
+            unallocated_encoding(s);
+            return;
+        }
     }
 
     if (!arm_dc_feature(s, feature)) {
@@ -11241,6 +11252,10 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
         feature = ARM_FEATURE_V8_SHA3;
         genfn = gen_helper_crypto_bcax;
         break;
+    case 2: /* SM3SS1 */
+        feature = ARM_FEATURE_V8_SM3;
+        genfn = gen_helper_crypto_sm3ss1;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -11306,6 +11321,46 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
 
 }
 
+/* Crypto three-reg imm2
+ *  31                   21 20  16 15  14 13 12  11  10  9    5 4    0
+ * +-----------------------+------+-----+------+--------+------+------+
+ * | 1 1 0 0 1 1 1 0 0 1 0 |  Rm  | 1 0 | imm2 | opcode |  Rn  |  Rd  |
+ * +-----------------------+------+-----+------+--------+------+------+
+ */
+static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
+{
+    int opcode = extract32(insn, 10, 2);
+    int imm2 = extract32(insn, 12, 2);
+    int rm = extract32(insn, 16, 5);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno, tcg_imm2, tcg_opcode;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_SM3)) {
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
+    tcg_imm2 = tcg_const_i32(imm2);
+    tcg_opcode = tcg_const_i32(opcode);
+
+    gen_helper_crypto_sm3tt(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_rm_regno,
+                            tcg_imm2, tcg_opcode);
+
+    tcg_temp_free_i32(tcg_rd_regno);
+    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_i32(tcg_rm_regno);
+    tcg_temp_free_i32(tcg_imm2);
+    tcg_temp_free_i32(tcg_opcode);
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11339,6 +11394,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
+    { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
