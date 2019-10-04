Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAED82133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Exh4qwfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAED82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKTo-0007mt-9Q
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2i-0005Lx-Jy
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2g-0005UI-Lh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42379 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2g-0005Rj-6n; Fri, 04 Oct 2019 05:38:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YM5PpGz9sSC; Fri,  4 Oct 2019 19:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181879;
 bh=iqohZkDGljecVREIaqjZ4QqBZV8/Qwt6VAbtTA6T0sw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Exh4qwfVpLDl4A0BWyXkoH4uOlwST89ULnT7kvRjQIC1TF5kKqvDKPPTvvNSyLPsK
 Pu9gJG/Bj49ZsWwh8uvewXnr+wtga/J5KYzD2SA0mMQTQjIK0uJ8cFR1A+XSE2iP01
 oQabXM0oaDuMJcd1Wn2L5Wwe+FsYkqIHzpx23/a4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 31/53] target/ppc: use Vsr macros in BCD helpers
Date: Fri,  4 Oct 2019 19:37:25 +1000
Message-Id: <20191004093747.31350-32-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This allows us to remove more endian-specific defines from int_helper.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 72 ++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 46deb57a34..6d238b989d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2052,15 +2052,11 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, ppc_avr_t *c)
 #define NATIONAL_PLUS   0x2B
 #define NATIONAL_NEG    0x2D
=20
-#if defined(HOST_WORDS_BIGENDIAN)
 #define BCD_DIG_BYTE(n) (15 - ((n) / 2))
-#else
-#define BCD_DIG_BYTE(n) ((n) / 2)
-#endif
=20
 static int bcd_get_sgn(ppc_avr_t *bcd)
 {
-    switch (bcd->u8[BCD_DIG_BYTE(0)] & 0xF) {
+    switch (bcd->VsrB(BCD_DIG_BYTE(0)) & 0xF) {
     case BCD_PLUS_PREF_1:
     case BCD_PLUS_PREF_2:
     case BCD_PLUS_ALT_1:
@@ -2095,9 +2091,9 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int n,=
 int *invalid)
 {
     uint8_t result;
     if (n & 1) {
-        result =3D bcd->u8[BCD_DIG_BYTE(n)] >> 4;
+        result =3D bcd->VsrB(BCD_DIG_BYTE(n)) >> 4;
     } else {
-       result =3D bcd->u8[BCD_DIG_BYTE(n)] & 0xF;
+       result =3D bcd->VsrB(BCD_DIG_BYTE(n)) & 0xF;
     }
=20
     if (unlikely(result > 9)) {
@@ -2109,11 +2105,11 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int =
n, int *invalid)
 static void bcd_put_digit(ppc_avr_t *bcd, uint8_t digit, int n)
 {
     if (n & 1) {
-        bcd->u8[BCD_DIG_BYTE(n)] &=3D 0x0F;
-        bcd->u8[BCD_DIG_BYTE(n)] |=3D (digit << 4);
+        bcd->VsrB(BCD_DIG_BYTE(n)) &=3D 0x0F;
+        bcd->VsrB(BCD_DIG_BYTE(n)) |=3D (digit << 4);
     } else {
-        bcd->u8[BCD_DIG_BYTE(n)] &=3D 0xF0;
-        bcd->u8[BCD_DIG_BYTE(n)] |=3D digit;
+        bcd->VsrB(BCD_DIG_BYTE(n)) &=3D 0xF0;
+        bcd->VsrB(BCD_DIG_BYTE(n)) |=3D digit;
     }
 }
=20
@@ -2228,21 +2224,21 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
=20
     if (!invalid) {
         if (sgna =3D=3D sgnb) {
-            result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, ps);
+            result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgna, ps)=
;
             bcd_add_mag(&result, a, b, &invalid, &overflow);
             cr =3D bcd_cmp_zero(&result);
         } else {
             int magnitude =3D bcd_cmp_mag(a, b);
             if (magnitude > 0) {
-                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, p=
s);
+                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgna,=
 ps);
                 bcd_sub_mag(&result, a, b, &invalid, &overflow);
                 cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
             } else if (magnitude < 0) {
-                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgnb, p=
s);
+                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgnb,=
 ps);
                 bcd_sub_mag(&result, b, a, &invalid, &overflow);
                 cr =3D (sgnb > 0) ? CRF_GT : CRF_LT;
             } else {
-                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(0, ps);
+                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(0, ps=
);
                 cr =3D CRF_EQ;
             }
         }
