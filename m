Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB8C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F195E20866
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F195E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUsx-0005MW-2Y
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUon-0003Mr-PW
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUol-0004Rt-V4
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:33 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46534
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUok-0004Qw-1z; Sun, 16 Jun 2019 09:03:30 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQ5-0001jp-7L; Sun, 16 Jun 2019 13:38:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:48 +0100
Message-Id: <20190616123751.781-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 12/15] target/ppc: introduce
 GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
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
introduce a new GEN_VSX_HELPER_R2_AB macro which performs the decode based
upon rA and rB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c             | 10 ++++------
 target/ppc/helper.h                 |  6 +++---
 target/ppc/translate/vsx-impl.inc.c | 24 +++++++++++++++++++++---
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index cb593517ae..f0a897cb9a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2452,10 +2452,9 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
     do_float_check_status(env, GETPC());
 }
 
-void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
+void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode,
+                       ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     int64_t exp_a, exp_b;
     uint32_t cc;
 
@@ -2531,10 +2530,9 @@ VSX_SCALAR_CMP(xscmpodp, 1)
 VSX_SCALAR_CMP(xscmpudp, 0)
 
 #define VSX_SCALAR_CMPQ(op, ordered)                                    \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          \
 {                                                                       \
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                         \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
     uint32_t cc = 0;                                                    \
     bool vxsnan_flag = false, vxvc_flag = false;                        \
                                                                         \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2e0646f5eb..a5e12a3933 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -390,11 +390,11 @@ DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpnedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpexpdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xscmpexpqp, void, env, i32)
+DEF_HELPER_4(xscmpexpqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xscmpoqp, void, env, i32)
-DEF_HELPER_2(xscmpuqp, void, env, i32)
+DEF_HELPER_4(xscmpoqp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscmpuqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmindp, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaxcdp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 05db509a0c..5cf053e7f2 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1133,6 +1133,24 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_R2_AB(name, op1, op2, inval, type)                     \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xa, xb;                                                          \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xa = gen_vsr_ptr(rA(ctx->opcode) + 32);                                   \
+    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
+    gen_helper_##name(cpu_env, opc, xa, xb);                                  \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1176,11 +1194,11 @@ GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2_AB(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R2_AB(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_R2_AB(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_R2_AB(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_R3(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
-- 
2.11.0


