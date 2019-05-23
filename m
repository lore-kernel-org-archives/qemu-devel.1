Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 23:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60382133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 23:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60382133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTxNt-0001A6-Vk
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 19:44:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTxKZ-0007TG-7a
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTxKY-0003e5-67
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hTxKY-0003dQ-16
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46184772DD;
	Thu, 23 May 2019 23:40:48 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53A2E600C4;
	Thu, 23 May 2019 23:40:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 01:40:11 +0200
Message-Id: <20190523234011.583-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190523234011.583-1-marcandre.lureau@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 23 May 2019 23:40:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] qemu-sockets: do not require configured
 ipv4/ipv6 address
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

podman containers without network don't have ipv4/ipv6 addresses other
than loopback address. However, some of our tests require
getaddrinfo("127.0.0.1") to succeed.

Alternatively, we may want to treat 127.0.0.1 as a special case, to
keep the AI_ADDRCONFIG convenience.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-sockets.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8850a280a8..f9c1392a05 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -31,10 +31,6 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
=20
-#ifndef AI_ADDRCONFIG
-# define AI_ADDRCONFIG 0
-#endif
-
 #ifndef AI_V4MAPPED
 # define AI_V4MAPPED 0
 #endif
@@ -385,7 +381,7 @@ static struct addrinfo *inet_parse_connect_saddr(Inet=
SocketAddress *saddr,
=20
     memset(&ai, 0, sizeof(ai));
=20
-    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
+    ai.ai_flags =3D AI_CANONNAME;
     if (atomic_read(&useV4Mapped)) {
         ai.ai_flags |=3D AI_V4MAPPED;
     }
@@ -472,7 +468,7 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr=
,
=20
     /* lookup peer addr */
     memset(&ai,0, sizeof(ai));
-    ai.ai_flags =3D AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
+    ai.ai_flags =3D AI_CANONNAME | AI_V4MAPPED;
     ai.ai_family =3D inet_ai_family_from_address(sraddr, &err);
     ai.ai_socktype =3D SOCK_DGRAM;
=20
--=20
2.22.0.rc1.1.g079e7d2849.dirty


