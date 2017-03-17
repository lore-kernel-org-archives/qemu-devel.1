Received: from eggs.gnu.org ([2001:4830:134:3::10]:46356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cooBF-0002FA-UF
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cooBC-0003Mh-Ro
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cooBC-0003M0-M4
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9637437F72
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:28:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Mar 2017 13:28:02 +0400
Message-Id: <20170317092802.17973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: fix a qio-channel leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8bfb1e0685..6e93b883b5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3677,6 +3677,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
         qio_channel_set_name(QIO_CHANNEL(sioc), name);
         if (qio_channel_socket_listen_sync(
                 sioc, rawaddrs[i], listenerr =3D=3D NULL ? &listenerr : =
NULL) < 0) {
+            object_unref(OBJECT(sioc));
             continue;
         }
         listening =3D true;
--=20
2.12.0.191.gc5d8de91d
