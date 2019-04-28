Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694120645
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45009 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKl5m-0001OS-79
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:47:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0t-00060q-7C
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0r-00056G-Li
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:43 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52920
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKl0r-0004ba-G6; Sun, 28 Apr 2019 10:42:41 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxI-0005tp-0K; Sun, 28 Apr 2019 15:39:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:37 +0100
Message-Id: <20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 06/14] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
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
Message-ID: <20190428143837.a2iCAR-0-f2xA3XRC63jrmd8o_OT4P74IK2zJ1loaeU@z>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
upon xA and xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             | 15 ++++++---------
 target/ppc/helper.h                 | 12 ++++++------
 target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 05099e1291..a2ff71e379 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2164,10 +2164,9 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
  *   nbits - number of fraction bits
  */
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          \
 {                                                                       \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                              \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
@@ -2413,10 +2412,9 @@ VSX_SCALAR_CMP_DP(xscmpgedp, le, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpgtdp, lt, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
 
-void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
+                       ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     int64_t exp_a, exp_b;
     uint32_t cc;
 
@@ -2474,10 +2472,9 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
 }
 
 #define VSX_SCALAR_CMP(op, ordered)                                      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                      \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                           \
 {                                                                        \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                               \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                               \
     uint32_t cc = 0;                                                     \
     bool vxsnan_flag = false, vxvc_flag = false;                         \
                                                                          \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c957c53755..9c236f016e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -387,7 +387,7 @@ DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_4(xsredp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xssqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrsqrtedp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xstdivdp, void, env, i32)
+DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
 DEF_HELPER_5(xsmaddadp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaddmdp, void, env, i32, vsr, vsr, vsr)
@@ -401,10 +401,10 @@ DEF_HELPER_5(xscmpeqdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpgtdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpgedp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpnedp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xscmpexpdp, void, env, i32)
+DEF_HELPER_4(xscmpexpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
-DEF_HELPER_2(xscmpodp, void, env, i32)
-DEF_HELPER_2(xscmpudp, void, env, i32)
+DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_5(xsmaxdp, void, env, i32, vsr, vsr, vsr)
@@ -472,7 +472,7 @@ DEF_HELPER_5(xvdivdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xvredp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvsqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtedp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtdivdp, void, env, i32)
+DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
 DEF_HELPER_5(xvmaddadp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaddmdp, void, env, i32, vsr, vsr, vsr)
@@ -510,7 +510,7 @@ DEF_HELPER_5(xvdivsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xvresp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvsqrtsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtesp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtdivsp, void, env, i32)
+DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
 DEF_HELPER_5(xvmaddasp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaddmsp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7f719e9172..fed56fce69 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -969,6 +969,24 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_X2_AB(name, op1, op2, inval, type)                     \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xa, xb;                                                          \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xa, xb);                                  \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -997,7 +1015,7 @@ GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
@@ -1011,10 +1029,10 @@ GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2_AB(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
@@ -1083,7 +1101,7 @@ GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
@@ -1121,7 +1139,7 @@ GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-- 
2.11.0


