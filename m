Received: from eggs.gnu.org ([2001:4830:134:3::10]:32829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cZILK-0000gM-GV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cZILH-0001sB-A9
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:26:34 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1512 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cZILG-0001ri-Ug
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:26:31 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  2 Feb 2017 17:26:29 +0300
Message-Id: <1486045589-8074-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/1] qemu-char: socket backend: disconnect
 on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Socket backend read handler should normally perform a disconnect, however
the read handler may not get a chance to run if the frontend is not ready
(qemu_chr_be_can_write() =3D=3D 0).

This means that in virtio-serial frontend case if
 - the host has disconnected (giving EPIPE on socket write)
 - and the guest has disconnected (-> frontend not ready -> backend
   will not read)
 - and there is still data (frontend->backend) to flush (has to be a real=
ly
   tricky timing but nevertheless, we have observed the case in productio=
n)

This results in virtio-serial trying to flush this data continiously form=
ing
a busy loop.

Solution: react on write error in the socket write handler.
errno is not reliable after qio_channel_writev_full(), so we may not get
the exact EPIPE, so disconnect on any error but QIO_CHANNEL_ERR_BLOCK whi=
ch
io_channel_send_full() converts to errno EAGAIN.
We must not disconnect right away though, there still may be data to read
(see 4bf1cb0).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
Changes from v2:
- fixed prototype of tcp_chr_disconnect

Changes from v1:
- we do not rely on EPIPE anynore. Socket should be closed on all errors
  except EAGAIN

 chardev/char-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4068dc5..865c527 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -97,6 +97,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
                                GIOCondition cond,
                                void *opaque);
=20
+static int tcp_chr_read_poll(void *opaque);
+static void tcp_chr_disconnect(Chardev *chr);
+
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -114,6 +117,13 @@ static int tcp_chr_write(Chardev *chr, const uint8_t=
 *buf, int len)
             s->write_msgfds_num =3D 0;
         }
=20
+        if (ret < 0 && errno !=3D EAGAIN) {
+            if (tcp_chr_read_poll(chr) <=3D 0) {
+                tcp_chr_disconnect(chr);
+                return len;
+            } /* else let the read handler finish it properly */
+        }
+
         return ret;
     } else {
         /* XXX: indicate an error ? */
--=20
2.7.4
