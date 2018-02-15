Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emGkG-0003pC-LZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emGkC-0003pt-Ne
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:26:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emGkC-0003op-JM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:26:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00845818B10B
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:26:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 10:26:02 +0000
Message-Id: <20180215102602.10864-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: remove bogus object_unref on client socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

vnc_listen_io() does not own the reference on the 'cioc' parameter is it
passed, so should not be unref'ing it.

Reported-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/vnc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index c715bae1cf..b97769aa9e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3152,7 +3152,6 @@ static void vnc_listen_io(QIONetListener *listener,
                          isWebsock ? "vnc-ws-server" : "vnc-server");
     qio_channel_set_delay(QIO_CHANNEL(cioc), false);
     vnc_connect(vd, cioc, false, isWebsock);
-    object_unref(OBJECT(cioc));
 }
=20
 static const DisplayChangeListenerOps dcl_ops =3D {
--=20
2.14.3
