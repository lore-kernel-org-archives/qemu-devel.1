Received: from eggs.gnu.org ([2001:4830:134:3::10]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkb-0005bO-GY
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkT-0008NE-TK
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHtkP-0008FO-4W
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p2-v6so15139953wmc.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 16:53:20 +0000
Message-Id: <20181031165321.4422-3-richard.henderson@linaro.org>
In-Reply-To: <20181031165321.4422-1-richard.henderson@linaro.org>
References: <20181031165321.4422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] decodetree: Remove "insn" argument from
 trans_* expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This allows trans_* expanders to be shared between decoders
for 32 and 16-bit insns, by not tying the expander to the
size of the insn that produced it.

This change requires adjusting the two existing users to match.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c  | 507 +++++++++++++++++-------------------
 target/openrisc/disas.c     |  23 +-
 target/openrisc/translate.c | 200 +++++++-------
 scripts/decodetree.py       |   5 +-
 4 files changed, 357 insertions(+), 378 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fe7aebdc19..b15b615ceb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -273,12 +273,12 @@ const uint64_t pred_esz_masks[4] = {
  *** SVE Logical - Unpredicated Group
  */
 
-static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
 }
 
-static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     if (a->rn == a->rm) { /* MOV */
         return do_mov_z(s, a->rd, a->rn);
@@ -287,12 +287,12 @@ static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     }
 }
 
-static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_xor, 0, a->rd, a->rn, a->rm);
 }
 
-static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
@@ -301,32 +301,32 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
  *** SVE Integer Arithmetic - Unpredicated Group
  */
 
-static bool trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_add, a->esz, a->rd, a->rn, a->rm);
 }
 
-static bool trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_sub, a->esz, a->rd, a->rn, a->rm);
 }
 
-static bool trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_ssadd, a->esz, a->rd, a->rn, a->rm);
 }
 
-static bool trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_sssub, a->esz, a->rd, a->rn, a->rm);
 }
 
-static bool trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_usadd, a->esz, a->rd, a->rn, a->rm);
 }
 
-static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_vector3_z(s, tcg_gen_gvec_ussub, a->esz, a->rd, a->rn, a->rm);
 }
@@ -369,8 +369,7 @@ static void do_sel_z(DisasContext *s, int rd, int rn, int rm, int pg, int esz)
 }
 
 #define DO_ZPZZ(NAME, name) \
