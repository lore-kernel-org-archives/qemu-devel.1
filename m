Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B908C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D172076C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1XMWs4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D172076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFBx-0004bO-4e
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF68-0003ls-SD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF67-0003oK-Kb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF67-0003k6-1E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PA1TH5QcQ1BStW+tdM1XTu8QFduUmsERW533elcOEg=;
 b=R1XMWs4ZMxzHj/qZUJW/vvdpfyJhl1XfwoeBkTa8EAL5DFjkEkuTsKKJjAYbxfPgYgAlBV
 oNIbJv8+g6yT8WPH86x+qwPzZZqO8bMunCOX3FZLsWYSu9yM7B6gy73d2HYTCwDa7IB52a
 0MCRpRbzTpfdEaECv+vkXPtKOp4W0N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-5_4fJ7p7PsuMMwdoS0GInw-1; Wed, 22 Apr 2020 09:07:24 -0400
X-MC-Unique: 5_4fJ7p7PsuMMwdoS0GInw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE4CA0CC6
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 13:07:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2608E5C29A;
 Wed, 22 Apr 2020 13:07:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F87911358C6; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] io: Fix qio_channel_socket_close() error handling
Date: Wed, 22 Apr 2020 15:07:15 +0200
Message-Id: <20200422130719.28225-11-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

qio_channel_socket_close() passes @errp first to
socket_listen_cleanup(), and then, if closesocket() fails, to
error_setg_errno().  If socket_listen_cleanup() failed, this will trip
the assertion in error_setv().

Fix by ignoring a second error.

Fixes: 73564c407caedf992a1c688b5fea776a8b56ba2a
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index b74f5b92a0..e1b4667087 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -704,6 +704,7 @@ qio_channel_socket_close(QIOChannel *ioc,
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
     int rc =3D 0;
+    Error *err =3D NULL;
=20
     if (sioc->fd !=3D -1) {
 #ifdef WIN32
@@ -715,8 +716,8 @@ qio_channel_socket_close(QIOChannel *ioc,
=20
         if (closesocket(sioc->fd) < 0) {
             sioc->fd =3D -1;
-            error_setg_errno(errp, errno,
-                             "Unable to close socket");
+            error_setg_errno(&err, errno, "Unable to close socket");
+            error_propagate(errp, err);
             return -1;
         }
         sioc->fd =3D -1;
--=20
2.21.1


