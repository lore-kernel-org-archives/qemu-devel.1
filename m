Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1808C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A3B2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1UqocFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUWe-00019C-QX
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36238 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jQUTO-0006jG-Jg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:20:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jQUTN-0005Lo-Dz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:20:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32916
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jQUTM-0005KW-WD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587381619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l1nyaP69P17y4KpSdRWipY3ZdgYvRLchrYtiR8M+Eqw=;
 b=Z1UqocFJD648Mcdv0NyVEb009Gl4KRjBjp96eoUEGfmJQ7caNnRBCuGjvUF23xp+hwqkk7
 0i3eIClSq7u0Hsy40VbKRw+4v307h+Fon/BF7uy3cdrPr9OGslCSwrYZYGTzwpwFbw210x
 Y1XtDEcYF3EidXq0dlenqYH2uwy+G6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-tAVm4svnNquMxfyoVitzEQ-1; Mon, 20 Apr 2020 07:20:17 -0400
X-MC-Unique: tAVm4svnNquMxfyoVitzEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E655BDB60
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:20:16 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A59781001B07;
 Mon, 20 Apr 2020 11:20:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] char: fix use-after-free with dup chardev & reconnect
Date: Mon, 20 Apr 2020 13:20:12 +0200
Message-Id: <20200420112012.567284-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With a reconnect socket, qemu_char_open() will start a background
thread. It should keep a reference on the chardev.

Fixes invalid read:
READ of size 8 at 0x6040000ac858 thread T7
    #0 0x5555598d37b8 in unix_connect_saddr /home/elmarco/src/qq/util/qemu-=
sockets.c:954
    #1 0x5555598d4751 in socket_connect /home/elmarco/src/qq/util/qemu-sock=
ets.c:1109
    #2 0x555559707c34 in qio_channel_socket_connect_sync /home/elmarco/src/=
qq/io/channel-socket.c:145
    #3 0x5555596adebb in tcp_chr_connect_client_task /home/elmarco/src/qq/c=
hardev/char-socket.c:1104
    #4 0x555559723d55 in qio_task_thread_worker /home/elmarco/src/qq/io/tas=
k.c:123
    #5 0x5555598a6731 in qemu_thread_start /home/elmarco/src/qq/util/qemu-t=
hread-posix.c:519
    #6 0x7ffff40d4431 in start_thread (/lib64/libpthread.so.0+0x9431)
    #7 0x7ffff40029d2 in __clone (/lib64/libc.so.6+0x1019d2)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c |  3 ++-
 tests/test-char.c     | 51 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda7..1f14c2c7c80 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1126,7 +1126,8 @@ static void tcp_chr_connect_client_async(Chardev *chr=
)
      */
     s->connect_task =3D qio_task_new(OBJECT(sioc),
                                    qemu_chr_socket_connected,
-                                   chr, NULL);
+                                   object_ref(OBJECT(chr)),
+                                   (GDestroyNotify)object_unref);
     qio_task_run_in_thread(s->connect_task,
                            tcp_chr_connect_client_task,
                            s->addr,
diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d5..8d39bdc9fab 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -871,6 +871,51 @@ typedef struct {
     bool fd_pass;
 } CharSocketClientTestConfig;
=20
+static void char_socket_client_dupid_test(gconstpointer opaque)
+{
+    const CharSocketClientTestConfig *config =3D opaque;
+    QIOChannelSocket *ioc;
+    char *optstr;
+    Chardev *chr1, *chr2;
+    SocketAddress *addr;
+    QemuOpts *opts;
+    Error *local_err =3D NULL;
+
+    /*
+     * Setup a listener socket and determine get its address
+     * so we know the TCP port for the client later
+     */
+    ioc =3D qio_channel_socket_new();
+    g_assert_nonnull(ioc);
+    qio_channel_socket_listen_sync(ioc, config->addr, 1, &error_abort);
+    addr =3D qio_channel_socket_get_local_address(ioc, &error_abort);
+    g_assert_nonnull(addr);
+
+    /*
+     * Populate the chardev address based on what the server
+     * is actually listening on
+     */
+    optstr =3D char_socket_addr_to_opt_str(addr,
+                                         config->fd_pass,
+                                         config->reconnect,
+                                         false);
+
+    opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+    chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr1);
+
+    chr2 =3D qemu_chr_new_from_opts(opts, NULL, &local_err);
+    g_assert_null(chr2);
+    error_free_or_abort(&local_err);
+
+    object_unref(OBJECT(ioc));
+    qemu_opts_del(opts);
+    object_unparent(OBJECT(chr1));
+    qapi_free_SocketAddress(addr);
+    g_free(optstr);
+}
=20
 static void char_socket_client_test(gconstpointer opaque)
 {
@@ -1433,6 +1478,8 @@ int main(int argc, char **argv)
         { addr, NULL, false, true };                                    \
     static CharSocketClientTestConfig client6 ## name =3D                 =
\
         { addr, NULL, true, true };                                     \
+    static CharSocketClientTestConfig client7 ## name =3D                 =
\
+        { addr, ",reconnect=3D1", false, false };                         =
\
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1444,7 +1491,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name, \
                          &client5 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
-                         &client6 ##name, char_socket_client_test)
+                         &client6 ##name, char_socket_client_test);     \
+    g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
+                         &client7 ##name, char_socket_client_dupid_test)
=20
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
--=20
2.26.0.106.g9fadedd637


