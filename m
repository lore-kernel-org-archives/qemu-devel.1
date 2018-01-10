Received: from eggs.gnu.org ([2001:4830:134:3::10]:53323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZGHN-0002pg-SX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZGHI-0002dy-LN
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:18:53 -0500
Received: from mail-eopbgr30123.outbound.protection.outlook.com
	([40.107.3.123]:47858
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1eZGHH-0002be-Vq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:18:48 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 10 Jan 2018 16:18:32 +0300
Message-Id: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, den@virtuozzo.com

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
(type something and pres enter)
C-a x (to exit)

Do 3 times:
minicom -D unix\#/tmp/console.sock
C-a x

It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
the kernel, and the 4th blocks.

The problem is that QEMU doesn't add a read watcher after succesful read
until the guest device wants to acquire recieved data, so
I propose to install a separate pullhup watcher regardless of
whether the device waits for data or not. After closing the connection,
the guest has a capability to read the data within timeout.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
 chardev/char-socket.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 630a7f2995..eb120b2aab 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -37,6 +37,8 @@
 
 #define TCP_MAX_FDS 16
 
+#define DATA_TIMEOUT 1
+
 typedef struct {
     Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
@@ -57,6 +59,9 @@ typedef struct {
     bool is_telnet;
     bool is_tn3270;
 
+    guint data_timer;
+    guint destroy_tag;
+
     guint reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
@@ -341,6 +346,15 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num = 0;
     }
 
+    if (s->destroy_tag != 0) {
+        g_source_remove(s->destroy_tag);
+        s->destroy_tag = 0;
+    }
+    if (s->data_timer != 0) {
+        g_source_remove(s->data_timer);
+        s->data_timer = 0;
+    }
+
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
     object_unref(OBJECT(s->sioc));
@@ -444,6 +458,37 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
+static gboolean tcp_chr_data_timeout(gpointer opaque)
+{
+    Chardev *chr = CHARDEV(opaque);
+
+    if (tcp_chr_read_poll(chr) <= 0) {
+        tcp_chr_disconnect(chr);
+        return TRUE;
+    } else {
+        tcp_chr_read(NULL, 0, opaque);
+        return TRUE;
+    }
+}
+
+static gboolean tcp_chr_destroy(QIOChannel *channel,
+                               GIOCondition cond,
+                               void *opaque)
+{
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    tcp_chr_read(channel, cond, opaque);
+    if (s->connected != 0) {
+        s->data_timer = g_timeout_add_seconds(DATA_TIMEOUT,
+                                              tcp_chr_data_timeout, chr);
+        if (s->destroy_tag != 0) {
+            g_source_remove(s->destroy_tag);
+            s->destroy_tag = 0;
+        }
+    }
+    return TRUE;
+}
+
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -517,6 +562,10 @@ static void tcp_chr_connect(void *opaque)
                                            tcp_chr_read,
                                            chr, chr->gcontext);
     }
+    if (s->destroy_tag == 0) {
+        s->destroy_tag = qio_channel_add_watch(s->ioc, G_IO_HUP,
+                                           tcp_chr_destroy, chr, NULL);
+    }
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
@@ -535,7 +584,11 @@ static void tcp_chr_update_read_handler(Chardev *chr)
                                            tcp_chr_read, chr,
                                            chr->gcontext);
     }
-}
+    if (s->destroy_tag == 0) {
+        s->destroy_tag = qio_channel_add_watch(s->ioc, G_IO_HUP,
+                                           tcp_chr_destroy, chr, NULL);
+    }
+ }
 
 typedef struct {
     Chardev *chr;
-- 
2.14.3
