Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95939C352A4
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F1D20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0I+JxQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F1D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02kk-0002xo-K0
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j02gk-0006bi-Fi
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j02gj-0002x9-6M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j02gj-0002wn-2l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581078288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf1bEPsOQ+el19y8yBj1u6MqvEbYJmnNEEKnwpNAv0c=;
 b=O0I+JxQJ3ZlRvvugmK+iY9c4uVbCCxdUszggmIneYMrJNOgLBjjFTU42IuO2iYwBFWYwwW
 1Ibo7AnlYEjpz4sYuNxK/etHSpoLy0S1PfGC+L9J2J8EIGUlU+m6bOfftaBKS6lGzQP7Ef
 yrD8ZrHSkoAKYEhN1oXp2QLnMK5UUSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-72BwIxcNNd6ktsrgPuW-CQ-1; Fri, 07 Feb 2020 07:24:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548B58010F0;
 Fri,  7 Feb 2020 12:24:43 +0000 (UTC)
Received: from dhcp-16-105.lcy.redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A36B77FB60;
 Fri,  7 Feb 2020 12:24:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] io/channel-websock: treat 'binary' and no sub-protocol as
 the same
Date: Fri,  7 Feb 2020 12:24:38 +0000
Message-Id: <20200207122440.2650229-2-berrange@redhat.com>
In-Reply-To: <20200207122440.2650229-1-berrange@redhat.com>
References: <20200207122440.2650229-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 72BwIxcNNd6ktsrgPuW-CQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Yu-Chen Lin <npes87184@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yu-Chen Lin <npes87184@gmail.com>

noVNC doesn't use 'binary' protocol by default after
commit c912230309806aacbae4295faf7ad6406da97617.

It will cause qemu return 400 when handshaking.

To overcome this problem and remain compatibility of
older noVNC client.

We treat 'binary' and no sub-protocol as the same
so that we can support different version of noVNC
client.

Tested on noVNC before c912230 and after c912230.

Buglink: https://bugs.launchpad.net/qemu/+bug/1849644

Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-websock.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index fc36d44eba..47a0e941d9 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -49,13 +49,20 @@
     "Server: QEMU VNC\r\n"                       \
     "Date: %s\r\n"
=20
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \
+    "HTTP/1.1 101 Switching Protocols\r\n"              \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON            \
+    "Upgrade: websocket\r\n"                            \
+    "Connection: Upgrade\r\n"                           \
+    "Sec-WebSocket-Accept: %s\r\n"                      \
+    "Sec-WebSocket-Protocol: binary\r\n"                \
+    "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
     "HTTP/1.1 101 Switching Protocols\r\n"      \
     QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
     "Upgrade: websocket\r\n"                    \
     "Connection: Upgrade\r\n"                   \
     "Sec-WebSocket-Accept: %s\r\n"              \
-    "Sec-WebSocket-Protocol: binary\r\n"        \
     "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
     "HTTP/1.1 404 Not Found\r\n"                    \
@@ -336,6 +343,7 @@ qio_channel_websock_find_header(QIOChannelWebsockHTTPHe=
ader *hdrs,
=20
 static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *i=
oc,
                                                       const char *key,
+                                                      const bool use_proto=
cols,
                                                       Error **errp)
 {
     char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
@@ -361,8 +369,14 @@ static void qio_channel_websock_handshake_send_res_ok(=
QIOChannelWebsock *ioc,
     }
=20
     date =3D qio_channel_websock_date_str();
-    qio_channel_websock_handshake_send_res(
-        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
+    if (use_protocols) {
+            qio_channel_websock_handshake_send_res(
+                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK,
+                date, accept);
+    } else {
+            qio_channel_websock_handshake_send_res(
+                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
+    }
=20
     g_free(date);
     g_free(accept);
@@ -387,10 +401,6 @@ static void qio_channel_websock_handshake_process(QIOC=
hannelWebsock *ioc,
=20
     protocols =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
-    if (!protocols) {
-        error_setg(errp, "Missing websocket protocol header data");
-        goto bad_request;
-    }
=20
     version =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
@@ -430,10 +440,12 @@ static void qio_channel_websock_handshake_process(QIO=
ChannelWebsock *ioc,
     trace_qio_channel_websock_http_request(ioc, protocols, version,
                                            host, connection, upgrade, key)=
;
=20
-    if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
-        error_setg(errp, "No '%s' protocol is supported by client '%s'",
-                   QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
-        goto bad_request;
+    if (protocols) {
+            if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)=
) {
+                error_setg(errp, "No '%s' protocol is supported by client =
'%s'",
+                           QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols)=
;
+                goto bad_request;
+            }
     }
=20
     if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
@@ -467,7 +479,7 @@ static void qio_channel_websock_handshake_process(QIOCh=
annelWebsock *ioc,
         goto bad_request;
     }
=20
-    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
+    qio_channel_websock_handshake_send_res_ok(ioc, key, !!protocols, errp)=
;
     return;
=20
  bad_request:
--=20
2.24.1


