Received: from eggs.gnu.org ([2001:4830:134:3::10]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5a-0003E1-Bq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5Z-0000JH-A7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpt5Z-0000Ii-5P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 290F98A4D8
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:54:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 09:54:38 +0100
Message-Id: <1490000078-31202-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
References: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/3] vnc: fix a qio-channel leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170317092802.17973-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8bfb1e0..6e93b88 100644
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
1.8.3.1
