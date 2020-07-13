Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5AEC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658862067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvR143pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658862067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutmc-0003zd-LA
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlj-0002DU-SJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutli-0006d7-1c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olYQTlXvAQ+BMyeWvUT8cC5Heg8dQQLnz23FRQO7M6s=;
 b=PvR143pjRJkaFUVV+UhI6QTRNePNo5CtplTyPOv1LV7etm417Wuw2FkQ9gzcbz/RxbjL+/
 j5y5hddq41z+k83azzd34qcXQFxmt4cbvsQ/sQQRB1j+kUzhmgHzKr6jHIl43HdaDBFXqW
 lW7s71FHi1oTwRsaAfUF3u411HpDV1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-PkaJviu_OViSKJeyo6yAjA-1; Mon, 13 Jul 2020 04:24:55 -0400
X-MC-Unique: PkaJviu_OViSKJeyo6yAjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10A110CE784
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:24:54 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 730AC27DE7C;
 Mon, 13 Jul 2020 08:24:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] char: fix use-after-free with dup chardev & reconnect
Date: Mon, 13 Jul 2020 12:24:19 +0400
Message-Id: <20200713082424.2947383-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With a reconnect socket, qemu_char_open() will start a background
thread. It should keep a reference on the chardev.

Fixes invalid read:
READ of size 8 at 0x6040000ac858 thread T7
    #0 0x5555598d37b8 in unix_connect_saddr /home/elmarco/src/qq/util/qemu-sockets.c:954
    #1 0x5555598d4751 in socket_connect /home/elmarco/src/qq/util/qemu-sockets.c:1109
    #2 0x555559707c34 in qio_channel_socket_connect_sync /home/elmarco/src/qq/io/channel-socket.c:145
    #3 0x5555596adebb in tcp_chr_connect_client_task /home/elmarco/src/qq/chardev/char-socket.c:1104
    #4 0x555559723d55 in qio_task_thread_worker /home/elmarco/src/qq/io/task.c:123
    #5 0x5555598a6731 in qemu_thread_start /home/elmarco/src/qq/util/qemu-thread-posix.c:519
    #6 0x7ffff40d4431 in start_thread (/lib64/libpthread.so.0+0x9431)
    #7 0x7ffff40029d2 in __clone (/lib64/libc.so.6+0x1019d2)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200420112012.567284-1-marcandre.lureau@redhat.com>
---
 chardev/char-socket.c |  3 ++-
 tests/test-char.c     | 54 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 320aa7c642f..ef62dbf3d73 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1129,7 +1129,8 @@ static void tcp_chr_connect_client_async(Chardev *chr)
      */
     s->connect_task = qio_task_new(OBJECT(sioc),
                                    qemu_chr_socket_connected,
-                                   chr, NULL);
+                                   object_ref(OBJECT(chr)),
+                                   (GDestroyNotify)object_unref);
     qio_task_run_in_thread(s->connect_task,
                            tcp_chr_connect_client_task,
                            s->addr,
diff --git a/tests/test-char.c b/tests/test-char.c
index 73ba1cf6010..9d8746414d7 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -904,6 +904,52 @@ typedef struct {
     char_socket_cb event_cb;
 } CharSocketClientTestConfig;
 
+static void char_socket_client_dupid_test(gconstpointer opaque)
+{
+    const CharSocketClientTestConfig *config = opaque;
+    QIOChannelSocket *ioc;
+    char *optstr;
+    Chardev *chr1, *chr2;
+    SocketAddress *addr;
+    QemuOpts *opts;
+    Error *local_err = NULL;
+
+    /*
+     * Setup a listener socket and determine get its address
+     * so we know the TCP port for the client later
+     */
+    ioc = qio_channel_socket_new();
+    g_assert_nonnull(ioc);
+    qio_channel_socket_listen_sync(ioc, config->addr, 1, &error_abort);
+    addr = qio_channel_socket_get_local_address(ioc, &error_abort);
+    g_assert_nonnull(addr);
+
+    /*
+     * Populate the chardev address based on what the server
+     * is actually listening on
+     */
+    optstr = char_socket_addr_to_opt_str(addr,
+                                         config->fd_pass,
+                                         config->reconnect,
+                                         false);
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+    chr1 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr1);
+
+    chr2 = qemu_chr_new_from_opts(opts, NULL, &local_err);
+    g_assert_null(chr2);
+    error_free_or_abort(&local_err);
+
+    object_unref(OBJECT(ioc));
+    qemu_opts_del(opts);
+    object_unparent(OBJECT(chr1));
+    qapi_free_SocketAddress(addr);
+    g_free(optstr);
+}
+
 static void char_socket_client_test(gconstpointer opaque)
 {
     const CharSocketClientTestConfig *config = opaque;
@@ -1456,7 +1502,7 @@ int main(int argc, char **argv)
 
 #define SOCKET_CLIENT_TEST(name, addr)                                  \
     static CharSocketClientTestConfig client1 ## name =                 \
-        { addr, NULL, false, false, char_socket_event};                 \
+        { addr, NULL, false, false, char_socket_event };                \
     static CharSocketClientTestConfig client2 ## name =                 \
         { addr, NULL, true, false, char_socket_event };                 \
     static CharSocketClientTestConfig client3 ## name =                 \
@@ -1470,6 +1516,8 @@ int main(int argc, char **argv)
     static CharSocketClientTestConfig client7 ## name =                 \
         { addr, ",reconnect=1", true, false,                            \
             char_socket_event_with_error };                             \
+    static CharSocketClientTestConfig client8 ## name =                 \
+        { addr, ",reconnect=1", false, false, char_socket_event };      \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1483,7 +1531,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
                          &client6 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
-                         &client7 ##name, char_socket_client_test)
+                         &client7 ##name, char_socket_client_test);     \
+    g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
+                         &client8 ##name, char_socket_client_dupid_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
-- 
2.27.0.221.ga08a83db2b


