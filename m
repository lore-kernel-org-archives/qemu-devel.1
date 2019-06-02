Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42CC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570D5278D7
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570D5278D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXORU-0004Se-B7
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:14:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPc-0003LM-V5
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPb-0003Wu-Oi
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:28 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51390
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOPb-0002iJ-Is; Sun, 02 Jun 2019 07:12:27 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLf-0008A4-0O; Sun, 02 Jun 2019 12:08:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:08:54 +0100
Message-Id: <20190602110903.3431-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 06/15] target/ppc: introduce separate
 generator and helper for xscvqpdp
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
introduce a new generator and helper function which perform the decode based
upon xT and xB at translation time.

The xscvqpdp helper is the only 2 parameter xT/xB implementation that requires
the opcode to be passed as an additional parameter, so handling this separately
allows us to optimise the conversion in the next commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  5 ++---
 target/ppc/helper.h                 |  2 +-
 target/ppc/translate/vsx-impl.inc.c | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 386db30681..a6556781e1 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2899,10 +2899,9 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
  * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
  * added to this later.
  */
-void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
+                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     ppc_vsr_t t = { };
     float_status tstat;
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f6a97cedc6..5d15166988 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -405,7 +405,7 @@ DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
-DEF_HELPER_2(xscvqpdp, void, env, i32)
+DEF_HELPER_4(xscvqpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvqpudz, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 0befbb508f..eac8c8937b 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -998,6 +998,23 @@ VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
 VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
 VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
 
+static void gen_xscvqpdp(DisasContext *ctx)
+{
+    TCGv_i32 opc;
+    TCGv_ptr xt, xb;
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    opc = tcg_const_i32(ctx->opcode);
+    xt = gen_vsr_ptr(xT(ctx->opcode));
+    xb = gen_vsr_ptr(xB(ctx->opcode));
+    gen_helper_xscvqpdp(cpu_env, opc, xt, xb);
+    tcg_temp_free_i32(opc);
+    tcg_temp_free_ptr(xt);
+    tcg_temp_free_ptr(xb);
+}
+
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                         \
 static void gen_##name(DisasContext *ctx)                                     \
 {                                                                             \
@@ -1086,7 +1103,6 @@ GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
-- 
2.11.0


