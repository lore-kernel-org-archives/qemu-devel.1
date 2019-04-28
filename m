Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69538C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2981620645
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2981620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKl8N-0002yL-97
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:50:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0v-00063O-N2
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0t-00057X-Ow
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:45 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52928
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKl0t-0004cE-II; Sun, 28 Apr 2019 10:42:43 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxJ-0005tp-2i; Sun, 28 Apr 2019 15:39:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:39 +0100
Message-Id: <20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 08/14] target/ppc: introduce GEN_VSX_HELPER_R3
 macro to fpu_helper.c
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428143839.tgYybcR1xygCm0LTGjk69eonuxm4GHPvulMdeD3k0qU@z>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X3 macro which performs the decode based
upon rD, rA and rB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             | 36 ++++++++++++------------------------
 target/ppc/helper.h                 | 16 ++++++++--------
 target/ppc/translate/vsx-impl.inc.c | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b4bc229b5..4e97093186 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1840,11 +1840,9 @@ VSX_ADD_SUB(xssubsp, sub, 1, float64, VsrD(0), 1, 1)
 VSX_ADD_SUB(xvsubdp, sub, 2, float64, VsrD(i), 0, 0)
 VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
     helper_reset_fpstatus(env);
@@ -1914,11 +1912,9 @@ VSX_MUL(xsmulsp, 1, float64, VsrD(0), 1, 1)
 VSX_MUL(xvmuldp, 2, float64, VsrD(i), 0, 0)
 VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
     helper_reset_fpstatus(env);
@@ -1989,11 +1985,9 @@ VSX_DIV(xsdivsp, 1, float64, VsrD(0), 1, 1)
 VSX_DIV(xvdivdp, 2, float64, VsrD(i), 0, 0)
 VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
     helper_reset_fpstatus(env);
@@ -2600,11 +2594,9 @@ VSX_MAX_MIN(xvmindp, minnum, 2, float64, VsrD(i))
 VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
 
 #define VSX_MAX_MINC(name, max)                                               \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                         \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)               \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                               \
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                               \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                               \
     ppc_vsr_t r;                                                              \
     bool vxsnan_flag = false, vex_flag = false;                               \
                                                                               \
@@ -2637,11 +2629,9 @@ VSX_MAX_MINC(xsmaxcdp, 1);
 VSX_MAX_MINC(xsmincdp, 0);
 
 #define VSX_MAX_MINJ(name, max)                                               \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                         \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)               \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                               \
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                               \
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                               \
     ppc_vsr_t r;                                                              \
     bool vxsnan_flag = false, vex_flag = false;                               \
                                                                               \
@@ -3405,11 +3395,9 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
     do_float_check_status(env, GETPC());
 }
 
-void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
+void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
     helper_reset_fpstatus(env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cb6b7a55c1..8ed35f91da 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -378,12 +378,12 @@ DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
 
 DEF_HELPER_5(xsadddp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xsaddqp, void, env, i32)
+DEF_HELPER_5(xsaddqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xssubdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmuldp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xsmulqp, void, env, i32)
+DEF_HELPER_5(xsmulqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsdivdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xsdivqp, void, env, i32)
+DEF_HELPER_5(xsdivqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xsredp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xssqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrsqrtedp, void, env, i32, vsr, vsr)
@@ -409,10 +409,10 @@ DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_5(xsmaxdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmindp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xsmaxcdp, void, env, i32)
-DEF_HELPER_2(xsmincdp, void, env, i32)
-DEF_HELPER_2(xsmaxjdp, void, env, i32)
-DEF_HELPER_2(xsminjdp, void, env, i32)
+DEF_HELPER_5(xsmaxcdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmincdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmaxjdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsminjdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xscvdphp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_4(xscvdpsp, void, env, i32, vsr, vsr)
@@ -446,7 +446,7 @@ DEF_HELPER_4(xsrdpiz, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
-DEF_HELPER_2(xssubqp, void, env, i32)
+DEF_HELPER_5(xssubqp, void, env, i32, vsr, vsr, vsr)
 
 DEF_HELPER_5(xsaddsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xssubsp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index a30e22a852..d30682cd4f 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1003,6 +1003,26 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_R3(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xt, xa, xb;                                                      \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xt = gen_vsr_ptr(rD(ctx->opcode) + 32);                                   \
+    xa = gen_vsr_ptr(rA(ctx->opcode) + 32);                                   \
+    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
+    gen_helper_##name(cpu_env, opc, xt, xa, xb);                              \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1022,12 +1042,12 @@ static void gen_##name(DisasContext *ctx)                     \
 }
 
 GEN_VSX_HELPER_X3(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
@@ -1053,10 +1073,10 @@ GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
@@ -1087,7 +1107,7 @@ GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
-GEN_VSX_HELPER_2(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
-- 
2.11.0


