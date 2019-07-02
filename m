Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3FC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E03921721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZDTvmyn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E03921721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCpm-0000Gs-PJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzm-0005mn-By
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0003RU-DF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:26 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37235 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBze-0003Gj-RV; Tue, 02 Jul 2019 02:10:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMn1kTvz9sR1; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047749;
 bh=HrkZzsZsoKkamfFXKlsfBLsFWeh1vidWdrrv3p2VGKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZDTvmyn2p120A6QYNH92I8iSHnyYzqogfktAQLB90kBUJpYth5xtAClwgM85E4YHc
 lq/ApFjtYTEJ/zJxRYvGYEe7/V9ZoEc/wyLxrc23Cr+CElVviFAMJG4pzFePxVxHEk
 W7CDSVact3ZSuzBVmybjOpgjFz0duNIlEGhPeMC0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:41 +1000
Message-Id: <20190702060857.3926-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 33/49] target/ppc: introduce GEN_VSX_HELPER_X2
 macro to fpu_helper.c
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

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X2 macro which performs the decode based
upon xT and xB at translation time.

With the previous change to the xscvqpdp generator and helper functions t=
he
opcode parameter is no longer required in the common case and can be
removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             |  36 ++------
 target/ppc/helper.h                 | 120 ++++++++++++-------------
 target/ppc/translate/vsx-impl.inc.c | 135 +++++++++++++++-------------
 3 files changed, 144 insertions(+), 147 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 230ee2f072..44dff1b459 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2040,10 +2040,8 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opc=
ode)
  *   sfprf - set FPRF
  */
 #define VSX_RE(op, nels, tp, fld, sfprf, r2sp)                          =
      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
