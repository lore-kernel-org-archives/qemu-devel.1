Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51528C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214EA20874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ezP/FgFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214EA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawBN-00078K-CK
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 01:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8m-0004Ur-8f
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8k-00072W-En
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:44 -0400
Received: from ozlabs.org ([203.11.71.1]:33539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haw8k-00070u-26; Wed, 12 Jun 2019 01:49:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NwtR1Hlnz9sNT; Wed, 12 Jun 2019 15:49:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560318575;
 bh=KS3YuiEIOq/GZnRXvIWmLklhlLsIdYGPylfsoDmpdvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ezP/FgFM07clANxNp9kcWY167jth5oTPP+Qu+oyqCDhoE520KweugtXUgMFp05lRv
 1P9BYCayylNXCxwgev9gFFbak8Lzn57ZT6NUtUy5n662Sdy+eUdY2GKhgUYqSFwC2e
 6HehvV/SM68lFBU1dia0HzWV9EBYgdmqnDQUjoeg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 15:49:27 +1000
Message-Id: <20190612054929.21136-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 11/13] target/ppc: Use tcg_gen_gvec_bitsel
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Replace the target-specific implementation of XXSEL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190603164927.8336-1-richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index cdb44b8b70..e9b7562f84 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1339,28 +1339,8 @@ static void glue(gen_, name)(DisasContext *ctx)   =
          \
 VSX_XXMRG(xxmrghw, 1)
 VSX_XXMRG(xxmrglw, 0)
=20
-static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
-{
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(t, a, b);
-}
-
-static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
-                      TCGv_vec b, TCGv_vec c)
-{
-    tcg_gen_and_vec(vece, b, b, c);
-    tcg_gen_andc_vec(vece, a, a, c);
-    tcg_gen_or_vec(vece, t, a, b);
-}
-
 static void gen_xxsel(DisasContext *ctx)
 {
-    static const GVecGen4 g =3D {
-        .fni8 =3D xxsel_i64,
-        .fniv =3D xxsel_vec,
-        .vece =3D MO_64,
-    };
     int rt =3D xT(ctx->opcode);
     int ra =3D xA(ctx->opcode);
     int rb =3D xB(ctx->opcode);
@@ -1370,8 +1350,8 @@ static void gen_xxsel(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
-                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g)=
;
+    tcg_gen_gvec_bitsel(MO_64, vsr_full_offset(rt), vsr_full_offset(rc),
+                        vsr_full_offset(rb), vsr_full_offset(ra), 16, 16=
);
 }
=20
 static void gen_xxspltw(DisasContext *ctx)
--=20
2.21.0


