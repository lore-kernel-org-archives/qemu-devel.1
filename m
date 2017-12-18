Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFK-0002dF-UT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFG-0004e0-5R
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:34 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFF-0004cc-DF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:29 -0500
Received: by mail-pg0-x244.google.com with SMTP id g7so9428154pgs.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:15 -0800
Message-Id: <20171218173022.18418-3-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/9] target/arm: Use pointers in crypto helpers
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

Rather than passing regnos to the helpers, pass pointers to the
vector registers directly.  This eliminates the need to pass in
the environment pointer and reduces the number of places that
directly access env->vfp.regs[].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  18 ++---
 target/arm/crypto_helper.c | 184 +++++++++++++++++----------------------------
 target/arm/translate-a64.c |  68 +++++++++--------
 target/arm/translate.c     |  68 +++++++++--------
 4 files changed, 154 insertions(+), 184 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5b6333347d..f9dd7432c1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -539,17 +539,17 @@ DEF_HELPER_3(neon_qzip8, void, env, i32, i32)
 DEF_HELPER_3(neon_qzip16, void, env, i32, i32)
 DEF_HELPER_3(neon_qzip32, void, env, i32, i32)
 
-DEF_HELPER_4(crypto_aese, void, env, i32, i32, i32)
-DEF_HELPER_4(crypto_aesmc, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_5(crypto_sha1_3reg, void, env, i32, i32, i32, i32)
-DEF_HELPER_3(crypto_sha1h, void, env, i32, i32)
-DEF_HELPER_3(crypto_sha1su1, void, env, i32, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_2(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr)
 
-DEF_HELPER_4(crypto_sha256h, void, env, i32, i32, i32)
-DEF_HELPER_4(crypto_sha256h2, void, env, i32, i32, i32)
-DEF_HELPER_3(crypto_sha256su0, void, env, i32, i32)
-DEF_HELPER_4(crypto_sha256su1, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 3b6df3f41a..9ca0bdead7 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -30,20 +30,14 @@ union CRYPTO_STATE {
 #define CR_ST_WORD(state, i)   (state.words[i])
 #endif
 
-void HELPER(crypto_aese)(CPUARMState *env, uint32_t rd, uint32_t rm,
-                         uint32_t decrypt)
+void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
 {
     static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
     static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
-
-    union CRYPTO_STATE rk = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
-    union CRYPTO_STATE st = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
+    union CRYPTO_STATE st = { .l = { rd[0], rd[1] } };
     int i;
 
     assert(decrypt < 2);
@@ -57,12 +51,11 @@ void HELPER(crypto_aese)(CPUARMState *env, uint32_t rd, uint32_t rm,
         CR_ST_BYTE(st, i) = sbox[decrypt][CR_ST_BYTE(rk, shift[decrypt][i])];
     }
 
-    env->vfp.regs[rd] = make_float64(st.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(st.l[1]);
+    rd[0] = st.l[0];
+    rd[1] = st.l[1];
 }
 
-void HELPER(crypto_aesmc)(CPUARMState *env, uint32_t rd, uint32_t rm,
-                          uint32_t decrypt)
+void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
 {
     static uint32_t const mc[][256] = { {
         /* MixColumns lookup table */
@@ -197,10 +190,10 @@ void HELPER(crypto_aesmc)(CPUARMState *env, uint32_t rd, uint32_t rm,
         0x92b479a7, 0x99b970a9, 0x84ae6bbb, 0x8fa362b5,
         0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
     } };
-    union CRYPTO_STATE st = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+
+    uint64_t *rd = vd;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
     int i;
 
     assert(decrypt < 2);
@@ -213,8 +206,8 @@ void HELPER(crypto_aesmc)(CPUARMState *env, uint32_t rd, uint32_t rm,
             rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
     }
 
-    env->vfp.regs[rd] = make_float64(st.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(st.l[1]);
+    rd[0] = st.l[0];
+    rd[1] = st.l[1];
 }
 
 /*
@@ -236,21 +229,14 @@ static uint32_t maj(uint32_t x, uint32_t y, uint32_t z)
     return (x & y) | ((x | y) & z);
 }
 
-void HELPER(crypto_sha1_3reg)(CPUARMState *env, uint32_t rd, uint32_t rn,
-                              uint32_t rm, uint32_t op)
+void HELPER(crypto_sha1_3reg)(void *vd, void *vn, void *vm, uint32_t op)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE n = { .l = {
-        float64_val(env->vfp.regs[rn]),
-        float64_val(env->vfp.regs[rn + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
 
     if (op == 3) { /* sha1su0 */
         d.l[0] ^= d.l[1] ^ m.l[0];
@@ -284,42 +270,37 @@ void HELPER(crypto_sha1_3reg)(CPUARMState *env, uint32_t rd, uint32_t rn,
             CR_ST_WORD(d, 0) = t;
         }
     }
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha1h)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(crypto_sha1h)(void *vd, void *vm)
 {
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
 
     CR_ST_WORD(m, 0) = ror32(CR_ST_WORD(m, 0), 2);
     CR_ST_WORD(m, 1) = CR_ST_WORD(m, 2) = CR_ST_WORD(m, 3) = 0;
 
-    env->vfp.regs[rd] = make_float64(m.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(m.l[1]);
+    rd[0] = m.l[0];
+    rd[1] = m.l[1];
 }
 
-void HELPER(crypto_sha1su1)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(crypto_sha1su1)(void *vd, void *vm)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
 
     CR_ST_WORD(d, 0) = rol32(CR_ST_WORD(d, 0) ^ CR_ST_WORD(m, 1), 1);
     CR_ST_WORD(d, 1) = rol32(CR_ST_WORD(d, 1) ^ CR_ST_WORD(m, 2), 1);
     CR_ST_WORD(d, 2) = rol32(CR_ST_WORD(d, 2) ^ CR_ST_WORD(m, 3), 1);
     CR_ST_WORD(d, 3) = rol32(CR_ST_WORD(d, 3) ^ CR_ST_WORD(d, 0), 1);
 
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
 
 /*
@@ -347,21 +328,14 @@ static uint32_t s1(uint32_t x)
     return ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10);
 }
 
-void HELPER(crypto_sha256h)(CPUARMState *env, uint32_t rd, uint32_t rn,
-                            uint32_t rm)
+void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE n = { .l = {
-        float64_val(env->vfp.regs[rn]),
-        float64_val(env->vfp.regs[rn + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
     int i;
 
     for (i = 0; i < 4; i++) {
@@ -383,25 +357,18 @@ void HELPER(crypto_sha256h)(CPUARMState *env, uint32_t rd, uint32_t rn,
         CR_ST_WORD(d, 0) = t;
     }
 
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha256h2)(CPUARMState *env, uint32_t rd, uint32_t rn,
-                             uint32_t rm)
+void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE n = { .l = {
-        float64_val(env->vfp.regs[rn]),
-        float64_val(env->vfp.regs[rn + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
     int i;
 
     for (i = 0; i < 4; i++) {
@@ -415,51 +382,40 @@ void HELPER(crypto_sha256h2)(CPUARMState *env, uint32_t rd, uint32_t rn,
         CR_ST_WORD(d, 0) = CR_ST_WORD(n, 3 - i) + t;
     }
 
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha256su0)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(crypto_sha256su0)(void *vd, void *vm)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
 
     CR_ST_WORD(d, 0) += s0(CR_ST_WORD(d, 1));
     CR_ST_WORD(d, 1) += s0(CR_ST_WORD(d, 2));
     CR_ST_WORD(d, 2) += s0(CR_ST_WORD(d, 3));
     CR_ST_WORD(d, 3) += s0(CR_ST_WORD(m, 0));
 
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha256su1)(CPUARMState *env, uint32_t rd, uint32_t rn,
-                              uint32_t rm)
+void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
 {
-    union CRYPTO_STATE d = { .l = {
-        float64_val(env->vfp.regs[rd]),
-        float64_val(env->vfp.regs[rd + 1])
-    } };
-    union CRYPTO_STATE n = { .l = {
-        float64_val(env->vfp.regs[rn]),
-        float64_val(env->vfp.regs[rn + 1])
-    } };
-    union CRYPTO_STATE m = { .l = {
-        float64_val(env->vfp.regs[rm]),
-        float64_val(env->vfp.regs[rm + 1])
-    } };
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
 
     CR_ST_WORD(d, 0) += s1(CR_ST_WORD(m, 2)) + CR_ST_WORD(n, 1);
     CR_ST_WORD(d, 1) += s1(CR_ST_WORD(m, 3)) + CR_ST_WORD(n, 2);
     CR_ST_WORD(d, 2) += s1(CR_ST_WORD(d, 0)) + CR_ST_WORD(n, 3);
     CR_ST_WORD(d, 3) += s1(CR_ST_WORD(d, 1)) + CR_ST_WORD(m, 0);
 
-    env->vfp.regs[rd] = make_float64(d.l[0]);
-    env->vfp.regs[rd + 1] = make_float64(d.l[1]);
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
 }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 79fede35c1..d246e8f6b5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -81,8 +81,9 @@ typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
-typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
-typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
+typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
+typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
 
 /* Note that the gvec expanders operate on offsets + sizes.  */
 typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
@@ -556,6 +557,14 @@ static inline int vec_full_reg_size(DisasContext *s)
     return 128 / 8;
 }
 
+/* Return a newly allocated pointer to the vector register.  */
+static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
+{
+    TCGv_ptr ret = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
+    return ret;
+}
+
 /* Return the offset into CPUARMState of a slice (from
  * the least significant end) of FP register Qn (ie
  * Dn, Sn, Hn or Bn).
@@ -12455,8 +12464,9 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int decrypt;
-    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_decrypt;
-    CryptoThreeOpEnvFn *genfn;
+    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
+    TCGv_i32 tcg_decrypt;
+    CryptoThreeOpIntFn *genfn;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
         || size != 0) {
@@ -12490,18 +12500,14 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
         return;
     }
 
-    /* Note that we convert the Vx register indexes into the
-     * index within the vfp.regs[] array, so we can share the
-     * helper with the AArch32 instructions.
-     */
-    tcg_rd_regno = tcg_const_i32(rd << 1);
-    tcg_rn_regno = tcg_const_i32(rn << 1);
+    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
     tcg_decrypt = tcg_const_i32(decrypt);
 
-    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_decrypt);
+    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_decrypt);
 
-    tcg_temp_free_i32(tcg_rd_regno);
-    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_ptr(tcg_rd_ptr);
+    tcg_temp_free_ptr(tcg_rn_ptr);
     tcg_temp_free_i32(tcg_decrypt);
 }
 
@@ -12518,8 +12524,8 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoThreeOpEnvFn *genfn;
-    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno;
+    CryptoThreeOpFn *genfn;
+    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
     int feature = ARM_FEATURE_V8_SHA256;
 
     if (size != 0) {
@@ -12558,23 +12564,23 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_regno = tcg_const_i32(rd << 1);
-    tcg_rn_regno = tcg_const_i32(rn << 1);
-    tcg_rm_regno = tcg_const_i32(rm << 1);
+    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
 
     if (genfn) {
-        genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_rm_regno);
+        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
     } else {
         TCGv_i32 tcg_opcode = tcg_const_i32(opcode);
 
-        gen_helper_crypto_sha1_3reg(cpu_env, tcg_rd_regno,
-                                    tcg_rn_regno, tcg_rm_regno, tcg_opcode);
+        gen_helper_crypto_sha1_3reg(tcg_rd_ptr, tcg_rn_ptr,
+                                    tcg_rm_ptr, tcg_opcode);
         tcg_temp_free_i32(tcg_opcode);
     }
 
-    tcg_temp_free_i32(tcg_rd_regno);
-    tcg_temp_free_i32(tcg_rn_regno);
-    tcg_temp_free_i32(tcg_rm_regno);
+    tcg_temp_free_ptr(tcg_rd_ptr);
+    tcg_temp_free_ptr(tcg_rn_ptr);
+    tcg_temp_free_ptr(tcg_rm_ptr);
 }
 
 /* Crypto two-reg SHA
@@ -12589,9 +12595,9 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoTwoOpEnvFn *genfn;
+    CryptoTwoOpFn *genfn;
     int feature;
-    TCGv_i32 tcg_rd_regno, tcg_rn_regno;
+    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
 
     if (size != 0) {
         unallocated_encoding(s);
@@ -12625,13 +12631,13 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_regno = tcg_const_i32(rd << 1);
-    tcg_rn_regno = tcg_const_i32(rn << 1);
+    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
 
-    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno);
+    genfn(tcg_rd_ptr, tcg_rn_ptr);
 
-    tcg_temp_free_i32(tcg_rd_regno);
-    tcg_temp_free_i32(tcg_rn_regno);
+    tcg_temp_free_ptr(tcg_rd_ptr);
+    tcg_temp_free_ptr(tcg_rn_ptr);
 }
 
 /* C3.6 Data processing - SIMD, inc Crypto
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 490e120b0b..0c35c39069 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1560,6 +1560,13 @@ static inline void neon_store_reg64(TCGv_i64 var, int reg)
     tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
 }
 
+static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
+{
+    TCGv_ptr ret = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ret, cpu_env, vfp_reg_offset(dp, reg));
+    return ret;
+}
+
 #define tcg_gen_ld_f32 tcg_gen_ld_i32
 #define tcg_gen_ld_f64 tcg_gen_ld_i64
 #define tcg_gen_st_f32 tcg_gen_st_i32
@@ -5614,6 +5621,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int u;
     uint32_t imm, mask;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
+    TCGv_ptr ptr1, ptr2, ptr3;
     TCGv_i64 tmp64;
 
     /* FIXME: this access check should not take precedence over UNDEF
@@ -5660,34 +5668,34 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
                     return 1;
                 }
-                tmp = tcg_const_i32(rd);
-                tmp2 = tcg_const_i32(rn);
-                tmp3 = tcg_const_i32(rm);
+                ptr1 = vfp_reg_ptr(true, rd);
+                ptr2 = vfp_reg_ptr(true, rn);
+                ptr3 = vfp_reg_ptr(true, rm);
                 tmp4 = tcg_const_i32(size);
-                gen_helper_crypto_sha1_3reg(cpu_env, tmp, tmp2, tmp3, tmp4);
+                gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
                 tcg_temp_free_i32(tmp4);
             } else { /* SHA-256 */
                 if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA256) || size == 3) {
                     return 1;
                 }
