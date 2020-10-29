Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC6C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE8206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ/3aJ9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8Fa-0005s4-2N
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88o-0005wo-4l
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88i-0008LY-E4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603978731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acTP4k7dJxWpJ5Fq0SQZT9+fmMb05Cb2TQXTfT3JKyc=;
 b=GJ/3aJ9jd1h8zCI5cU3FO/ekeTlFVvgObTFx5q0Kdm2n3arSs7fZ2PH/p59D7ZhMsekriv
 JWV+X4iy7inHITuFWBx4MUtqcUvoiTGK+mkmPmMrVtwcRYCisz2f7eGVKezxhMkW1TiXxH
 xr2sFflFCdZXCiIj45C+6e6PhY//fEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-ryl5pZOvNRCVrgfKl3AXXg-1; Thu, 29 Oct 2020 09:38:49 -0400
X-MC-Unique: ryl5pZOvNRCVrgfKl3AXXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26D71018F8C;
 Thu, 29 Oct 2020 13:38:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B4B5C1C4;
 Thu, 29 Oct 2020 13:38:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A61EC1132D67; Thu, 29 Oct 2020 14:38:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] test-util-sockets: Synchronize properly, don't sleep(1)
Date: Thu, 29 Oct 2020 14:38:27 +0100
Message-Id: <20201029133833.3450220-6-armbru@redhat.com>
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The abstract sockets test spawns a thread to listen and a accept, and
a second one to connect, with a sleep(1) in between to "ensure" the
former is listening when the latter tries to connect.  Review fail.
Risks spurious test failure, say when a heavily loaded machine doesn't
schedule the first thread quickly enough.  It's also slow.

Listen and accept in the main thread, and start the connect thread in
between.  Look ma, no sleep!  Run time drops from 2s wall clock to a
few milliseconds.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-util-sockets.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 77fc51d6f5..c2802f69ee 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -230,25 +230,6 @@ static void test_socket_fd_pass_num_nocli(void)
 #endif
 
 #ifdef __linux__
-static gpointer unix_server_thread_func(gpointer user_data)
-{
-    int fd;
-    int connfd;
-    struct sockaddr_un un;
-    socklen_t len = sizeof(un);
-
-    fd = socket_listen(user_data, 1, &error_abort);
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
     int fd;
@@ -261,20 +242,26 @@ static gpointer unix_client_thread_func(gpointer user_data)
 
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


