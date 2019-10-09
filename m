Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FEC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19891206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Fw0PgFZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19891206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEs5-0002Lb-HA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59E-0001XW-73
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59B-0006VJ-2s
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:31 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53977 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59A-0006PI-Mw; Wed, 09 Oct 2019 02:08:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gD2gkkz9sPf; Wed,  9 Oct 2019 17:08:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601304;
 bh=bDJ+lL6U7/EjRyMJMnAmLePHj2/5rsdcdvyY0UDu9xU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fw0PgFZTguwK62yr30BqolDZx60aWG9qPkcfW8zi8krI8c0gMkNagxYwT6moZ4hrl
 luqsxymGe7P7OIlajDZk+XQJE8cIBXWBd/ec5Aw7eZWZre61RbiWSbbkXA+mW/Ba3m
 NTHb9uPRXRli1uZxHRIzsWKf71xEuj8zK/3pvO1Y=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 03/19] target/ppc: Fix for optimized vsl/vsr instructions
Date: Wed,  9 Oct 2019 17:08:02 +1100
Message-Id: <20191009060818.29719-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, groug@kaod.org,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "Paul A. Clark" <pc@us.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
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