-static bool trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a)         \
 {                                                                         \
     static gen_helper_gvec_4 * const fns[4] = {                           \
         gen_helper_sve_##name##_zpzz_b, gen_helper_sve_##name##_zpzz_h,   \
@@ -402,7 +401,7 @@ DO_ZPZZ(ASR, asr)
 DO_ZPZZ(LSR, lsr)
 DO_ZPZZ(LSL, lsl)
 
-static bool trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a)
 {
     static gen_helper_gvec_4 * const fns[4] = {
         NULL, NULL, gen_helper_sve_sdiv_zpzz_s, gen_helper_sve_sdiv_zpzz_d
@@ -410,7 +409,7 @@ static bool trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     return do_zpzz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a)
 {
     static gen_helper_gvec_4 * const fns[4] = {
         NULL, NULL, gen_helper_sve_udiv_zpzz_s, gen_helper_sve_udiv_zpzz_d
@@ -418,7 +417,7 @@ static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     return do_zpzz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_SEL_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_SEL_zpzz(DisasContext *s, arg_rprr_esz *a)
 {
     if (sve_access_check(s)) {
         do_sel_z(s, a->rd, a->rn, a->rm, a->pg, a->esz);
@@ -448,7 +447,7 @@ static bool do_zpz_ool(DisasContext *s, arg_rpr_esz *a, gen_helper_gvec_3 *fn)
 }
 
 #define DO_ZPZ(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a)           \
 {                                                                   \
     static gen_helper_gvec_3 * const fns[4] = {                     \
         gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,       \
@@ -465,7 +464,7 @@ DO_ZPZ(NOT_zpz, not_zpz)
 DO_ZPZ(ABS, abs)
 DO_ZPZ(NEG, neg)
 
-static bool trans_FABS(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FABS(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -476,7 +475,7 @@ static bool trans_FABS(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_FNEG(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FNEG(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -487,7 +486,7 @@ static bool trans_FNEG(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_SXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SXTB(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -498,7 +497,7 @@ static bool trans_SXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_UXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UXTB(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -509,7 +508,7 @@ static bool trans_UXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_SXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SXTH(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL, NULL,
@@ -519,7 +518,7 @@ static bool trans_SXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_UXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UXTH(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL, NULL,
@@ -529,12 +528,12 @@ static bool trans_UXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_SXTW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SXTW(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_sxtw_d : NULL);
 }
 
-static bool trans_UXTW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UXTW(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_uxtw_d : NULL);
 }
@@ -579,7 +578,7 @@ static bool do_vpz_ool(DisasContext *s, arg_rpr_esz *a,
 }
 
 #define DO_VPZ(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a)                \
 {                                                                        \
     static gen_helper_gvec_reduc * const fns[4] = {                      \
         gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,            \
@@ -598,7 +597,7 @@ DO_VPZ(UMAXV, umaxv)
 DO_VPZ(SMINV, sminv)
 DO_VPZ(UMINV, uminv)
 
-static bool trans_SADDV(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SADDV(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_reduc * const fns[4] = {
         gen_helper_sve_saddv_b, gen_helper_sve_saddv_h,
@@ -659,7 +658,7 @@ static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
     return true;
 }
 
-static bool trans_ASR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+static bool trans_ASR_zpzi(DisasContext *s, arg_rpri_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_asr_zpzi_b, gen_helper_sve_asr_zpzi_h,
@@ -675,7 +674,7 @@ static bool trans_ASR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     return do_zpzi_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_LSR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+static bool trans_LSR_zpzi(DisasContext *s, arg_rpri_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_lsr_zpzi_b, gen_helper_sve_lsr_zpzi_h,
@@ -693,7 +692,7 @@ static bool trans_LSR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     }
 }
 
-static bool trans_LSL_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+static bool trans_LSL_zpzi(DisasContext *s, arg_rpri_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_lsl_zpzi_b, gen_helper_sve_lsl_zpzi_h,
@@ -711,7 +710,7 @@ static bool trans_LSL_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     }
 }
 
-static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_asrd_b, gen_helper_sve_asrd_h,
@@ -734,8 +733,7 @@ static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
  */
 
 #define DO_ZPZW(NAME, name) \
-static bool trans_##NAME##_zpzw(DisasContext *s, arg_rprr_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_zpzw(DisasContext *s, arg_rprr_esz *a)         \
 {                                                                         \
     static gen_helper_gvec_4 * const fns[3] = {                           \
         gen_helper_sve_##name##_zpzw_b, gen_helper_sve_##name##_zpzw_h,   \
@@ -784,17 +782,17 @@ static bool do_shift_imm(DisasContext *s, arg_rri_esz *a, bool asr,
     return true;
 }
 
-static bool trans_ASR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_ASR_zzi(DisasContext *s, arg_rri_esz *a)
 {
     return do_shift_imm(s, a, true, tcg_gen_gvec_sari);
 }
 
-static bool trans_LSR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_LSR_zzi(DisasContext *s, arg_rri_esz *a)
 {
     return do_shift_imm(s, a, false, tcg_gen_gvec_shri);
 }
 
-static bool trans_LSL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_LSL_zzi(DisasContext *s, arg_rri_esz *a)
 {
     return do_shift_imm(s, a, false, tcg_gen_gvec_shli);
 }
@@ -815,8 +813,7 @@ static bool do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
 }
 
 #define DO_ZZW(NAME, name) \
-static bool trans_##NAME##_zzw(DisasContext *s, arg_rrr_esz *a,           \
-                               uint32_t insn)                             \
+static bool trans_##NAME##_zzw(DisasContext *s, arg_rrr_esz *a)           \
 {                                                                         \
     static gen_helper_gvec_3 * const fns[4] = {                           \
         gen_helper_sve_##name##_zzw_b, gen_helper_sve_##name##_zzw_h,     \
@@ -851,7 +848,7 @@ static bool do_zpzzz_ool(DisasContext *s, arg_rprrr_esz *a,
 }
 
 #define DO_ZPZZZ(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a)          \
 {                                                                    \
     static gen_helper_gvec_5 * const fns[4] = {                      \
         gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,        \
@@ -900,7 +897,7 @@ static void do_index(DisasContext *s, int esz, int rd,
     tcg_temp_free_i32(desc);
 }
 
-static bool trans_INDEX_ii(DisasContext *s, arg_INDEX_ii *a, uint32_t insn)
+static bool trans_INDEX_ii(DisasContext *s, arg_INDEX_ii *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 start = tcg_const_i64(a->imm1);
@@ -912,7 +909,7 @@ static bool trans_INDEX_ii(DisasContext *s, arg_INDEX_ii *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INDEX_ir(DisasContext *s, arg_INDEX_ir *a, uint32_t insn)
+static bool trans_INDEX_ir(DisasContext *s, arg_INDEX_ir *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 start = tcg_const_i64(a->imm);
@@ -923,7 +920,7 @@ static bool trans_INDEX_ir(DisasContext *s, arg_INDEX_ir *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INDEX_ri(DisasContext *s, arg_INDEX_ri *a, uint32_t insn)
+static bool trans_INDEX_ri(DisasContext *s, arg_INDEX_ri *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 start = cpu_reg(s, a->rn);
@@ -934,7 +931,7 @@ static bool trans_INDEX_ri(DisasContext *s, arg_INDEX_ri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
+static bool trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 start = cpu_reg(s, a->rn);
@@ -948,7 +945,7 @@ static bool trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
  *** SVE Stack Allocation Group
  */
 
-static bool trans_ADDVL(DisasContext *s, arg_ADDVL *a, uint32_t insn)
+static bool trans_ADDVL(DisasContext *s, arg_ADDVL *a)
 {
     TCGv_i64 rd = cpu_reg_sp(s, a->rd);
     TCGv_i64 rn = cpu_reg_sp(s, a->rn);
@@ -956,7 +953,7 @@ static bool trans_ADDVL(DisasContext *s, arg_ADDVL *a, uint32_t insn)
     return true;
 }
 
-static bool trans_ADDPL(DisasContext *s, arg_ADDPL *a, uint32_t insn)
+static bool trans_ADDPL(DisasContext *s, arg_ADDPL *a)
 {
     TCGv_i64 rd = cpu_reg_sp(s, a->rd);
     TCGv_i64 rn = cpu_reg_sp(s, a->rn);
@@ -964,7 +961,7 @@ static bool trans_ADDPL(DisasContext *s, arg_ADDPL *a, uint32_t insn)
     return true;
 }
 
-static bool trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
+static bool trans_RDVL(DisasContext *s, arg_RDVL *a)
 {
     TCGv_i64 reg = cpu_reg(s, a->rd);
     tcg_gen_movi_i64(reg, a->imm * vec_full_reg_size(s));
@@ -987,22 +984,22 @@ static bool do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
     return true;
 }
 
-static bool trans_ADR_p32(DisasContext *s, arg_rrri *a, uint32_t insn)
+static bool trans_ADR_p32(DisasContext *s, arg_rrri *a)
 {
     return do_adr(s, a, gen_helper_sve_adr_p32);
 }
 
-static bool trans_ADR_p64(DisasContext *s, arg_rrri *a, uint32_t insn)
+static bool trans_ADR_p64(DisasContext *s, arg_rrri *a)
 {
     return do_adr(s, a, gen_helper_sve_adr_p64);
 }
 
-static bool trans_ADR_s32(DisasContext *s, arg_rrri *a, uint32_t insn)
+static bool trans_ADR_s32(DisasContext *s, arg_rrri *a)
 {
     return do_adr(s, a, gen_helper_sve_adr_s32);
 }
 
-static bool trans_ADR_u32(DisasContext *s, arg_rrri *a, uint32_t insn)
+static bool trans_ADR_u32(DisasContext *s, arg_rrri *a)
 {
     return do_adr(s, a, gen_helper_sve_adr_u32);
 }
@@ -1011,7 +1008,7 @@ static bool trans_ADR_u32(DisasContext *s, arg_rrri *a, uint32_t insn)
  *** SVE Integer Misc - Unpredicated Group
  */
 
-static bool trans_FEXPA(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_FEXPA(DisasContext *s, arg_rr_esz *a)
 {
     static gen_helper_gvec_2 * const fns[4] = {
         NULL,
@@ -1031,7 +1028,7 @@ static bool trans_FEXPA(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_FTSSEL(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_FTSSEL(DisasContext *s, arg_rrr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -1120,7 +1117,7 @@ static void gen_and_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_and_vec(vece, pd, pd, pg);
 }
 
-static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_and_pg_i64,
@@ -1156,7 +1153,7 @@ static void gen_bic_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_and_vec(vece, pd, pd, pg);
 }
 
-static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_bic_pg_i64,
@@ -1186,7 +1183,7 @@ static void gen_eor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_and_vec(vece, pd, pd, pg);
 }
 
-static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_eor_pg_i64,
@@ -1216,7 +1213,7 @@ static void gen_sel_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_or_vec(vece, pd, pn, pm);
 }
 
-static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_sel_pg_i64,
@@ -1244,7 +1241,7 @@ static void gen_orr_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_and_vec(vece, pd, pd, pg);
 }
 
-static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_orr_pg_i64,
@@ -1274,7 +1271,7 @@ static void gen_orn_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_and_vec(vece, pd, pd, pg);
 }
 
-static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_orn_pg_i64,
@@ -1302,7 +1299,7 @@ static void gen_nor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_andc_vec(vece, pd, pg, pd);
 }
 
-static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_nor_pg_i64,
@@ -1330,7 +1327,7 @@ static void gen_nand_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
     tcg_gen_andc_vec(vece, pd, pg, pd);
 }
 
-static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a)
 {
     static const GVecGen4 op = {
         .fni8 = gen_nand_pg_i64,
@@ -1349,7 +1346,7 @@ static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
  *** SVE Predicate Misc Group
  */
 
-static bool trans_PTEST(DisasContext *s, arg_PTEST *a, uint32_t insn)
+static bool trans_PTEST(DisasContext *s, arg_PTEST *a)
 {
     if (sve_access_check(s)) {
         int nofs = pred_full_reg_offset(s, a->rn);
@@ -1491,24 +1488,24 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
     return true;
 }
 
-static bool trans_PTRUE(DisasContext *s, arg_PTRUE *a, uint32_t insn)
+static bool trans_PTRUE(DisasContext *s, arg_PTRUE *a)
 {
     return do_predset(s, a->esz, a->rd, a->pat, a->s);
 }
 
-static bool trans_SETFFR(DisasContext *s, arg_SETFFR *a, uint32_t insn)
+static bool trans_SETFFR(DisasContext *s, arg_SETFFR *a)
 {
     /* Note pat == 31 is #all, to set all elements.  */
     return do_predset(s, 0, FFR_PRED_NUM, 31, false);
 }
 
-static bool trans_PFALSE(DisasContext *s, arg_PFALSE *a, uint32_t insn)
+static bool trans_PFALSE(DisasContext *s, arg_PFALSE *a)
 {
     /* Note pat == 32 is #unimp, to set no elements.  */
     return do_predset(s, 0, a->rd, 32, false);
 }
 
-static bool trans_RDFFR_p(DisasContext *s, arg_RDFFR_p *a, uint32_t insn)
+static bool trans_RDFFR_p(DisasContext *s, arg_RDFFR_p *a)
 {
     /* The path through do_pppp_flags is complicated enough to want to avoid
      * duplication.  Frob the arguments into the form of a predicated AND.
@@ -1517,15 +1514,15 @@ static bool trans_RDFFR_p(DisasContext *s, arg_RDFFR_p *a, uint32_t insn)
         .rd = a->rd, .pg = a->pg, .s = a->s,
         .rn = FFR_PRED_NUM, .rm = FFR_PRED_NUM,
     };
-    return trans_AND_pppp(s, &alt_a, insn);
+    return trans_AND_pppp(s, &alt_a);
 }
 
-static bool trans_RDFFR(DisasContext *s, arg_RDFFR *a, uint32_t insn)
+static bool trans_RDFFR(DisasContext *s, arg_RDFFR *a)
 {
     return do_mov_p(s, a->rd, FFR_PRED_NUM);
 }
 
-static bool trans_WRFFR(DisasContext *s, arg_WRFFR *a, uint32_t insn)
+static bool trans_WRFFR(DisasContext *s, arg_WRFFR *a)
 {
     return do_mov_p(s, FFR_PRED_NUM, a->rn);
 }
@@ -1559,12 +1556,12 @@ static bool do_pfirst_pnext(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
-static bool trans_PFIRST(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_PFIRST(DisasContext *s, arg_rr_esz *a)
 {
     return do_pfirst_pnext(s, a, gen_helper_sve_pfirst);
 }
 
-static bool trans_PNEXT(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_PNEXT(DisasContext *s, arg_rr_esz *a)
 {
     return do_pfirst_pnext(s, a, gen_helper_sve_pnext);
 }
@@ -1735,7 +1732,7 @@ static void do_sat_addsub_vec(DisasContext *s, int esz, int rd, int rn,
     tcg_temp_free_i32(desc);
 }
 
-static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a, uint32_t insn)
+static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a)
 {
     if (sve_access_check(s)) {
         unsigned fullsz = vec_full_reg_size(s);
@@ -1745,7 +1742,7 @@ static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
+static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a)
 {
     if (sve_access_check(s)) {
         unsigned fullsz = vec_full_reg_size(s);
@@ -1758,8 +1755,7 @@ static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
     return true;
 }
 
-static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a,
-                               uint32_t insn)
+static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a)
 {
     if (!sve_access_check(s)) {
         return true;
@@ -1785,8 +1781,7 @@ static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a,
     return true;
 }
 
-static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a,
-                               uint32_t insn)
+static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a)
 {
     if (!sve_access_check(s)) {
         return true;
@@ -1805,7 +1800,7 @@ static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a,
     return true;
 }
 
-static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a, uint32_t insn)
+static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a)
 {
     if (a->esz == 0) {
         return false;
@@ -1829,8 +1824,7 @@ static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a, uint32_t insn)
     return true;
 }
 
-static bool trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a,
-                            uint32_t insn)
+static bool trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a)
 {
     if (a->esz == 0) {
         return false;
@@ -1872,22 +1866,22 @@ static bool do_zz_dbm(DisasContext *s, arg_rr_dbm *a, GVecGen2iFn *gvec_fn)
     return true;
 }
 
-static bool trans_AND_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+static bool trans_AND_zzi(DisasContext *s, arg_rr_dbm *a)
 {
     return do_zz_dbm(s, a, tcg_gen_gvec_andi);
 }
 
-static bool trans_ORR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+static bool trans_ORR_zzi(DisasContext *s, arg_rr_dbm *a)
 {
     return do_zz_dbm(s, a, tcg_gen_gvec_ori);
 }
 
-static bool trans_EOR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+static bool trans_EOR_zzi(DisasContext *s, arg_rr_dbm *a)
 {
     return do_zz_dbm(s, a, tcg_gen_gvec_xori);
 }
 
-static bool trans_DUPM(DisasContext *s, arg_DUPM *a, uint32_t insn)
+static bool trans_DUPM(DisasContext *s, arg_DUPM *a)
 {
     uint64_t imm;
     if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
@@ -1934,7 +1928,7 @@ static void do_cpy_m(DisasContext *s, int esz, int rd, int rn, int pg,
     tcg_temp_free_i32(desc);
 }
 
-static bool trans_FCPY(DisasContext *s, arg_FCPY *a, uint32_t insn)
+static bool trans_FCPY(DisasContext *s, arg_FCPY *a)
 {
     if (a->esz == 0) {
         return false;
@@ -1949,9 +1943,9 @@ static bool trans_FCPY(DisasContext *s, arg_FCPY *a, uint32_t insn)
     return true;
 }
 
-static bool trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+static bool trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a)
 {
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1962,14 +1956,14 @@ static bool trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
+static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a)
 {
     static gen_helper_gvec_2i * const fns[4] = {
         gen_helper_sve_cpy_z_b, gen_helper_sve_cpy_z_h,
         gen_helper_sve_cpy_z_s, gen_helper_sve_cpy_z_d,
     };
 
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1987,7 +1981,7 @@ static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
  *** SVE Permute Extract Group
  */
 
-static bool trans_EXT(DisasContext *s, arg_EXT *a, uint32_t insn)
+static bool trans_EXT(DisasContext *s, arg_EXT *a)
 {
     if (!sve_access_check(s)) {
         return true;
@@ -2021,7 +2015,7 @@ static bool trans_EXT(DisasContext *s, arg_EXT *a, uint32_t insn)
  *** SVE Permute - Unpredicated Group
  */
 
-static bool trans_DUP_s(DisasContext *s, arg_DUP_s *a, uint32_t insn)
+static bool trans_DUP_s(DisasContext *s, arg_DUP_s *a)
 {
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
@@ -2031,7 +2025,7 @@ static bool trans_DUP_s(DisasContext *s, arg_DUP_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a, uint32_t insn)
+static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
 {
     if ((a->imm & 0x1f) == 0) {
         return false;
@@ -2076,7 +2070,7 @@ static void do_insr_i64(DisasContext *s, arg_rrr_esz *a, TCGv_i64 val)
     tcg_temp_free_i32(desc);
 }
 
-static bool trans_INSR_f(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_INSR_f(DisasContext *s, arg_rrr_esz *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 t = tcg_temp_new_i64();
@@ -2087,7 +2081,7 @@ static bool trans_INSR_f(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INSR_r(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_INSR_r(DisasContext *s, arg_rrr_esz *a)
 {
     if (sve_access_check(s)) {
         do_insr_i64(s, a, cpu_reg(s, a->rm));
@@ -2095,7 +2089,7 @@ static bool trans_INSR_r(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_REV_v(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_REV_v(DisasContext *s, arg_rr_esz *a)
 {
     static gen_helper_gvec_2 * const fns[4] = {
         gen_helper_sve_rev_b, gen_helper_sve_rev_h,
@@ -2111,7 +2105,7 @@ static bool trans_REV_v(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_TBL(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_TBL(DisasContext *s, arg_rrr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_tbl_b, gen_helper_sve_tbl_h,
@@ -2128,7 +2122,7 @@ static bool trans_TBL(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_UNPK(DisasContext *s, arg_UNPK *a, uint32_t insn)
+static bool trans_UNPK(DisasContext *s, arg_UNPK *a)
 {
     static gen_helper_gvec_2 * const fns[4][2] = {
         { NULL, NULL },
@@ -2225,47 +2219,47 @@ static bool do_perm_pred2(DisasContext *s, arg_rr_esz *a, bool high_odd,
     return true;
 }
 
-static bool trans_ZIP1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ZIP1_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 0, gen_helper_sve_zip_p);
 }
 
-static bool trans_ZIP2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ZIP2_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 1, gen_helper_sve_zip_p);
 }
 
-static bool trans_UZP1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UZP1_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 0, gen_helper_sve_uzp_p);
 }
 
-static bool trans_UZP2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UZP2_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 1, gen_helper_sve_uzp_p);
 }
 
-static bool trans_TRN1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_TRN1_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 0, gen_helper_sve_trn_p);
 }
 
-static bool trans_TRN2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_TRN2_p(DisasContext *s, arg_rrr_esz *a)
 {
     return do_perm_pred3(s, a, 1, gen_helper_sve_trn_p);
 }
 
-static bool trans_REV_p(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_REV_p(DisasContext *s, arg_rr_esz *a)
 {
     return do_perm_pred2(s, a, 0, gen_helper_sve_rev_p);
 }
 
-static bool trans_PUNPKLO(DisasContext *s, arg_PUNPKLO *a, uint32_t insn)
+static bool trans_PUNPKLO(DisasContext *s, arg_PUNPKLO *a)
 {
     return do_perm_pred2(s, a, 0, gen_helper_sve_punpk_p);
 }
 
-static bool trans_PUNPKHI(DisasContext *s, arg_PUNPKHI *a, uint32_t insn)
+static bool trans_PUNPKHI(DisasContext *s, arg_PUNPKHI *a)
 {
     return do_perm_pred2(s, a, 1, gen_helper_sve_punpk_p);
 }
@@ -2305,12 +2299,12 @@ static bool do_zzz_data_ool(DisasContext *s, arg_rrr_esz *a, int data,
     return true;
 }
 
-static bool trans_ZIP1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ZIP1_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zip(s, a, false);
 }
 
-static bool trans_ZIP2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_ZIP2_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zip(s, a, true);
 }
@@ -2320,12 +2314,12 @@ static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
 };
 
-static bool trans_UZP1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UZP1_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zzz_data_ool(s, a, 0, uzp_fns[a->esz]);
 }
 
-static bool trans_UZP2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_UZP2_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zzz_data_ool(s, a, 1 << a->esz, uzp_fns[a->esz]);
 }
@@ -2335,12 +2329,12 @@ static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_s, gen_helper_sve_trn_d,
 };
 
-static bool trans_TRN1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_TRN1_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zzz_data_ool(s, a, 0, trn_fns[a->esz]);
 }
 
-static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a)
 {
     return do_zzz_data_ool(s, a, 1 << a->esz, trn_fns[a->esz]);
 }
@@ -2349,7 +2343,7 @@ static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
  *** SVE Permute Vector - Predicated Group
  */
 
-static bool trans_COMPACT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_COMPACT(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL, NULL, gen_helper_sve_compact_s, gen_helper_sve_compact_d
@@ -2516,12 +2510,12 @@ static bool do_clast_vector(DisasContext *s, arg_rprr_esz *a, bool before)
     return true;
 }
 
-static bool trans_CLASTA_z(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_CLASTA_z(DisasContext *s, arg_rprr_esz *a)
 {
     return do_clast_vector(s, a, false);
 }
 
-static bool trans_CLASTB_z(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_CLASTB_z(DisasContext *s, arg_rprr_esz *a)
 {
     return do_clast_vector(s, a, true);
 }
@@ -2574,12 +2568,12 @@ static bool do_clast_fp(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-static bool trans_CLASTA_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CLASTA_v(DisasContext *s, arg_rpr_esz *a)
 {
     return do_clast_fp(s, a, false);
 }
 
-static bool trans_CLASTB_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CLASTB_v(DisasContext *s, arg_rpr_esz *a)
 {
     return do_clast_fp(s, a, true);
 }
@@ -2614,12 +2608,12 @@ static bool do_clast_general(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-static bool trans_CLASTA_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CLASTA_r(DisasContext *s, arg_rpr_esz *a)
 {
     return do_clast_general(s, a, false);
 }
 
-static bool trans_CLASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CLASTB_r(DisasContext *s, arg_rpr_esz *a)
 {
     return do_clast_general(s, a, true);
 }
@@ -2654,12 +2648,12 @@ static bool do_last_fp(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-static bool trans_LASTA_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_LASTA_v(DisasContext *s, arg_rpr_esz *a)
 {
     return do_last_fp(s, a, false);
 }
 
-static bool trans_LASTB_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_LASTB_v(DisasContext *s, arg_rpr_esz *a)
 {
     return do_last_fp(s, a, true);
 }
@@ -2675,17 +2669,17 @@ static bool do_last_general(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-static bool trans_LASTA_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_LASTA_r(DisasContext *s, arg_rpr_esz *a)
 {
     return do_last_general(s, a, false);
 }
 
-static bool trans_LASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_LASTB_r(DisasContext *s, arg_rpr_esz *a)
 {
     return do_last_general(s, a, true);
 }
 
-static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a)
 {
     if (sve_access_check(s)) {
         do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, cpu_reg_sp(s, a->rn));
@@ -2693,7 +2687,7 @@ static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a)
 {
     if (sve_access_check(s)) {
         int ofs = vec_reg_offset(s, a->rn, 0, a->esz);
@@ -2704,7 +2698,7 @@ static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_REVB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_REVB(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -2715,7 +2709,7 @@ static bool trans_REVB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_REVH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_REVH(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         NULL,
@@ -2726,12 +2720,12 @@ static bool trans_REVH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_REVW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_REVW(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_revw_d : NULL);
 }
 
-static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_rbit_b,
@@ -2742,7 +2736,7 @@ static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
-static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a)
 {
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
@@ -2799,8 +2793,7 @@ static bool do_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
 }
 
 #define DO_PPZZ(NAME, name) \
-static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a)         \
 {                                                                         \
     static gen_helper_gvec_flags_4 * const fns[4] = {                     \
         gen_helper_sve_##name##_ppzz_b, gen_helper_sve_##name##_ppzz_h,   \
@@ -2819,8 +2812,7 @@ DO_PPZZ(CMPHS, cmphs)
 #undef DO_PPZZ
 
 #define DO_PPZW(NAME, name) \
-static bool trans_##NAME##_ppzw(DisasContext *s, arg_rprr_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_ppzw(DisasContext *s, arg_rprr_esz *a)         \
 {                                                                         \
     static gen_helper_gvec_flags_4 * const fns[4] = {                     \
         gen_helper_sve_##name##_ppzw_b, gen_helper_sve_##name##_ppzw_h,   \
@@ -2883,8 +2875,7 @@ static bool do_ppzi_flags(DisasContext *s, arg_rpri_esz *a,
 }
 
 #define DO_PPZI(NAME, name) \
-static bool trans_##NAME##_ppzi(DisasContext *s, arg_rpri_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_ppzi(DisasContext *s, arg_rpri_esz *a)         \
 {                                                                         \
     static gen_helper_gvec_flags_3 * const fns[4] = {                     \
         gen_helper_sve_##name##_ppzi_b, gen_helper_sve_##name##_ppzi_h,   \
@@ -2977,37 +2968,37 @@ static bool do_brk2(DisasContext *s, arg_rpr_s *a,
     return true;
 }
 
-static bool trans_BRKPA(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_BRKPA(DisasContext *s, arg_rprr_s *a)
 {
     return do_brk3(s, a, gen_helper_sve_brkpa, gen_helper_sve_brkpas);
 }
 
-static bool trans_BRKPB(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+static bool trans_BRKPB(DisasContext *s, arg_rprr_s *a)
 {
     return do_brk3(s, a, gen_helper_sve_brkpb, gen_helper_sve_brkpbs);
 }
 
-static bool trans_BRKA_m(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+static bool trans_BRKA_m(DisasContext *s, arg_rpr_s *a)
 {
     return do_brk2(s, a, gen_helper_sve_brka_m, gen_helper_sve_brkas_m);
 }
 
-static bool trans_BRKB_m(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+static bool trans_BRKB_m(DisasContext *s, arg_rpr_s *a)
 {
     return do_brk2(s, a, gen_helper_sve_brkb_m, gen_helper_sve_brkbs_m);
 }
 
-static bool trans_BRKA_z(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+static bool trans_BRKA_z(DisasContext *s, arg_rpr_s *a)
 {
     return do_brk2(s, a, gen_helper_sve_brka_z, gen_helper_sve_brkas_z);
 }
 
-static bool trans_BRKB_z(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+static bool trans_BRKB_z(DisasContext *s, arg_rpr_s *a)
 {
     return do_brk2(s, a, gen_helper_sve_brkb_z, gen_helper_sve_brkbs_z);
 }
 
-static bool trans_BRKN(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+static bool trans_BRKN(DisasContext *s, arg_rpr_s *a)
 {
     return do_brk2(s, a, gen_helper_sve_brkn, gen_helper_sve_brkns);
 }
@@ -3058,7 +3049,7 @@ static void do_cntp(DisasContext *s, TCGv_i64 val, int esz, int pn, int pg)
     }
 }
 
-static bool trans_CNTP(DisasContext *s, arg_CNTP *a, uint32_t insn)
+static bool trans_CNTP(DisasContext *s, arg_CNTP *a)
 {
     if (sve_access_check(s)) {
         do_cntp(s, cpu_reg(s, a->rd), a->esz, a->rn, a->pg);
@@ -3066,8 +3057,7 @@ static bool trans_CNTP(DisasContext *s, arg_CNTP *a, uint32_t insn)
     return true;
 }
 
-static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a,
-                            uint32_t insn)
+static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 reg = cpu_reg(s, a->rd);
@@ -3084,8 +3074,7 @@ static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a,
     return true;
 }
 
-static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a,
-                            uint32_t insn)
+static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 {
     if (a->esz == 0) {
         return false;
@@ -3102,8 +3091,7 @@ static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a,
     return true;
 }
 
-static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a,
-                                uint32_t insn)
+static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 reg = cpu_reg(s, a->rd);
@@ -3115,8 +3103,7 @@ static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a,
     return true;
 }
 
-static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a,
-                                uint32_t insn)
+static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 reg = cpu_reg(s, a->rd);
@@ -3128,8 +3115,7 @@ static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a,
     return true;
 }
 
-static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a,
-                             uint32_t insn)
+static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 {
     if (a->esz == 0) {
         return false;
@@ -3146,7 +3132,7 @@ static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a,
  *** SVE Integer Compare Scalars Group
  */
 
-static bool trans_CTERM(DisasContext *s, arg_CTERM *a, uint32_t insn)
+static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 {
     if (!sve_access_check(s)) {
         return true;
@@ -3171,7 +3157,7 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a, uint32_t insn)
     return true;
 }
 
-static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
+static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2, t3;
@@ -3260,7 +3246,7 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
 
-static bool trans_FDUP(DisasContext *s, arg_FDUP *a, uint32_t insn)
+static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
 {
     if (a->esz == 0) {
         return false;
@@ -3279,9 +3265,9 @@ static bool trans_FDUP(DisasContext *s, arg_FDUP *a, uint32_t insn)
     return true;
 }
 
-static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a, uint32_t insn)
+static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a)
 {
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3293,9 +3279,9 @@ static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a, uint32_t insn)
     return true;
 }
 
-static bool trans_ADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_ADD_zzi(DisasContext *s, arg_rri_esz *a)
 {
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3306,13 +3292,13 @@ static bool trans_ADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_SUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_SUB_zzi(DisasContext *s, arg_rri_esz *a)
 {
     a->imm = -a->imm;
-    return trans_ADD_zzi(s, a, insn);
+    return trans_ADD_zzi(s, a);
 }
 
-static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
 {
     static const GVecGen2s op[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
@@ -3342,7 +3328,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
           .scalar_first = true }
     };
 
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3356,7 +3342,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_MUL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_MUL_zzi(DisasContext *s, arg_rri_esz *a)
 {
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
@@ -3366,10 +3352,9 @@ static bool trans_MUL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
     return true;
 }
 
-static bool do_zzi_sat(DisasContext *s, arg_rri_esz *a, uint32_t insn,
-                       bool u, bool d)
+static bool do_zzi_sat(DisasContext *s, arg_rri_esz *a, bool u, bool d)
 {
-    if (a->esz == 0 && extract32(insn, 13, 1)) {
+    if (a->esz == 0 && extract32(s->insn, 13, 1)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3380,24 +3365,24 @@ static bool do_zzi_sat(DisasContext *s, arg_rri_esz *a, uint32_t insn,
     return true;
 }
 
-static bool trans_SQADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_SQADD_zzi(DisasContext *s, arg_rri_esz *a)
 {
-    return do_zzi_sat(s, a, insn, false, false);
+    return do_zzi_sat(s, a, false, false);
 }
 
-static bool trans_UQADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_UQADD_zzi(DisasContext *s, arg_rri_esz *a)
 {
-    return do_zzi_sat(s, a, insn, true, false);
+    return do_zzi_sat(s, a, true, false);
 }
 
-static bool trans_SQSUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_SQSUB_zzi(DisasContext *s, arg_rri_esz *a)
 {
-    return do_zzi_sat(s, a, insn, false, true);
+    return do_zzi_sat(s, a, false, true);
 }
 
-static bool trans_UQSUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+static bool trans_UQSUB_zzi(DisasContext *s, arg_rri_esz *a)
 {
-    return do_zzi_sat(s, a, insn, true, true);
+    return do_zzi_sat(s, a, true, true);
 }
 
 static bool do_zzi_ool(DisasContext *s, arg_rri_esz *a, gen_helper_gvec_2i *fn)
@@ -3415,8 +3400,7 @@ static bool do_zzi_ool(DisasContext *s, arg_rri_esz *a, gen_helper_gvec_2i *fn)
 }
 
 #define DO_ZZI(NAME, name) \
-static bool trans_##NAME##_zzi(DisasContext *s, arg_rri_esz *a,         \
-                               uint32_t insn)                           \
+static bool trans_##NAME##_zzi(DisasContext *s, arg_rri_esz *a)         \
 {                                                                       \
     static gen_helper_gvec_2i * const fns[4] = {                        \
         gen_helper_sve_##name##i_b, gen_helper_sve_##name##i_h,         \
@@ -3432,7 +3416,7 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
-static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a, uint32_t insn)
+static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a)
 {
     static gen_helper_gvec_3 * const fns[2][2] = {
         { gen_helper_gvec_sdot_b, gen_helper_gvec_sdot_h },
@@ -3449,7 +3433,7 @@ static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a, uint32_t insn)
+static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a)
 {
     static gen_helper_gvec_3 * const fns[2][2] = {
         { gen_helper_gvec_sdot_idx_b, gen_helper_gvec_sdot_idx_h },
@@ -3471,7 +3455,7 @@ static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a, uint32_t insn)
  *** SVE Floating Point Multiply-Add Indexed Group
  */
 
-static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a, uint32_t insn)
+static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
 {
     static gen_helper_gvec_4_ptr * const fns[3] = {
         gen_helper_gvec_fmla_idx_h,
@@ -3497,7 +3481,7 @@ static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a, uint32_t insn)
  *** SVE Floating Point Multiply Indexed Group
  */
 
-static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_zzx *a, uint32_t insn)
+static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_zzx *a)
 {
     static gen_helper_gvec_3_ptr * const fns[3] = {
         gen_helper_gvec_fmul_idx_h,
@@ -3552,7 +3536,7 @@ static void do_reduce(DisasContext *s, arg_rpr_esz *a,
 }
 
 #define DO_VPZ(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a)                \
 {                                                                        \
     static gen_helper_fp_reduce * const fns[3] = {                       \
         gen_helper_sve_##name##_h,                                       \
@@ -3589,7 +3573,7 @@ static void do_zz_fp(DisasContext *s, arg_rr_esz *a, gen_helper_gvec_2_ptr *fn)
     tcg_temp_free_ptr(status);
 }
 
-static bool trans_FRECPE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_FRECPE(DisasContext *s, arg_rr_esz *a)
 {
     static gen_helper_gvec_2_ptr * const fns[3] = {
         gen_helper_gvec_frecpe_h,
@@ -3605,7 +3589,7 @@ static bool trans_FRECPE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_FRSQRTE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+static bool trans_FRSQRTE(DisasContext *s, arg_rr_esz *a)
 {
     static gen_helper_gvec_2_ptr * const fns[3] = {
         gen_helper_gvec_frsqrte_h,
@@ -3639,7 +3623,7 @@ static void do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
 }
 
 #define DO_PPZ(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a)         \
 {                                                                 \
     static gen_helper_gvec_3_ptr * const fns[3] = {               \
         gen_helper_sve_##name##_h,                                \
@@ -3668,7 +3652,7 @@ DO_PPZ(FCMNE_ppz0, fcmne0)
  *** SVE floating-point trig multiply-add coefficient
  */
 
-static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a, uint32_t insn)
+static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a)
 {
     static gen_helper_gvec_3_ptr * const fns[3] = {
         gen_helper_sve_ftmad_h,
@@ -3695,7 +3679,7 @@ static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a, uint32_t insn)
  *** SVE Floating Point Accumulating Reduction Group
  */
 
-static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
 {
     typedef void fadda_fn(TCGv_i64, TCGv_i64, TCGv_ptr,
                           TCGv_ptr, TCGv_ptr, TCGv_i32);
@@ -3760,7 +3744,7 @@ static bool do_zzz_fp(DisasContext *s, arg_rrr_esz *a,
 
 
 #define DO_FP3(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)           \
 {                                                                   \
     static gen_helper_gvec_3_ptr * const fns[4] = {                 \
         NULL, gen_helper_gvec_##name##_h,                           \
@@ -3802,7 +3786,7 @@ static bool do_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
 }
 
 #define DO_FP3(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)          \
 {                                                                   \
     static gen_helper_gvec_4_ptr * const fns[4] = {                 \
         NULL, gen_helper_sve_##name##_h,                            \
@@ -3862,8 +3846,7 @@ static void do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
 }
 
 #define DO_FP_IMM(NAME, name, const0, const1) \
-static bool trans_##NAME##_zpzi(DisasContext *s, arg_rpri_esz *a,         \
-                                uint32_t insn)                            \
+static bool trans_##NAME##_zpzi(DisasContext *s, arg_rpri_esz *a)         \
 {                                                                         \
     static gen_helper_sve_fp2scalar * const fns[3] = {                    \
         gen_helper_sve_##name##_h,                                        \
@@ -3919,8 +3902,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
 }
 
 #define DO_FPCMP(NAME, name) \
-static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a,     \
-                                uint32_t insn)                        \
+static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a)     \
 {                                                                     \
     static gen_helper_gvec_4_ptr * const fns[4] = {                   \
         NULL, gen_helper_sve_##name##_h,                              \
@@ -3939,7 +3921,7 @@ DO_FPCMP(FACGT, facgt)
 
 #undef DO_FPCMP
 
-static bool trans_FCADD(DisasContext *s, arg_FCADD *a, uint32_t insn)
+static bool trans_FCADD(DisasContext *s, arg_FCADD *a)
 {
     static gen_helper_gvec_4_ptr * const fns[3] = {
         gen_helper_sve_fcadd_h,
@@ -3996,7 +3978,7 @@ static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
 }
 
 #define DO_FMLA(NAME, name) \
-static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn) \
+static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a)          \
 {                                                                    \
     static gen_helper_sve_fmla * const fns[4] = {                    \
         NULL, gen_helper_sve_##name##_h,                             \
@@ -4012,8 +3994,7 @@ DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
 
 #undef DO_FMLA
 
-static bool trans_FCMLA_zpzzz(DisasContext *s,
-                              arg_FCMLA_zpzzz *a, uint32_t insn)
+static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
 {
     static gen_helper_sve_fmla * const fns[3] = {
         gen_helper_sve_fcmla_zpzzz_h,
@@ -4049,7 +4030,7 @@ static bool trans_FCMLA_zpzzz(DisasContext *s,
     return true;
 }
 
-static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a, uint32_t insn)
+static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
 {
     static gen_helper_gvec_3_ptr * const fns[2] = {
         gen_helper_gvec_fcmlah_idx,
@@ -4091,102 +4072,102 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
     return true;
 }
 
-static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sh);
 }
 
-static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hs);
 }
 
-static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_dh);
 }
 
-static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hd);
 }
 
-static bool trans_FCVT_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_ds(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_ds);
 }
 
-static bool trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sd);
 }
 
-static bool trans_FCVTZS_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_hh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hh);
 }
 
-static bool trans_FCVTZU_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_hh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hh);
 }
 
-static bool trans_FCVTZS_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_hs(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hs);
 }
 
-static bool trans_FCVTZU_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_hs(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hs);
 }
 
-static bool trans_FCVTZS_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_hd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hd);
 }
 
-static bool trans_FCVTZU_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_hd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hd);
 }
 
-static bool trans_FCVTZS_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_ss(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ss);
 }
 
-static bool trans_FCVTZU_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_ss(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ss);
 }
 
-static bool trans_FCVTZS_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_sd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_sd);
 }
 
-static bool trans_FCVTZU_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_sd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_sd);
 }
 
-static bool trans_FCVTZS_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_ds(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ds);
 }
 
-static bool trans_FCVTZU_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_ds(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ds);
 }
 
-static bool trans_FCVTZS_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZS_dd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_dd);
 }
 
-static bool trans_FCVTZU_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FCVTZU_dd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_dd);
 }
@@ -4197,7 +4178,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[3] = {
     gen_helper_sve_frint_d
 };
 
-static bool trans_FRINTI(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTI(DisasContext *s, arg_rpr_esz *a)
 {
     if (a->esz == 0) {
         return false;
@@ -4206,7 +4187,7 @@ static bool trans_FRINTI(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
                       frint_fns[a->esz - 1]);
 }
 
-static bool trans_FRINTX(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTX(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3_ptr * const fns[3] = {
         gen_helper_sve_frintx_h,
@@ -4243,32 +4224,32 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a, int mode)
     return true;
 }
 
-static bool trans_FRINTN(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTN(DisasContext *s, arg_rpr_esz *a)
 {
     return do_frint_mode(s, a, float_round_nearest_even);
 }
 
-static bool trans_FRINTP(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTP(DisasContext *s, arg_rpr_esz *a)
 {
     return do_frint_mode(s, a, float_round_up);
 }
 
-static bool trans_FRINTM(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTM(DisasContext *s, arg_rpr_esz *a)
 {
     return do_frint_mode(s, a, float_round_down);
 }
 
-static bool trans_FRINTZ(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTZ(DisasContext *s, arg_rpr_esz *a)
 {
     return do_frint_mode(s, a, float_round_to_zero);
 }
 
-static bool trans_FRINTA(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRINTA(DisasContext *s, arg_rpr_esz *a)
 {
     return do_frint_mode(s, a, float_round_ties_away);
 }
 
-static bool trans_FRECPX(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FRECPX(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3_ptr * const fns[3] = {
         gen_helper_sve_frecpx_h,
@@ -4281,7 +4262,7 @@ static bool trans_FRECPX(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16, fns[a->esz - 1]);
 }
 
-static bool trans_FSQRT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_FSQRT(DisasContext *s, arg_rpr_esz *a)
 {
     static gen_helper_gvec_3_ptr * const fns[3] = {
         gen_helper_sve_fsqrt_h,
@@ -4294,72 +4275,72 @@ static bool trans_FSQRT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16, fns[a->esz - 1]);
 }
 
-static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
 }
 
-static bool trans_SCVTF_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_sh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_sh);
 }
 
-static bool trans_SCVTF_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_dh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_dh);
 }
 
-static bool trans_SCVTF_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_ss(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_ss);
 }
 
-static bool trans_SCVTF_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_ds(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_ds);
 }
 
-static bool trans_SCVTF_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_sd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_sd);
 }
 
-static bool trans_SCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_SCVTF_dd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_dd);
 }
 
-static bool trans_UCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_hh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_hh);
 }
 
-static bool trans_UCVTF_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_sh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_sh);
 }
 
-static bool trans_UCVTF_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_dh(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_dh);
 }
 
-static bool trans_UCVTF_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_ss(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_ss);
 }
 
-static bool trans_UCVTF_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_ds(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_ds);
 }
 
-static bool trans_UCVTF_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_sd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_sd);
 }
 
-static bool trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_dd);
 }
@@ -4538,7 +4519,7 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     tcg_temp_free_i64(t0);
 }
 
-static bool trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
+static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
 {
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
@@ -4548,7 +4529,7 @@ static bool trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
+static bool trans_LDR_pri(DisasContext *s, arg_rri *a)
 {
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
@@ -4558,7 +4539,7 @@ static bool trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_STR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
+static bool trans_STR_zri(DisasContext *s, arg_rri *a)
 {
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
@@ -4568,7 +4549,7 @@ static bool trans_STR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_STR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
+static bool trans_STR_pri(DisasContext *s, arg_rri *a)
 {
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
@@ -4693,7 +4674,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
     do_mem_zpa(s, zt, pg, addr, dtype, fn);
 }
 
-static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
 {
     if (a->rm == 31) {
         return false;
@@ -4707,7 +4688,7 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 {
     if (sve_access_check(s)) {
         int vsz = vec_full_reg_size(s);
@@ -4722,7 +4703,7 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
 {
     static gen_helper_gvec_mem * const fns[2][16] = {
         /* Little-endian */
@@ -4778,7 +4759,7 @@ static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 {
     static gen_helper_gvec_mem * const fns[2][16] = {
         /* Little-endian */
@@ -4890,7 +4871,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     }
 }
 
-static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a)
 {
     if (a->rm == 31) {
         return false;
@@ -4905,7 +4886,7 @@ static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
@@ -4916,7 +4897,7 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
 }
 
 /* Load and broadcast element.  */
-static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 {
     if (!sve_access_check(s)) {
         return true;
@@ -5036,7 +5017,7 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     do_mem_zpa(s, zt, pg, addr, msz_dtype(msz), fn);
 }
 
-static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
+static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
 {
     if (a->rm == 31 || a->msz > a->esz) {
         return false;
@@ -5050,7 +5031,7 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
     return true;
 }
 
-static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a, uint32_t insn)
+static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
 {
     if (a->msz > a->esz) {
         return false;
@@ -5264,7 +5245,7 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][2][3][2][4] = {
             gen_helper_sve_ldffdd_be_zd, } } } },
 };
 
-static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
+static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     int be = s->be_data == MO_BE;
@@ -5288,7 +5269,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
+static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     int be = s->be_data == MO_BE;
@@ -5368,7 +5349,7 @@ static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][3][4] = {
         gen_helper_sve_stdd_be_zd, } },
 };
 
-static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
+static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
     int be = s->be_data == MO_BE;
@@ -5394,7 +5375,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
+static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     int be = s->be_data == MO_BE;
@@ -5430,14 +5411,14 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
  * Prefetches
  */
 
-static bool trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
+static bool trans_PRF(DisasContext *s, arg_PRF *a)
 {
     /* Prefetch is a nop within QEMU.  */
     (void)sve_access_check(s);
     return true;
 }
 
-static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
+static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a)
 {
     if (a->rm == 31) {
         return false;
@@ -5461,12 +5442,12 @@ static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
  * In the meantime, just emit the moves.
  */
 
-static bool trans_MOVPRFX(DisasContext *s, arg_MOVPRFX *a, uint32_t insn)
+static bool trans_MOVPRFX(DisasContext *s, arg_MOVPRFX *a)
 {
     return do_mov_z(s, a->rd, a->rn);
 }
 
-static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a)
 {
     if (sve_access_check(s)) {
         do_sel_z(s, a->rd, a->rn, a->rd, a->pg, a->esz);
@@ -5474,7 +5455,7 @@ static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return true;
 }
 
-static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a)
 {
     if (sve_access_check(s)) {
         do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz);
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 4bfd2dd8a6..bc63093ee9 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -51,12 +51,11 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info)
     return 4;
 }
 
-#define INSN(opcode, format, ...) \
-static bool trans_l_##opcode(disassemble_info *info,    \
-    arg_l_##opcode *a, uint32_t insn)                   \
-{                                                       \
-    output("l." #opcode, format, ##__VA_ARGS__);        \
-    return true;                                        \
+#define INSN(opcode, format, ...)                                       \
+static bool trans_l_##opcode(disassemble_info *info, arg_l_##opcode *a) \
+{                                                                       \
+    output("l." #opcode, format, ##__VA_ARGS__);                        \
+    return true;                                                        \
 }
 
 INSN(add,    "r%d, r%d, r%d", a->d, a->a, a->b)
@@ -146,12 +145,12 @@ INSN(psync,  "")
 INSN(csync,  "")
 INSN(rfe,    "")
 
-#define FP_INSN(opcode, suffix, format, ...) \
-static bool trans_lf_##opcode##_##suffix(disassemble_info *info, \
-    arg_lf_##opcode##_##suffix *a, uint32_t insn)                \
-{                                                                \
-    output("lf." #opcode "." #suffix, format, ##__VA_ARGS__);    \
-    return true;                                                 \
+#define FP_INSN(opcode, suffix, format, ...)                            \
+static bool trans_lf_##opcode##_##suffix(disassemble_info *info,        \
+                                         arg_lf_##opcode##_##suffix *a) \
+{                                                                       \
+    output("lf." #opcode "." #suffix, format, ##__VA_ARGS__);           \
+    return true;                                                        \
 }
 
 FP_INSN(add, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a271cd3903..c089914d6a 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -434,105 +434,105 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
-static bool trans_l_add(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_add(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_add(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_addc(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_addc(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_addc(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sub(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_sub(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_sub(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_and(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_and(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_and_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_or(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_or(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_or_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_xor(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_xor(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_xor_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sll(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_sll(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_shl_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_srl(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_srl(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_shr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sra(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_sra(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_sar_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_ror(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_ror(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     tcg_gen_rotr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_exths(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_exths(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_ext16s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
-static bool trans_l_extbs(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_extbs(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_ext8s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
-static bool trans_l_exthz(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_exthz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_ext16u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
-static bool trans_l_extbz(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_extbz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_ext8u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
-static bool trans_l_cmov(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     TCGv zero;
 
@@ -544,7 +544,7 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_ff1(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_ctzi_tl(cpu_R[a->d], cpu_R[a->a], -1);
@@ -552,7 +552,7 @@ static bool trans_l_ff1(DisasContext *dc, arg_da *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_fl1(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(a->d);
     tcg_gen_clzi_tl(cpu_R[a->d], cpu_R[a->a], TARGET_LONG_BITS);
@@ -560,47 +560,47 @@ static bool trans_l_fl1(DisasContext *dc, arg_da *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_mul(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_mul(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_mul(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_mulu(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_mulu(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_mulu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_div(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_div(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_div(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_divu(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_l_divu(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_divu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_muld(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_muld(DisasContext *dc, arg_ab *a)
 {
     gen_muld(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_muldu(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_muldu(DisasContext *dc, arg_ab *a)
 {
     gen_muldu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
+static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
     target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
 
@@ -610,7 +610,7 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_jal(DisasContext *dc, arg_l_jal *a, uint32_t insn)
+static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 {
     target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
     target_ulong ret_pc = dc->base.pc_next + 8;
@@ -640,26 +640,26 @@ static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
     dc->delayed_branch = 2;
 }
 
-static bool trans_l_bf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
+static bool trans_l_bf(DisasContext *dc, arg_l_bf *a)
 {
     do_bf(dc, a, TCG_COND_NE);
     return true;
 }
 
-static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
+static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a)
 {
     do_bf(dc, a, TCG_COND_EQ);
     return true;
 }
 
-static bool trans_l_jr(DisasContext *dc, arg_l_jr *a, uint32_t insn)
+static bool trans_l_jr(DisasContext *dc, arg_l_jr *a)
 {
     tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
     dc->delayed_branch = 2;
     return true;
 }
 
-static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a, uint32_t insn)
+static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a)
 {
     tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
     tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
@@ -667,7 +667,7 @@ static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_lwa(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lwa(DisasContext *dc, arg_load *a)
 {
     TCGv ea;
 
@@ -692,43 +692,43 @@ static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)
     tcg_temp_free(ea);
 }
 
-static bool trans_l_lwz(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_TEUL);
     return true;
 }
 
-static bool trans_l_lws(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_TESL);
     return true;
 }
 
-static bool trans_l_lbz(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lbz(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_UB);
     return true;
 }
 
-static bool trans_l_lbs(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_SB);
     return true;
 }
 
-static bool trans_l_lhz(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_TEUW);
     return true;
 }
 
-static bool trans_l_lhs(DisasContext *dc, arg_load *a, uint32_t insn)
+static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
     do_load(dc, a, MO_TESW);
     return true;
 }
 
-static bool trans_l_swa(DisasContext *dc, arg_store *a, uint32_t insn)
+static bool trans_l_swa(DisasContext *dc, arg_store *a)
 {
     TCGv ea, val;
     TCGLabel *lab_fail, *lab_done;
@@ -771,30 +771,30 @@ static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)
     tcg_temp_free(t0);
 }
 
-static bool trans_l_sw(DisasContext *dc, arg_store *a, uint32_t insn)
+static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
     do_store(dc, a, MO_TEUL);
     return true;
 }
 
-static bool trans_l_sb(DisasContext *dc, arg_store *a, uint32_t insn)
+static bool trans_l_sb(DisasContext *dc, arg_store *a)
 {
     do_store(dc, a, MO_UB);
     return true;
 }
 
-static bool trans_l_sh(DisasContext *dc, arg_store *a, uint32_t insn)
+static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
     do_store(dc, a, MO_TEUW);
     return true;
 }
 
-static bool trans_l_nop(DisasContext *dc, arg_l_nop *a, uint32_t insn)
+static bool trans_l_nop(DisasContext *dc, arg_l_nop *a)
 {
     return true;
 }
 
-static bool trans_l_addi(DisasContext *dc, arg_rri *a, uint32_t insn)
+static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
@@ -805,7 +805,7 @@ static bool trans_l_addi(DisasContext *dc, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_addic(DisasContext *dc, arg_rri *a, uint32_t insn)
+static bool trans_l_addic(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
@@ -816,7 +816,7 @@ static bool trans_l_addic(DisasContext *dc, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_muli(DisasContext *dc, arg_rri *a, uint32_t insn)
+static bool trans_l_muli(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
@@ -827,7 +827,7 @@ static bool trans_l_muli(DisasContext *dc, arg_rri *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_maci(DisasContext *dc, arg_l_maci *a, uint32_t insn)
+static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
 {
     TCGv t0;
 
@@ -837,28 +837,28 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_andi(DisasContext *dc, arg_rrk *a, uint32_t insn)
+static bool trans_l_andi(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(a->d);
     tcg_gen_andi_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
 }
 
-static bool trans_l_ori(DisasContext *dc, arg_rrk *a, uint32_t insn)
+static bool trans_l_ori(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(a->d);
     tcg_gen_ori_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
 }
 
-static bool trans_l_xori(DisasContext *dc, arg_rri *a, uint32_t insn)
+static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(a->d);
     tcg_gen_xori_tl(cpu_R[a->d], cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
+static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 {
     check_r0_write(a->d);
 
@@ -873,7 +873,7 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
+static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
 {
     if (is_user(dc)) {
         gen_illegal_exception(dc);
@@ -901,66 +901,66 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_mac(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_mac(DisasContext *dc, arg_ab *a)
 {
     gen_mac(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_msb(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_msb(DisasContext *dc, arg_ab *a)
 {
     gen_msb(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_macu(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_macu(DisasContext *dc, arg_ab *a)
 {
     gen_macu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_msbu(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_l_msbu(DisasContext *dc, arg_ab *a)
 {
     gen_msbu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_slli(DisasContext *dc, arg_dal *a, uint32_t insn)
+static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(a->d);
     tcg_gen_shli_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
-static bool trans_l_srli(DisasContext *dc, arg_dal *a, uint32_t insn)
+static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(a->d);
     tcg_gen_shri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
-static bool trans_l_srai(DisasContext *dc, arg_dal *a, uint32_t insn)
+static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(a->d);
     tcg_gen_sari_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
-static bool trans_l_rori(DisasContext *dc, arg_dal *a, uint32_t insn)
+static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(a->d);
     tcg_gen_rotri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
-static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a, uint32_t insn)
+static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 {
     check_r0_write(a->d);
     tcg_gen_movi_tl(cpu_R[a->d], a->k << 16);
     return true;
 }
 
-static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
+static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
     check_r0_write(a->d);
     tcg_gen_trunc_i64_tl(cpu_R[a->d], cpu_mac);
@@ -968,127 +968,127 @@ static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_sfeq(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfeq(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfne(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfne(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfltu(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfltu(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfleu(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfleu(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfgts(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfgts(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfges(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfges(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sflts(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sflts(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfles(DisasContext *dc, arg_ab *a, TCGCond cond)
+static bool trans_l_sfles(DisasContext *dc, arg_ab *a)
 {
     tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
-static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfnei(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfnei(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfltui(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfltui(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfleui(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfleui(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sflesi(DisasContext *dc, arg_ai *a, TCGCond cond)
+static bool trans_l_sflesi(DisasContext *dc, arg_ai *a)
 {
     tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
-static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
+static bool trans_l_sys(DisasContext *dc, arg_l_sys *a)
 {
     tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_SYSCALL);
@@ -1096,7 +1096,7 @@ static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_trap(DisasContext *dc, arg_l_trap *a, uint32_t insn)
+static bool trans_l_trap(DisasContext *dc, arg_l_trap *a)
 {
     tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_TRAP);
@@ -1104,23 +1104,23 @@ static bool trans_l_trap(DisasContext *dc, arg_l_trap *a, uint32_t insn)
     return true;
 }
 
-static bool trans_l_msync(DisasContext *dc, arg_l_msync *a, uint32_t insn)
+static bool trans_l_msync(DisasContext *dc, arg_l_msync *a)
 {
     tcg_gen_mb(TCG_MO_ALL);
     return true;
 }
 
-static bool trans_l_psync(DisasContext *dc, arg_l_psync *a, uint32_t insn)
+static bool trans_l_psync(DisasContext *dc, arg_l_psync *a)
 {
     return true;
 }
 
-static bool trans_l_csync(DisasContext *dc, arg_l_csync *a, uint32_t insn)
+static bool trans_l_csync(DisasContext *dc, arg_l_csync *a)
 {
     return true;
 }
 
-static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
+static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
 {
     if (is_user(dc)) {
         gen_illegal_exception(dc);
@@ -1162,49 +1162,49 @@ static void do_fpcmp(DisasContext *dc, arg_ab *a,
     gen_helper_update_fpcsr(cpu_env);
 }
 
-static bool trans_lf_add_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_add_s(DisasContext *dc, arg_dab *a)
 {
     do_fp3(dc, a, gen_helper_float_add_s);
     return true;
 }
 
-static bool trans_lf_sub_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_sub_s(DisasContext *dc, arg_dab *a)
 {
     do_fp3(dc, a, gen_helper_float_sub_s);
     return true;
 }
 
-static bool trans_lf_mul_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_mul_s(DisasContext *dc, arg_dab *a)
 {
     do_fp3(dc, a, gen_helper_float_mul_s);
     return true;
 }
 
-static bool trans_lf_div_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_div_s(DisasContext *dc, arg_dab *a)
 {
     do_fp3(dc, a, gen_helper_float_div_s);
     return true;
 }
 
-static bool trans_lf_rem_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_rem_s(DisasContext *dc, arg_dab *a)
 {
     do_fp3(dc, a, gen_helper_float_rem_s);
     return true;
 }
 
-static bool trans_lf_itof_s(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_lf_itof_s(DisasContext *dc, arg_da *a)
 {
     do_fp2(dc, a, gen_helper_itofs);
     return true;
 }
 
-static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a, uint32_t insn)
+static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a)
 {
     do_fp2(dc, a, gen_helper_ftois);
     return true;
 }
 
-static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(a->d);
     gen_helper_float_madd_s(cpu_R[a->d], cpu_env, cpu_R[a->d],
@@ -1213,37 +1213,37 @@ static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a, uint32_t insn)
     return true;
 }
 
-static bool trans_lf_sfeq_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sfeq_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_eq_s, false, false);
     return true;
 }
 
-static bool trans_lf_sfne_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sfne_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_eq_s, true, false);
     return true;
 }
 
-static bool trans_lf_sfgt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sfgt_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_lt_s, false, true);
     return true;
 }
 
-static bool trans_lf_sfge_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sfge_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_le_s, false, true);
     return true;
 }
 
-static bool trans_lf_sflt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sflt_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_lt_s, false, false);
     return true;
 }
 
-static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a)
 {
     do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
     return true;
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 28bbd4e3c1..6670d58cc1 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -466,8 +466,7 @@ class Pattern(General):
         output('typedef ', self.base.base.struct_name(),
                ' arg_', self.name, ';\n')
         output(translate_scope, 'bool ', translate_prefix, '_', self.name,
-               '(DisasContext *ctx, arg_', self.name,
-               ' *a, ', insntype, ' insn);\n')
+               '(DisasContext *ctx, arg_', self.name, ' *a);\n')
 
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
@@ -479,7 +478,7 @@ class Pattern(General):
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         output(ind, 'return ', translate_prefix, '_', self.name,
-               '(ctx, &u.f_', arg, ', insn);\n')
+               '(ctx, &u.f_', arg, ');\n')
 # end Pattern
 
 
-- 
2.17.2
