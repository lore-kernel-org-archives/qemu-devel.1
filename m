Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A07C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5F0214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5F0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2eSa-0004yS-7G
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2eQl-0003RE-EK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2eQk-0000Fc-DJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2eQi-0000Dt-1A; Tue, 27 Aug 2019 12:34:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44CEA18AF95E;
 Tue, 27 Aug 2019 16:34:47 +0000 (UTC)
Received: from localhost (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE5985DAAF;
 Tue, 27 Aug 2019 16:34:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 27 Aug 2019 18:34:35 +0200
Message-Id: <20190827163439.16686-3-mreitz@redhat.com>
In-Reply-To: <20190827163439.16686-1-mreitz@redhat.com>
References: <20190827163439.16686-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 27 Aug 2019 16:34:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] curl: Keep *socket until the end of
 curl_sock_cb()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not really change anything, but it makes the code a bit easier
to follow once we use @socket as the opaque pointer for
aio_set_fd_handler().

(Also, this change stops us from creating new CURLSocket objects when
the cURL library just wants to stop listening on an existing socket that
we do not recognize.  With a well-behaving cURL, that should never
happen anyway.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 92dc2f630e..8a45b371cc 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -174,18 +174,16 @@ static int curl_sock_cb(CURL *curl, curl_socket_t f=
d, int action,
         if (socket->fd =3D=3D fd) {
             if (action =3D=3D CURL_POLL_REMOVE) {
                 QLIST_REMOVE(socket, next);
-                g_free(socket);
             }
             break;
         }
     }
-    if (!socket) {
+    if (action !=3D CURL_POLL_REMOVE && !socket) {
         socket =3D g_new0(CURLSocket, 1);
         socket->fd =3D fd;
         socket->state =3D state;
         QLIST_INSERT_HEAD(&state->sockets, socket, next);
     }
-    socket =3D NULL;
=20
     trace_curl_sock_cb(action, (int)fd);
     switch (action) {
@@ -207,6 +205,9 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd,=
 int action,
             break;
     }
=20
+    if (action =3D=3D CURL_POLL_REMOVE) {
+        g_free(socket);
+    }
     return 0;
 }
=20
--=20
2.21.0