@@ -2353,15 +2349,15 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b=
, uint32_t ps)
     int zone_lead =3D ps ? 0xF : 0x3;
     int digit =3D 0;
     ppc_avr_t ret =3D { .u64 =3D { 0, 0 } };
-    int sgnb =3D b->u8[BCD_DIG_BYTE(0)] >> 4;
+    int sgnb =3D b->VsrB(BCD_DIG_BYTE(0)) >> 4;
=20
     if (unlikely((sgnb < 0xA) && ps)) {
         invalid =3D 1;
     }
=20
     for (i =3D 0; i < 16; i++) {
-        zone_digit =3D i ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
-        digit =3D b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
+        zone_digit =3D i ? b->VsrB(BCD_DIG_BYTE(i * 2)) >> 4 : zone_lead=
;
+        digit =3D b->VsrB(BCD_DIG_BYTE(i * 2)) & 0xF;
         if (unlikely(zone_digit !=3D zone_lead || digit > 0x9)) {
             invalid =3D 1;
             break;
@@ -2407,7 +2403,7 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, =
uint32_t ps)
             break;
         }
=20
-        ret.u8[BCD_DIG_BYTE(i * 2)] =3D zone_lead + digit;
+        ret.VsrB(BCD_DIG_BYTE(i * 2)) =3D zone_lead + digit;
     }
=20
     if (ps) {
@@ -2519,7 +2515,7 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a=
, ppc_avr_t *b, uint32_t ps)
     }
=20
     *r =3D *a;
-    bcd_put_digit(r, b->u8[BCD_DIG_BYTE(0)] & 0xF, 0);
+    bcd_put_digit(r, b->VsrB(BCD_DIG_BYTE(0)) & 0xF, 0);
=20
     for (i =3D 1; i < 32; i++) {
         bcd_get_digit(a, i, &invalid);
@@ -2549,11 +2545,7 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t =
*b, uint32_t ps)
 uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t =
ps)
 {
     int cr;
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i =3D a->s8[7];
-#else
-    int i =3D a->s8[8];
-#endif
+    int i =3D a->VsrSB(7);
     bool ox_flag =3D false;
     int sgnb =3D bcd_get_sgn(b);
     ppc_avr_t ret =3D *b;
@@ -2602,11 +2594,7 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t ps)
         }
     }
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-    i =3D a->s8[7];
-#else
-    i =3D a->s8[8];
-#endif
+    i =3D a->VsrSB(7);
     if (i >=3D 32) {
         ox_flag =3D true;
         ret.VsrD(1) =3D ret.VsrD(0) =3D 0;
@@ -2637,13 +2625,11 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a,=
 ppc_avr_t *b, uint32_t ps)
     ppc_avr_t ret =3D *b;
     ret.VsrD(1) &=3D ~0xf;
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i =3D a->s8[7];
-    ppc_avr_t bcd_one =3D { .u64 =3D { 0, 0x10 } };
-#else
-    int i =3D a->s8[8];
-    ppc_avr_t bcd_one =3D { .u64 =3D { 0x10, 0 } };
-#endif
+    int i =3D a->VsrSB(7);
+    ppc_avr_t bcd_one;
+
+    bcd_one.VsrD(0) =3D 0;
+    bcd_one.VsrD(1) =3D 0x10;
=20
     if (bcd_is_valid(b) =3D=3D false) {
         return CRF_SO;
@@ -2679,11 +2665,7 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
 {
     uint64_t mask;
     uint32_t ox_flag =3D 0;
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i =3D a->s16[3] + 1;
-#else
-    int i =3D a->s16[4] + 1;
-#endif
+    int i =3D a->VsrSH(3) + 1;
     ppc_avr_t ret =3D *b;
=20
     if (bcd_is_valid(b) =3D=3D false) {
@@ -2728,11 +2710,7 @@ uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t =
*a, ppc_avr_t *b, uint32_t ps)
         }
     }
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-    i =3D a->s16[3];
-#else
-    i =3D a->s16[4];
-#endif
+    i =3D a->VsrSH(3);
     if (i > 16 && i < 33) {
         mask =3D (uint64_t)-1 >> (128 - i * 4);
         if (ret.VsrD(0) & ~mask) {
--=20
2.21.0


