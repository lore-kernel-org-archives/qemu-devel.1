Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A0DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B549B207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReleTagV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B549B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOMu-0004X1-Pj
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL4-0002LP-1G
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL0-0004rH-A8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589979645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0DGTd+YS1rJ35uWK7JwTQ+j527Kyn929jw0GYQAMEo=;
 b=ReleTagVS4UAdX6wYh5q6KOKYSsJ9wgZTL8S0Y68wJ6EXgU+1f+/vJB6KaKhTV3E+u8Oo4
 fLrCoWU1PjstcHuixyn2UM0btgt3lBKip5Q0KhbJmT+NI/2822TJWdAlVcXIo4FCu73ssb
 b/uCtWUKQ+kNYCohMhPkRfp5hldQSr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-kzlC-NSSMLWnlSrj7TYkWw-1; Wed, 20 May 2020 09:00:42 -0400
X-MC-Unique: kzlC-NSSMLWnlSrj7TYkWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D876B18FE867;
 Wed, 20 May 2020 13:00:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D77981024879;
 Wed, 20 May 2020 13:00:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] tests/util-sockets: add abstract unix socket cases
Date: Wed, 20 May 2020 14:00:24 +0100
Message-Id: <20200520130025.2201467-3-berrange@redhat.com>
In-Reply-To: <20200520130025.2201467-1-berrange@redhat.com>
References: <20200520130025.2201467-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 xiaoqiang zhao <zxq_yx_007@163.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: xiaoqiang zhao <zxq_yx_007@163.com>

add cases to test tight and non-tight for abstract address type

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-util-sockets.c | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 5fd947c7bf..2ca1e99f17 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -227,6 +227,93 @@ static void test_socket_fd_pass_num_nocli(void)
     g_free(addr.u.fd.str);
 }
 
+#ifdef __linux__
+static gchar *abstract_sock_name;
+
+static gpointer unix_server_thread_func(gpointer user_data)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd = -1;
+    int connfd = -1;
+    struct sockaddr_un un;
+    socklen_t len = sizeof(un);
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.abstract = true;
+
+    fd = socket_listen(&addr, 1, &err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert(fd_is_socket(fd));
+
+    connfd = accept(fd, (struct sockaddr *)&un, &len);
+    g_assert_cmpint(connfd, !=, -1);
+
+    close(fd);
+
+    return NULL;
+}
+
+static gpointer unix_client_thread_func(gpointer user_data)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd = -1;
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.abstract = true;
+
+    fd = socket_connect(&addr, &err);
+
+    g_assert_cmpint(fd, >=, 0);
+
+    close(fd);
+
+    return NULL;
+}
+
+static void test_socket_unix_abstract_good(void)
+{
+    GRand *r = g_rand_new();
+
+    abstract_sock_name = g_strdup_printf("unix-%d-%d", getpid(),
+                                         g_rand_int_range(r, 100, 1000));
+
+    /* non tight socklen serv and cli */
+    GThread *serv = g_thread_new("abstract_unix_server",
+                                 unix_server_thread_func,
+                                 NULL);
+
+    sleep(1);
+
+    GThread *cli = g_thread_new("abstract_unix_client",
+                                unix_client_thread_func,
+                                NULL);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+
+    /* tight socklen serv and cli */
+    serv = g_thread_new("abstract_unix_server",
+                        unix_server_thread_func,
+                        (gpointer)1);
+
+    sleep(1);
+
+    cli = g_thread_new("abstract_unix_client",
+                       unix_client_thread_func,
+                       (gpointer)1);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+
+    g_free(abstract_sock_name);
+}
+#endif
 
 int main(int argc, char **argv)
 {
@@ -265,6 +352,11 @@ int main(int argc, char **argv)
                         test_socket_fd_pass_num_nocli);
     }
 
+#ifdef __linux__
+    g_test_add_func("/util/socket/unix-abstract/good",
+                    test_socket_unix_abstract_good);
+#endif
+
 end:
     return g_test_run();
 }
-- 
2.26.2


