Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B72C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1B5206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1B5206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlCE-0005tf-AP
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:54:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0v-00062u-6b
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0r-00056b-Qq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:45 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52910
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKl0r-0004bc-HW; Sun, 28 Apr 2019 10:42:41 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxG-0005tp-V6; Sun, 28 Apr 2019 15:38:59 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:36 +0100
Message-Id: <20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 05/14] target/ppc: introduce GEN_VSX_HELPER_X2
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
Message-ID: <20190428143836.m8QMIVeOx89fvDrR39_YWUfkc2vWGp3WAdAI-lgjTm4@z>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X2 macro which performs the decode based
upon xT and xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  50 ++++++-------
 target/ppc/helper.h                 | 122 +++++++++++++++----------------
 target/ppc/translate/vsx-impl.inc.c | 140 ++++++++++++++++++++----------------
 3 files changed, 160 insertions(+), 152 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 39c4f4cfb0..05099e1291 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2028,10 +2028,9 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
  *   sfprf - set FPRF
  */
 #define VSX_RE(op, nels, tp, fld, sfprf, r2sp)                                \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                                \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
     helper_reset_fpstatus(env);                                               \
@@ -2068,10 +2067,9 @@ VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_SQRT(op, nels, tp, fld, sfprf, r2sp)                             \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                               \
 {                                                                            \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
     helper_reset_fpstatus(env);                                              \
@@ -2116,10 +2114,9 @@ VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_RSQRTE(op, nels, tp, fld, sfprf, r2sp)                           \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                               \
 {                                                                            \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
     helper_reset_fpstatus(env);                                              \
@@ -2767,10 +2764,9 @@ VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf)    \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                     \
 {                                                                  \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                         \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                         \
     int i;                                                         \
                                                                    \
     for (i = 0; i < nels; i++) {                                   \
@@ -2839,10 +2835,9 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfprf) \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                     \
 {                                                                  \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                         \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                         \
     int i;                                                         \
                                                                    \
     memset(xt, 0, sizeof(ppc_vsr_t));                              \
@@ -2871,10 +2866,9 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
  * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
  * added to this later.
  */
-void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
+                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     float_status tstat;
 
     memset(xt, 0, sizeof(ppc_vsr_t));
@@ -2922,11 +2916,10 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
  *   rnan  - resulting NaN
  */
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, rnan)              \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                               \
 {                                                                            \
     int all_flags = env->fp_status.float_exception_flags, flags;             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
@@ -3009,10 +3002,9 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint32, f128, VsrD(0), 0x0ULL)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_INT_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf, r2sp)  \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                          \
 {                                                                       \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                              \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
                                                                         \
     for (i = 0; i < nels; i++) {                                        \
@@ -3081,10 +3073,9 @@ VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float128, VsrD(0), f128)
  *   sfprf - set FPRF
  */
 #define VSX_ROUND(op, nels, tp, fld, rmode, sfprf)                     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                    \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)                         \
 {                                                                      \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                             \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                             \
     int i;                                                             \
                                                                        \
     if (rmode != FLOAT_ROUND_CURRENT) {                                \
@@ -3165,10 +3156,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                   \
 VSX_XXPERM(xxperm, 0)
 VSX_XXPERM(xxpermr, 1)
 
-void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
+void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode,
+                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     uint32_t exp, i, fraction;
 
     memset(xt, 0, sizeof(ppc_vsr_t));
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e2f9010ae0..c957c53755 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -384,9 +384,9 @@ DEF_HELPER_5(xsmuldp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsmulqp, void, env, i32)
 DEF_HELPER_5(xsdivdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsdivqp, void, env, i32)
-DEF_HELPER_2(xsredp, void, env, i32)
-DEF_HELPER_2(xssqrtdp, void, env, i32)
-DEF_HELPER_2(xsrsqrtedp, void, env, i32)
+DEF_HELPER_4(xsredp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xssqrtdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xstdivdp, void, env, i32)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
 DEF_HELPER_5(xsmaddadp, void, env, i32, vsr, vsr, vsr)
@@ -413,36 +413,36 @@ DEF_HELPER_2(xsmaxcdp, void, env, i32)
 DEF_HELPER_2(xsmincdp, void, env, i32)
 DEF_HELPER_2(xsmaxjdp, void, env, i32)
 DEF_HELPER_2(xsminjdp, void, env, i32)
-DEF_HELPER_2(xscvdphp, void, env, i32)
+DEF_HELPER_4(xscvdphp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
-DEF_HELPER_2(xscvdpsp, void, env, i32)
+DEF_HELPER_4(xscvdpsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
-DEF_HELPER_2(xscvqpdp, void, env, i32)
+DEF_HELPER_4(xscvqpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvqpudz, void, env, i32)
 DEF_HELPER_2(xscvqpuwz, void, env, i32)
-DEF_HELPER_2(xscvhpdp, void, env, i32)
+DEF_HELPER_4(xscvhpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvsdqp, void, env, i32)
-DEF_HELPER_2(xscvspdp, void, env, i32)
+DEF_HELPER_4(xscvspdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
-DEF_HELPER_2(xscvdpsxds, void, env, i32)
-DEF_HELPER_2(xscvdpsxws, void, env, i32)
-DEF_HELPER_2(xscvdpuxds, void, env, i32)
-DEF_HELPER_2(xscvdpuxws, void, env, i32)
-DEF_HELPER_2(xscvsxddp, void, env, i32)
-DEF_HELPER_2(xscvuxdsp, void, env, i32)
-DEF_HELPER_2(xscvsxdsp, void, env, i32)
+DEF_HELPER_4(xscvdpsxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvdpsxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvdpuxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvdpuxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvsxddp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvuxdsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscvsxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvudqp, void, env, i32)
-DEF_HELPER_2(xscvuxddp, void, env, i32)
+DEF_HELPER_4(xscvuxddp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xststdcsp, void, env, i32)
 DEF_HELPER_2(xststdcdp, void, env, i32)
 DEF_HELPER_2(xststdcqp, void, env, i32)
-DEF_HELPER_2(xsrdpi, void, env, i32)
-DEF_HELPER_2(xsrdpic, void, env, i32)
-DEF_HELPER_2(xsrdpim, void, env, i32)
-DEF_HELPER_2(xsrdpip, void, env, i32)
-DEF_HELPER_2(xsrdpiz, void, env, i32)
+DEF_HELPER_4(xsrdpi, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrdpic, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrdpim, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrdpip, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrdpiz, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
@@ -452,10 +452,10 @@ DEF_HELPER_5(xsaddsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xssubsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmulsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsdivsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xsresp, void, env, i32)
+DEF_HELPER_4(xsresp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xsrsp, i64, env, i64)
-DEF_HELPER_2(xssqrtsp, void, env, i32)
-DEF_HELPER_2(xsrsqrtesp, void, env, i32)
+DEF_HELPER_4(xssqrtsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xsrsqrtesp, void, env, i32, vsr, vsr)
 DEF_HELPER_5(xsmaddasp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaddmsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmsubasp, void, env, i32, vsr, vsr, vsr)
@@ -469,9 +469,9 @@ DEF_HELPER_5(xvadddp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvsubdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmuldp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvdivdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xvredp, void, env, i32)
-DEF_HELPER_2(xvsqrtdp, void, env, i32)
-DEF_HELPER_2(xvrsqrtedp, void, env, i32)
+DEF_HELPER_4(xvredp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvsqrtdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtdivdp, void, env, i32)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
 DEF_HELPER_5(xvmaddadp, void, env, i32, vsr, vsr, vsr)
@@ -488,28 +488,28 @@ DEF_HELPER_5(xvcmpeqdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpgedp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpgtdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpnedp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xvcvdpsp, void, env, i32)
-DEF_HELPER_2(xvcvdpsxds, void, env, i32)
-DEF_HELPER_2(xvcvdpsxws, void, env, i32)
-DEF_HELPER_2(xvcvdpuxds, void, env, i32)
-DEF_HELPER_2(xvcvdpuxws, void, env, i32)
-DEF_HELPER_2(xvcvsxddp, void, env, i32)
-DEF_HELPER_2(xvcvuxddp, void, env, i32)
-DEF_HELPER_2(xvcvsxwdp, void, env, i32)
-DEF_HELPER_2(xvcvuxwdp, void, env, i32)
-DEF_HELPER_2(xvrdpi, void, env, i32)
-DEF_HELPER_2(xvrdpic, void, env, i32)
-DEF_HELPER_2(xvrdpim, void, env, i32)
-DEF_HELPER_2(xvrdpip, void, env, i32)
-DEF_HELPER_2(xvrdpiz, void, env, i32)
+DEF_HELPER_4(xvcvdpsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvdpsxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvdpsxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvdpuxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvdpuxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvsxddp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvuxddp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvsxwdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvuxwdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrdpi, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrdpic, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrdpim, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrdpip, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrdpiz, void, env, i32, vsr, vsr)
 
 DEF_HELPER_5(xvaddsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvsubsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmulsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvdivsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xvresp, void, env, i32)
-DEF_HELPER_2(xvsqrtsp, void, env, i32)
-DEF_HELPER_2(xvrsqrtesp, void, env, i32)
+DEF_HELPER_4(xvresp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvsqrtsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrsqrtesp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtdivsp, void, env, i32)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
 DEF_HELPER_5(xvmaddasp, void, env, i32, vsr, vsr, vsr)
@@ -526,29 +526,29 @@ DEF_HELPER_5(xvcmpeqsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpgesp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpgtsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpnesp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_2(xvcvspdp, void, env, i32)
-DEF_HELPER_2(xvcvsphp, void, env, i32)
-DEF_HELPER_2(xvcvhpsp, void, env, i32)
-DEF_HELPER_2(xvcvspsxds, void, env, i32)
-DEF_HELPER_2(xvcvspsxws, void, env, i32)
-DEF_HELPER_2(xvcvspuxds, void, env, i32)
-DEF_HELPER_2(xvcvspuxws, void, env, i32)
-DEF_HELPER_2(xvcvsxdsp, void, env, i32)
-DEF_HELPER_2(xvcvuxdsp, void, env, i32)
-DEF_HELPER_2(xvcvsxwsp, void, env, i32)
-DEF_HELPER_2(xvcvuxwsp, void, env, i32)
+DEF_HELPER_4(xvcvspdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvsphp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvhpsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvspsxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvspsxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvspuxds, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvspuxws, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvsxdsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvuxdsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvsxwsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvcvuxwsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtstdcsp, void, env, i32)
 DEF_HELPER_2(xvtstdcdp, void, env, i32)
-DEF_HELPER_2(xvrspi, void, env, i32)
-DEF_HELPER_2(xvrspic, void, env, i32)
-DEF_HELPER_2(xvrspim, void, env, i32)
-DEF_HELPER_2(xvrspip, void, env, i32)
-DEF_HELPER_2(xvrspiz, void, env, i32)
+DEF_HELPER_4(xvrspi, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrspic, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrspim, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrspip, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvrspiz, void, env, i32, vsr, vsr)
 DEF_HELPER_5(xxperm, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xxpermr, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
-DEF_HELPER_2(xvxsigsp, void, env, i32)
+DEF_HELPER_4(xvxsigsp, void, env, i32, vsr, vsr)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 083dfa515c..7f719e9172 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -951,6 +951,24 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xt, xb;                                                          \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xt, xb);                                  \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -976,9 +994,9 @@ GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
@@ -1005,31 +1023,31 @@ GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpuwz, 0x04, 0x1A, 0x01, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvsdqp, 0x04, 0x1A, 0x0A, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvdpsxds, 0x10, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvdpsxws, 0x10, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvdpuxds, 0x10, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvdpuxws, 0x10, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscvsxddp, 0x10, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdpsxds, 0x10, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdpsxws, 0x10, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdpuxds, 0x10, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdpuxws, 0x10, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvsxddp, 0x10, 0x17, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvudqp, 0x04, 0x1A, 0x02, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvuxddp, 0x10, 0x16, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrdpi, 0x12, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrdpic, 0x16, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrdpim, 0x12, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvuxddp, 0x10, 0x16, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrdpi, 0x12, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrdpic, 0x16, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrdpim, 0x12, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
@@ -1041,9 +1059,9 @@ GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
@@ -1052,8 +1070,8 @@ GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
@@ -1062,9 +1080,9 @@ GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
@@ -1081,28 +1099,28 @@ GEN_VSX_HELPER_X3(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvdpuxds, 0x10, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvdpuxws, 0x10, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvsxddp, 0x10, 0x1F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvuxddp, 0x10, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvsxwdp, 0x10, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvuxwdp, 0x10, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrdpi, 0x12, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrdpic, 0x16, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrdpim, 0x12, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrdpip, 0x12, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrdpiz, 0x12, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvdpuxds, 0x10, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvdpuxws, 0x10, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvsxddp, 0x10, 0x1F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvuxddp, 0x10, 0x1E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvsxwdp, 0x10, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvuxwdp, 0x10, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrdpi, 0x12, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrdpic, 0x16, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrdpim, 0x12, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrdpip, 0x12, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrdpiz, 0x12, 0x0D, 0, PPC2_VSX)
 
 GEN_VSX_HELPER_X3(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
@@ -1119,22 +1137,22 @@ GEN_VSX_HELPER_X3(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
-GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
-GEN_VSX_HELPER_2(xvcvspsxds, 0x10, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvspsxws, 0x10, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvspuxds, 0x10, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvspuxws, 0x10, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvsxdsp, 0x10, 0x1B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvuxdsp, 0x10, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvsxwsp, 0x10, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcvuxwsp, 0x10, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrspi, 0x12, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xvcvspsxds, 0x10, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvspsxws, 0x10, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvspuxds, 0x10, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvspuxws, 0x10, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvsxdsp, 0x10, 0x1B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvuxdsp, 0x10, 0x1A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvsxwsp, 0x10, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvcvuxwsp, 0x10, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrspi, 0x12, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
@@ -1813,7 +1831,7 @@ static void gen_xvxexpdp(DisasContext *ctx)
     tcg_temp_free_i64(xbl);
 }
 
-GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
 
 static void gen_xvxsigdp(DisasContext *ctx)
 {
-- 
2.11.0


