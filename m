Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CFC35280
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 06:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953C82082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 06:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eCXAtyAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXfGt-0001VN-K1
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 02:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jXfGB-0000g1-O2
 for qemu-devel@nongnu.org; Sun, 10 May 2020 02:16:23 -0400
Received: from m12-18.163.com ([220.181.12.18]:49200)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jXfG8-0000xO-9L
 for qemu-devel@nongnu.org; Sun, 10 May 2020 02:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=lVrFysFkDG9ewq07JW
 wjB/lue4dFXuRJNZJNnV0jr8w=; b=eCXAtyAUn2iaW38P5V72EMUWUQcKnzNyGa
 G+lbLf38MG15BDYQhKjPifPxvRPjIzGhLrtEmmsFtNQXt2TV1LkMKmFq8aZmwv5F
 cT1GuBpNrBcV9Z99CtJNS6JAVTU4DFz34iPokoI+5sL5N5I3aG4F3uNczXOpjN0t
 tmX8XjD7E=
Received: from localhost.localdomain (unknown [103.235.247.137])
 by smtp14 (Coremail) with SMTP id EsCowADH7trXm7dehaPQBA--.17000S4;
 Sun, 10 May 2020 14:15:38 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: berrange@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com,
 kwolf@redhat.com, armbru@redhat.com
Subject: [PATCH v3 2/3] tests/util-sockets: add abstract unix socket cases
Date: Sun, 10 May 2020 14:14:21 +0800
Message-Id: <20200510061422.24841-3-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510061422.24841-1-zxq_yx_007@163.com>
References: <20200510061422.24841-1-zxq_yx_007@163.com>
X-CM-TRANSID: EsCowADH7trXm7dehaPQBA--.17000S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1kurWkCFyfXF13GrW3Wrg_yoW5Jw4xpF
 yfGFy5Kw4rAFs7uwsxJaykXr1fGF4rZa1jy3s3A3W5Ar4DG34YqFsYkFyUtw1xAFW8Xw4S
 9rnxKF10gw43taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULTmhUUUUU=
X-Originating-IP: [103.235.247.137]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiMxIgxlXl3hAvLgAAs4
Received-SPF: pass client-ip=220.181.12.18; envelope-from=zxq_yx_007@163.com;
 helo=m12-18.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 02:16:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 xiaoqiang zhao <zxq_yx_007@163.com>, kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add cases to test tight and non-tight for abstract address type

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 tests/test-util-sockets.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 5fd947c7bf..8042fb9276 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -227,6 +227,84 @@ static void test_socket_fd_pass_num_nocli(void)
     g_free(addr.u.fd.str);
 }
 
+static gpointer unix_server_thread_func(gpointer user_data)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd = -1;
+    int connfd = -1;
+    struct sockaddr_un un;
+    socklen_t len = sizeof(un);
+    char name[] = "/tmp/unix-test.sock";
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = name;
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
+    char name[] = "/tmp/unix-test.sock";
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = name;
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
+    /* non tight socklen serv and cli */
+    GThread *serv = g_thread_new("abstract_unix_server",
+                                 unix_server_thread_func,
+                                 NULL);
+
+    sleep(1);
+
+    GThread *cli = g_thread_new("abstruct_unix_client",
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
+    cli = g_thread_new("abstruct_unix_client",
+                       unix_client_thread_func,
+                       (gpointer)1);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+}
 
 int main(int argc, char **argv)
 {
@@ -265,6 +343,11 @@ int main(int argc, char **argv)
                         test_socket_fd_pass_num_nocli);
     }
 
+#ifdef __linux__
+        g_test_add_func("/util/socket/unix-abstract/good",
+                        test_socket_unix_abstract_good);
+#endif
+
 end:
     return g_test_run();
 }
-- 
2.17.1



