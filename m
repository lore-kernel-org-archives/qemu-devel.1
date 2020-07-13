Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF924C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695462067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXuc1S9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695462067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutmT-0003Z7-JT
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlb-0001xe-I7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlZ-0006cT-Gv
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCSxY69a4IEh6ENvK1x9IfIircfR5ePI2fwQkbZqkdo=;
 b=fXuc1S9JfSksPeir312SZX4pnnS3VU5YDeX+ullv19sw6E/XUwiqd9G7nlOjuOpzgjOW7F
 9e/2bUiqPeeZJ/Hdw15Oa8gJbrXaGj+hc4O4fUlI6aCBYV3zyu4r44KJayzbjHDSPz5uNI
 OgmPBVaDd3M01Wl+n0MI/mTxKmMDTHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-GljYrIiIOvi3lJARap52uA-1; Mon, 13 Jul 2020 04:24:42 -0400
X-MC-Unique: GljYrIiIOvi3lJARap52uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4EF107ACCA;
 Mon, 13 Jul 2020 08:24:41 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D74106FEF3;
 Mon, 13 Jul 2020 08:24:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] char-socket: initialize reconnect timer only when the
 timer doesn't start
Date: Mon, 13 Jul 2020 12:24:17 +0400
Message-Id: <20200713082424.2947383-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Li Feng <fengli@smartx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Feng <fengli@smartx.com>

When the disconnect event is triggered in the connecting stage,
the tcp_chr_disconnect_locked may be called twice.

The first call:
    #0  qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:120
    #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
    #2  0x000055555558e3cd in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
    #3  0x000055555558ea32 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
    #4  0x000055555558eeb8 in qemu_chr_socket_connected (task=0x55555582f300, opaque=<optimized out>) at chardev/char-socket.c:1090
    #5  0x0000555555574352 in qio_task_complete (task=task@entry=0x55555582f300) at io/task.c:196
    #6  0x00005555555745f4 in qio_task_thread_result (opaque=0x55555582f300) at io/task.c:111
    #7  qio_task_wait_thread (task=0x55555582f300) at io/task.c:190
    #8  0x000055555558f17e in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1013
    #9  0x0000555555567cbd in char_socket_client_reconnect_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1152
The second call:
    #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
    #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
    #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/libc.so.6
    #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.6
    #4  0x000055555558d10a in qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:125
    #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
    #6  0x000055555558df4d in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
    #7  0x000055555558e5b2 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
    #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=chr@entry=0x55555582ee90, errp=errp@entry=0x7fffffffd178) at chardev/char-socket.c:944
    #9  0x000055555558ec78 in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1035
    #10 0x000055555556804b in char_socket_client_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1023

Run test/test-char to reproduce this issue.

test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.

Signed-off-by: Li Feng <fengli@smartx.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200522025554.41063-1-fengli@smartx.com>
---
 chardev/char-socket.c |  2 +-
 tests/test-char.c     | 73 +++++++++++++++++++++++++++++++++----------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5758d9900fc..320aa7c642f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -490,7 +490,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time) {
+    if (s->reconnect_time && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d5..73ba1cf6010 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -625,12 +625,14 @@ static void char_udp_test(void)
 typedef struct {
     int event;
     bool got_pong;
+    CharBackend *be;
 } CharSocketTestData;
 
 
 #define SOCKET_PING "Hello"
 #define SOCKET_PONG "World"
 
+typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);
 
 static void
 char_socket_event(void *opaque, QEMUChrEvent event)
@@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent event)
     data->event = event;
 }
 
+static void
+char_socket_event_with_error(void *opaque, QEMUChrEvent event)
+{
+    static bool first_error;
+    CharSocketTestData *data = opaque;
+    CharBackend *be = data->be;
+    data->event = event;
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (!first_error) {
+            first_error = true;
+            qemu_chr_fe_disconnect(be);
+        }
+        return;
+    case CHR_EVENT_CLOSED:
+        return;
+    default:
+        return;
+    }
+}
+
 
 static void
 char_socket_read(void *opaque, const uint8_t *buf, int size)
@@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr, bool fd_pass,
 }
 
 
