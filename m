Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C3022D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C3022D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UYv-0002fJ-H8
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPp-0007HX-Uq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPn-0005c5-E7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPn-0005bQ-1t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33FB4A2F6B6;
 Wed, 21 Aug 2019 17:28:54 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC03860E1C;
 Wed, 21 Aug 2019 17:28:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:21 +0200
Message-Id: <1566408501-48680-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 17:28:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/13] char-socket: Lock tcp_chr_disconnect()
 and socket_reconnect_timeout()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <1565625509-404969-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7ca5d97..03f0340 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -150,7 +150,7 @@ static void tcp_chr_accept(QIONetListener *listener,
                            void *opaque);
 
 static int tcp_chr_read_poll(void *opaque);
-static void tcp_chr_disconnect(Chardev *chr);
+static void tcp_chr_disconnect_locked(Chardev *chr);
 
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
@@ -174,7 +174,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
-                tcp_chr_disconnect(chr);
+                tcp_chr_disconnect_locked(chr);
                 return len;
             } /* else let the read handler finish it properly */
         }
@@ -469,8 +469,9 @@ static void update_disconnected_filename(SocketChardev *s)
 /* NB may be called even if tcp_chr_connect has not been
  * reached, due to TLS or telnet initialization failure,
  * so can *not* assume s->state == TCP_CHARDEV_STATE_CONNECTED
+ * This must be called with chr->chr_write_lock held.
  */
-static void tcp_chr_disconnect(Chardev *chr)
+static void tcp_chr_disconnect_locked(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     bool emit_close = s->state == TCP_CHARDEV_STATE_CONNECTED;
@@ -490,6 +491,13 @@ static void tcp_chr_disconnect(Chardev *chr)
     }
 }
 
+static void tcp_chr_disconnect(Chardev *chr)
+{
+    qemu_mutex_lock(&chr->chr_write_lock);
+    tcp_chr_disconnect_locked(chr);
+    qemu_mutex_unlock(&chr->chr_write_lock);
+}
+
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -1131,8 +1139,10 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
 
+    qemu_mutex_lock(&chr->chr_write_lock);
     g_source_unref(s->reconnect_timer);
     s->reconnect_timer = NULL;
+    qemu_mutex_unlock(&chr->chr_write_lock);
 
     if (chr->be_open) {
         return false;
-- 
1.8.3.1


