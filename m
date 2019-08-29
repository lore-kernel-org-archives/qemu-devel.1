Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B76215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bexbe0nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B76215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Doj-0007gO-Ly
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dc5-0004Jm-KS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dc1-0003kW-Ij
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dc0-0003hF-HQ; Thu, 29 Aug 2019 02:08:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscN4fPsz9sPV; Thu, 29 Aug 2019 16:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058916;
 bh=ymMSTYLQLz6KT9co8vwGr8fLoufPtaRsO9JJjm+zhtc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bexbe0nmi4YO1oQdWI/HEYJeOt2/g9RBlfxZ0FB8UUwsjpFb544rxVhlYJiLcCCco
 rxruV28+UxXirAfR1RtZ2ex5F/zZZ04181k6W7tlzu/GG1QnEXtfdQdF0GchQzgNwd
 DbAQxiLtUbE2PfB1gqX8a0qcmUsLnAF7fL5c3mdA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:21 +1000
Message-Id: <20190829060827.25731-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 13/19] target/ppc: Refactor emulation of vmrgew
 and vmrgow instructions
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
 Richard Henderson <richard.henderson@linaro.org>, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Brankovic <stefan.brankovic@rt-rk.com>

Since I found this two instructions implemented with tcg, I refactored
them so they are consistent with other similar implementations that
I introduced in this patch.

Also, a new dual macro GEN_VXFORM_TRANS_DUAL is added. This macro is
used if one instruction is realized with direct translation, and second
one with a helper.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-Id: <1566898663-25858-4-git-send-email-stefan.brankovic@rt-rk.com=
>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vmx-impl.inc.c | 66 ++++++++++++++++-------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 0d71c10428..2472a5217a 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -350,6 +350,28 @@ static void glue(gen_, name0##_##name1)(DisasContext=
 *ctx)             \
     }                                                                  \
 }
=20
+/*
+ * We use this macro if one instruction is realized with direct
+ * translation, and second one with helper.
+ */
+#define GEN_VXFORM_TRANS_DUAL(name0, flg0, flg2_0, name1, flg1, flg2_1)\
+static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
+{                                                                      \
+    if ((Rc(ctx->opcode) =3D=3D 0) &&                                   =
   \
+        ((ctx->insns_flags & flg0) || (ctx->insns_flags2 & flg2_0))) { \
+        if (unlikely(!ctx->altivec_enabled)) {                         \
+            gen_exception(ctx, POWERPC_EXCP_VPU);                      \
+            return;                                                    \
+        }                                                              \
+        trans_##name0(ctx);                                            \
+    } else if ((Rc(ctx->opcode) =3D=3D 1) &&                            =
   \
+        ((ctx->insns_flags & flg1) || (ctx->insns_flags2 & flg2_1))) { \
+        gen_##name1(ctx);                                              \
+    } else {                                                           \
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);            \
+    }                                                                  \
+}
+
 /* Adds support to provide invalid mask */
 #define GEN_VXFORM_DUAL_EXT(name0, flg0, flg2_0, inval0,                =
\
                             name1, flg1, flg2_1, inval1)                =
\
@@ -431,20 +453,13 @@ GEN_VXFORM(vmrglb, 6, 4);
 GEN_VXFORM(vmrglh, 6, 5);
 GEN_VXFORM(vmrglw, 6, 6);
=20
-static void gen_vmrgew(DisasContext *ctx)
+static void trans_vmrgew(DisasContext *ctx)
 {
-    TCGv_i64 tmp;
-    TCGv_i64 avr;
-    int VT, VA, VB;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    VT =3D rD(ctx->opcode);
-    VA =3D rA(ctx->opcode);
-    VB =3D rB(ctx->opcode);
-    tmp =3D tcg_temp_new_i64();
-    avr =3D tcg_temp_new_i64();
+    int VT =3D rD(ctx->opcode);
+    int VA =3D rA(ctx->opcode);
+    int VB =3D rB(ctx->opcode);
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+    TCGv_i64 avr =3D tcg_temp_new_i64();
=20
     get_avr64(avr, VB, true);
     tcg_gen_shri_i64(tmp, avr, 32);
@@ -462,21 +477,14 @@ static void gen_vmrgew(DisasContext *ctx)
     tcg_temp_free_i64(avr);
 }
=20
-static void gen_vmrgow(DisasContext *ctx)
+static void trans_vmrgow(DisasContext *ctx)
 {
-    TCGv_i64 t0, t1;
-    TCGv_i64 avr;
-    int VT, VA, VB;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    VT =3D rD(ctx->opcode);
-    VA =3D rA(ctx->opcode);
-    VB =3D rB(ctx->opcode);
-    t0 =3D tcg_temp_new_i64();
-    t1 =3D tcg_temp_new_i64();
-    avr =3D tcg_temp_new_i64();
+    int VT =3D rD(ctx->opcode);
+    int VA =3D rA(ctx->opcode);
+    int VB =3D rB(ctx->opcode);
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 avr =3D tcg_temp_new_i64();
=20
     get_avr64(t0, VB, true);
     get_avr64(t1, VA, true);
@@ -936,14 +944,14 @@ GEN_VXFORM_ENV(vminfp, 5, 17);
 GEN_VXFORM_HETRO(vextublx, 6, 24)
 GEN_VXFORM_HETRO(vextuhlx, 6, 25)
 GEN_VXFORM_HETRO(vextuwlx, 6, 26)
-GEN_VXFORM_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
+GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwlx, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_HETRO(vextubrx, 6, 28)
 GEN_VXFORM_HETRO(vextuhrx, 6, 29)
 GEN_VXFORM_HETRO(vextuwrx, 6, 30)
 GEN_VXFORM_TRANS(lvsl, 6, 31)
 GEN_VXFORM_TRANS(lvsr, 6, 32)
-GEN_VXFORM_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207, \
+GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwrx, PPC_NONE, PPC2_ISA300)
=20
 #define GEN_VXRFORM1(opname, name, str, opc2, opc3)                     =
\
--=20
2.21.0


