Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4FC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87CB20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87CB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFICD-0001Yr-Vy
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAe-0008LM-F7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAd-0000En-B7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iFIAd-0000E8-5h
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6885E12E5;
 Tue,  1 Oct 2019 13:26:26 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661F35D9CC;
 Tue,  1 Oct 2019 13:26:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] util: WSAEWOULDBLOCK on connect should map to EINPROGRESS
Date: Tue,  1 Oct 2019 17:26:07 +0400
Message-Id: <20191001132609.23184-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191001132609.23184-1-marcandre.lureau@redhat.com>
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 01 Oct 2019 13:26:26 +0000 (UTC)
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In general, WSAEWOULDBLOCK can be mapped to EAGAIN as done by
socket_error() (or EWOULDBLOCK). But for connect() with non-blocking
sockets, it actually means the operation is in progress:

https://docs.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2-c=
onnect
"The socket is marked as nonblocking and the connection cannot be complet=
ed immediately."

(this is also the behaviour implemented by GLib GSocket)

This fixes socket_can_bind_connect() test on win32.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/oslib-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c62cd4328c..886e400d6a 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -585,7 +585,11 @@ int qemu_connect_wrap(int sockfd, const struct socka=
ddr *addr,
     int ret;
     ret =3D connect(sockfd, addr, addrlen);
     if (ret < 0) {
-        errno =3D socket_error();
+        if (WSAGetLastError() =3D=3D WSAEWOULDBLOCK) {
+            errno =3D EINPROGRESS;
+        } else {
+            errno =3D socket_error();
+        }
     }
     return ret;
 }
--=20
2.23.0


