Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1849FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A66215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI5XVGQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A66215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5x2-0007Ra-AQ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5nD-0003mf-N3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5nA-00044J-Qp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5nA-00042v-Ke
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nunur+v8C6yUd2Ig0aPCWyll3+RfwG+OyCvKxZXgQ6w=;
 b=CI5XVGQ5/QqN/gx2RlfVvJGQpuzq5ynAs6lBnE3SxGd55rG6pycSRxSIrhH6RR/uWB7qJ/
 fPV9erCwM/jzYEzVBI0Kzzcv3VdwnmsflxNiqpdQpOyDBOXWU7E/F8FCBK40mRPaHi4UP6
 k6l01PcjdZA3lXCitT7QdRgA6uM3b6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-FaHNDH-QMOS0q3r8iX7A9g-1; Fri, 08 Nov 2019 10:03:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648D2180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:03:13 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC505C1BB;
 Fri,  8 Nov 2019 15:03:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/25] qga: simplify dispatch_return_cb
Date: Fri,  8 Nov 2019 19:01:05 +0400
Message-Id: <20191108150123.12213-8-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FaHNDH-QMOS0q3r8iX7A9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 armbru@redhat.com, kraxel@redhat.com
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
@@ -531,9 +532,6 @@ static int send_response(GAState *s, const QDict *rsp)
     g_assert(rsp && s->channel);
=20
     payload_qstr =3D qobject_to_json(QOBJECT(rsp));
-    if (!payload_qstr) {
-        return -EINVAL;
-    }
=20
     if (s->delimit_response) {
         s->delimit_response =3D false;
@@ -550,18 +548,7 @@ static int send_response(GAState *s, const QDict *rsp)
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
2.24.0


