Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23DAC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10782146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dJmlNk15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10782146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCnU-0006zp-Vy
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC06-0006Bf-O3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC05-0003fg-59
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58959 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC04-0003Ri-H0; Tue, 02 Jul 2019 02:10:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp290dz9sR3; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=B1wupSItFhctbPQyGbBaJGA0F4VFXTOpYDbwzZ2fIDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dJmlNk15ll9K0mZhWc5AB4MiCIOsyetJtyRgit0D/yZiJufTKLMzbo3Kqf3Rsin7c
 6HX4abKZAeGG9JR1gbxqyFWpiy/dYxm3aYutR0kHpHOgpJRa6ZMxsFRvvOTAie2VCr
 jX7Y9XWJnEucImTthRGOQjY1jZTWjDpYFZgt3GSA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:38 +1000
Message-Id: <20190702060857.3926-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 30/49] target/ppc: introduce separate VSX_CMP
 macro for xvcmp* instructions
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
introduce a new VSX_CMP macro which performs the decode based upon xT, xA
and xB at translation time.

Subsequent commits will make the same changes for other instructions howe=
ver
the xvcmp* instructions are different in that they return a set of flags =
to be
optionally written back to the crf[6] register. Move this logic from the
helper function to the generator function, along with the float_status up=
date.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 15 ++++-----
 target/ppc/helper.h                 | 20 +++++++-----
 target/ppc/translate/vsx-impl.inc.c | 49 ++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 8da805d175..b1ce954354 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2746,12 +2746,11 @@ VSX_MAX_MINJ(xsminjdp, 0);
  *   exp   - expected result of comparison
  */
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                     =
  \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
  \
+uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                   =
  \
+                     ppc_vsr_t *xa, ppc_vsr_t *xb)                      =
  \
 {                                                                       =
  \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
    \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
    \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
    \
     ppc_vsr_t t =3D *xt;                                                =
    \
+    uint32_t crf6 =3D 0;                                                =
    \
     int i;                                                              =
  \
     int all_true =3D 1;                                                 =
    \
     int all_false =3D 1;                                                =
    \
@@ -2780,11 +2779,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                       \
     }                                                                   =
  \
                                                                         =
  \
     *xt =3D t;                                                          =
    \
-    if ((opcode >> (31 - 21)) & 1) {                                    =
  \
-        env->crf[6] =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);   =
    \
-    }                                                                   =
  \
-    do_float_check_status(env, GETPC());                                =
  \
- }
+    crf6 =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);              =
    \
+    return crf6;                                                        =
  \
+}
=20
 VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
 VSX_CMP(xvcmpgedp, 2, float64, VsrD(i), le, 1, 1)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 02b67a333e..8666415169 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -108,6 +108,10 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, =
i64)
 #define dh_ctype_avr ppc_avr_t *
 #define dh_is_signed_avr dh_is_signed_ptr
=20
+#define dh_alias_vsr ptr
+#define dh_ctype_vsr ppc_vsr_t *
+#define dh_is_signed_vsr dh_is_signed_ptr
+
 DEF_HELPER_3(vavgub, void, avr, avr, avr)
 DEF_HELPER_3(vavguh, void, avr, avr, avr)
 DEF_HELPER_3(vavguw, void, avr, avr, avr)
@@ -468,10 +472,10 @@ DEF_HELPER_2(xvnmsubadp, void, env, i32)
 DEF_HELPER_2(xvnmsubmdp, void, env, i32)
 DEF_HELPER_2(xvmaxdp, void, env, i32)
 DEF_HELPER_2(xvmindp, void, env, i32)
-DEF_HELPER_2(xvcmpeqdp, void, env, i32)
-DEF_HELPER_2(xvcmpgedp, void, env, i32)
-DEF_HELPER_2(xvcmpgtdp, void, env, i32)
-DEF_HELPER_2(xvcmpnedp, void, env, i32)
+DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvdpsp, void, env, i32)
 DEF_HELPER_2(xvcvdpsxds, void, env, i32)
 DEF_HELPER_2(xvcvdpsxws, void, env, i32)
@@ -506,10 +510,10 @@ DEF_HELPER_2(xvnmsubasp, void, env, i32)
 DEF_HELPER_2(xvnmsubmsp, void, env, i32)
 DEF_HELPER_2(xvmaxsp, void, env, i32)
 DEF_HELPER_2(xvminsp, void, env, i32)
-DEF_HELPER_2(xvcmpeqsp, void, env, i32)
-DEF_HELPER_2(xvcmpgesp, void, env, i32)
-DEF_HELPER_2(xvcmpgtsp, void, env, i32)
-DEF_HELPER_2(xvcmpnesp, void, env, i32)
+DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvspdp, void, env, i32)
 DEF_HELPER_2(xvcvsphp, void, env, i32)
 DEF_HELPER_2(xvcvhpsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index e9b7562f84..900ba07d40 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -20,6 +20,13 @@ static inline void set_cpu_vsrl(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, false));
 }
=20
+static inline TCGv_ptr gen_vsr_ptr(int reg)
+{
+    TCGv_ptr r =3D tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(r, cpu_env, vsr_full_offset(reg));
+    return r;
+}
+
 #define VSX_LOAD_SCALAR(name, operation)                      \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -958,6 +965,40 @@ VSX_VECTOR_MOVE(xvnabssp, OP_NABS, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvnegsp, OP_NEG, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvcpsgnsp, OP_CPSGN, SGN_MASK_SP)
=20
+#define VSX_CMP(name, op1, op2, inval, type)                            =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_i32 ignored;                                                   =
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
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));                                =
        \
+    xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
+    if ((ctx->opcode >> (31 - 21)) & 1) {                               =
      \
+        gen_helper_##name(cpu_crf[6], cpu_env, xt, xa, xb);             =
      \
+    } else {                                                            =
      \
+        ignored =3D tcg_temp_new_i32();                                 =
        \
+        gen_helper_##name(ignored, cpu_env, xt, xa, xb);                =
      \
+        tcg_temp_free_i32(ignored);                                     =
      \
+    }                                                                   =
      \
+    gen_helper_float_check_status(cpu_env);                             =
      \
+    tcg_temp_free_ptr(xt);                                              =
      \
+    tcg_temp_free_ptr(xa);                                              =
      \
+    tcg_temp_free_ptr(xb);                                              =
      \
+}
+
+VSX_CMP(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
+VSX_CMP(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
+VSX_CMP(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
+VSX_CMP(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
+VSX_CMP(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
+VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
+VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
+VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
+
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                   =
      \
 static void gen_##name(DisasContext *ctx)                               =
      \
 {                                                                       =
      \
@@ -1097,10 +1138,6 @@ GEN_VSX_HELPER_2(xvnmsubadp, 0x04, 0x1E, 0, PPC2_V=
SX)
 GEN_VSX_HELPER_2(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
@@ -1135,10 +1172,6 @@ GEN_VSX_HELPER_2(xvnmsubasp, 0x04, 0x1A, 0, PPC2_V=
SX)
 GEN_VSX_HELPER_2(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
--=20
2.21.0


