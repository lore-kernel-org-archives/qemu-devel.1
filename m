Received: from eggs.gnu.org ([209.51.188.92]:49439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjf4-0001MA-Pg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjev-0004Ct-Gn
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:12 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:59537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grjev-000404-5G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:05 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  7 Feb 2019 15:23:23 +0200
Message-Id: <f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 3/3] char-socket: Lock tcp_chr_disconnect() and
 socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There's a race condition in which the tcp_chr_read() ioc handler can
close a connection that is being written to from another thread.

Running iotest 136 in a loop triggers this problem and crashes QEMU.

 (gdb) bt
 #0  0x00005558b842902d in object_get_class (obj=0x0) at qom/object.c:860
 #1  0x00005558b84f92db in qio_channel_writev_full (ioc=0x0, iov=0x7ffc355decf0, niov=1, fds=0x0, nfds=0, errp=0x0) at io/channel.c:76
 #2  0x00005558b84e0e9e in io_channel_send_full (ioc=0x0, buf=0x5558baf5beb0, len=138, fds=0x0, nfds=0) at chardev/char-io.c:123
 #3  0x00005558b84e4a69 in tcp_chr_write (chr=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138) at chardev/char-socket.c:135
 #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138, offset=0x7ffc355dedd0, write_all=false) at chardev/char.c:112
 #5  0x00005558b84dcbc2 in qemu_chr_write (s=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138, write_all=false) at chardev/char.c:147
 #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=0x5558ba476610, buf=0x5558baf5beb0 "...", len=138) at chardev/char-fe.c:42
 #7  0x00005558b8088c86 in monitor_flush_locked (mon=0x5558ba476610) at monitor.c:406
 #8  0x00005558b8088e8c in monitor_puts (mon=0x5558ba476610, str=0x5558ba921e49 "") at monitor.c:449
 #9  0x00005558b8089178 in qmp_send_response (mon=0x5558ba476610, rsp=0x5558bb161600) at monitor.c:498
 #10 0x00005558b808920c in monitor_qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:526
 #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:551
 #12 0x00005558b80896c0 in qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:626
 #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=false, reason=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
 #14 0x00005558b81911ef in qemu_system_shutdown (cause=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at vl.c:1837
 #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
 #16 0x00005558b819140d in main_loop () at vl.c:1924
 #17 0x00005558b8198c84 in main (argc=18, argv=0x7ffc355df3f8, envp=0x7ffc355df490) at vl.c:4665

This patch adds a lock to protect tcp_chr_disconnect() and
socket_reconnect_timeout()

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 chardev/char-socket.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index eaa8e8b68f..5f421bdc58 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -148,7 +148,9 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
+                qemu_mutex_unlock(&chr->chr_write_lock);
                 tcp_chr_disconnect(chr);
+                qemu_mutex_lock(&chr->chr_write_lock);
                 return len;
             } /* else let the read handler finish it properly */
         }
@@ -440,6 +442,13 @@ static void update_disconnected_filename(SocketChardev *s)
     }
 }
 
+static gboolean tcp_chr_be_event_closed(gpointer opaque)
+{
+    Chardev *chr = opaque;
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+    return FALSE;
+}
+
 /* NB may be called even if tcp_chr_connect has not been
  * reached, due to TLS or telnet initialization failure,
  * so can *not* assume s->connected == true
@@ -447,7 +456,10 @@ static void update_disconnected_filename(SocketChardev *s)
 static void tcp_chr_disconnect(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-    bool emit_close = s->connected;
+    bool emit_close;
+
+    qemu_mutex_lock(&chr->chr_write_lock);
+    emit_close = s->connected;
 
     tcp_chr_free_connection(chr);
 
@@ -457,11 +469,12 @@ static void tcp_chr_disconnect(Chardev *chr)
     }
     update_disconnected_filename(s);
     if (emit_close) {
-        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        qemu_idle_add(tcp_chr_be_event_closed, chr, chr->gcontext);
     }
     if (s->reconnect_time) {
         qemu_chr_socket_restart_timer(chr);
     }
+    qemu_mutex_unlock(&chr->chr_write_lock);
 }
 
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
@@ -975,8 +988,10 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
 
+    qemu_mutex_lock(&chr->chr_write_lock);
     g_source_unref(s->reconnect_timer);
     s->reconnect_timer = NULL;
+    qemu_mutex_unlock(&chr->chr_write_lock);
 
     if (chr->be_open) {
         return false;
-- 
2.11.0
