Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6637C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDBE278FE
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDBE278FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXOxh-0008KS-Kj
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOtK-0004pU-CB
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOj9-0005e7-4t
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:32:41 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51506
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOj8-0005cv-SJ; Sun, 02 Jun 2019 07:32:39 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLl-0008A4-WB; Sun, 02 Jun 2019 12:08:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:09:03 +0100
Message-Id: <20190602110903.3431-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 15/15] target/ppc: improve VSX_FMADD with
 new GEN_VSX_HELPER_VSX_MADD macro
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

Introduce a new GEN_VSX_HELPER_VSX_MADD macro for the generator function which
enables the source and destination registers to be decoded at translation time.

This enables the determination of a or m form to be made at translation time so
that a single helper function can now be used for both variants.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             | 68 ++++++++++---------------------
 target/ppc/helper.h                 | 48 ++++++++--------------
 target/ppc/translate/vsx-impl.inc.c | 81 +++++++++++++++++++++----------------
 target/ppc/translate/vsx-ops.inc.c  | 70 +++++++++++++++++---------------
 4 files changed, 122 insertions(+), 145 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 350505e420..f13855d324 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2280,24 +2280,15 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  *   maddflgs - flags for the float*muladd routine that control the
  *           various forms (madd, msub, nmadd, nmsub)
- *   afrm  - A form (1=A, 0=M)
  *   sfprf - set FPRF
  */
-#define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
+#define VSX_MADD(op, nels, tp, fld, maddflgs, sfprf, r2sp)                    \
 void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
-                 ppc_vsr_t *xa, ppc_vsr_t *xb)                                \
+                 ppc_vsr_t *xa, ppc_vsr_t *b, ppc_vsr_t *c)                   \
 {                                                                             \
-    ppc_vsr_t t = *xt, *b, *c;                                                \
+    ppc_vsr_t t = *xt;                                                        \
     int i;                                                                    \
                                                                               \
-    if (afrm) { /* AxB + T */                                                 \
-        b = xb;                                                               \
-        c = xt;                                                               \
-    } else { /* AxT + B */                                                    \
-        b = xt;                                                               \
-        c = xb;                                                               \
-    }                                                                         \
-                                                                              \
     helper_reset_fpstatus(env);                                               \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
@@ -2336,41 +2327,24 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
     do_float_check_status(env, GETPC());                                      \
 }
 
-VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
-VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
-VSX_MADD(xsmsubadp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1, 0)
-VSX_MADD(xsmsubmdp, 1, float64, VsrD(0), MSUB_FLGS, 0, 1, 0)
-VSX_MADD(xsnmaddadp, 1, float64, VsrD(0), NMADD_FLGS, 1, 1, 0)
-VSX_MADD(xsnmaddmdp, 1, float64, VsrD(0), NMADD_FLGS, 0, 1, 0)
-VSX_MADD(xsnmsubadp, 1, float64, VsrD(0), NMSUB_FLGS, 1, 1, 0)
-VSX_MADD(xsnmsubmdp, 1, float64, VsrD(0), NMSUB_FLGS, 0, 1, 0)
-
-VSX_MADD(xsmaddasp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 1)
-VSX_MADD(xsmaddmsp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 1)
-VSX_MADD(xsmsubasp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1, 1)
-VSX_MADD(xsmsubmsp, 1, float64, VsrD(0), MSUB_FLGS, 0, 1, 1)
-VSX_MADD(xsnmaddasp, 1, float64, VsrD(0), NMADD_FLGS, 1, 1, 1)
-VSX_MADD(xsnmaddmsp, 1, float64, VsrD(0), NMADD_FLGS, 0, 1, 1)
-VSX_MADD(xsnmsubasp, 1, float64, VsrD(0), NMSUB_FLGS, 1, 1, 1)
-VSX_MADD(xsnmsubmsp, 1, float64, VsrD(0), NMSUB_FLGS, 0, 1, 1)
-
-VSX_MADD(xvmaddadp, 2, float64, VsrD(i), MADD_FLGS, 1, 0, 0)
-VSX_MADD(xvmaddmdp, 2, float64, VsrD(i), MADD_FLGS, 0, 0, 0)
-VSX_MADD(xvmsubadp, 2, float64, VsrD(i), MSUB_FLGS, 1, 0, 0)
-VSX_MADD(xvmsubmdp, 2, float64, VsrD(i), MSUB_FLGS, 0, 0, 0)
-VSX_MADD(xvnmaddadp, 2, float64, VsrD(i), NMADD_FLGS, 1, 0, 0)
-VSX_MADD(xvnmaddmdp, 2, float64, VsrD(i), NMADD_FLGS, 0, 0, 0)
-VSX_MADD(xvnmsubadp, 2, float64, VsrD(i), NMSUB_FLGS, 1, 0, 0)
-VSX_MADD(xvnmsubmdp, 2, float64, VsrD(i), NMSUB_FLGS, 0, 0, 0)
-
-VSX_MADD(xvmaddasp, 4, float32, VsrW(i), MADD_FLGS, 1, 0, 0)
-VSX_MADD(xvmaddmsp, 4, float32, VsrW(i), MADD_FLGS, 0, 0, 0)
-VSX_MADD(xvmsubasp, 4, float32, VsrW(i), MSUB_FLGS, 1, 0, 0)
-VSX_MADD(xvmsubmsp, 4, float32, VsrW(i), MSUB_FLGS, 0, 0, 0)
-VSX_MADD(xvnmaddasp, 4, float32, VsrW(i), NMADD_FLGS, 1, 0, 0)
-VSX_MADD(xvnmaddmsp, 4, float32, VsrW(i), NMADD_FLGS, 0, 0, 0)
-VSX_MADD(xvnmsubasp, 4, float32, VsrW(i), NMSUB_FLGS, 1, 0, 0)
-VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0, 0)
+VSX_MADD(xsmadddp, 1, float64, VsrD(0), MADD_FLGS, 1, 0)
+VSX_MADD(xsmsubdp, 1, float64, VsrD(0), MSUB_FLGS, 1, 0)
+VSX_MADD(xsnmadddp, 1, float64, VsrD(0), NMADD_FLGS, 1, 0)
+VSX_MADD(xsnmsubdp, 1, float64, VsrD(0), NMSUB_FLGS, 1, 0)
+VSX_MADD(xsmaddsp, 1, float64, VsrD(0), MADD_FLGS, 1, 1)
+VSX_MADD(xsmsubsp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1)
+VSX_MADD(xsnmaddsp, 1, float64, VsrD(0), NMADD_FLGS, 1, 1)
+VSX_MADD(xsnmsubsp, 1, float64, VsrD(0), NMSUB_FLGS, 1, 1)
+
+VSX_MADD(xvmadddp, 2, float64, VsrD(i), MADD_FLGS, 0, 0)
+VSX_MADD(xvmsubdp, 2, float64, VsrD(i), MSUB_FLGS, 0, 0)
+VSX_MADD(xvnmadddp, 2, float64, VsrD(i), NMADD_FLGS, 0, 0)
+VSX_MADD(xvnmsubdp, 2, float64, VsrD(i), NMSUB_FLGS, 0, 0)
+
+VSX_MADD(xvmaddsp, 4, float32, VsrW(i), MADD_FLGS, 0, 0)
+VSX_MADD(xvmsubsp, 4, float32, VsrW(i), MSUB_FLGS, 0, 0)
+VSX_MADD(xvnmaddsp, 4, float32, VsrW(i), NMADD_FLGS, 0, 0)
+VSX_MADD(xvnmsubsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0)
 
 /*
  * VSX_SCALAR_CMP_DP - VSX scalar floating point compare double precision
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3d5150a524..380c9b1e2a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -377,14 +377,10 @@ DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xstsqrtdp, void, env, i32, vsr)
-DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmaddmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmsubadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmsubmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmaddadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmaddmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmsubadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_5(xsmadddp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubdp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmadddp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpeqdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
@@ -444,14 +440,10 @@ DEF_HELPER_3(xsresp, void, env, vsr, vsr)
 DEF_HELPER_2(xsrsp, i64, env, i64)
 DEF_HELPER_3(xssqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtesp, void, env, vsr, vsr)
-DEF_HELPER_4(xsmaddasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmaddmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmsubasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmsubmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmaddasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmaddmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmsubasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsnmsubmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_5(xsmaddsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmaddsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubsp, void, env, vsr, vsr, vsr, vsr)
 
 DEF_HELPER_4(xvadddp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvsubdp, void, env, vsr, vsr, vsr)
@@ -462,14 +454,10 @@ DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xvtsqrtdp, void, env, i32, vsr)
-DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmaddmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmsubadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmsubmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmaddadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmaddmdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmsubadp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_5(xvmadddp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubdp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmadddp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaxdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmindp, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
@@ -500,14 +488,10 @@ DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
 DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xvtsqrtsp, void, env, i32, vsr)
-DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmaddmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmsubasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmsubmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmaddasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmaddmsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmsubasp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvnmsubmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_5(xvmaddsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmaddsp, void, env, vsr, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaxsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvminsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index b3bb1746ee..0b9dcfc718 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1181,14 +1181,6 @@ GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
@@ -1230,12 +1222,10 @@ GEN_VSX_HELPER_X2(xsrdpim, 0x12, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
-
 GEN_VSX_HELPER_R2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
-
 GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
@@ -1243,14 +1233,6 @@ GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
@@ -1266,14 +1248,6 @@ GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
@@ -1300,14 +1274,6 @@ GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
@@ -1331,6 +1297,53 @@ GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
+#define GEN_VSX_HELPER_VSX_MADD(name, op1, aop, mop, inval, type)             \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_ptr xt, xa, b, c;                                                    \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    if (ctx->opcode & PPC_BIT(25)) {                                          \
+        /*                                                                    \
+         * AxT + B                                                            \
+         */                                                                   \
+        b = gen_vsr_ptr(xT(ctx->opcode));                                     \
+        c = gen_vsr_ptr(xB(ctx->opcode));                                     \
+    } else {                                                                  \
+        /*                                                                    \
+         * AxB + T                                                            \
+         */                                                                   \
+        b = gen_vsr_ptr(xB(ctx->opcode));                                     \
+        c = gen_vsr_ptr(xT(ctx->opcode));                                     \
+    }                                                                         \
+    gen_helper_##name(cpu_env, xt, xa, b, c);                                 \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(b);                                                     \
+    tcg_temp_free_ptr(c);                                                     \
+}
+
+GEN_VSX_HELPER_VSX_MADD(xsmadddp, 0x04, 0x04, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmsubdp, 0x04, 0x06, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmadddp, 0x04, 0x14, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubdp, 0x04, 0x16, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmaddsp, 0x04, 0x00, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsmsubsp, 0x04, 0x02, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmaddsp, 0x04, 0x10, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubsp, 0x04, 0x12, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xvmadddp, 0x04, 0x0C, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubdp, 0x04, 0x0E, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmadddp, 0x04, 0x1C, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubdp, 0x04, 0x1E, 0x1F, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmaddsp, 0x04, 0x08, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubsp, 0x04, 0x0A, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmaddsp, 0x04, 0x18, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubsp, 0x04, 0x1A, 0x1B, 0, PPC2_VSX)
+
 static void gen_xxbrd(DisasContext *ctx)
 {
     TCGv_i64 xth;
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 5030c4aceb..7fd3942b84 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -63,6 +63,12 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 2, opc3, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 3, opc3, 0, PPC_NONE, fl2)
 
