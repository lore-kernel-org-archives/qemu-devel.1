Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F87C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5861A21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5861A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP68z-0001ca-J1
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:05:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65O-0007Ba-D8
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65N-00025P-El
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP65N-000255-9X
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A50B4308620C
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:01:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71672600CC;
	Fri, 10 May 2019 14:01:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 60F0FA208; Fri, 10 May 2019 16:01:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 16:01:00 +0200
Message-Id: <20190510140103.3834-6-kraxel@redhat.com>
In-Reply-To: <20190510140103.3834-1-kraxel@redhat.com>
References: <20190510140103.3834-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 10 May 2019 14:01:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] util: simplify unix_listen()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The only caller of unix_listen() left is qga/channel-posix.c.

There is no need to deal with legacy coma-trailing options ",...".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190503130034.24916-6-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/qemu-sockets.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index ba6335e71a95..8850a280a84b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -970,26 +970,12 @@ static int unix_connect_saddr(UnixSocketAddress *sa=
ddr, Error **errp)
 /* compatibility wrapper */
 int unix_listen(const char *str, Error **errp)
 {
-    char *path, *optstr;
-    int sock, len;
     UnixSocketAddress *saddr;
+    int sock;
=20
     saddr =3D g_new0(UnixSocketAddress, 1);
-
-    optstr =3D strchr(str, ',');
-    if (optstr) {
-        len =3D optstr - str;
-        if (len) {
-            path =3D g_malloc(len+1);
-            snprintf(path, len+1, "%.*s", len, str);
-            saddr->path =3D path;
-        }
-    } else {
-        saddr->path =3D g_strdup(str);
-    }
-
+    saddr->path =3D g_strdup(str);
     sock =3D unix_listen_saddr(saddr, errp);
-
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
--=20
2.18.1


