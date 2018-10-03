Received: from eggs.gnu.org ([2001:4830:134:3::10]:42162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erW-0000RV-At
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erS-0002iU-8S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7erR-0002Sg-Oe
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 14:57:50 +0400
Message-Id: <20181003105755.10862-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181003105755.10862-1-marcandre.lureau@redhat.com>
References: <20181003105755.10862-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] chardev: avoid crash if no associated
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A socket chardev may not have associated address (when adding client
fd manually for example). But on disconnect, updating socket filename
expects an address and may lead to this crash:

  Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
  0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x555556043062 "di=
sconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) at /home/=
elmarco/src/qq/chardev/char-socket.c:388
  388	    switch (addr->type) {
  (gdb) bt
  #0  0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x555556043062=
 "disconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) at /h=
ome/elmarco/src/qq/chardev/char-socket.c:388
  #1  0x0000555555d8c8aa in update_disconnected_filename (s=3D0x555556b1e=
d00) at /home/elmarco/src/qq/chardev/char-socket.c:419
  #2  0x0000555555d8c959 in tcp_chr_disconnect (chr=3D0x555556b1ed00) at =
/home/elmarco/src/qq/chardev/char-socket.c:438
  #3  0x0000555555d8cba1 in tcp_chr_hup (channel=3D0x555556b75690, cond=3D=
G_IO_HUP, opaque=3D0x555556b1ed00) at /home/elmarco/src/qq/chardev/char-s=
ocket.c:482
  #4  0x0000555555da596e in qio_channel_fd_source_dispatch (source=3D0x55=
5556bb68b0, callback=3D0x555555d8cb58 <tcp_chr_hup>, user_data=3D0x555556=
b1ed00) at /home/elmarco/src/qq/io/channel-watch.c:84

Replace filename with a generic "disconnected:socket" in this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7cd0ae2824..a75b46d9fe 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -423,8 +423,12 @@ static void update_disconnected_filename(SocketChard=
ev *s)
     Chardev *chr =3D CHARDEV(s);
=20
     g_free(chr->filename);
-    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
-                                         s->is_listen, s->is_telnet);
+    if (s->addr) {
+        chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
+                                             s->is_listen, s->is_telnet)=
;
+    } else {
+        chr->filename =3D g_strdup("disconnected:socket");
+    }
 }
=20
 /* NB may be called even if tcp_chr_connect has not been
--=20
2.19.0.271.gfe8321ec05