-                tmp = tcg_const_i32(rd);
-                tmp2 = tcg_const_i32(rn);
-                tmp3 = tcg_const_i32(rm);
+                ptr1 = vfp_reg_ptr(true, rd);
+                ptr2 = vfp_reg_ptr(true, rn);
+                ptr3 = vfp_reg_ptr(true, rm);
                 switch (size) {
                 case 0:
-                    gen_helper_crypto_sha256h(cpu_env, tmp, tmp2, tmp3);
+                    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
                     break;
                 case 1:
-                    gen_helper_crypto_sha256h2(cpu_env, tmp, tmp2, tmp3);
+                    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
                     break;
                 case 2:
-                    gen_helper_crypto_sha256su1(cpu_env, tmp, tmp2, tmp3);
+                    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
                     break;
                 }
             }
-            tcg_temp_free_i32(tmp);
-            tcg_temp_free_i32(tmp2);
-            tcg_temp_free_i32(tmp3);
+            tcg_temp_free_ptr(ptr1);
+            tcg_temp_free_ptr(ptr2);
+            tcg_temp_free_ptr(ptr3);
             return 0;
 
         case NEON_3R_VPADD_VQRDMLAH:
@@ -7238,8 +7246,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    tmp = tcg_const_i32(rd);
-                    tmp2 = tcg_const_i32(rm);
+                    ptr1 = vfp_reg_ptr(true, rd);
+                    ptr2 = vfp_reg_ptr(true, rm);
 
                      /* Bit 6 is the lowest opcode bit; it distinguishes between
                       * encryption (AESE/AESMC) and decryption (AESD/AESIMC)
@@ -7247,12 +7255,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tmp3 = tcg_const_i32(extract32(insn, 6, 1));
 
                     if (op == NEON_2RM_AESE) {
-                        gen_helper_crypto_aese(cpu_env, tmp, tmp2, tmp3);
+                        gen_helper_crypto_aese(ptr1, ptr2, tmp3);
                     } else {
-                        gen_helper_crypto_aesmc(cpu_env, tmp, tmp2, tmp3);
+                        gen_helper_crypto_aesmc(ptr1, ptr2, tmp3);
                     }
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(tmp2);
+                    tcg_temp_free_ptr(ptr1);
+                    tcg_temp_free_ptr(ptr2);
                     tcg_temp_free_i32(tmp3);
                     break;
                 case NEON_2RM_SHA1H:
@@ -7260,13 +7268,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    tmp = tcg_const_i32(rd);
-                    tmp2 = tcg_const_i32(rm);
+                    ptr1 = vfp_reg_ptr(true, rd);
+                    ptr2 = vfp_reg_ptr(true, rm);
 
-                    gen_helper_crypto_sha1h(cpu_env, tmp, tmp2);
+                    gen_helper_crypto_sha1h(ptr1, ptr2);
 
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(tmp2);
+                    tcg_temp_free_ptr(ptr1);
+                    tcg_temp_free_ptr(ptr2);
                     break;
                 case NEON_2RM_SHA1SU1:
                     if ((rm | rd) & 1) {
@@ -7280,15 +7288,15 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     } else if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
                         return 1;
                     }
-                    tmp = tcg_const_i32(rd);
-                    tmp2 = tcg_const_i32(rm);
+                    ptr1 = vfp_reg_ptr(true, rd);
+                    ptr2 = vfp_reg_ptr(true, rm);
                     if (q) {
-                        gen_helper_crypto_sha256su0(cpu_env, tmp, tmp2);
+                        gen_helper_crypto_sha256su0(ptr1, ptr2);
                     } else {
-                        gen_helper_crypto_sha1su1(cpu_env, tmp, tmp2);
+                        gen_helper_crypto_sha1su1(ptr1, ptr2);
                     }
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(tmp2);
+                    tcg_temp_free_ptr(ptr1);
+                    tcg_temp_free_ptr(ptr2);
                     break;
                 default:
                 elementwise:
-- 
2.14.3
