Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFEDC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FA1216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HFypH67I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FA1216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCxG-0007DB-VP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC04-000665-By
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC03-0003f3-0C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57077 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC02-0003Q7-BO; Tue, 02 Jul 2019 02:10:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp0D5Rz9sR4; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=Axez3PVN/CxOZIqehgWqX2RsHqKYDdtwh+wxBA4eIkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HFypH67IXWDSorAS9YxKf9Jtk3IxgMU+geWgmXDhid8N8DSf+9HS7lPH9f2ajrQo3
 +PC80/eYw46IS2PpdlsORWOagKjSct5CTmVVJCb01R+B+oK5glC1iIH199zHxcDqsZ
 l+r8XEHXwjF25uqaCEMkyU9RTK3+f0rfExFfT4FQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:40 +1000
Message-Id: <20190702060857.3926-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 32/49] target/ppc: introduce separate generator
 and helper for xscvqpdp
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
introduce a new generator and helper function which perform the decode ba=
sed
upon xT and xB at translation time.

The xscvqpdp helper is the only 2 parameter xT/xB implementation that req=
uires
the opcode to be passed as an additional parameter, so handling this sepa=
rately
allows us to optimise the conversion in the next commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             |  5 ++---
 target/ppc/helper.h                 |  2 +-
 target/ppc/translate/vsx-impl.inc.c | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 012dfdac3e..230ee2f072 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2899,10 +2899,9 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32,=
 VsrH(2 * i + 1), VsrW(i), 0)
  * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
  * added to this later.
  */
-void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
+                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     ppc_vsr_t t =3D { };
     float_status tstat;
=20
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f6a97cedc6..5d15166988 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -405,7 +405,7 @@ DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
-DEF_HELPER_2(xscvqpdp, void, env, i32)
+DEF_HELPER_4(xscvqpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvqpudz, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index b24be00ccf..ffbe3b0fac 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -999,6 +999,23 @@ VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
 VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
 VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
=20
+static void gen_xscvqpdp(DisasContext *ctx)
+{
+    TCGv_i32 opc;
+    TCGv_ptr xt, xb;
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    opc =3D tcg_const_i32(ctx->opcode);
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));
+    gen_helper_xscvqpdp(cpu_env, opc, xt, xb);
+    tcg_temp_free_i32(opc);
+    tcg_temp_free_ptr(xt);
+    tcg_temp_free_ptr(xb);
+}
+
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                   =
      \
 static void gen_##name(DisasContext *ctx)                               =
      \
 {                                                                       =
      \
@@ -1087,7 +1104,6 @@ GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_I=
SA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
--=20
2.21.0


