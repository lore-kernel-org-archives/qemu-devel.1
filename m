Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D190C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3922C21739
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvtmSxu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922C21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6V5-00080v-QD
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6K1-0000oL-GN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6K0-0001NR-12
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jz-0001LU-SZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZ2DbNqFEAdNbbqQ3g6CSccV8ATliONK13wR0ePiKL0=;
 b=ZvtmSxu/DVdF5w/JK1ykIjKTrn9b+FJVvCroKmz3gWP4QOkneSNL8Dg2f4atpCWPlMC8xU
 9YH0CitRmxfvRJ7gOvh8Vf9qzsrMaJyVu1EMCkkRC/CQbiupbHyEtaYbuK/tS8tt9sFxdI
 TKwYdjYLauspL7ynX1EfxJr7RVvPqOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-iU1fIHmYPi-DZ0pWfOOeJQ-1; Tue, 17 Dec 2019 01:27:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9ADB800D41;
 Tue, 17 Dec 2019 06:27:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 728CF6886C;
 Tue, 17 Dec 2019 06:26:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE4441136430; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Date: Tue, 17 Dec 2019 07:26:49 +0100
Message-Id: <20191217062651.9687-33-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: iU1fIHmYPi-DZ0pWfOOeJQ-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason for local_err here, use errp directly instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Message-Id: <20191205174635.18758-20-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/cryptodev.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 3c071eab95..5a9735684e 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -176,19 +176,10 @@ cryptodev_backend_complete(UserCreatable *uc, Error *=
*errp)
 {
     CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(uc);
     CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_GET_CLASS(uc);
-    Error *local_err =3D NULL;
=20
     if (bc->init) {
-        bc->init(backend, &local_err);
-        if (local_err) {
-            goto out;
-        }
+        bc->init(backend, errp);
     }
-
-    return;
-
-out:
-    error_propagate(errp, local_err);
 }
=20
 void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
--=20
2.21.0


