Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7DC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8EB2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VExsOXu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8EB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCg0-0007kI-A2
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC05-00068L-8E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC02-0003ey-Vp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50453 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC02-0003Q5-9x; Tue, 02 Jul 2019 02:10:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMn6B9hz9sQy; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047749;
 bh=K3gseZpaRA/q/OGlxS1V/aoyPLNjjj2Bc7VVCjpjRx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VExsOXu7eCqy8Esseh5dopmK+X/vyKiZII/p96HMKfa7OIbDhQzJi8ci/cYcUhYM5
 NznXfodLqxWB64QGPmOClONru00dAlT5zgv6O6KU75WGenw+xwDyFoyB/uqBD4q84o
 QLs5jw/3aaEe8q/62jbBE4alY/frbS8zBz9lkGyY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:48 +1000
Message-Id: <20190702060857.3926-41-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 40/49] target/ppc: decode target register in
 VSX_EXTRACT_INSERT at translation time
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  4 ++--
 target/ppc/int_helper.c             | 12 ++++--------
 target/ppc/translate/vsx-impl.inc.c | 10 +++++-----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7ed9effff2..3d5150a524 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -534,8 +534,8 @@ DEF_HELPER_3(xvrspip, void, env, vsr, vsr)
 DEF_HELPER_3(xvrspiz, void, env, vsr, vsr)
 DEF_HELPER_4(xxperm, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xxpermr, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
-DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxextractuw, void, env, vsr, vsr, i32)
+DEF_HELPER_4(xxinsertw, void, env, vsr, vsr, i32)
 DEF_HELPER_3(xvxsigsp, void, env, vsr, vsr)
=20
 DEF_HELPER_2(efscfsi, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 3b8939edcc..5c07ef3e4d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1899,11 +1899,9 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
=20
-void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
-                        target_ulong xbn, uint32_t index)
+void helper_xxextractuw(CPUPPCState *env, ppc_vsr_t *xt,
+                        ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt =3D &env->vsr[xtn];
-    ppc_vsr_t *xb =3D &env->vsr[xbn];
     ppc_vsr_t t =3D { };
     size_t es =3D sizeof(uint32_t);
     uint32_t ext_index;
@@ -1917,11 +1915,9 @@ void helper_xxextractuw(CPUPPCState *env, target_u=
long xtn,
     *xt =3D t;
 }
=20
-void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
-                      target_ulong xbn, uint32_t index)
+void helper_xxinsertw(CPUPPCState *env, ppc_vsr_t *xt,
+                      ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt =3D &env->vsr[xtn];
-    ppc_vsr_t *xb =3D &env->vsr[xbn];
     ppc_vsr_t t =3D *xt;
     size_t es =3D sizeof(uint32_t);
     int ins_index, i =3D 0;
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index e853ee1386..7a4b7cb8f9 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1632,7 +1632,7 @@ static void gen_xxsldwi(DisasContext *ctx)
 #define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv xt, xb;                                                \
+    TCGv_ptr xt, xb;                                            \
     TCGv_i32 t0;                                                \
     TCGv_i64 t1;                                                \
     uint8_t uimm =3D UIMM4(ctx->opcode);                          \
@@ -1641,8 +1641,8 @@ static void gen_##name(DisasContext *ctx)          =
             \
         gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
         return;                                                 \
     }                                                           \
-    xt =3D tcg_const_tl(xT(ctx->opcode));                         \
-    xb =3D tcg_const_tl(xB(ctx->opcode));                         \
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));                          \
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                          \
     t0 =3D tcg_temp_new_i32();                                    \
     t1 =3D tcg_temp_new_i64();                                    \
     /*                                                          \
@@ -1657,8 +1657,8 @@ static void gen_##name(DisasContext *ctx)          =
             \
     }                                                           \
     tcg_gen_movi_i32(t0, uimm);                                 \
     gen_helper_##name(cpu_env, xt, xb, t0);                     \
-    tcg_temp_free(xb);                                          \
-    tcg_temp_free(xt);                                          \
+    tcg_temp_free_ptr(xb);                                      \
+    tcg_temp_free_ptr(xt);                                      \
     tcg_temp_free_i32(t0);                                      \
     tcg_temp_free_i64(t1);                                      \
 }
--=20
2.21.0