@@ -2082,10 +2080,8 @@ VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_SQRT(op, nels, tp, fld, sfprf, r2sp)                        =
     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        =
     \
 {                                                                       =
     \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
     ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
@@ -2132,10 +2128,8 @@ VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_RSQRTE(op, nels, tp, fld, sfprf, r2sp)                      =
     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        =
     \
 {                                                                       =
     \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
     ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
@@ -2791,10 +2785,8 @@ VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf)    \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
 {                                                                  \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                         \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                         \
     ppc_vsr_t t =3D *xt;                                             \
     int i;                                                         \
                                                                    \
@@ -2867,10 +2859,8 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, floa=
t128, VsrD(0), f128, 1)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfprf) \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
 {                                                                  \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                         \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                         \
     ppc_vsr_t t =3D { };                                             \
     int i;                                                         \
                                                                    \
@@ -2949,11 +2939,9 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64=
_t xb)
  *   rnan  - resulting NaN
  */
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, rnan)         =
     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        =
     \
 {                                                                       =
     \
     int all_flags =3D env->fp_status.float_exception_flags, flags;      =
       \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
     ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
@@ -3037,10 +3025,8 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint=
32, f128, VsrD(0), 0x0ULL)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_INT_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf, r2sp)  =
\
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        =
\
 {                                                                       =
\
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
  \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
     ppc_vsr_t t =3D *xt;                                                =
  \
     int i;                                                              =
\
                                                                         =
\
@@ -3113,10 +3099,8 @@ VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float12=
8, VsrD(0), f128)
  *   sfprf - set FPRF
  */
 #define VSX_ROUND(op, nels, tp, fld, rmode, sfprf)                     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)       \
 {                                                                      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
 \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
 \
     ppc_vsr_t t =3D *xt;                                                =
 \
     int i;                                                             \
                                                                        \
@@ -3201,10 +3185,8 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, =
                    \
 VSX_XXPERM(xxperm, 0)
 VSX_XXPERM(xxpermr, 1)
=20
-void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
+void helper_xvxsigsp(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     ppc_vsr_t t =3D { };
     uint32_t exp, i, fraction;
=20
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5d15166988..f56476ec41 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -372,9 +372,9 @@ DEF_HELPER_4(xsmuldp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsmulqp, void, env, i32)
 DEF_HELPER_4(xsdivdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsdivqp, void, env, i32)
-DEF_HELPER_2(xsredp, void, env, i32)
-DEF_HELPER_2(xssqrtdp, void, env, i32)
-DEF_HELPER_2(xsrsqrtedp, void, env, i32)
+DEF_HELPER_3(xsredp, void, env, vsr, vsr)
+DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
+DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_2(xstdivdp, void, env, i32)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
 DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
@@ -401,36 +401,36 @@ DEF_HELPER_2(xsmaxcdp, void, env, i32)
 DEF_HELPER_2(xsmincdp, void, env, i32)
 DEF_HELPER_2(xsmaxjdp, void, env, i32)
 DEF_HELPER_2(xsminjdp, void, env, i32)
-DEF_HELPER_2(xscvdphp, void, env, i32)
+DEF_HELPER_3(xscvdphp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
-DEF_HELPER_2(xscvdpsp, void, env, i32)
+DEF_HELPER_3(xscvdpsp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_4(xscvqpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvqpudz, void, env, i32)
 DEF_HELPER_2(xscvqpuwz, void, env, i32)
-DEF_HELPER_2(xscvhpdp, void, env, i32)
+DEF_HELPER_3(xscvhpdp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvsdqp, void, env, i32)
-DEF_HELPER_2(xscvspdp, void, env, i32)
+DEF_HELPER_3(xscvspdp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
-DEF_HELPER_2(xscvdpsxds, void, env, i32)
-DEF_HELPER_2(xscvdpsxws, void, env, i32)
-DEF_HELPER_2(xscvdpuxds, void, env, i32)
-DEF_HELPER_2(xscvdpuxws, void, env, i32)
-DEF_HELPER_2(xscvsxddp, void, env, i32)
-DEF_HELPER_2(xscvuxdsp, void, env, i32)
-DEF_HELPER_2(xscvsxdsp, void, env, i32)
+DEF_HELPER_3(xscvdpsxds, void, env, vsr, vsr)
+DEF_HELPER_3(xscvdpsxws, void, env, vsr, vsr)
+DEF_HELPER_3(xscvdpuxds, void, env, vsr, vsr)
+DEF_HELPER_3(xscvdpuxws, void, env, vsr, vsr)
+DEF_HELPER_3(xscvsxddp, void, env, vsr, vsr)
+DEF_HELPER_3(xscvuxdsp, void, env, vsr, vsr)
+DEF_HELPER_3(xscvsxdsp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvudqp, void, env, i32)
-DEF_HELPER_2(xscvuxddp, void, env, i32)
+DEF_HELPER_3(xscvuxddp, void, env, vsr, vsr)
 DEF_HELPER_2(xststdcsp, void, env, i32)
 DEF_HELPER_2(xststdcdp, void, env, i32)
 DEF_HELPER_2(xststdcqp, void, env, i32)
-DEF_HELPER_2(xsrdpi, void, env, i32)
-DEF_HELPER_2(xsrdpic, void, env, i32)
-DEF_HELPER_2(xsrdpim, void, env, i32)
-DEF_HELPER_2(xsrdpip, void, env, i32)
-DEF_HELPER_2(xsrdpiz, void, env, i32)
+DEF_HELPER_3(xsrdpi, void, env, vsr, vsr)
+DEF_HELPER_3(xsrdpic, void, env, vsr, vsr)
+DEF_HELPER_3(xsrdpim, void, env, vsr, vsr)
+DEF_HELPER_3(xsrdpip, void, env, vsr, vsr)
+DEF_HELPER_3(xsrdpiz, void, env, vsr, vsr)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
@@ -440,10 +440,10 @@ DEF_HELPER_4(xsaddsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xssubsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmulsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsdivsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xsresp, void, env, i32)
+DEF_HELPER_3(xsresp, void, env, vsr, vsr)
 DEF_HELPER_2(xsrsp, i64, env, i64)
-DEF_HELPER_2(xssqrtsp, void, env, i32)
-DEF_HELPER_2(xsrsqrtesp, void, env, i32)
+DEF_HELPER_3(xssqrtsp, void, env, vsr, vsr)
+DEF_HELPER_3(xsrsqrtesp, void, env, vsr, vsr)
 DEF_HELPER_4(xsmaddasp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmaddmsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmsubasp, void, env, vsr, vsr, vsr)
@@ -457,9 +457,9 @@ DEF_HELPER_4(xvadddp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvsubdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmuldp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvdivdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xvredp, void, env, i32)
-DEF_HELPER_2(xvsqrtdp, void, env, i32)
-DEF_HELPER_2(xvrsqrtedp, void, env, i32)
+DEF_HELPER_3(xvredp, void, env, vsr, vsr)
+DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
+DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
 DEF_HELPER_2(xvtdivdp, void, env, i32)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
 DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
@@ -476,28 +476,28 @@ DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32,=
 env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
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
+DEF_HELPER_3(xvcvdpsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvdpsxds, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvdpsxws, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvdpuxds, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvdpuxws, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvsxddp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvuxddp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvsxwdp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvuxwdp, void, env, vsr, vsr)
+DEF_HELPER_3(xvrdpi, void, env, vsr, vsr)
+DEF_HELPER_3(xvrdpic, void, env, vsr, vsr)
+DEF_HELPER_3(xvrdpim, void, env, vsr, vsr)
+DEF_HELPER_3(xvrdpip, void, env, vsr, vsr)
+DEF_HELPER_3(xvrdpiz, void, env, vsr, vsr)
=20
 DEF_HELPER_4(xvaddsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvsubsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmulsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvdivsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xvresp, void, env, i32)
-DEF_HELPER_2(xvsqrtsp, void, env, i32)
-DEF_HELPER_2(xvrsqrtesp, void, env, i32)
+DEF_HELPER_3(xvresp, void, env, vsr, vsr)
+DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
 DEF_HELPER_2(xvtdivsp, void, env, i32)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
 DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
@@ -514,29 +514,29 @@ DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32,=
 env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
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
+DEF_HELPER_3(xvcvspdp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvsphp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvhpsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvspsxds, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvspsxws, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvspuxds, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvspuxws, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvsxdsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvuxdsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvsxwsp, void, env, vsr, vsr)
+DEF_HELPER_3(xvcvuxwsp, void, env, vsr, vsr)
 DEF_HELPER_2(xvtstdcsp, void, env, i32)
 DEF_HELPER_2(xvtstdcdp, void, env, i32)
-DEF_HELPER_2(xvrspi, void, env, i32)
-DEF_HELPER_2(xvrspic, void, env, i32)
-DEF_HELPER_2(xvrspim, void, env, i32)
-DEF_HELPER_2(xvrspip, void, env, i32)
-DEF_HELPER_2(xvrspiz, void, env, i32)
+DEF_HELPER_3(xvrspi, void, env, vsr, vsr)
+DEF_HELPER_3(xvrspic, void, env, vsr, vsr)
+DEF_HELPER_3(xvrspim, void, env, vsr, vsr)
+DEF_HELPER_3(xvrspip, void, env, vsr, vsr)
+DEF_HELPER_3(xvrspiz, void, env, vsr, vsr)
 DEF_HELPER_4(xxperm, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xxpermr, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
-DEF_HELPER_2(xvxsigsp, void, env, i32)
+DEF_HELPER_3(xvxsigsp, void, env, vsr, vsr)
=20
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index ffbe3b0fac..36fb740f6a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1046,6 +1046,21 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_ptr(xb);                                              =
      \
 }
=20
+#define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                  =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_ptr xt, xb;                                                    =
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
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
+    gen_helper_##name(cpu_env, xt, xb);                                 =
      \
+    tcg_temp_free_ptr(xt);                                              =
      \
+    tcg_temp_free_ptr(xb);                                              =
      \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1071,9 +1086,9 @@ GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
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
@@ -1100,30 +1115,30 @@ GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_IS=
A300)
 GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
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
=20
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
@@ -1135,9 +1150,9 @@ GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX2=
07)
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
@@ -1146,8 +1161,8 @@ GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_V=
SX207)
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
@@ -1156,9 +1171,9 @@ GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
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
@@ -1171,28 +1186,28 @@ GEN_VSX_HELPER_X3(xvnmsubadp, 0x04, 0x1E, 0, PPC2=
_VSX)
 GEN_VSX_HELPER_X3(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
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
=20
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
@@ -1205,22 +1220,22 @@ GEN_VSX_HELPER_X3(xvnmsubasp, 0x04, 0x1A, 0, PPC2=
_VSX)
 GEN_VSX_HELPER_X3(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
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
@@ -1879,7 +1894,7 @@ static void gen_xvxexpdp(DisasContext *ctx)
     tcg_temp_free_i64(xbl);
 }
=20
-GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
=20
 static void gen_xvxsigdp(DisasContext *ctx)
 {
--=20
2.21.0