+#define GEN_XX3FORM_NAME(name, opcname, opc2, opc3, fl2)               \
+GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 0, opc3, 0, PPC_NONE, fl2), \
+GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2), \
+GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 2, opc3, 0, PPC_NONE, fl2), \
+GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 3, opc3, 0, PPC_NONE, fl2)
+
 #define GEN_XX2IFORM(name, opc2, opc3, fl2)                           \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 1, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 1, PPC_NONE, fl2), \
@@ -182,14 +188,14 @@ GEN_XX2FORM(xssqrtdp,  0x16, 0x04, PPC2_VSX),
 GEN_XX2FORM(xsrsqrtedp,  0x14, 0x04, PPC2_VSX),
 GEN_XX3FORM(xstdivdp,  0x14, 0x07, PPC2_VSX),
 GEN_XX2FORM(xstsqrtdp,  0x14, 0x06, PPC2_VSX),
-GEN_XX3FORM(xsmaddadp, 0x04, 0x04, PPC2_VSX),
-GEN_XX3FORM(xsmaddmdp, 0x04, 0x05, PPC2_VSX),
-GEN_XX3FORM(xsmsubadp, 0x04, 0x06, PPC2_VSX),
-GEN_XX3FORM(xsmsubmdp, 0x04, 0x07, PPC2_VSX),
-GEN_XX3FORM(xsnmaddadp, 0x04, 0x14, PPC2_VSX),
-GEN_XX3FORM(xsnmaddmdp, 0x04, 0x15, PPC2_VSX),
-GEN_XX3FORM(xsnmsubadp, 0x04, 0x16, PPC2_VSX),
-GEN_XX3FORM(xsnmsubmdp, 0x04, 0x17, PPC2_VSX),
+GEN_XX3FORM_NAME(xsmadddp, "xsmaddadp", 0x04, 0x04, PPC2_VSX),
+GEN_XX3FORM_NAME(xsmadddp, "xsmaddmdp", 0x04, 0x05, PPC2_VSX),
+GEN_XX3FORM_NAME(xsmsubdp, "xsmsubadp", 0x04, 0x06, PPC2_VSX),
+GEN_XX3FORM_NAME(xsmsubdp, "xsmsubmdp", 0x04, 0x07, PPC2_VSX),
+GEN_XX3FORM_NAME(xsnmadddp, "xsnmaddadp", 0x04, 0x14, PPC2_VSX),
+GEN_XX3FORM_NAME(xsnmadddp, "xsnmaddmdp", 0x04, 0x15, PPC2_VSX),
+GEN_XX3FORM_NAME(xsnmsubdp, "xsnmsubadp", 0x04, 0x16, PPC2_VSX),
+GEN_XX3FORM_NAME(xsnmsubdp, "xsnmsubmdp", 0x04, 0x17, PPC2_VSX),
 GEN_XX3FORM(xscmpeqdp, 0x0C, 0x00, PPC2_ISA300),
 GEN_XX3FORM(xscmpgtdp, 0x0C, 0x01, PPC2_ISA300),
 GEN_XX3FORM(xscmpgedp, 0x0C, 0x02, PPC2_ISA300),
