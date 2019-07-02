Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A783C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EC921479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mM30thk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EC921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCZt-0002tz-WA
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzk-0005mP-I4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0003RC-Co
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33249 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBze-0003Gd-Pp; Tue, 02 Jul 2019 02:10:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMn2xnHz9sQw; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047749;
 bh=8HWqks/agtnsnV6k6iB40M1ApeJ/DJnEJ6XKD8++Mak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mM30thk/68+fWkmZbbMOZepeoA3PxqRjgGBNfSXhsHjVkyl1AY6DSt3xS8dgpVjqi
 pbzjpugO0wBPM7t592IeA1hT0L1BvO5fnhowCYC+NA84YDndfpI0sxhl2ixlMNBa0x
 dZgq8dHycJwotA6dunG3z+JaUN5zPaNqj9L7KMUk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:44 +1000
Message-Id: <20190702060857.3926-37-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 36/49] target/ppc: introduce GEN_VSX_HELPER_R3
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
introduce a new GEN_VSX_HELPER_R3 macro which performs the decode based
upon rD, rA and rB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 36 ++++++++++-------------------
 target/ppc/helper.h                 | 16 ++++++-------
 target/ppc/translate/vsx-impl.inc.c | 36 ++++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5fb43b619e..44970ebec9 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1842,11 +1842,9 @@ VSX_ADD_SUB(xssubsp, sub, 1, float64, VsrD(0), 1, =
1)
 VSX_ADD_SUB(xvsubdp, sub, 2, float64, VsrD(i), 0, 0)
 VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
=20
-void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
@@ -1920,11 +1918,9 @@ VSX_MUL(xsmulsp, 1, float64, VsrD(0), 1, 1)
 VSX_MUL(xvmuldp, 2, float64, VsrD(i), 0, 0)
 VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
=20
-void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
@@ -1999,11 +1995,9 @@ VSX_DIV(xsdivsp, 1, float64, VsrD(0), 1, 1)
 VSX_DIV(xvdivdp, 2, float64, VsrD(i), 0, 0)
 VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
=20
-void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
+void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
@@ -2620,11 +2614,9 @@ VSX_MAX_MIN(xvmindp, minnum, 2, float64, VsrD(i))
 VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
=20
 #define VSX_MAX_MINC(name, max)                                         =
      \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                   =
      \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)         =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
        \
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
        \
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vex_flag =3D false;                     =
          \
                                                                         =
      \
@@ -2657,11 +2649,9 @@ VSX_MAX_MINC(xsmaxcdp, 1);
 VSX_MAX_MINC(xsmincdp, 0);
=20
 #define VSX_MAX_MINJ(name, max)                                         =
      \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                   =
      \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)         =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
        \
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
        \
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vex_flag =3D false;                     =
          \
                                                                         =
      \
@@ -3436,11 +3426,9 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t op=
code)
     do_float_check_status(env, GETPC());
 }
=20
-void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
+void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
+                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a8886c56ad..9134da9cbb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -366,12 +366,12 @@ DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
=20
 DEF_HELPER_4(xsadddp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xsaddqp, void, env, i32)
+DEF_HELPER_5(xsaddqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xssubdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmuldp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xsmulqp, void, env, i32)
+DEF_HELPER_5(xsmulqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xsdivdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xsdivqp, void, env, i32)
+DEF_HELPER_5(xsdivqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_3(xsredp, void, env, vsr, vsr)
 DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
@@ -397,10 +397,10 @@ DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmindp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xsmaxcdp, void, env, i32)
-DEF_HELPER_2(xsmincdp, void, env, i32)
-DEF_HELPER_2(xsmaxjdp, void, env, i32)
-DEF_HELPER_2(xsminjdp, void, env, i32)
+DEF_HELPER_5(xsmaxcdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmincdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmaxjdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsminjdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_3(xscvdphp, void, env, vsr, vsr)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_3(xscvdpsp, void, env, vsr, vsr)
@@ -434,7 +434,7 @@ DEF_HELPER_3(xsrdpiz, void, env, vsr, vsr)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
-DEF_HELPER_2(xssubqp, void, env, i32)
+DEF_HELPER_5(xssubqp, void, env, i32, vsr, vsr, vsr)
=20
 DEF_HELPER_4(xsaddsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xssubsp, void, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 8af093d256..8380651a8d 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1095,6 +1095,26 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_ptr(xb);                                              =
      \
 }
=20
+#define GEN_VSX_HELPER_R3(name, op1, op2, inval, type)                  =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_i32 opc;                                                       =
      \
+    TCGv_ptr xt, xa, xb;                                                =
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
+    xt =3D gen_vsr_ptr(rD(ctx->opcode) + 32);                           =
        \
+    xa =3D gen_vsr_ptr(rA(ctx->opcode) + 32);                           =
        \
+    xb =3D gen_vsr_ptr(rB(ctx->opcode) + 32);                           =
        \
+    gen_helper_##name(cpu_env, opc, xt, xa, xb);                        =
      \
+    tcg_temp_free_i32(opc);                                             =
      \
+    tcg_temp_free_ptr(xt);                                              =
      \
+    tcg_temp_free_ptr(xa);                                              =
      \
+    tcg_temp_free_ptr(xb);                                              =
      \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1114,12 +1134,12 @@ static void gen_##name(DisasContext *ctx)        =
             \
 }
=20
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
@@ -1145,10 +1165,10 @@ GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VS=
X)
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
@@ -1178,7 +1198,7 @@ GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2=
_VSX207)
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
-GEN_VSX_HELPER_2(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
=20
 GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
--=20
2.21.0


