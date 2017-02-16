Received: from eggs.gnu.org ([2001:4830:134:3::10]:51742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6Q-0003ad-2V
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6P-00082n-7A
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:10 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6P-00082d-0U
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:09 -0500
Received: by mail-wr0-x242.google.com with SMTP id z61so1487307wrc.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:29 +0100
Message-Id: <1487255507-106654-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/23] qemu-char: socket backend: disconnect on
 write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=83=C2=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Socket backend read handler should normally perform a disconnect, however
the read handler may not get a chance to run if the frontend is not ready
(qemu_chr_be_can_write() == 0).

This means that in virtio-serial frontend case if
 - the host has disconnected (giving EPIPE on socket write)
 - and the guest has disconnected (-> frontend not ready -> backend
   will not read)
 - and there is still data (frontend->backend) to flush (has to be a really
   tricky timing but nevertheless, we have observed the case in production)

This results in virtio-serial trying to flush this data continiously forming
a busy loop.

Solution: react on write error in the socket write handler.
errno is not reliable after qio_channel_writev_full(), so we may not get
the exact EPIPE, so disconnect on any error but QIO_CHANNEL_ERR_BLOCK which
io_channel_send_full() converts to errno EAGAIN.
We must not disconnect right away though, there still may be data to read
(see 4bf1cb0).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <1486045589-8074-1-git-send-email-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4068dc5..865c527 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -97,6 +97,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
                                GIOCondition cond,
                                void *opaque);
 
+static int tcp_chr_read_poll(void *opaque);
+static void tcp_chr_disconnect(Chardev *chr);
+
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -114,6 +117,13 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
             s->write_msgfds_num = 0;
         }
 
+        if (ret < 0 && errno != EAGAIN) {
+            if (tcp_chr_read_poll(chr) <= 0) {
+                tcp_chr_disconnect(chr);
+                return len;
+            } /* else let the read handler finish it properly */
+        }
+
         return ret;
     } else {
         /* XXX: indicate an error ? */
-- 
1.8.3.1
