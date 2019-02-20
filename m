Received: from eggs.gnu.org ([209.51.188.92]:41809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUP6-0002t9-58
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUP3-0005Yu-5b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwUP0-0005LK-6Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D259F14AF9B
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:06:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 17:06:28 +0100
Message-Id: <20190220160628.6555-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190220160628.6555-1-marcandre.lureau@redhat.com>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] char-socket: restart the reconnect timer
 to switch context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The reconnect timer is not switched to the given context, fix it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4fcdd8aedd..671861f98c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -632,6 +632,11 @@ static void tcp_chr_update_read_handler(Chardev *chr=
)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
+    if (s->reconnect_timer) {
+        tcp_chr_reconn_timer_cancel(s);
+        qemu_chr_socket_restart_timer(chr);
+    }
+
     if (s->listener) {
         /*
          * It's possible that chardev context is changed in
--=20
2.21.0.rc1