-static void
-char_socket_ping_pong(QIOChannel *ioc)
+static int
+char_socket_ping_pong(QIOChannel *ioc, Error **errp)
 {
     char greeting[sizeof(SOCKET_PING)];
     const char *response = SOCKET_PONG;
 
-    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
+    int ret;
+    ret = qio_channel_read_all(ioc, greeting, sizeof(greeting), errp);
+    if (ret != 0) {
+        object_unref(OBJECT(ioc));
+        return -1;
+    }
 
     g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) == 0);
 
-    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abort);
-
+    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), errp);
     object_unref(OBJECT(ioc));
+    return 0;
 }
 
 
@@ -723,7 +751,7 @@ char_socket_server_client_thread(gpointer data)
 
     qio_channel_socket_connect_sync(ioc, addr, &error_abort);
 
-    char_socket_ping_pong(QIO_CHANNEL(ioc));
+    char_socket_ping_pong(QIO_CHANNEL(ioc), &error_abort);
 
     return NULL;
 }
@@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
                              char_socket_event, NULL,
                              &data, NULL, true);
@@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)
     QIOChannelSocket *ioc = data;
     QIOChannelSocket *cioc;
 
+retry:
     cioc = qio_channel_socket_accept(ioc, &error_abort);
     g_assert_nonnull(cioc);
 
-    char_socket_ping_pong(QIO_CHANNEL(cioc));
+    if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) != 0) {
+        goto retry;
+    }
 
     return NULL;
 }
@@ -869,12 +901,13 @@ typedef struct {
     const char *reconnect;
     bool wait_connected;
     bool fd_pass;
+    char_socket_cb event_cb;
 } CharSocketClientTestConfig;
 
-
 static void char_socket_client_test(gconstpointer opaque)
 {
     const CharSocketClientTestConfig *config = opaque;
+    const char_socket_cb event_cb = config->event_cb;
     QIOChannelSocket *ioc;
     char *optstr;
     Chardev *chr;
@@ -938,8 +971,9 @@ static void char_socket_client_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     if (config->reconnect) {
         g_assert(data.event == -1);
@@ -977,7 +1011,7 @@ static void char_socket_client_test(gconstpointer opaque)
     /* Setup a callback to receive the reply to our greeting */
     qemu_chr_fe_set_handlers(&be, char_socket_can_read,
                              char_socket_read,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     g_assert(data.event == CHR_EVENT_OPENED);
     data.event = -1;
@@ -1422,17 +1456,20 @@ int main(int argc, char **argv)
 
 #define SOCKET_CLIENT_TEST(name, addr)                                  \
     static CharSocketClientTestConfig client1 ## name =                 \
-        { addr, NULL, false, false };                                   \
+        { addr, NULL, false, false, char_socket_event};                 \
     static CharSocketClientTestConfig client2 ## name =                 \
-        { addr, NULL, true, false };                                    \
+        { addr, NULL, true, false, char_socket_event };                 \
     static CharSocketClientTestConfig client3 ## name =                 \
-        { addr, ",reconnect=1", false };                                \
+        { addr, ",reconnect=1", false, false, char_socket_event };      \
     static CharSocketClientTestConfig client4 ## name =                 \
-        { addr, ",reconnect=1", true };                                 \
+        { addr, ",reconnect=1", true, false, char_socket_event };       \
     static CharSocketClientTestConfig client5 ## name =                 \
-        { addr, NULL, false, true };                                    \
+        { addr, NULL, false, true, char_socket_event };                 \
     static CharSocketClientTestConfig client6 ## name =                 \
-        { addr, NULL, true, true };                                     \
+        { addr, NULL, true, true, char_socket_event };                  \
+    static CharSocketClientTestConfig client7 ## name =                 \
+        { addr, ",reconnect=1", true, false,                            \
+            char_socket_event_with_error };                             \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1444,7 +1481,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name, \
                          &client5 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
-                         &client6 ##name, char_socket_client_test)
+                         &client6 ##name, char_socket_client_test);     \
+    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
+                         &client7 ##name, char_socket_client_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
-- 
2.27.0.221.ga08a83db2b


