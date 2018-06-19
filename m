Received: from eggs.gnu.org ([2001:4830:134:3::10]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9Il-0005qR-Ei
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9Ik-00043M-Ec
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9Ik-000439-9H
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:34 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Jun 2018 13:34:26 +0800
Message-Id: <20180619053426.13065-8-peterx@redhat.com>
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/7] Revert "tests: Add parameter to
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit ddee57e0176f6ab53b13c6c97605b62737a8fd7a.

Meanwhile, revert one line from fa198ad9bdef to make sure
qtest_init_without_qmp_handshake() will only pass in one parameter.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqtest.h |  4 +---
 tests/libqtest.c | 10 ++++------
 tests/qmp-test.c |  4 ++--
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index ac52872cbe..180d2cc6ff 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -56,14 +56,12 @@ QTestState *qtest_init(const char *extra_args);
 
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
diff --git a/tests/libqtest.c b/tests/libqtest.c
index c5cb3f925c..51af4a289e 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -173,8 +173,7 @@ static const char *qtest_qemu_binary(void)
     return qemu_bin;
 }
 
-QTestState *qtest_init_without_qmp_handshake(bool use_oob,
-                                             const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -207,13 +206,12 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
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
@@ -248,7 +246,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
 
 QTestState *qtest_init(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(false, extra_args);
+    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
 
     /* Read the QMP greeting and then do the handshake */
     qtest_qmp_discard_response(s, "");
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 3747bf7fbb..7d23daba28 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -81,7 +81,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;
 
-    qts = qtest_init_without_qmp_handshake(false, common_args);
+    qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Test greeting */
     resp = qtest_qmp_receive(qts);
@@ -146,7 +146,7 @@ static void test_qmp_oob(void)
     QString *qstr;
     const char *cmd_id;
 
-    qts = qtest_init_without_qmp_handshake(true, common_args);
+    qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Check the greeting message. */
     resp = qtest_qmp_receive(qts);
-- 
2.17.1
