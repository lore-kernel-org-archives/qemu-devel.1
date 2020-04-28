Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F84C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97F5206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="ON6ygoG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F5206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMct-00032t-NA
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jTMT0-0005hc-C7
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jTLzp-0007fq-Ax
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:58:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jTLzo-0007fd-Sy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:53:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id r14so10363487pfg.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YVaXGPGd8Q2+faJKdiZOSxUYLEVCJh2RPvbe2ldUqVs=;
 b=ON6ygoG+QiqUyX2FbBcaxYcqv2+amzCEKVbqAqg4OyXUDaXe3mxhhpkiyBNwgCeCdJ
 47NAgqOD3C3Hj+0ahQXattqFpC/wKLTMCx8PiBxnFwCyRjB/pqCtGUjf7Vm9Z9jDnFzZ
 ivlrRBqe1gjZHYuiYtwKusixebKn5SXAf0q6Dbv8tRpR1jJ1UqfD0Css/RoAGbJeqcIg
 90+zKyJBuqIYlpZnNr71EG7fgORn7eG5NcsOCdUQjuFaz6bvdABkbTXsrn7O6um8ML89
 mhEaGzYP28aBrUsXxK19h3//qP3ippHWmpaiBxjYUZz1z3vfOQL6FNfVAL3h1VIScUUG
 jtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YVaXGPGd8Q2+faJKdiZOSxUYLEVCJh2RPvbe2ldUqVs=;
 b=qMSD6LffYTtc/eDqt61SqvePjyGvS+knIpx+DN9H/otcvwU6ElaTNxzRJS9DxmWdJ2
 W/yna7gBkW0VUFYMrqMYPnh/SNdC/froG2FolQMwkjhTPDapgpAJa0QbreNe8e5oW2LK
 oZtW4XyFWuno4mEB0yO4qX7WOmgIlkHAoJfFwzj4eCa2IprwoC+9iIcW9nSOEvQr72AU
 eDdpg9DiRRQEETGkoQOsq5wfsifLVg0zFqitBofrZek/UW6g1J8LhWo0jq6BBEfT0dCM
 JME0K13xlZNQXcxzcXL3Qe7iALybw7Zi0OK2wZH1suBOTDGTrou4wqdx8KeZN1j5dE5R
 3thw==
X-Gm-Message-State: AGi0Pub2Nln32tOCIOGgjparvJTUUm4e2GND4Bj/24xRWoEXErgm9bbX
 g2GM4m5pQZVYMbdZ9dLqlJtwhw==
X-Google-Smtp-Source: APiQypL5ZpDTBgQc4PWFKrZzQE1LJhG5ncFx/+rkuvLw91Pv2TL3LgnKihPyisSMOfBegXdIH4ip4g==
X-Received: by 2002:a63:2e03:: with SMTP id u3mr11290050pgu.121.1588064019320; 
 Tue, 28 Apr 2020 01:53:39 -0700 (PDT)
Received: from 31_216.localdomain ([47.75.194.237])
 by smtp.gmail.com with ESMTPSA id k12sm14393523pfp.158.2020.04.28.01.53.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 01:53:38 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, lifeng1519@gmail.com, dimastep@yandex-team.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2] char-socket: initialize reconnect timer only when the
 timer doesn't start
Date: Tue, 28 Apr 2020 16:54:08 +0800
Message-Id: <20200428085409.2414-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415032826.16701-4-fengli@smartx.com>
References: <20200415032826.16701-4-fengli@smartx.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v2:
- Rewrite the solution.
- Add test to reproduce this issue.

 chardev/char-socket.c |  2 +-
 tests/test-char.c     | 48 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1f14c2c7c8..d84330b3c9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time) {
+    if (s->reconnect_time && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
diff --git a/tests/test-char.c b/tests/test-char.c
index 8d39bdc9fa..13dbbfe2a3 100644
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
@@ -639,6 +641,23 @@ char_socket_event(void *opaque, QEMUChrEvent event)
     data->event = event;
 }
 
+static void
+char_socket_event_with_error(void *opaque, QEMUChrEvent event)
+{
+    CharSocketTestData *data = opaque;
+    CharBackend *be = data->be;
+    data->event = event;
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        qemu_chr_fe_disconnect(be);
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
@@ -783,6 +802,7 @@ static void char_socket_server_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
                              char_socket_event, NULL,
                              &data, NULL, true);
@@ -869,6 +889,7 @@ typedef struct {
     const char *reconnect;
     bool wait_connected;
     bool fd_pass;
+    char_socket_cb event_cb;
 } CharSocketClientTestConfig;
 
 static void char_socket_client_dupid_test(gconstpointer opaque)
@@ -920,6 +941,7 @@ static void char_socket_client_dupid_test(gconstpointer opaque)
 static void char_socket_client_test(gconstpointer opaque)
 {
     const CharSocketClientTestConfig *config = opaque;
+    const char_socket_cb event_cb = config->event_cb;
     QIOChannelSocket *ioc;
     char *optstr;
     Chardev *chr;
@@ -983,8 +1005,9 @@ static void char_socket_client_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     if (config->reconnect) {
         g_assert(data.event == -1);
@@ -1022,7 +1045,7 @@ static void char_socket_client_test(gconstpointer opaque)
     /* Setup a callback to receive the reply to our greeting */
     qemu_chr_fe_set_handlers(&be, char_socket_can_read,
                              char_socket_read,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     g_assert(data.event == CHR_EVENT_OPENED);
     data.event = -1;
@@ -1467,19 +1490,22 @@ int main(int argc, char **argv)
 
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
     static CharSocketClientTestConfig client7 ## name =                 \
-        { addr, ",reconnect=1", false, false };                         \
+        { addr, ",reconnect=1", false, false, char_socket_event };      \
+    static CharSocketClientTestConfig client8 ## name =                 \
+        { addr, ",reconnect=1", true, false,                            \
+            char_socket_event_with_error };                             \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1493,7 +1519,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
                          &client6 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
-                         &client7 ##name, char_socket_client_dupid_test)
+                         &client7 ##name, char_socket_client_dupid_test);\
+    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
+                         &client8 ##name, char_socket_client_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
-- 
2.11.0


