Received: from eggs.gnu.org ([2001:4830:134:3::10]:40946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp4-0003f7-BR
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp1-00015B-Ii
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxp1-00013l-D8
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D1189BB6A
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:48 +0200
Message-Id: <20180713130916.4153-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/29] chardev: avoid crash if no associated
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
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index efbad6ee7c..fa5bfb3b0e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -419,8 +419,12 @@ static void update_disconnected_filename(SocketChard=
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
2.18.0.129.ge3331758f1
