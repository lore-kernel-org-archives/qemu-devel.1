Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF75C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2194620870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUYT-0002Ha-E3
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUQE-0003vy-VY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUQD-00062d-8z
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:38:10 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46352
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQD-000617-2l; Sun, 16 Jun 2019 08:38:09 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUPx-0001jp-Sj; Sun, 16 Jun 2019 13:37:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:40 +0100
Message-Id: <20190616123751.781-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 04/15] target/ppc: introduce separate
 VSX_CMP macro for xvcmp* instructions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than perform the VSR register decoding within the helper itself,
introduce a new VSX_CMP macro which performs the decode based upon xT, xA
and xB at translation time.

Subsequent commits will make the same changes for other instructions however
the xvcmp* instructions are different in that they return a set of flags to be
optionally written back to the crf[6] register. Move this logic from the
helper function to the generator function, along with the float_status update.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c             | 15 +++++-------
 target/ppc/helper.h                 | 20 +++++++++------
 target/ppc/translate/vsx-impl.inc.c | 49 +++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 8da805d175..b1ce954354 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2746,12 +2746,11 @@ VSX_MAX_MINJ(xsminjdp, 0);
  *   exp   - expected result of comparison
  */
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
+uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
+                     ppc_vsr_t *xa, ppc_vsr_t *xb)                        \
 {                                                                         \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                \
     ppc_vsr_t t = *xt;                                                    \
+    uint32_t crf6 = 0;                                                    \
     int i;                                                                \
     int all_true = 1;                                                     \
     int all_false = 1;                                                    \
@@ -2780,11 +2779,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
     }                                                                     \
                                                                           \
     *xt = t;                                                              \
-    if ((opcode >> (31 - 21)) & 1) {                                      \
-        env->crf[6] = (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);       \
-    }                                                                     \
-    do_float_check_status(env, GETPC());                                  \
- }
+    crf6 = (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);                  \
+    return crf6;                                                          \
+}
 
 VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
 VSX_CMP(xvcmpgedp, 2, float64, VsrD(i), le, 1, 1)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 02b67a333e..8666415169 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -108,6 +108,10 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, i64)
 #define dh_ctype_avr ppc_avr_t *
 #define dh_is_signed_avr dh_is_signed_ptr
 
+#define dh_alias_vsr ptr
+#define dh_ctype_vsr ppc_vsr_t *
+#define dh_is_signed_vsr dh_is_signed_ptr
+
 DEF_HELPER_3(vavgub, void, avr, avr, avr)
 DEF_HELPER_3(vavguh, void, avr, avr, avr)
 DEF_HELPER_3(vavguw, void, avr, avr, avr)
@@ -468,10 +472,10 @@ DEF_HELPER_2(xvnmsubadp, void, env, i32)
 DEF_HELPER_2(xvnmsubmdp, void, env, i32)
 DEF_HELPER_2(xvmaxdp, void, env, i32)
 DEF_HELPER_2(xvmindp, void, env, i32)
-DEF_HELPER_2(xvcmpeqdp, void, env, i32)
-DEF_HELPER_2(xvcmpgedp, void, env, i32)
-DEF_HELPER_2(xvcmpgtdp, void, env, i32)
-DEF_HELPER_2(xvcmpnedp, void, env, i32)
+DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvdpsp, void, env, i32)
 DEF_HELPER_2(xvcvdpsxds, void, env, i32)
 DEF_HELPER_2(xvcvdpsxws, void, env, i32)
@@ -506,10 +510,10 @@ DEF_HELPER_2(xvnmsubasp, void, env, i32)
 DEF_HELPER_2(xvnmsubmsp, void, env, i32)
 DEF_HELPER_2(xvmaxsp, void, env, i32)
 DEF_HELPER_2(xvminsp, void, env, i32)
-DEF_HELPER_2(xvcmpeqsp, void, env, i32)
-DEF_HELPER_2(xvcmpgesp, void, env, i32)
-DEF_HELPER_2(xvcmpgtsp, void, env, i32)
-DEF_HELPER_2(xvcmpnesp, void, env, i32)
+DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvspdp, void, env, i32)
 DEF_HELPER_2(xvcvsphp, void, env, i32)
 DEF_HELPER_2(xvcvhpsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e9b7562f84..900ba07d40 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -20,6 +20,13 @@ static inline void set_cpu_vsrl(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, false));
 }
 
+static inline TCGv_ptr gen_vsr_ptr(int reg)
+{
+    TCGv_ptr r = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(r, cpu_env, vsr_full_offset(reg));
+    return r;
+}
+
 #define VSX_LOAD_SCALAR(name, operation)                      \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -958,6 +965,40 @@ VSX_VECTOR_MOVE(xvnabssp, OP_NABS, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvnegsp, OP_NEG, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvcpsgnsp, OP_CPSGN, SGN_MASK_SP)
 
+#define VSX_CMP(name, op1, op2, inval, type)                                  \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 ignored;                                                         \
+    TCGv_ptr xt, xa, xb;                                                      \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    if ((ctx->opcode >> (31 - 21)) & 1) {                                     \
+        gen_helper_##name(cpu_crf[6], cpu_env, xt, xa, xb);                   \
+    } else {                                                                  \
+        ignored = tcg_temp_new_i32();                                         \
+        gen_helper_##name(ignored, cpu_env, xt, xa, xb);                      \
+        tcg_temp_free_i32(ignored);                                           \
+    }                                                                         \
+    gen_helper_float_check_status(cpu_env);                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
+VSX_CMP(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
+VSX_CMP(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
+VSX_CMP(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
+VSX_CMP(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
+VSX_CMP(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
+VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
+VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
+VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
+
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                         \
 static void gen_##name(DisasContext *ctx)                                     \
 {                                                                             \
@@ -1097,10 +1138,6 @@ GEN_VSX_HELPER_2(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
@@ -1135,10 +1172,6 @@ GEN_VSX_HELPER_2(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
-- 
2.11.0


