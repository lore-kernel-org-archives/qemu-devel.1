Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC27C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A8421743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TxcLUtvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A8421743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSyV0-000138-Si
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:43:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHV-0005sl-TZ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHU-0007mL-AH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyHT-0007hd-Rc; Tue, 21 May 2019 02:29:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qpg0tHvz9sNs; Tue, 21 May 2019 16:29:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420171;
	bh=ixFuCpsnBZYHkeYrLQ26Rb+EWQNCUX6wDdO2BVyDFVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxcLUtvc+ykPP3Uu1vkVJPuZfS5EwdAGKnK4R+XwNu/sayor/N4RNILicB7H2/S2X
	yDrEKK/vaked4QGez2gyFR1EDZ0i6U7SWJk/C7cFUwAmdbDn21+QYxrtsfOFw/ayd5
	Vprdpa+VlJ16ELd5DVpdpod8T05QH4hxGb+ftzWk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:28:56 +1000
Message-Id: <20190521062924.6930-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 10/38] target/ppc: Fix vslv and vsrv
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
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org, Anton Blanchard <anton@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
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
index f6a088ac08..fd715b4076 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1800,10 +1800,10 @@ void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
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
@@ -1818,10 +1818,10 @@ void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
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


