Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B527C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227920866
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUsM-0004Ia-Fr
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 09:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUoJ-00032c-NP
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUoI-0004Iw-3r
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:03 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46508
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUoH-0004IM-UP; Sun, 16 Jun 2019 09:03:02 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQ4-0001jp-Gs; Sun, 16 Jun 2019 13:38:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:47 +0100
Message-Id: <20190616123751.781-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 11/15] target/ppc: introduce
 GEN_VSX_HELPER_R2 macro to fpu_helper.c
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
introduce a new GEN_VSX_HELPER_R2 macro which performs the decode based
upon rD and rB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c             | 30 ++++++++++++-----------------
 target/ppc/helper.h                 | 20 +++++++++----------
 target/ppc/translate/vsx-impl.inc.c | 38 +++++++++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 44970ebec9..cb593517ae 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2808,10 +2808,9 @@ VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2 * i), VsrD(i), 0)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP_VECTOR(op, nels, stp, ttp, sfld, tfld, sfprf)    \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                       \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                            \
 {                                                                       \
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                         \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
     ppc_vsr_t t = *xt;                                                  \
     int i;                                                              \
                                                                         \
@@ -2975,10 +2974,9 @@ VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), 0U)
  *   rnan  - resulting NaN
  */
 #define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)             \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                               \
 {                                                                            \
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                              \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                              \
     ppc_vsr_t t = { };                                                       \
                                                                              \
     t.tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);      \
@@ -3052,10 +3050,9 @@ VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, VsrW(i), VsrW(i), 0, 0)
  *   tfld  - target vsr_t field
  */
 #define VSX_CVT_INT_TO_FP_VECTOR(op, stp, ttp, sfld, tfld)              \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                          \
 {                                                                       \
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                         \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
     ppc_vsr_t t = *xt;                                                  \
                                                                         \
     t.tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);                 \
@@ -3278,10 +3275,9 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
     env->crf[BF(opcode)] = cc;
 }
 
-void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
+void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
+                   ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t = { };
     uint8_t r = Rrm(opcode);
     uint8_t ex = Rc(opcode);
@@ -3336,10 +3332,9 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
     *xt = t;
 }
 
-void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
+void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t = { };
     uint8_t r = Rrm(opcode);
     uint8_t rmc = RMC(opcode);
@@ -3391,10 +3386,9 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
     do_float_check_status(env, GETPC());
 }
 
-void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
+void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode,
+                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t = { };
     float_status tstat;
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 9134da9cbb..2e0646f5eb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -402,16 +402,16 @@ DEF_HELPER_5(xsmincdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaxjdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsminjdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_3(xscvdphp, void, env, vsr, vsr)
-DEF_HELPER_2(xscvdpqp, void, env, i32)
+DEF_HELPER_4(xscvdpqp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xscvdpsp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_4(xscvqpdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xscvqpsdz, void, env, i32)
-DEF_HELPER_2(xscvqpswz, void, env, i32)
-DEF_HELPER_2(xscvqpudz, void, env, i32)
-DEF_HELPER_2(xscvqpuwz, void, env, i32)
+DEF_HELPER_4(xscvqpsdz, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvqpswz, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvqpudz, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvqpuwz, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xscvhpdp, void, env, vsr, vsr)
-DEF_HELPER_2(xscvsdqp, void, env, i32)
+DEF_HELPER_4(xscvsdqp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xscvspdp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
 DEF_HELPER_3(xscvdpsxds, void, env, vsr, vsr)
@@ -421,7 +421,7 @@ DEF_HELPER_3(xscvdpuxws, void, env, vsr, vsr)
 DEF_HELPER_3(xscvsxddp, void, env, vsr, vsr)
 DEF_HELPER_3(xscvuxdsp, void, env, vsr, vsr)
 DEF_HELPER_3(xscvsxdsp, void, env, vsr, vsr)
-DEF_HELPER_2(xscvudqp, void, env, i32)
+DEF_HELPER_4(xscvudqp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xscvuxddp, void, env, vsr, vsr)
 DEF_HELPER_3(xststdcsp, void, env, i32, vsr)
 DEF_HELPER_2(xststdcdp, void, env, i32)
@@ -431,9 +431,9 @@ DEF_HELPER_3(xsrdpic, void, env, vsr, vsr)
 DEF_HELPER_3(xsrdpim, void, env, vsr, vsr)
 DEF_HELPER_3(xsrdpip, void, env, vsr, vsr)
 DEF_HELPER_3(xsrdpiz, void, env, vsr, vsr)
-DEF_HELPER_2(xsrqpi, void, env, i32)
-DEF_HELPER_2(xsrqpxp, void, env, i32)
-DEF_HELPER_2(xssqrtqp, void, env, i32)
+DEF_HELPER_4(xsrqpi, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrqpxp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xssqrtqp, void, env, i32, vsr, vsr)
 DEF_HELPER_5(xssubqp, void, env, i32, vsr, vsr, vsr)
 
 DEF_HELPER_4(xsaddsp, void, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8380651a8d..05db509a0c 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1115,6 +1115,24 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_R2(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xt, xb;                                                          \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xt = gen_vsr_ptr(rD(ctx->opcode) + 32);                                   \
+    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
+    gen_helper_##name(cpu_env, opc, xt, xb);                                  \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1171,14 +1189,14 @@ GEN_VSX_HELPER_R3(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvqpuwz, 0x04, 0x1A, 0x01, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvqpuwz, 0x04, 0x1A, 0x01, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvsdqp, 0x04, 0x1A, 0x0A, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvsdqp, 0x04, 0x1A, 0x0A, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvdpsxds, 0x10, 0x15, 0, PPC2_VSX)
@@ -1186,7 +1204,7 @@ GEN_VSX_HELPER_X2(xscvdpsxws, 0x10, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xscvdpuxds, 0x10, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xscvdpuxws, 0x10, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xscvsxddp, 0x10, 0x17, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvudqp, 0x04, 0x1A, 0x02, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xscvudqp, 0x04, 0x1A, 0x02, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvuxddp, 0x10, 0x16, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpi, 0x12, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpic, 0x16, 0x06, 0, PPC2_VSX)
@@ -1195,9 +1213,9 @@ GEN_VSX_HELPER_X2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 
-GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
-- 
2.11.0