@@ -235,14 +241,14 @@ GEN_XX2FORM(xsresp,  0x14, 0x01, PPC2_VSX207),
 GEN_XX2FORM(xsrsp, 0x12, 0x11, PPC2_VSX207),
 GEN_XX2FORM(xssqrtsp,  0x16, 0x00, PPC2_VSX207),
 GEN_XX2FORM(xsrsqrtesp,  0x14, 0x00, PPC2_VSX207),
-GEN_XX3FORM(xsmaddasp, 0x04, 0x00, PPC2_VSX207),
-GEN_XX3FORM(xsmaddmsp, 0x04, 0x01, PPC2_VSX207),
-GEN_XX3FORM(xsmsubasp, 0x04, 0x02, PPC2_VSX207),
-GEN_XX3FORM(xsmsubmsp, 0x04, 0x03, PPC2_VSX207),
-GEN_XX3FORM(xsnmaddasp, 0x04, 0x10, PPC2_VSX207),
-GEN_XX3FORM(xsnmaddmsp, 0x04, 0x11, PPC2_VSX207),
-GEN_XX3FORM(xsnmsubasp, 0x04, 0x12, PPC2_VSX207),
-GEN_XX3FORM(xsnmsubmsp, 0x04, 0x13, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsmaddsp, "xsmaddasp", 0x04, 0x00, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsmaddsp, "xsmaddmsp", 0x04, 0x01, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsmsubsp, "xsmsubasp", 0x04, 0x02, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsmsubsp, "xsmsubmsp", 0x04, 0x03, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsnmaddsp, "xsnmaddasp", 0x04, 0x10, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsnmaddsp, "xsnmaddmsp", 0x04, 0x11, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsnmsubsp, "xsnmsubasp", 0x04, 0x12, PPC2_VSX207),
+GEN_XX3FORM_NAME(xsnmsubsp, "xsnmsubmsp", 0x04, 0x13, PPC2_VSX207),
 GEN_XX2FORM(xscvsxdsp, 0x10, 0x13, PPC2_VSX207),
 GEN_XX2FORM(xscvuxdsp, 0x10, 0x12, PPC2_VSX207),
 
