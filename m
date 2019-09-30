Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CEBC388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C541C2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="D2hykylc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvAn-0006gO-I7
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv54-0002Ng-61
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv51-00027K-4q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:09 -0400
Received: from shirlock.uni-paderborn.de ([131.234.189.15]:41570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iEv4v-00022y-Di
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VlOMqpP60+lmuiPE847Xi37FZdHD1O4pbhYYKBs5M00=; b=D2hykylcenYV47aQ+lA7S5oyZW
 S3px6H/IfR+2yHW2BVd5vlnhzzU0PTXhlxX5ZrhIc2TI5eWwMZK9I0GrKxWl+5hNqQ1piuOjHoR6m
 WcZ+HDL2iBIc+uhYMWxAhljn4MX5xKb67AHpckmYTssAv0QYKX9ACLSHE8MNOQtfI4Ec=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/tricore: Move translate feature check to ctx
Date: Mon, 30 Sep 2019 14:46:40 +0200
Message-Id: <20190930124643.179695-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
References: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.30.123317, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.27.5650000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.234.189.15
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andreas Konopik <andreas.konopik@fau.de>, david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this allows us to remove the references to env from ctx. This also fixes
a segfault that was due to the unititalized ctx->env ptr.

Reported-by: Andreas Konopik <andreas.konopik@fau.de>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 60 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index c556e9a7ab..832ff6328d 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -66,14 +66,19 @@ static const char *regnames_d[] = {
 
 typedef struct DisasContext {
     DisasContextBase base;
-    CPUTriCoreState *env;
     target_ulong pc_succ_insn;
     uint32_t opcode;
     /* Routine used to access memory */
     int mem_idx;
     uint32_t hflags, saved_hflags;
+    uint64_t features;
 } DisasContext;
 
+static int has_feature(DisasContext *ctx, int feature)
+{
+    return (ctx->features & (1ULL << feature)) != 0;
+}
+
 enum {
     MODE_LL = 0,
     MODE_LU = 1,
@@ -370,7 +375,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
    These makros also specify in which ISA version the csfr was introduced. */
 #define R(ADDRESS, REG, FEATURE)                                         \
     case ADDRESS:                                                        \
-        if (tricore_feature(ctx->env, FEATURE)) {                        \
+        if (has_feature(ctx, FEATURE)) {                             \
             tcg_gen_ld_tl(ret, cpu_env, offsetof(CPUTriCoreState, REG)); \
         }                                                                \
         break;
@@ -395,7 +400,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
                                     since no execption occurs */
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
     case ADDRESS:                                                        \
-        if (tricore_feature(ctx->env, FEATURE)) {                        \
+        if (has_feature(ctx, FEATURE)) {                             \
             tcg_gen_st_tl(r1, cpu_env, offsetof(CPUTriCoreState, REG));  \
         }                                                                \
         break;
@@ -3158,7 +3163,7 @@ gen_dvinit_b(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
 
-    if (!tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+    if (!has_feature(ctx, TRICORE_FEATURE_131)) {
         gen_helper_dvinit_b_13(ret, cpu_env, r1, r2);
     } else {
         gen_helper_dvinit_b_131(ret, cpu_env, r1, r2);
@@ -3173,7 +3178,7 @@ gen_dvinit_h(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
 
-    if (!tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+    if (!has_feature(ctx, TRICORE_FEATURE_131)) {
         gen_helper_dvinit_h_13(ret, cpu_env, r1, r2);
     } else {
         gen_helper_dvinit_h_131(ret, cpu_env, r1, r2);
@@ -3655,7 +3660,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
         tcg_gen_movi_tl(cpu_gpr_a[r1], const4);
         break;
     case OPC1_16_SRC_MOV_E:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             tcg_gen_movi_tl(cpu_gpr_d[r1], const4);
             tcg_gen_sari_tl(cpu_gpr_d[r1+1], cpu_gpr_d[r1], 31);
         } else {
@@ -4106,7 +4111,7 @@ static void decode_16Bit_opc(DisasContext *ctx)
         break;
     case OPC1_16_SBC_JEQ2:
     case OPC1_16_SBC_JNE2:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             address = MASK_OP_SBC_DISP4(ctx->opcode);
             const16 = MASK_OP_SBC_CONST4_SEXT(ctx->opcode);
             gen_compute_branch(ctx, op1, 0, 0, const16, address);
@@ -4124,7 +4129,7 @@ static void decode_16Bit_opc(DisasContext *ctx)
 /* SBR-format */
     case OPC1_16_SBR_JEQ2:
     case OPC1_16_SBR_JNE2:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             r1 = MASK_OP_SBR_S2(ctx->opcode);
             address = MASK_OP_SBR_DISP4(ctx->opcode);
             gen_compute_branch(ctx, op1, r1, 0, 0, address);
@@ -4704,13 +4709,13 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_CACHEI_WI_SHORTOFF:
     case OPC2_32_BO_CACHEI_W_SHORTOFF:
-        if (!tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+        if (!has_feature(ctx, TRICORE_FEATURE_131)) {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC2_32_BO_CACHEI_W_POSTINC:
     case OPC2_32_BO_CACHEI_WI_POSTINC:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+        if (has_feature(ctx, TRICORE_FEATURE_131)) {
             tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -4718,7 +4723,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_CACHEI_W_PREINC:
     case OPC2_32_BO_CACHEI_WI_PREINC:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+        if (has_feature(ctx, TRICORE_FEATURE_131)) {
             tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -5372,7 +5377,7 @@ static void decode_bol_opc(DisasContext *ctx, int32_t op1)
         tcg_gen_addi_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], address);
         break;
     case OPC1_32_BOL_ST_A_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_st(ctx, cpu_gpr_a[r1], cpu_gpr_a[r2], address, MO_LEUL);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -5382,42 +5387,42 @@ static void decode_bol_opc(DisasContext *ctx, int32_t op1)
         gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_LEUL);
         break;
     case OPC1_32_BOL_LD_B_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_SB);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_BOL_LD_BU_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_UB);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_BOL_LD_H_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_LESW);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_BOL_LD_HU_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_LEUW);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_BOL_ST_B_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_SB);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_BOL_ST_H_LONGOFF:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], address, MO_LESW);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6022,7 +6027,7 @@ static void decode_rlc_opc(DisasContext *ctx,
         tcg_gen_movi_tl(cpu_gpr_d[r2], const16);
         break;
     case OPC1_32_RLC_MOV_64:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r2);
             tcg_gen_movi_tl(cpu_gpr_d[r2], const16);
             tcg_gen_movi_tl(cpu_gpr_d[r2+1], const16 >> 15);
@@ -6248,7 +6253,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
         tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MOV_64:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             temp = tcg_temp_new();
 
             CHECK_REG_PAIR(r3);
@@ -6262,7 +6267,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_MOVS_64:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r3);
             tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
             tcg_gen_sari_tl(cpu_gpr_d[r3 + 1], cpu_gpr_d[r2], 31);
@@ -6602,7 +6607,7 @@ static void decode_rr_divide(DisasContext *ctx)
         tcg_gen_shri_tl(temp3, cpu_gpr_d[r1], 8);
         /* reset av */
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
-        if (!tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+        if (!has_feature(ctx, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
             tcg_gen_abs_tl(temp, temp3);
             tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
@@ -6635,7 +6640,7 @@ static void decode_rr_divide(DisasContext *ctx)
         tcg_gen_shri_tl(temp3, cpu_gpr_d[r1], 16);
         /* reset av */
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
-        if (!tricore_feature(ctx->env, TRICORE_FEATURE_131)) {
+        if (!has_feature(ctx, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
             tcg_gen_abs_tl(temp, temp3);
             tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
@@ -6698,14 +6703,14 @@ static void decode_rr_divide(DisasContext *ctx)
         gen_unpack(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CRC32:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_161)) {
+        if (has_feature(ctx, TRICORE_FEATURE_161)) {
             gen_helper_crc32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC2_32_RR_DIV:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
                           cpu_gpr_d[r2]);
         } else {
@@ -6713,7 +6718,7 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_DIV_U:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             GEN_HELPER_RR(divide_u, cpu_gpr_d[r3], cpu_gpr_d[r3+1],
                           cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
@@ -8411,7 +8416,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         gen_helper_svlcx(cpu_env);
         break;
     case OPC2_32_SYS_RESTORE:
-        if (tricore_feature(ctx->env, TRICORE_FEATURE_16)) {
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
             if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM ||
                 (ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_UM1) {
                 tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
@@ -8792,6 +8797,7 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
     CPUTriCoreState *env = cs->env_ptr;
     ctx->mem_idx = cpu_mmu_index(env, false);
     ctx->hflags = (uint32_t)ctx->base.tb->flags;
+    ctx->features = env->features;
 }
 
 static void tricore_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.23.0


