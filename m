Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE9C2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E2D21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9VMTo/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E2D21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUum-00076G-LC
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWa-00067G-48
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWY-0002c4-Tx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWW-0002YW-KE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZ2DbNqFEAdNbbqQ3g6CSccV8ATliONK13wR0ePiKL0=;
 b=i9VMTo/3pRnmNhpOVMQsCCHMmE2iF8t9dnIpmCohlPLk+GvjgseO/4+GoL91QyO8smOL8+
 wzIz88Cw3a4SaTnHUursQrlTnj7galGe+zqqXmfmvjn4lZEHmFZYunF3zz7y+pLNEACahy
 YlKmv22PmH68B40umqXA2PgPwuoHvI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-VB7uZBIpNLyzO3XkCVIYDg-1; Wed, 18 Dec 2019 03:17:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9475D800D5A;
 Wed, 18 Dec 2019 08:17:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43A5F60C18;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7F8C1136431; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 33/35] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Date: Wed, 18 Dec 2019 09:17:19 +0100
Message-Id: <20191218081721.23520-34-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VB7uZBIpNLyzO3XkCVIYDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


