Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF264C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E742064A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E742064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm13D-0003ax-TY
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 15:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hm12y-00031W-4e
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hm12w-0005zh-Nl
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:17:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:40354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hm12w-0005xl-3F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:17:30 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hm12q-0007oR-NG; Fri, 12 Jul 2019 22:17:24 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 22:17:13 +0300
Message-Id: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] chardev: race condition with tcp_chr_disconnect
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
Cc: vsementsov@virtuozzo.com, pbonzini@redhat.com,
 andrey.shinkevich@virtuozzo.com, rkagan@virtuozzo.com,
 marcandre.lureau@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When tcp_chr_disconnect() is called, other thread may be still writing
to the channel. This patch protects only read operations that initiate
the disconnection.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
The segmentation fault occurred because of the race condition when the
write operation was interrupted by the closed channel. The issue can be
reproduced by running the iotest 093 with the parameter read-zeroes=on,
self.vm.add_drive(self.test_img, "file.read-zeroes=on")
The back trace is below:

Thread 3 (Thread 0x7fabe105a700 (LWP 22443)):
#0  0x000055631de53b69 in tcp_chr_free_connection (chr=0x55631f754360) at chardev/char-socket.c:418
#1  0x000055631de53e32 in tcp_chr_disconnect (chr=0x55631f754360) at chardev/char-socket.c:478
#2  0x000055631de53ffa in tcp_chr_read (chan=0x55631f754630, cond=(G_IO_IN | G_IO_HUP), opaque=0x55631f754360) at chardev/char-socket.c:511
#3  0x000055631de6eb6e in qio_channel_fd_source_dispatch (source=0x7fabdc004200, callback=0x55631de53eb4 <tcp_chr_read>, user_data=0x55631f754360) at io/channel-watch.c:84
#4  0x00007fac0481d049 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#5  0x00007fac0481d3a8 in g_main_context_iterate.isra.19 () at /lib64/libglib-2.0.so.0
#6  0x00007fac0481d67a in g_main_loop_run () at /lib64/libglib-2.0.so.0
#7  0x000055631dac72cb in iothread_run (opaque=0x55631f784180) at iothread.c:82
#8  0x000055631deda136 in qemu_thread_start (args=0x55631f77bf40) at util/qemu-thread-posix.c:502
#9  0x00007fabec2a9dd5 in start_thread (arg=0x7fabe105a700) at pthread_create.c:307
#10 0x00007fabebfd2ead in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 1 (Thread 0x7fac05316d80 (LWP 22373)):
#0  0x000055631dd815e3 in object_get_class (obj=0x0) at qom/object.c:905
#1  0x000055631de6817d in qio_channel_writev_full (ioc=0x0, iov=0x7fff982b6540, niov=1, fds=0x0, nfds=0, errp=0x0) at io/channel.c:77
#2  0x000055631de4f71c in io_channel_send_full (ioc=0x0, buf=0x55631f784e00, len=137, fds=0x0, nfds=0) at chardev/char-io.c:123
#3  0x000055631de5316b in tcp_chr_write (chr=0x55631f754360, buf=0x55631f784e00 "{\"timestamp\": {\"seconds\": 1562851228, \"microseconds\": 27216}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n", len=137) at chardev/char-socket.c:161
#4  0x000055631de4b1e5 in qemu_chr_write_buffer (s=0x55631f754360, buf=0x55631f784e00 "{\"timestamp\": {\"seconds\": 1562851228, \"microseconds\": 27216}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n", len=137, offset=0x7fff982b6630, write_all=false) at chardev/char.c:114
#5  0x000055631de4b354 in qemu_chr_write (s=0x55631f754360, buf=0x55631f784e00 "{\"timestamp\": {\"seconds\": 1562851228, \"microseconds\": 27216}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n", len=137, write_all=false) at chardev/char.c:149
#6  0x000055631de4e358 in qemu_chr_fe_write (be=0x55631f784010, buf=0x55631f784e00 "{\"timestamp\": {\"seconds\": 1562851228, \"microseconds\": 27216}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n", len=137) at chardev/char-fe.c:42
#7  0x000055631dd013f8 in monitor_flush_locked (mon=0x55631f784010) at monitor/monitor.c:124
#8  0x000055631dd015f7 in monitor_puts (mon=0x55631f784010, str=0x5563200c7780 "{\"timestamp\": {\"seconds\": 1562851228, \"microseconds\": 27216}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\n") at monitor/monitor.c:166
#9  0x000055631dd02c76 in qmp_send_response (mon=0x55631f784010, rsp=0x556320136020) at monitor/qmp.c:94
#10 0x000055631dd018ef in monitor_qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x556320136020) at monitor/monitor.c:266
#11 0x000055631dd019e9 in monitor_qapi_event_queue_no_reenter (event=QAPI_EVENT_SHUTDOWN, qdict=0x556320136020) at monitor/monitor.c:291
#12 0x000055631dd01d9d in qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x556320136020) at monitor/monitor.c:366
#13 0x000055631dec4304 in qapi_event_send_shutdown (guest=false, reason=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
#14 0x000055631dad02f2 in qemu_system_shutdown (cause=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at vl.c:1779
#15 0x000055631dad0406 in main_loop_should_exit () at vl.c:1827
#16 0x000055631dad050b in main_loop () at vl.c:1866
#17 0x000055631dad7e27 in main (argc=22, argv=0x7fff982b6c88, envp=0x7fff982b6d40) at vl.c:4547

 chardev/char-socket.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7ca5d97..14eb7c0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -490,6 +490,16 @@ static void tcp_chr_disconnect(Chardev *chr)
     }
 }
 
+/*
+ * Call to allow the write operation to complete
+ */
+static void tcp_chr_disconnect_locked(Chardev *chr)
+{
+    qemu_mutex_lock(&chr->chr_write_lock);
+    tcp_chr_disconnect(chr);
+    qemu_mutex_unlock(&chr->chr_write_lock);
+}
+
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -508,7 +518,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     size = tcp_chr_recv(chr, (void *)buf, len);
     if (size == 0 || (size == -1 && errno != EAGAIN)) {
         /* connection closed */
-        tcp_chr_disconnect(chr);
+        tcp_chr_disconnect_locked(chr);
     } else if (size > 0) {
         if (s->do_telnetopt) {
             tcp_chr_process_IAC_bytes(chr, s, buf, &size);
@@ -544,7 +554,7 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
     qio_channel_set_blocking(s->ioc, false, NULL);
     if (size == 0) {
         /* connection closed */
-        tcp_chr_disconnect(chr);
+        tcp_chr_disconnect_locked(chr);
     }
 
     return size;
-- 
1.8.3.1


