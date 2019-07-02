Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CEC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6D32146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lrVQJ6Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6D32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCn4-00067b-TP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzk-0005mQ-I7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0003RO-CJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45411 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBze-0003Gf-QE; Tue, 02 Jul 2019 02:10:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMn59JBz9sRC; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047749;
 bh=O8V1KPSTq+vPEWBvmMn6IzTO80C/9lqflwskQ4jDmXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lrVQJ6RtT53Nz9zFQ18MDOxXpdpKqp4dEAYYJpXO7QCjSyCIlr+813oD8Rh6JvpAL
 W8HlC9jRPuYmgo7BXJjJv6yOHUpQQCg4JqNYell44k9UqVfp7HGAdQOHODmHdFWGAp
 8AqoQPwZ9Byzq4uh3zu4yxQtKGmw9LIVF43Yx3rE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:43 +1000
Message-Id: <20190702060857.3926-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 35/49] target/ppc: introduce GEN_VSX_HELPER_X1
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
introduce a new GEN_VSX_HELPER_X1 macro which performs the decode based
upon xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             |  6 ++----
 target/ppc/helper.h                 |  8 ++++----
 target/ppc/translate/vsx-impl.inc.c | 24 ++++++++++++++++++++----
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 902d63b139..5fb43b619e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2236,9 +2236,8 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, =
23)
  *   nbits - number of fraction bits
  */
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       =
\
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
+void helper_##op(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)      =
\
 {                                                                       =
\
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
     int i;                                                              =
\
     int fe_flag =3D 0;                                                  =
  \
     int fg_flag =3D 0;                                                  =
  \
@@ -3258,9 +3257,8 @@ VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW=
(i), VsrW(i), UINT32_MAX, 0)
 VSX_TEST_DC(xststdcdp, 1, xB(opcode), float64, VsrD(0), VsrD(0), 0, 1)
 VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0,=
 1)
=20
-void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
+void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     uint32_t dcmx, sign, exp;
     uint32_t cc, match =3D 0, not_sp =3D 0;
=20
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
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 9b4603ac33..8af093d256 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1079,6 +1079,22 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_ptr(xb);                                              =
      \
 }
=20
+#define GEN_VSX_HELPER_X1(name, op1, op2, inval, type)                  =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_i32 opc;                                                       =
      \
+    TCGv_ptr xb;                                                        =
      \
+    if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                          =
      \
+        return;                                                         =
      \
+    }                                                                   =
      \
+    opc =3D tcg_const_i32(ctx->opcode);                                 =
        \
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
+    gen_helper_##name(cpu_env, opc, xb);                                =
      \
+    tcg_temp_free_i32(opc);                                             =
      \
+    tcg_temp_free_ptr(xb);                                              =
      \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1108,7 +1124,7 @@ GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
@@ -1181,7 +1197,7 @@ GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_V=
SX207)
 GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
=20
@@ -1193,7 +1209,7 @@ GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
@@ -1227,7 +1243,7 @@ GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
--=20
2.21.0


