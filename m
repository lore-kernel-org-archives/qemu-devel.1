Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B2C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0682075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UEqNJoUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0682075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJeT-0006a2-Bm
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 01:18:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ9H-0003hr-Mx
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ9G-0006uW-Ci
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53265 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTJ9F-0006fY-MM; Wed, 22 May 2019 00:46:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4580Sx5nN6z9sPJ; Wed, 22 May 2019 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558500369;
	bh=JovPQt+w+OsaE4OA9JcscahCs/Ep/b23xTHJ4b5HExg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEqNJoUSrLObRKvdfa8v+dP9LYeHJd9zkmItcnJn9RYbb/nrvqLn1s1gAnHQDrOtQ
	MxaHHXvGbR4JYUPKur6WB5EY3sOJW10pkp8kRDZ/e3EbVXeD2LkUHe25p0fgA9/8V9
	UAnrOs+7PKNJNAtpOsLk97qldHANsPe831GREqFU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 22 May 2019 14:45:44 +1000
Message-Id: <20190522044600.16534-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522044600.16534-1-david@gibson.dropbear.id.au>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 22/38] target/ppc: Use vector variable shifts
 for VSL, VSR, VSRA
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
Cc: lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
	clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The gvec expanders take care of masking the shift amount
against the element width.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 | 12 ----------
 target/ppc/int_helper.c             | 37 -----------------------------
 target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
 3 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 638a6e99c4..02b67a333e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -180,18 +180,6 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
 DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
 DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
-DEF_HELPER_3(vsrab, void, avr, avr, avr)
-DEF_HELPER_3(vsrah, void, avr, avr, avr)
-DEF_HELPER_3(vsraw, void, avr, avr, avr)
-DEF_HELPER_3(vsrad, void, avr, avr, avr)
-DEF_HELPER_3(vsrb, void, avr, avr, avr)
-DEF_HELPER_3(vsrh, void, avr, avr, avr)
-DEF_HELPER_3(vsrw, void, avr, avr, avr)
-DEF_HELPER_3(vsrd, void, avr, avr, avr)
-DEF_HELPER_3(vslb, void, avr, avr, avr)
-DEF_HELPER_3(vslh, void, avr, avr, avr)
-DEF_HELPER_3(vslw, void, avr, avr, avr)
-DEF_HELPER_3(vsld, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f5c81acd53..0b22774a9d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1776,23 +1776,6 @@ VSHIFT(l, 1)
 VSHIFT(r, 0)
 #undef VSHIFT
=20
-#define VSL(suffix, element, mask)                                      =
\
-    void helper_vsl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   =
\
-    {                                                                   =
\
-        int i;                                                          =
\
-                                                                        =
\
-        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
-            unsigned int shift =3D b->element[i] & mask;                =
  \
-                                                                        =
\
-            r->element[i] =3D a->element[i] << shift;                   =
  \
-        }                                                               =
\
-    }
-VSL(b, u8, 0x7)
-VSL(h, u16, 0x0F)
-VSL(w, u32, 0x1F)
-VSL(d, u64, 0x3F)
-#undef VSL
-
 void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
@@ -1965,26 +1948,6 @@ VNEG(vnegw, s32)
 VNEG(vnegd, s64)
 #undef VNEG
=20
-#define VSR(suffix, element, mask)                                      =
\
-    void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   =
\
-    {                                                                   =
\
-        int i;                                                          =
\
-                                                                        =
\
-        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
-            unsigned int shift =3D b->element[i] & mask;                =
  \
-            r->element[i] =3D a->element[i] >> shift;                   =
  \
-        }                                                               =
\
-    }
-VSR(ab, s8, 0x7)
-VSR(ah, s16, 0xF)
-VSR(aw, s32, 0x1F)
-VSR(ad, s64, 0x3F)
-VSR(b, u8, 0x7)
-VSR(h, u16, 0xF)
-VSR(w, u32, 0x1F)
-VSR(d, u64, 0x3F)
-#undef VSR
-
 void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int sh =3D (b->VsrB(0xf) >> 3) & 0xf;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 6861f4c5b9..663275b729 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -530,21 +530,21 @@ GEN_VXFORM(vmuleuw, 4, 10);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
-GEN_VXFORM(vslb, 2, 4);
-GEN_VXFORM(vslh, 2, 5);
-GEN_VXFORM(vslw, 2, 6);
+GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
+GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
+GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsld, 2, 23);
-GEN_VXFORM(vsrb, 2, 8);
-GEN_VXFORM(vsrh, 2, 9);
-GEN_VXFORM(vsrw, 2, 10);
-GEN_VXFORM(vsrd, 2, 27);
-GEN_VXFORM(vsrab, 2, 12);
-GEN_VXFORM(vsrah, 2, 13);
-GEN_VXFORM(vsraw, 2, 14);
-GEN_VXFORM(vsrad, 2, 15);
+GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
+GEN_VXFORM_V(vsrb, MO_8, tcg_gen_gvec_shrv, 2, 8);
+GEN_VXFORM_V(vsrh, MO_16, tcg_gen_gvec_shrv, 2, 9);
+GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
+GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
+GEN_VXFORM_V(vsrab, MO_8, tcg_gen_gvec_sarv, 2, 12);
+GEN_VXFORM_V(vsrah, MO_16, tcg_gen_gvec_sarv, 2, 13);
+GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
+GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
 GEN_VXFORM(vslv, 2, 29);
 GEN_VXFORM(vslo, 6, 16);
--=20
2.21.0


