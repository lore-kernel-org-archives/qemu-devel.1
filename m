Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D878CC04A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99524206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="VG9iYfMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99524206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36137 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNoOL-0004UX-SP
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHY-0006r4-Jv
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHX-0002xn-Fd
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43833 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hNoHX-0002wC-4G; Mon, 06 May 2019 20:48:31 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 44ygvc40f3z9sML; Tue,  7 May 2019 10:48:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557190108; bh=Br7n9jkoD7Lz4TVAjhUWzEgGMOPCpu2rEkoH84CVUho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VG9iYfMe86sZELUAq8cwa8DoOAaS4K1Fv4fJS0Iz8KHFGPNuxWCw53cGzFXaQ8+ob
	CllELd1jla4DKWBjP98NXuUpQImlEVauaT79QHm2Eg1mCkKM4FmTb+jauhUhoHDNkA
	vdAEdLMBCSxMa6+ORfNWC/KyoXrtoIpTAphBOi0XSyPFI4aNlln3X/af8YId7nSkwT
	P2mB++Kf2tg8H6JPdNxM2vkxcDFTMwJ+s0spPNNNK8ggmLF274iaPdYIIcX+7v6UfN
	9PTnMNzzqNV6rw4l9yv8XryQ5eFPRkbz3UzpQasUm+8wxf/yd1CVQJEkmwZ0DEusMC
	dVBfNVso9XInA==
From: Anton Blanchard <anton@ozlabs.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:48:08 +1000
Message-Id: <20190507004811.29968-6-anton@ozlabs.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507004811.29968-1-anton@ozlabs.org>
References: <20190507004811.29968-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH 6/9] target/ppc: Fix vslv and vsrv
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, mark.cave-ayland@ilande.co.uk,
	f4bug@amsat.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vslv and vsrv are broken on little endian, we append 00 to the
high byte not the low byte. Fix it by using the VsrB() accessor.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
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
2.20.1


