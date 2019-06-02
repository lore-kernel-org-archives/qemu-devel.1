Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6CBC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2100424DA4
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100424DA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXOUV-00073q-Bx
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:17:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPh-0003NO-On
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPf-0003bj-OV
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:33 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51410
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOPf-0002mJ-Hy; Sun, 02 Jun 2019 07:12:31 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLh-0008A4-2d; Sun, 02 Jun 2019 12:08:25 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:08:57 +0100
Message-Id: <20190602110903.3431-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 09/15] target/ppc: introduce
 GEN_VSX_HELPER_X1 macro to fpu_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X1 macro which performs the decode based
upon xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  6 ++----
 target/ppc/helper.h                 |  8 ++++----
 target/ppc/translate/vsx-impl.inc.c | 24 ++++++++++++++++++++----
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 628621d1b2..953d57d34e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2236,9 +2236,8 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, 23)
  *   nbits - number of fraction bits
  */
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)      \
 {                                                                       \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
@@ -3258,9 +3257,8 @@ VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX, 0)
 VSX_TEST_DC(xststdcdp, 1, xB(opcode), float64, VsrD(0), VsrD(0), 0, 1)
 VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0, 1)
 
-void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
+void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     uint32_t dcmx, sign, exp;
     uint32_t cc, match = 0, not_sp = 0;
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 0ab1ef2aee..a8886c56ad 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -376,7 +376,7 @@ DEF_HELPER_3(xsredp, void, env, vsr, vsr)
 DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xstsqrtdp, void, env, i32)
+DEF_HELPER_3(xstsqrtdp, void, env, i32, vsr)
 DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmaddmdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmsubadp, void, env, vsr, vsr, vsr)
@@ -423,7 +423,7 @@ DEF_HELPER_3(xscvuxdsp, void, env, vsr, vsr)
 DEF_HELPER_3(xscvsxdsp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvudqp, void, env, i32)
 DEF_HELPER_3(xscvuxddp, void, env, vsr, vsr)
-DEF_HELPER_2(xststdcsp, void, env, i32)
+DEF_HELPER_3(xststdcsp, void, env, i32, vsr)
 DEF_HELPER_2(xststdcdp, void, env, i32)
 DEF_HELPER_2(xststdcqp, void, env, i32)
 DEF_HELPER_3(xsrdpi, void, env, vsr, vsr)
@@ -461,7 +461,7 @@ DEF_HELPER_3(xvredp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtsqrtdp, void, env, i32)
+DEF_HELPER_3(xvtsqrtdp, void, env, i32, vsr)
 DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmsubadp, void, env, vsr, vsr, vsr)
@@ -499,7 +499,7 @@ DEF_HELPER_3(xvresp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
 DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtsqrtsp, void, env, i32)
+DEF_HELPER_3(xvtsqrtsp, void, env, i32, vsr)
 DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmsubasp, void, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index d8e9b80d4a..e4831700bf 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1078,6 +1078,22 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_X1(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xb;                                                              \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xb);                                      \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1107,7 +1123,7 @@ GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
@@ -1180,7 +1196,7 @@ GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
 
@@ -1192,7 +1208,7 @@ GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
@@ -1226,7 +1242,7 @@ GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-- 
2.11.0


