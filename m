Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24236C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D632C2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DLvoIqq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D632C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiChy-0000h0-48
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzM-0005Oc-0C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzI-0003Fs-HS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53147 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzF-0003Dw-Bx; Tue, 02 Jul 2019 02:09:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMm10TLz9sR6; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047748;
 bh=1RRurkyx+MTbG9RptIaONizY63tkp2A1+2xZYl3r0Ew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DLvoIqq54szOLapgAnTxCLnKMsxF+fRBzUQNeFaglq9bVm1hmqrrmzMNgJF2SAHRq
 BO5k9duHWD0HosAUFMKEHgrA7sXzmHKx3DNV4R+6c80VV6fzJz4YtPkKcjvsFlkysr
 rsE27RvX8Jwdfnyth+84DTjBfZXz+jde6xe9fhkk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:49 +1000
Message-Id: <20190702060857.3926-42-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 41/49] target/ppc: improve VSX_FMADD with new
 GEN_VSX_HELPER_VSX_MADD macro
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Introduce a new GEN_VSX_HELPER_VSX_MADD macro for the generator function =
which
enables the source and destination registers to be decoded at translation=
 time.

This enables the determination of a or m form to be made at translation t=
ime so
that a single helper function can now be used for both variants.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 68 ++++++++----------------
 target/ppc/helper.h                 | 48 ++++++-----------
 target/ppc/translate/vsx-impl.inc.c | 81 +++++++++++++++++------------
 target/ppc/translate/vsx-ops.inc.c  | 70 +++++++++++++------------
 4 files changed, 122 insertions(+), 145 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index f0a897cb9a..f437c88aad 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2280,24 +2280,15 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 2=
3)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  *   maddflgs - flags for the float*muladd routine that control the
  *           various forms (madd, msub, nmadd, nmsub)
- *   afrm  - A form (1=3DA, 0=3DM)
  *   sfprf - set FPRF
  */
-#define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)        =
      \
+#define VSX_MADD(op, nels, tp, fld, maddflgs, sfprf, r2sp)              =
      \
 void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                       =
      \
-                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
      \
+                 ppc_vsr_t *xa, ppc_vsr_t *b, ppc_vsr_t *c)             =
      \
 {                                                                       =
      \
-    ppc_vsr_t t =3D *xt, *b, *c;                                        =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
-    if (afrm) { /* AxB + T */                                           =
      \
-        b =3D xb;                                                       =
        \
-        c =3D xt;                                                       =
        \
-    } else { /* AxT + B */                                              =
      \
-        b =3D xt;                                                       =
        \
-        c =3D xb;                                                       =
        \
-    }                                                                   =
      \
-                                                                        =
      \
     helper_reset_fpstatus(env);                                         =
      \
                                                                         =
      \
     for (i =3D 0; i < nels; i++) {                                      =
        \
@@ -2336,41 +2327,24 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,=
                             \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
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
=20
 /*
  * VSX_SCALAR_CMP_DP - VSX scalar floating point compare double precisio=
n
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
=20
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
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 7a4b7cb8f9..3922686ad6 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1182,14 +1182,6 @@ GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VS=
X)
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
@@ -1231,12 +1223,10 @@ GEN_VSX_HELPER_X2(xsrdpim, 0x12, 0x07, 0, PPC2_VS=
X)
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
@@ -1244,14 +1234,6 @@ GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX=
207)
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
@@ -1267,14 +1249,6 @@ GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VS=
X)
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
@@ -1301,14 +1275,6 @@ GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VS=
X)
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
@@ -1332,6 +1298,53 @@ GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VS=
X)
 GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
=20
+#define GEN_VSX_HELPER_VSX_MADD(name, op1, aop, mop, inval, type)       =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_ptr xt, xa, b, c;                                              =
      \
+    if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                          =
      \
+        return;                                                         =
      \
+    }                                                                   =
      \
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));                                =
        \
+    xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
+    if (ctx->opcode & PPC_BIT(25)) {                                    =
      \
+        /*                                                              =
      \
+         * AxT + B                                                      =
      \
+         */                                                             =
      \
+        b =3D gen_vsr_ptr(xT(ctx->opcode));                             =
        \
+        c =3D gen_vsr_ptr(xB(ctx->opcode));                             =
        \
+    } else {                                                            =
      \
+        /*                                                              =
      \
+         * AxB + T                                                      =
      \
+         */                                                             =
      \
+        b =3D gen_vsr_ptr(xB(ctx->opcode));                             =
        \
+        c =3D gen_vsr_ptr(xT(ctx->opcode));                             =
        \
+    }                                                                   =
      \
+    gen_helper_##name(cpu_env, xt, xa, b, c);                           =
      \
+    tcg_temp_free_ptr(xt);                                              =
      \
+    tcg_temp_free_ptr(xa);                                              =
      \
+    tcg_temp_free_ptr(b);                                               =
      \
+    tcg_temp_free_ptr(c);                                               =
      \
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
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
index 5030c4aceb..7fd3942b84 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -63,6 +63,12 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, P=
PC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 2, opc3, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 3, opc3, 0, PPC_NONE, fl2)
=20
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
=20
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
--=20
2.21.0


