Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7008206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7008206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sJI-0002jX-Vs
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ruQ-0003Dj-S8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ruP-0000nN-GY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ruM-0000mJ-KC; Mon, 16 Sep 2019 10:23:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E297A796E0;
 Mon, 16 Sep 2019 14:23:13 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C7DC1001B13;
 Mon, 16 Sep 2019 14:23:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:38 +0200
Message-Id: <20190916142246.31474-9-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 16 Sep 2019 14:23:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/16] curl: Check completion in curl_multi_do()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it is more likely that transfers complete after some file
descriptor has data ready to read, we probably should not rely on it.
Better be safe than sorry and call curl_multi_check_completion() in
curl_multi_do(), too, just like it is done in curl_multi_read().

With this change, curl_multi_do() and curl_multi_read() are actually the
same, so drop curl_multi_read() and use curl_multi_do() as the sole FD
handler.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190910124136.10565-4-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 95d7b77dc0..5838afef99 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -139,7 +139,6 @@ typedef struct BDRVCURLState {
=20
 static void curl_clean_state(CURLState *s);
 static void curl_multi_do(void *arg);
-static void curl_multi_read(void *arg);
=20
 #ifdef NEED_CURL_TIMER_CALLBACK
 /* Called from curl_multi_do_locked, with s->mutex held.  */
@@ -186,7 +185,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd,=
 int action,
     switch (action) {
         case CURL_POLL_IN:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, NULL, NULL, state);
+                               curl_multi_do, NULL, NULL, state);
             break;
         case CURL_POLL_OUT:
             aio_set_fd_handler(s->aio_context, fd, false,
@@ -194,7 +193,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd,=
 int action,
             break;
         case CURL_POLL_INOUT:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, curl_multi_do, NULL, sta=
te);
+                               curl_multi_do, curl_multi_do, NULL, state=
);
             break;
         case CURL_POLL_REMOVE:
             aio_set_fd_handler(s->aio_context, fd, false,
@@ -416,15 +415,6 @@ static void curl_multi_do(void *arg)
 {
     CURLState *s =3D (CURLState *)arg;
=20
-    qemu_mutex_lock(&s->s->mutex);
-    curl_multi_do_locked(s);
-    qemu_mutex_unlock(&s->s->mutex);
-}
-
-static void curl_multi_read(void *arg)
-{
-    CURLState *s =3D (CURLState *)arg;
-
     qemu_mutex_lock(&s->s->mutex);
     curl_multi_do_locked(s);
     curl_multi_check_completion(s->s);
--=20
2.21.0