@@ -255,14 +261,14 @@ GEN_XX2FORM(xvsqrtdp,  0x16, 0x0C, PPC2_VSX),
 GEN_XX2FORM(xvrsqrtedp,  0x14, 0x0C, PPC2_VSX),
 GEN_XX3FORM(xvtdivdp, 0x14, 0x0F, PPC2_VSX),
 GEN_XX2FORM(xvtsqrtdp, 0x14, 0x0E, PPC2_VSX),
-GEN_XX3FORM(xvmaddadp, 0x04, 0x0C, PPC2_VSX),
-GEN_XX3FORM(xvmaddmdp, 0x04, 0x0D, PPC2_VSX),
-GEN_XX3FORM(xvmsubadp, 0x04, 0x0E, PPC2_VSX),
-GEN_XX3FORM(xvmsubmdp, 0x04, 0x0F, PPC2_VSX),
-GEN_XX3FORM(xvnmaddadp, 0x04, 0x1C, PPC2_VSX),
-GEN_XX3FORM(xvnmaddmdp, 0x04, 0x1D, PPC2_VSX),
-GEN_XX3FORM(xvnmsubadp, 0x04, 0x1E, PPC2_VSX),
-GEN_XX3FORM(xvnmsubmdp, 0x04, 0x1F, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmadddp, "xvmaddadp", 0x04, 0x0C, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmadddp, "xvmaddmdp", 0x04, 0x0D, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmsubdp, "xvmsubadp", 0x04, 0x0E, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmsubdp, "xvmsubmdp", 0x04, 0x0F, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddadp", 0x04, 0x1C, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddmdp", 0x04, 0x1D, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubadp", 0x04, 0x1E, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubmdp", 0x04, 0x1F, PPC2_VSX),
 GEN_XX3FORM(xvmaxdp, 0x00, 0x1C, PPC2_VSX),
 GEN_XX3FORM(xvmindp, 0x00, 0x1D, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpeqdp, 0x0C, 0x0C, PPC2_VSX),
@@ -293,14 +299,14 @@ GEN_XX2FORM(xvsqrtsp, 0x16, 0x08, PPC2_VSX),
 GEN_XX2FORM(xvrsqrtesp, 0x14, 0x08, PPC2_VSX),
 GEN_XX3FORM(xvtdivsp, 0x14, 0x0B, PPC2_VSX),
 GEN_XX2FORM(xvtsqrtsp, 0x14, 0x0A, PPC2_VSX),
-GEN_XX3FORM(xvmaddasp, 0x04, 0x08, PPC2_VSX),
-GEN_XX3FORM(xvmaddmsp, 0x04, 0x09, PPC2_VSX),
-GEN_XX3FORM(xvmsubasp, 0x04, 0x0A, PPC2_VSX),
-GEN_XX3FORM(xvmsubmsp, 0x04, 0x0B, PPC2_VSX),
-GEN_XX3FORM(xvnmaddasp, 0x04, 0x18, PPC2_VSX),
-GEN_XX3FORM(xvnmaddmsp, 0x04, 0x19, PPC2_VSX),
-GEN_XX3FORM(xvnmsubasp, 0x04, 0x1A, PPC2_VSX),
-GEN_XX3FORM(xvnmsubmsp, 0x04, 0x1B, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmaddsp, "xvmaddasp", 0x04, 0x08, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmaddsp, "xvmaddmsp", 0x04, 0x09, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmsubsp, "xvmsubasp", 0x04, 0x0A, PPC2_VSX),
+GEN_XX3FORM_NAME(xvmsubsp, "xvmsubmsp", 0x04, 0x0B, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddasp", 0x04, 0x18, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddmsp", 0x04, 0x19, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubasp", 0x04, 0x1A, PPC2_VSX),
+GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubmsp", 0x04, 0x1B, PPC2_VSX),
 GEN_XX3FORM(xvmaxsp, 0x00, 0x18, PPC2_VSX),
 GEN_XX3FORM(xvminsp, 0x00, 0x19, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpeqsp, 0x0C, 0x08, PPC2_VSX),
-- 
2.11.0


