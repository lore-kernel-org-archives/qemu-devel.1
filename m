Received: from eggs.gnu.org ([2001:4830:134:3::10]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfs3-00070t-V0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfs2-0004f0-7g
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:59 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfs1-0004eO-Ts
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:58 -0500
Received: by mail-wm0-x244.google.com with SMTP id g1so17768492wmg.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:26:57 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 17:26:42 +0000
Message-Id: <20180122172643.29742-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v5 3/4] target/arm: implement SM3 instructions
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
 target/arm/crypto_helper.c | 117 ++++++++++++++++++++
 target/arm/helper.h        |   5 +
 target/arm/translate-a64.c |  75 ++++++++++++-
 4 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d0b19e0cbc88..18383666e02d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1374,6 +1374,7 @@ enum arm_features {
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index fb45948e9f13..c1d9f765cd40 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -492,3 +492,120 @@ void HELPER(crypto_sha512su1)(void *vd, void *vn, void *vm)
     rd[0] += s1_512(rn[0]) + rm[0];
     rd[1] += s1_512(rn[1]) + rm[1];
 }
+
+void HELPER(crypto_sm3partw1)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
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
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
+
+void HELPER(crypto_sm3partw2)(void *vd, void *vn, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
+    uint32_t t = CR_ST_WORD(n, 0) ^ ror32(CR_ST_WORD(m, 0), 25);
+
+    CR_ST_WORD(d, 0) ^= t;
+    CR_ST_WORD(d, 1) ^= CR_ST_WORD(n, 1) ^ ror32(CR_ST_WORD(m, 1), 25);
+    CR_ST_WORD(d, 2) ^= CR_ST_WORD(n, 2) ^ ror32(CR_ST_WORD(m, 2), 25);
+    CR_ST_WORD(d, 3) ^= CR_ST_WORD(n, 3) ^ ror32(CR_ST_WORD(m, 3), 25) ^
+                        ror32(t, 17) ^ ror32(t, 2) ^ ror32(t, 26);
+
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
+
+void HELPER(crypto_sm3ss1)(void *vd, void *vn, void *va, void *vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *ra = va;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d;
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE a = { .l = { ra[0], ra[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
+
+    CR_ST_WORD(d, 0) = 0;
+    CR_ST_WORD(d, 1) = 0;
+    CR_ST_WORD(d, 2) = 0;
+    CR_ST_WORD(d, 3) = ror32(ror32(CR_ST_WORD(n, 3), 20) + CR_ST_WORD(m, 3) +
+                             CR_ST_WORD(a, 3), 25);
+
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
+
+void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
+                          uint32_t opcode)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
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
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 81d460702867..2d0bba10c006 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -539,6 +539,11 @@ DEF_HELPER_FLAGS_3(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_2(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sha512su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
+DEF_HELPER_FLAGS_4(crypto_sm3ss1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(crypto_sm3partw1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 10f2e518f303..57cf1ded4db7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11168,8 +11168,19 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         }
     } else {
-        unallocated_encoding(s);
-        return;
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
@@ -11282,6 +11293,9 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
     case 1: /* BCAX */
         feature = ARM_FEATURE_V8_SHA3;
         break;
+    case 2: /* SM3SS1 */
+        feature = ARM_FEATURE_V8_SM3;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -11329,7 +11343,20 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
         tcg_temp_free(tcg_res[0]);
         tcg_temp_free(tcg_res[1]);
     } else {
-        g_assert_not_reached();
+        TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_ra_ptr, tcg_rm_ptr;
+
+        tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+        tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+        tcg_ra_ptr = vec_full_reg_ptr(s, ra);
+        tcg_rm_ptr = vec_full_reg_ptr(s, rm);
+
+        gen_helper_crypto_sm3ss1(tcg_rd_ptr, tcg_rn_ptr, tcg_ra_ptr,
+                                 tcg_rm_ptr);
+
+        tcg_temp_free_ptr(tcg_rd_ptr);
+        tcg_temp_free_ptr(tcg_rn_ptr);
+        tcg_temp_free_ptr(tcg_ra_ptr);
+        tcg_temp_free_ptr(tcg_rm_ptr);
     }
 }
 
@@ -11378,6 +11405,47 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
     tcg_temp_free(tcg_res[1]);
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
+    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
+    TCGv_i32 tcg_imm2, tcg_opcode;
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
+    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
+    tcg_imm2   = tcg_const_i32(imm2);
+    tcg_opcode = tcg_const_i32(opcode);
+
+    gen_helper_crypto_sm3tt(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr, tcg_imm2,
+                            tcg_opcode);
+
+    tcg_temp_free_ptr(tcg_rd_ptr);
+    tcg_temp_free_ptr(tcg_rn_ptr);
+    tcg_temp_free_ptr(tcg_rm_ptr);
+    tcg_temp_free_i32(tcg_imm2);
+    tcg_temp_free_i32(tcg_opcode);
+}
+
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -11411,6 +11479,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
+    { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.11.0
