Received: from eggs.gnu.org ([2001:4830:134:3::10]:37709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cYul7-0000dQ-Lb
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cYul3-0004ea-IQ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:15:37 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:44246 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cYul3-0004eK-6i
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:15:33 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  1 Feb 2017 16:15:28 +0300
Message-Id: <1485954928-22287-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] qemu_char: socket backend: disconnect on
 EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Socket backend read handler should normally perform a disconnect, however
the read handler may not get a chance to run if the frontend is not ready
(qemu_chr_be_can_write == 0).

This means that in virtio-serial frontend case if
 - the host has disconnected (giving EPIPE on socket write)
 - and the guest has disconnected (-> frontend not ready -> backend
   will not read)
 - and there is still data (frontend->backend) to flush (has to be a really
   tricky timing but nevertheless, we have observed the case in production)

This results in virtio-serial trying to flush this data continiously forming
a busy loop.

Solution: react on EPIPE in the socket write handler. We must not disconnect
right away though, there still may be data to read (see 4bf1cb0).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-char.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/qemu-char.c b/qemu-char.c
index 6b4a299..f1f7a07 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1202,7 +1202,7 @@ static int io_channel_send_full(QIOChannel *ioc,
             errno = EAGAIN;
             return -1;
         } else if (ret < 0) {
-            errno = EINVAL;
+            errno = errno == EPIPE ? EPIPE : EINVAL;
             return -1;
         }
 
@@ -2854,6 +2854,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
                                GIOCondition cond,
                                void *opaque);
 
+static int tcp_chr_read_poll(void *opaque);
+static void tcp_chr_disconnect(Chardev *chr);
+
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -2871,6 +2874,13 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
             s->write_msgfds_num = 0;
         }
 
+        if (ret < 0 && errno == EPIPE) {
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
2.7.4
