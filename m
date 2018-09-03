Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXZ-0007UR-A5
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXW-0000MO-1k
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgXV-0000Ll-LH
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64AA6402243B
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:36 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:48 +0800
Message-Id: <20180903043149.4076-7-peterx@redhat.com>
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 6/7] Revert "tests: Add parameter to
 qtest_init_without_qmp_handshake"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This reverts commit ddee57e0176f6ab53b13c6c97605b62737a8fd7a.

Meanwhile, revert one line from fa198ad9bdef to make sure
qtest_init_without_qmp_handshake() will only pass in one parameter.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqtest.c | 10 ++++------
 tests/libqtest.h |  4 +---
 tests/qmp-test.c |  4 ++--
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index ebd92f22f6..3c594abbc2 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -191,8 +191,7 @@ static const char *qtest_qemu_binary(void)
     return qemu_bin;
 }
 
-QTestState *qtest_init_without_qmp_handshake(bool use_oob,
-                                             const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -225,13 +224,12 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
         command = g_strdup_printf("exec %s "
                                   "-qtest unix:%s,nowait "
                                   "-qtest-log %s "
-                                  "-chardev socket,path=%s,nowait,id=char0 "
-                                  "-mon chardev=char0,mode=control%s "
+                                  "-qmp unix:%s,nowait "
                                   "-machine accel=qtest "
                                   "-display none "
                                   "%s", qemu_binary, socket_path,
                                   getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
-                                  qmp_socket_path, "",
+                                  qmp_socket_path,
                                   extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
@@ -266,7 +264,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
 
 QTestState *qtest_init(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(false, extra_args);
+    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
     QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 36d5caecd4..49ffc1ba9f 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -55,14 +55,12 @@ QTestState *qtest_init(const char *extra_args);
 
 /**
  * qtest_init_without_qmp_handshake:
- * @use_oob: true to have the server advertise OOB support
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_without_qmp_handshake(bool use_oob,
-                                             const char *extra_args);
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
 /**
  * qtest_quit:
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5302bd07b9..91a90d1c9d 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -135,7 +135,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;
 
-    qts = qtest_init_without_qmp_handshake(false, common_args);
+    qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Test greeting */
     resp = qtest_qmp_receive(qts);
@@ -249,7 +249,7 @@ static void test_qmp_oob(void)
     QList *capabilities;
     QString *qstr;
 
-    qts = qtest_init_without_qmp_handshake(true, common_args);
+    qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Check the greeting message. */
     resp = qtest_qmp_receive(qts);
-- 
2.17.1
