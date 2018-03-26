Received: from eggs.gnu.org ([2001:4830:134:3::10]:38260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Ln1-0002JB-Mq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Ln0-0006mS-PW
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Ln0-0006mO-K3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3483F8424D
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:39:00 +0800
Message-Id: <20180326063901.27425-8-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 7/8] tests: introduce
 qtest_init_with_qmp_format()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It is abstracted from qtest_init_without_qmp_handshake(). It works just
like qtest_init_without_qmp_handshake() but further it would allow the
caller to specify the QMP parameter.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqtest.c | 14 +++++++++++---
 tests/libqtest.h | 14 ++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 200b2b9e92..d2af1b17f0 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -166,19 +166,22 @@ static const char *qtest_qemu_binary(void)
     return qemu_bin;
 }
 
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+QTestState *qtest_init_with_qmp_format(const char *extra_args,
+                                       const char *qmp_format)
 {
     QTestState *s;
     int sock, qmpsock, i;
     gchar *socket_path;
     gchar *qmp_socket_path;
     gchar *command;
+    gchar *qmp_params;
     const char *qemu_binary = qtest_qemu_binary();
 
     s = g_new(QTestState, 1);
 
     socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
     qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
+    qmp_params = g_strdup_printf(qmp_format, qmp_socket_path);
 
     /* It's possible that if an earlier test run crashed it might
      * have left a stale unix socket lying around. Delete any
@@ -199,12 +202,12 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
         command = g_strdup_printf("exec %s "
                                   "-qtest unix:%s,nowait "
                                   "-qtest-log %s "
-                                  "-qmp unix:%s,nowait "
+                                  "%s "
                                   "-machine accel=qtest "
                                   "-display none "
                                   "%s", qemu_binary, socket_path,
                                   getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
-                                  qmp_socket_path,
+                                  qmp_params,
                                   extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
@@ -237,6 +240,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }
 
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+{
+    return qtest_init_with_qmp_format(extra_args, "-qmp unix:%s,nowait");
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     QTestState *s = qtest_init_without_qmp_handshake(extra_args);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 811169453a..1f3605ce73 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -62,6 +62,20 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
+/**
+ * qtest_init_with_qmp_format:
+ * @extra_args: other arguments to pass to QEMU.
+ * @qmp_format: format of QMP parameters, should contain one "%s"
+ *              field so that the socket path will be filled later.
+ *
+ * Note that this function will work just like
+ * qtest_init_without_qmp_handshake(), so no QMP handshake will be done.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_qmp_format(const char *extra_args,
+                                       const char *qmp_format);
+
 /**
  * qtest_quit:
  * @s: #QTestState instance to operate on.
-- 
2.14.3
