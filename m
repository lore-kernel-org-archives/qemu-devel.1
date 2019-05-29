Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72FC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECF221019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RWn4jKQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECF221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVt3F-0000fB-IE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:31:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQ3-0008HR-Go
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQ1-0002bA-QU
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:39 -0400
Received: from ozlabs.org ([203.11.71.1]:50785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQ1-0002YX-FA; Wed, 29 May 2019 02:50:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv30dnzz9sNd; Wed, 29 May 2019 16:50:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112623;
	bh=D6HlYklBeyORnQ3CRuWd6HqfaBBCxV2REDkcz3eR2Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWn4jKQUiFwyT50zFomoIEqdg2RtGLF3U3GJh7iv2e7WWU4PGoPjUYN5kU98mJFR0
	BkUD8YRAzE5tOE8Vdkux+PrmqaGjbL49ZENr9VocYzkb/LSBZ4DxzKO+CFqC7cnFva
	asI0n4dWr7n4sMgIGHW9BEgIeLbl1f/UsNEBvX0c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:44 +1000
Message-Id: <20190529065017.15149-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 11/44] target/ppc: Fix vslv and vsrv
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@ozlabs.org>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Blanchard <anton@ozlabs.org>

vslv and vsrv are broken on little endian, we append 00 to the
high byte not the low byte. Fix it by using the VsrB() accessor.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
Message-Id: <20190507004811.29968-6-anton@ozlabs.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 9af779ad38..2bad2d5620 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1815,10 +1815,10 @@ void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)
=20
     size =3D ARRAY_SIZE(r->u8);
     for (i =3D 0; i < size; i++) {
-        shift =3D b->u8[i] & 0x7;             /* extract shift value */
-        bytes =3D (a->u8[i] << 8) +             /* extract adjacent byte=
s */
-            (((i + 1) < size) ? a->u8[i + 1] : 0);
-        r->u8[i] =3D (bytes << shift) >> 8;   /* shift and store result =
*/
+        shift =3D b->VsrB(i) & 0x7;             /* extract shift value *=
/
+        bytes =3D (a->VsrB(i) << 8) +           /* extract adjacent byte=
s */
+            (((i + 1) < size) ? a->VsrB(i + 1) : 0);
+        r->VsrB(i) =3D (bytes << shift) >> 8;   /* shift and store resul=
t */
     }
 }
=20
@@ -1833,10 +1833,10 @@ void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)
      * order will guarantee that computed result is not fed back.
      */
     for (i =3D ARRAY_SIZE(r->u8) - 1; i >=3D 0; i--) {
-        shift =3D b->u8[i] & 0x7;                 /* extract shift value=
 */
-        bytes =3D ((i ? a->u8[i - 1] : 0) << 8) + a->u8[i];
+        shift =3D b->VsrB(i) & 0x7;               /* extract shift value=
 */
+        bytes =3D ((i ? a->VsrB(i - 1) : 0) << 8) + a->VsrB(i);
                                                 /* extract adjacent byte=
s */
-        r->u8[i] =3D (bytes >> shift) & 0xFF;     /* shift and store res=
ult */
+        r->VsrB(i) =3D (bytes >> shift) & 0xFF;   /* shift and store res=
ult */
     }
 }
=20
--=20
2.21.0


