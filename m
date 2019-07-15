Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B994C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525DC2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525DC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6O5-0007vO-E5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Nq-00072q-0h
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Np-0003Md-3V
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:11:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hn6No-0003MU-Uj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D5C559461;
 Mon, 15 Jul 2019 19:11:32 +0000 (UTC)
Received: from localhost (ovpn-112-18.ams2.redhat.com [10.36.112.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C36560BEC;
 Mon, 15 Jul 2019 19:11:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:09:48 +0400
Message-Id: <20190715191001.1188-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190715191001.1188-1-marcandre.lureau@redhat.com>
References: <20190715191001.1188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 15 Jul 2019 19:11:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 07/20] qga: simplify dispatch_return_cb
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fold send_response().

qobject_to_json() can't return NULL (it will crash if allocation
failed, either in memcpy() or abort from g_realloc()).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index b005550c70..66fe7ac3de 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -522,8 +522,9 @@ fail:
 #endif
 }
=20
-static int send_response(GAState *s, const QDict *rsp)
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
 {
+    GAState *s =3D container_of(session, GAState, session);
     const char *buf;
     QString *payload_qstr, *response_qstr;
     GIOStatus status;
@@ -531,9 +532,6 @@ static int send_response(GAState *s, const QDict *rsp=
)
     g_assert(rsp && s->channel);
=20
     payload_qstr =3D qobject_to_json(QOBJECT(rsp));
-    if (!payload_qstr) {
-        return -EINVAL;
-    }
=20
     if (s->delimit_response) {
         s->delimit_response =3D false;
@@ -550,18 +548,7 @@ static int send_response(GAState *s, const QDict *rs=
p)
     status =3D ga_channel_write_all(s->channel, buf, strlen(buf));
     qobject_unref(response_qstr);
     if (status !=3D G_IO_STATUS_NORMAL) {
-        return -EIO;
-    }
-
-    return 0;
-}
-
-static void dispatch_return_cb(QmpSession *session, QDict *rsp)
-{
-    GAState *s =3D container_of(session, GAState, session);
-    int ret =3D send_response(s, rsp);
-    if (ret < 0) {
-        g_warning("error sending response: %s", strerror(-ret));
+        g_warning("Failed sending response");
     }
 }
=20
--=20
2.22.0.428.g6d5b264208


