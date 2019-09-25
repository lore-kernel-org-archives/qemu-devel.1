Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534EDC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2404621D81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2404621D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7fm-0000Eu-Bf
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iD7US-0003jS-0b
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iD7UQ-00065S-LN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iD7UQ-00065B-Fu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9FE4116BB32;
 Wed, 25 Sep 2019 13:37:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F189F19C7F;
 Wed, 25 Sep 2019 13:37:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/5] util/qemu-sockets: fix keep_alive handling in
 inet_connect_saddr
Date: Wed, 25 Sep 2019 08:37:40 -0500
Message-Id: <20190925133740.30401-6-eblake@redhat.com>
In-Reply-To: <20190925133740.30401-1-eblake@redhat.com>
References: <20190925133740.30401-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 25 Sep 2019 13:37:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In "if (saddr->keep_alive) {" we may already be on error path, with
invalid sock < 0. Fix it by returning error earlier.

Reported-by: Coverity (CID 1405300)
Fixes: aec21d31756cbd
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190910075943.12977-1-vsementsov@virtuozzo.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-sockets.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 98ff3a1cce64..bcc06d0e01c7 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -461,12 +461,13 @@ int inet_connect_saddr(InetSocketAddress *saddr, Er=
ror **errp)
         }
     }

+    freeaddrinfo(res);
+
     if (sock < 0) {
         error_propagate(errp, local_err);
+        return sock;
     }

-    freeaddrinfo(res);
-
     if (saddr->keep_alive) {
         int val =3D 1;
         int ret =3D qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
--=20
2.21.0


