Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27CC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC6622277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap2PHXQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC6622277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWST-0007VD-Sr
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOK-0002dK-N5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOI-00059k-8h
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/OgfYQh8HJzQ0t4tZ94KeAjaQks7kVAngJOMp4dio0=;
 b=ap2PHXQPqdNTXwAopPODK09jIES8yGBg1STbQQdu4b6tO55/UjrsWXatzhHJF0SABJzoMg
 WT/E6Wy0XRsxXcoaNu4NaHABC3hhgHG6/+UK+S9scKYhdl3pLN8vcbBmf3TQHpGoMZ09PP
 iIVoc1380Hjgrn1OQvQakjjNRpcb7Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Vm2UiXZgNcKH1FUzenY-vw-1; Mon, 02 Nov 2020 04:44:39 -0500
X-MC-Unique: Vm2UiXZgNcKH1FUzenY-vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 049E457203;
 Mon,  2 Nov 2020 09:44:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B77955D9DD;
 Mon,  2 Nov 2020 09:44:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EBF28116B844; Mon,  2 Nov 2020 10:44:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/11] test-util-sockets: Synchronize properly,
 don't sleep(1)
Date: Mon,  2 Nov 2020 10:44:16 +0100
Message-Id: <20201102094422.173975-6-armbru@redhat.com>
In-Reply-To: <20201102094422.173975-1-armbru@redhat.com>
References: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The abstract sockets test spawns a thread to listen and accept, and a
second one to connect, with a sleep(1) in between to "ensure" the
former is listening when the latter tries to connect.  Review fail.
Risks spurious test failure, say when a heavily loaded machine doesn't
schedule the first thread quickly enough.  It's also slow.

Listen and accept in the main thread, and start the connect thread in
between.  Look ma, no sleep!  Run time drops from 2s wall clock to a
few milliseconds.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-util-sockets.c | 40 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 40ff893e64..4cedf622f0 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -230,26 +230,6 @@ static void test_socket_fd_pass_num_nocli(void)
 #endif
 
 #ifdef __linux__
-static gpointer unix_server_thread_func(gpointer user_data)
-{
-    SocketAddress *addr = user_data;
-    int fd;
-    int connfd;
-    struct sockaddr_un un;
-    socklen_t len = sizeof(un);
-
-    fd = socket_listen(addr, 1, &error_abort);
-    g_assert_cmpint(fd, >=, 0);
-    g_assert(fd_is_socket(fd));
-
-    connfd = accept(fd, (struct sockaddr *)&un, &len);
-    g_assert_cmpint(connfd, !=, -1);
-    close(connfd);
-
-    close(fd);
-    return NULL;
-}
-
 static gpointer unix_client_thread_func(gpointer user_data)
 {
     SocketAddress *addr = user_data;
@@ -263,20 +243,26 @@ static gpointer unix_client_thread_func(gpointer user_data)
 
 static void test_socket_unix_abstract_one(SocketAddress *addr)
 {
-    GThread *serv, *cli;
+    int fd, connfd;
+    GThread *cli;
+    struct sockaddr_un un;
+    socklen_t len = sizeof(un);
 
-    serv = g_thread_new("abstract_unix_server",
-                        unix_server_thread_func,
-                        addr);
-
-    sleep(1);
+    fd = socket_listen(addr, 1, &error_abort);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert(fd_is_socket(fd));
 
     cli = g_thread_new("abstract_unix_client",
                        unix_client_thread_func,
                        addr);
 
+    connfd = accept(fd, (struct sockaddr *)&un, &len);
+    g_assert_cmpint(connfd, !=, -1);
+    close(connfd);
+
+    close(fd);
+
     g_thread_join(cli);
-    g_thread_join(serv);
 }
 
 static void test_socket_unix_abstract_good(void)
-- 
2.26.2


