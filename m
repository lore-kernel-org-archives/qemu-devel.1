Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D2020863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ffb-0004jo-Ua
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fTA-0002cA-Dq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fT9-0005I8-BA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fT6-0005Dk-Hk; Tue, 10 Sep 2019 08:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6376A2F86A;
 Tue, 10 Sep 2019 12:41:59 +0000 (UTC)
Received: from localhost (ovpn-117-90.ams2.redhat.com [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00FC45D6B2;
 Tue, 10 Sep 2019 12:41:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 14:41:33 +0200
Message-Id: <20190910124136.10565-5-mreitz@redhat.com>
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 12:41:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/7] curl: Pass CURLSocket to curl_multi_do()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

curl_multi_do_locked() currently marks all sockets as ready.  That is
not only inefficient, but in fact unsafe (the loop is).  A follow-up
patch will change that, but to do so, curl_multi_do_locked() needs to
know exactly which socket is ready; and that is accomplished by this
patch here.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 5838afef99..cf2686218d 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -185,15 +185,15 @@ static int curl_sock_cb(CURL *curl, curl_socket_t f=
d, int action,
     switch (action) {
         case CURL_POLL_IN:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_do, NULL, NULL, state);
+                               curl_multi_do, NULL, NULL, socket);
             break;
         case CURL_POLL_OUT:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               NULL, curl_multi_do, NULL, state);
+                               NULL, curl_multi_do, NULL, socket);
             break;
         case CURL_POLL_INOUT:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_do, curl_multi_do, NULL, state=
);
+                               curl_multi_do, curl_multi_do, NULL, socke=
t);
             break;
         case CURL_POLL_REMOVE:
             aio_set_fd_handler(s->aio_context, fd, false,
@@ -392,9 +392,10 @@ static void curl_multi_check_completion(BDRVCURLStat=
e *s)
 }
=20
 /* Called with s->mutex held.  */
-static void curl_multi_do_locked(CURLState *s)
+static void curl_multi_do_locked(CURLSocket *ready_socket)
 {
     CURLSocket *socket, *next_socket;
+    CURLState *s =3D ready_socket->state;
     int running;
     int r;
=20
@@ -413,12 +414,13 @@ static void curl_multi_do_locked(CURLState *s)
=20
 static void curl_multi_do(void *arg)
 {
-    CURLState *s =3D (CURLState *)arg;
+    CURLSocket *socket =3D arg;
+    BDRVCURLState *s =3D socket->state->s;
=20
-    qemu_mutex_lock(&s->s->mutex);
-    curl_multi_do_locked(s);
-    curl_multi_check_completion(s->s);
-    qemu_mutex_unlock(&s->s->mutex);
+    qemu_mutex_lock(&s->mutex);
+    curl_multi_do_locked(socket);
+    curl_multi_check_completion(s);
+    qemu_mutex_unlock(&s->mutex);
 }
=20
 static void curl_multi_timeout_do(void *arg)
--=20
2.21.0


