Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C568BC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB1222226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPsZjABF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB1222226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwz7-0003k8-47
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwtt-0006pC-EI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwtr-0003PI-3I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604412182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+IjmS1q+jOGviqOHLrLDb+/UDo2/xtYhKrZpy2+2zU=;
 b=DPsZjABFXmsK07shxCcIeb27xFdhUvYFIPvgsF9U7UOkc4rFeVFD7T6AZE8N4JSSRgN/gd
 NOHv2CQPUVJqca9tePaXEW+woVU8P16IQiwoAsu8/UrVwbvysphLDiA1mZK/h5O404ERio
 BGJjDlW3I6ty0NSfdV3knabQ+ip4Q4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-daTXTdvvMKK1A2mXSBXBAw-1; Tue, 03 Nov 2020 09:03:00 -0500
X-MC-Unique: daTXTdvvMKK1A2mXSBXBAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 421B364151
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 14:02:59 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E09CB5B4C7;
 Tue,  3 Nov 2020 14:02:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] test-util-sockets: Test the complete abstract socket
 matrix
Date: Tue,  3 Nov 2020 14:02:20 +0000
Message-Id: <20201103140225.496776-7-berrange@redhat.com>
In-Reply-To: <20201103140225.496776-1-berrange@redhat.com>
References: <20201103140225.496776-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The test covers only two out of nine combinations.  Test all nine.
Four turn out to be broken.  Marked /* BUG */.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-util-sockets.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 4cedf622f0..f8b6586e70 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -230,60 +230,99 @@ static void test_socket_fd_pass_num_nocli(void)
 #endif
 
 #ifdef __linux__
+
+#define ABSTRACT_SOCKET_VARIANTS 3
+
+typedef struct {
+    SocketAddress *server, *client[ABSTRACT_SOCKET_VARIANTS];
+    bool expect_connect[ABSTRACT_SOCKET_VARIANTS];
+} abstract_socket_matrix_row;
+
 static gpointer unix_client_thread_func(gpointer user_data)
 {
-    SocketAddress *addr = user_data;
-    int fd;
-
-    fd = socket_connect(addr, &error_abort);
-    g_assert_cmpint(fd, >=, 0);
-    close(fd);
+    abstract_socket_matrix_row *row = user_data;
+    Error *err = NULL;
+    int i, fd;
+
+    for (i = 0; i < ABSTRACT_SOCKET_VARIANTS; i++) {
+        if (row->expect_connect[i]) {
+            fd = socket_connect(row->client[i], &error_abort);
+            g_assert_cmpint(fd, >=, 0);
+        } else {
+            fd = socket_connect(row->client[i], &err);
+            g_assert_cmpint(fd, ==, -1);
+            error_free_or_abort(&err);
+        }
+        close(fd);
+    }
     return NULL;
 }
 
-static void test_socket_unix_abstract_one(SocketAddress *addr)
+static void test_socket_unix_abstract_row(abstract_socket_matrix_row *test)
 {
-    int fd, connfd;
+    int fd, connfd, i;
     GThread *cli;
     struct sockaddr_un un;
     socklen_t len = sizeof(un);
 
-    fd = socket_listen(addr, 1, &error_abort);
+    /* Last one must connect, or else accept() below hangs */
+    assert(test->expect_connect[ABSTRACT_SOCKET_VARIANTS - 1]);
+
+    fd = socket_listen(test->server, 1, &error_abort);
     g_assert_cmpint(fd, >=, 0);
     g_assert(fd_is_socket(fd));
 
     cli = g_thread_new("abstract_unix_client",
                        unix_client_thread_func,
-                       addr);
-
-    connfd = accept(fd, (struct sockaddr *)&un, &len);
-    g_assert_cmpint(connfd, !=, -1);
-    close(connfd);
+                       test);
+
+    for (i = 0; i < ABSTRACT_SOCKET_VARIANTS; i++) {
+        if (test->expect_connect[i]) {
+            connfd = accept(fd, (struct sockaddr *)&un, &len);
+            g_assert_cmpint(connfd, !=, -1);
+            close(connfd);
+        }
+    }
 
     close(fd);
-
     g_thread_join(cli);
 }
 
-static void test_socket_unix_abstract_good(void)
+static void test_socket_unix_abstract(void)
 {
-    SocketAddress addr;
+    SocketAddress addr, addr_tight, addr_padded;
+    abstract_socket_matrix_row matrix[ABSTRACT_SOCKET_VARIANTS] = {
+        { &addr,
+          { &addr_tight, &addr_padded, &addr },
+          { false /* BUG */, true /* BUG */, true } },
+        { &addr_tight,
+          { &addr_padded, &addr, &addr_tight },
+          { false, false /* BUG */, true } },
+        { &addr_padded,
+          { &addr, &addr_tight, &addr_padded },
+          { true /* BUG */, false, true } }
+    };
+    int i;
 
     addr.type = SOCKET_ADDRESS_TYPE_UNIX;
     addr.u.q_unix.path = g_strdup_printf("unix-%d-%u",
                                          getpid(), g_random_int());
     addr.u.q_unix.has_abstract = true;
     addr.u.q_unix.abstract = true;
-
-    /* non tight socklen serv and cli */
     addr.u.q_unix.has_tight = false;
     addr.u.q_unix.tight = false;
-    test_socket_unix_abstract_one(&addr);
 
-    /* tight socklen serv and cli */
-    addr.u.q_unix.has_tight = true;
-    addr.u.q_unix.tight = true;
-    test_socket_unix_abstract_one(&addr);
+    addr_tight = addr;
+    addr_tight.u.q_unix.has_tight = true;
+    addr_tight.u.q_unix.tight = true;
+
+    addr_padded = addr;
+    addr_padded.u.q_unix.has_tight = true;
+    addr_padded.u.q_unix.tight = false;
+
+    for (i = 0; i < ABSTRACT_SOCKET_VARIANTS; i++) {
+        test_socket_unix_abstract_row(&matrix[i]);
+    }
 
     g_free(addr.u.q_unix.path);
 }
@@ -330,8 +369,8 @@ int main(int argc, char **argv)
     }
 
 #ifdef __linux__
-    g_test_add_func("/util/socket/unix-abstract/good",
-                    test_socket_unix_abstract_good);
+    g_test_add_func("/util/socket/unix-abstract",
+                    test_socket_unix_abstract);
 #endif
 
 end:
-- 
2.28.0


