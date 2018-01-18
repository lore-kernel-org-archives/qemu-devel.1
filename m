Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecBFk-0008Bs-Ru
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecBFh-0008Lj-HE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:33:16 -0500
Received: from mail-he1eur01on0103.outbound.protection.outlook.com
	([104.47.0.103]:36580
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ecBFg-0008Je-Cj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:33:13 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Thu, 18 Jan 2018 17:33:01 +0300
Message-Id: <20180118143301.10864-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com

The following behavior was observed for QEMU configured by libvirt
to use guest agent as usual for the guests without virtio-serial
driver (Windows or the guest remaining in BIOS stage).

In QEMU on first connect to listen character device socket
the listen socket is removed from poll just after the accept().
virtio_serial_guest_ready() returns 0 and the descriptor
of the connected Unix socket is removed from poll and it will
not be present in poll() until the guest will initialize the driver
and change the state of the serial to "guest connected".

In libvirt connect() to guest agent is performed on restart and
is run under VM state lock. Connect() is blocking and can
wait forever.
In this case libvirt can not perform ANY operation on that VM.

The bug can be easily reproduced this way:

Terminal 1:
qemu-system-x86_64 -m 512 -device pci-serial,chardev=serial1 -chardev socket,id=serial1,path=/tmp/console.sock,server,nowait
(virtio-serial and isa-serial also fit)

Terminal 2:
minicom -D unix\#/tmp/console.sock
(type something and press enter)
C-a x (to exit)

Do 3 times:
minicom -D unix\#/tmp/console.sock
C-a x

It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
the kernel, and the 4th blocks.

The problem is that QEMU doesn't add a read watcher after succesful read
until the guest device wants to acquire recieved data, so
I propose to install a separate pullhup watcher regardless of
whether the device waits for data or not.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
Changelog:
v2: Remove timer as a redundant feature

 chardev/char-socket.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 77cdf487eb..d3fe903ab6 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -42,6 +42,7 @@ typedef struct {
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIONetListener *listener;
+    guint hup_tag;
     QCryptoTLSCreds *tls_creds;
     int connected;
     int max_size;
@@ -352,6 +353,11 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num = 0;
     }
 
+    if (s->hup_tag != 0) {
+        g_source_remove(s->hup_tag);
+        s->hup_tag = 0;
+    }
+
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
     object_unref(OBJECT(s->sioc));
@@ -455,6 +461,19 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
+static gboolean tcp_chr_hup(QIOChannel *channel,
+                               GIOCondition cond,
+                               void *opaque)
+{
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    tcp_chr_read(channel, cond, opaque);
+    if (s->connected != 0) {
+        tcp_chr_disconnect(chr);
+    }
+    return TRUE;
+}
+
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -528,6 +547,10 @@ static void tcp_chr_connect(void *opaque)
                                            tcp_chr_read,
                                            chr, chr->gcontext);
     }
+    if (s->hup_tag == 0) {
+        s->hup_tag = qio_channel_add_watch(s->ioc, G_IO_HUP,
+                                           tcp_chr_hup, chr, NULL);
+    }
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
@@ -546,7 +569,11 @@ static void tcp_chr_update_read_handler(Chardev *chr)
                                            tcp_chr_read, chr,
                                            chr->gcontext);
     }
-}
+    if (s->hup_tag == 0) {
+        s->hup_tag = qio_channel_add_watch(s->ioc, G_IO_HUP,
+                                           tcp_chr_hup, chr, NULL);
+    }
+ }
 
 typedef struct {
     Chardev *chr;
-- 
2.14.3
