Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSP-0004aZ-2V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSN-00053h-Qg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSN-00053U-Iy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id f3so28130267wmc.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:39 +0100
Message-Id: <1517858941-5538-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/47] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Klim Kireev <klim.kireev@virtuozzo.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

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
Message-Id: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 77cdf48..a340af6 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -42,6 +42,7 @@ typedef struct {
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIONetListener *listener;
+    GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
     int connected;
     int max_size;
@@ -352,6 +353,12 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num = 0;
     }
 
+    if (s->hup_source != NULL) {
+        g_source_destroy(s->hup_source);
+        g_source_unref(s->hup_source);
+        s->hup_source = NULL;
+    }
+
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
     object_unref(OBJECT(s->sioc));
@@ -455,6 +462,15 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
+static gboolean tcp_chr_hup(QIOChannel *channel,
+                               GIOCondition cond,
+                               void *opaque)
+{
+    Chardev *chr = CHARDEV(opaque);
+    tcp_chr_disconnect(chr);
+    return G_SOURCE_REMOVE;
+}
+
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -528,6 +544,12 @@ static void tcp_chr_connect(void *opaque)
                                            tcp_chr_read,
                                            chr, chr->gcontext);
     }
+
+    s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
+    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
+                          chr, NULL);
+    g_source_attach(s->hup_source, chr->gcontext);
+
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
-- 
1.8.3.1
