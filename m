Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEE920659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZGmYsw/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEE920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYSc-0003ni-Bi
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKT-0004k4-9k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKR-00054r-HT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54339 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKR-0004zf-5N; Thu, 24 Oct 2019 04:18:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrX6s7hz9sR3; Thu, 24 Oct 2019 19:18:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905116;
 bh=bDJ+lL6U7/EjRyMJMnAmLePHj2/5rsdcdvyY0UDu9xU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZGmYsw/CupiLTExxSXKfkADhiCYCMymEsc8fkH4oplEbzIBrdRGklkrTxlN8PQlpA
 Np2i0nbiAvuBDcVYIpZhQG9LIT9oDgIcZkjPZAlGUwIx5G/u9OFtTwCLOQ7nXKwp2Q
 r6rmsY7Ltq1jHzRb2cD6y6Z+6g97O0yMhbInUfFE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/28] target/ppc: Fix for optimized vsl/vsr instructions
Date: Thu, 24 Oct 2019 19:17:48 +1100
Message-Id: <20191024081813.2115-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>, "Paul A. Clark" <pc@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Brankovic <stefan.brankovic@rt-rk.com>

In previous implementation, invocation of TCG shift function could reques=
t
shift of TCG variable by 64 bits when variable 'sh' is 0, which is not
supported in TCG (values can be shifted by 0 to 63 bits). This patch fixe=
s
this by using two separate invocation of TCG shift functions, with maximu=
m
shift amount of 32.

Name of variable 'shifted' is changed to 'carry' so variable naming
is similar to old helper implementation.

Variables 'avrA' and 'avrB' are replaced with variable 'avr'.

Fixes: 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
Reported-by: "Paul A. Clark" <pc@us.ibm.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-Id: <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
Tested-by: Paul A. Clarke  <pc@us.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vmx-impl.inc.c | 84 ++++++++++++++---------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 2472a5217a..81d5a7a341 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -590,40 +590,38 @@ static void trans_vsl(DisasContext *ctx)
     int VT =3D rD(ctx->opcode);
     int VA =3D rA(ctx->opcode);
     int VB =3D rB(ctx->opcode);
-    TCGv_i64 avrA =3D tcg_temp_new_i64();
-    TCGv_i64 avrB =3D tcg_temp_new_i64();
+    TCGv_i64 avr =3D tcg_temp_new_i64();
     TCGv_i64 sh =3D tcg_temp_new_i64();
-    TCGv_i64 shifted =3D tcg_temp_new_i64();
+    TCGv_i64 carry =3D tcg_temp_new_i64();
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
-    /* Place bits 125-127 of vB in sh. */
-    get_avr64(avrB, VB, false);
-    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+    /* Place bits 125-127 of vB in 'sh'. */
+    get_avr64(avr, VB, false);
+    tcg_gen_andi_i64(sh, avr, 0x07ULL);
=20
     /*
-     * Save highest sh bits of lower doubleword element of vA in variabl=
e
-     * shifted and perform shift on lower doubleword.
+     * Save highest 'sh' bits of lower doubleword element of vA in varia=
ble
+     * 'carry' and perform shift on lower doubleword.
      */
-    get_avr64(avrA, VA, false);
-    tcg_gen_subfi_i64(tmp, 64, sh);
-    tcg_gen_shr_i64(shifted, avrA, tmp);
-    tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
-    tcg_gen_shl_i64(avrA, avrA, sh);
-    set_avr64(VT, avrA, false);
+    get_avr64(avr, VA, false);
+    tcg_gen_subfi_i64(tmp, 32, sh);
+    tcg_gen_shri_i64(carry, avr, 32);
+    tcg_gen_shr_i64(carry, carry, tmp);
+    tcg_gen_shl_i64(avr, avr, sh);
+    set_avr64(VT, avr, false);
=20
     /*
      * Perform shift on higher doubleword element of vA and replace lowe=
st
-     * sh bits with shifted.
+     * 'sh' bits with 'carry'.
      */
-    get_avr64(avrA, VA, true);
-    tcg_gen_shl_i64(avrA, avrA, sh);
-    tcg_gen_or_i64(avrA, avrA, shifted);
-    set_avr64(VT, avrA, true);
+    get_avr64(avr, VA, true);
+    tcg_gen_shl_i64(avr, avr, sh);
+    tcg_gen_or_i64(avr, avr, carry);
+    set_avr64(VT, avr, true);
=20
-    tcg_temp_free_i64(avrA);
-    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(avr);
     tcg_temp_free_i64(sh);
-    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(carry);
     tcg_temp_free_i64(tmp);
 }
=20
@@ -639,39 +637,37 @@ static void trans_vsr(DisasContext *ctx)
     int VT =3D rD(ctx->opcode);
     int VA =3D rA(ctx->opcode);
     int VB =3D rB(ctx->opcode);
-    TCGv_i64 avrA =3D tcg_temp_new_i64();
-    TCGv_i64 avrB =3D tcg_temp_new_i64();
+    TCGv_i64 avr =3D tcg_temp_new_i64();
     TCGv_i64 sh =3D tcg_temp_new_i64();
-    TCGv_i64 shifted =3D tcg_temp_new_i64();
+    TCGv_i64 carry =3D tcg_temp_new_i64();
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
-    /* Place bits 125-127 of vB in sh. */
-    get_avr64(avrB, VB, false);
-    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+    /* Place bits 125-127 of vB in 'sh'. */
+    get_avr64(avr, VB, false);
+    tcg_gen_andi_i64(sh, avr, 0x07ULL);
=20
     /*
-     * Save lowest sh bits of higher doubleword element of vA in variabl=
e
-     * shifted and perform shift on higher doubleword.
+     * Save lowest 'sh' bits of higher doubleword element of vA in varia=
ble
+     * 'carry' and perform shift on higher doubleword.
      */
-    get_avr64(avrA, VA, true);
-    tcg_gen_subfi_i64(tmp, 64, sh);
-    tcg_gen_shl_i64(shifted, avrA, tmp);
-    tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
-    tcg_gen_shr_i64(avrA, avrA, sh);
-    set_avr64(VT, avrA, true);
+    get_avr64(avr, VA, true);
+    tcg_gen_subfi_i64(tmp, 32, sh);
+    tcg_gen_shli_i64(carry, avr, 32);
+    tcg_gen_shl_i64(carry, carry, tmp);
+    tcg_gen_shr_i64(avr, avr, sh);
+    set_avr64(VT, avr, true);
     /*
      * Perform shift on lower doubleword element of vA and replace highe=
st
-     * sh bits with shifted.
+     * 'sh' bits with 'carry'.
      */
-    get_avr64(avrA, VA, false);
-    tcg_gen_shr_i64(avrA, avrA, sh);
-    tcg_gen_or_i64(avrA, avrA, shifted);
-    set_avr64(VT, avrA, false);
+    get_avr64(avr, VA, false);
+    tcg_gen_shr_i64(avr, avr, sh);
+    tcg_gen_or_i64(avr, avr, carry);
+    set_avr64(VT, avr, false);
=20
-    tcg_temp_free_i64(avrA);
-    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(avr);
     tcg_temp_free_i64(sh);
-    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(carry);
     tcg_temp_free_i64(tmp);
 }
=20
--=20
2.21.0


