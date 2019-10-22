Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF2ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1634520B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PohcJwXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1634520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMx8R-0004TO-D0
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwxJ-0008Lg-G2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwxI-0007v2-Dh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:24:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwxI-0007us-AA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANOM+DENzs2RClux1nqzQgfztZmX7jOCZ0LMIkdZMSU=;
 b=PohcJwXAmGUrvjfihQ8eWtK9oeNA4Bh8/qxG/W6e5hVeyJ+QN0pisUYOJXUm1UIyoHAF3N
 6slkIAjT/wVdK8Mlp6vAWHhVh+Xh7uoPPJAGa/HGYou2aH+4iue8pU9bL1XmAZxItuUm5r
 KBl3cqi86Aftpu1j45TZM40w4Uh1YH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-O9SXo48dNq2giy1BQlKR7w-1; Tue, 22 Oct 2019 12:24:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF7F91800D79;
 Tue, 22 Oct 2019 16:24:13 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C32995D6A9;
 Tue, 22 Oct 2019 16:24:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/28] RFC: mips/cps: fix setting saar property
Date: Tue, 22 Oct 2019 18:21:30 +0200
Message-Id: <20191022162137.27161-22-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: O9SXo48dNq2giy1BQlKR7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "saar" property. Note: I haven't been able to test this
code. Help welcome.

May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:
Update ITU to utilize SAARI and SAAR CP0 registers")

Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/mips/cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 1660f86908..c49868d5da 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-pres=
ent",
                                  &err);
         if (saar_present) {
-            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->CP0_S=
AAR);
+            s->itu.saar =3D &env->CP0_SAAR;
         }
         object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
         if (err !=3D NULL) {
--=20
2.23.0.606.g08da6496b6


