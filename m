Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A8C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BFA206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTiHCN1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BFA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRvY-0002jy-3N
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56454 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrA-0002st-O1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRr9-0006uz-UL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44613
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRr9-0006sn-Gq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc/ix8FdW6/SCJf2RneUwHtmQ4Mxt7ZATaDhXfEvU9A=;
 b=XTiHCN1rraW4/RpzDGOw8HIE+0uDyFpZBi6oJdzviCJOR635kXYVkMnLm4MMse5TzQCJOW
 +GclpDGrbssWZ03oja37Jdt5sjf63ImEjimgmDB7htqJoB9XDd3ny+OLnQpRDKBacXJFrX
 cicCLkOYatHNlQkwtsa6fp0b82Ts/q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-hz9251v_O1m0u_b__-Yiig-1; Mon, 20 Apr 2020 04:32:40 -0400
X-MC-Unique: hz9251v_O1m0u_b__-Yiig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0983F107ACC9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCAF011E7E1;
 Mon, 20 Apr 2020 08:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF11311358C6; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] io: Fix qio_channel_socket_close() error handling
Date: Mon, 20 Apr 2020 10:32:35 +0200
Message-Id: <20200420083236.19309-11-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


