Received: from eggs.gnu.org ([2001:4830:134:3::10]:39756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dZO-0005pF-Bv
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dZL-0007k5-Sh
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0dZL-0007jx-Np
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Mar 2018 20:36:19 -0500
Message-Id: <20180327013620.1644387-4-eblake@redhat.com>
In-Reply-To: <20180327013620.1644387-1-eblake@redhat.com>
References: <20180327013620.1644387-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] tests: Add parameter to
 qtest_init_without_qmp_handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, marcandre.lureau@redhat.com, borntraeger@de.ibm.com, Markus Armbruster <armbru@redhat.com>

Allow callers to choose whether to allow OOB support during a test;
for now, all existing callers pass false, but the next patch will
add a new caller.  Also, rewrite the monitor setup to be generic
(using the -qmp shorthand is insufficient for honoring the parameter).

Based on an idea by Peter Xu, in <20180326063901.27425-8-peterx@redhat.com>

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h |  7 +++++--
 tests/libqtest.c | 10 ++++++----
 tests/qmp-test.c |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 811169453ab..cbe8df44730 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -56,11 +56,14 @@ QTestState *qtest_init(const char *extra_args);

 /**
  * qtest_init_without_qmp_handshake:
- * @extra_args: other arguments to pass to QEMU.
+ * @use_oob: true to have the server advertise OOB support
+ * @extra_args: other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
+QTestState *qtest_init_without_qmp_handshake(bool use_oob,
+                                             const char *extra_args);

 /**
  * qtest_quit:
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 200b2b9e92a..6f33a37667c 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -166,7 +166,8 @@ static const char *qtest_qemu_binary(void)
     return qemu_bin;
 }

-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(bool use_oob,
+                                             const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -199,12 +200,13 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
         command = g_strdup_printf("exec %s "
                                   "-qtest unix:%s,nowait "
                                   "-qtest-log %s "
-                                  "-qmp unix:%s,nowait "
+                                  "-chardev socket,path=%s,nowait,id=char0 "
+                                  "-mon chardev=char0,mode=control%s "
                                   "-machine accel=qtest "
                                   "-display none "
                                   "%s", qemu_binary, socket_path,
                                   getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
-                                  qmp_socket_path,
+                                  qmp_socket_path, use_oob ? ",x-oob=on" : "",
                                   extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
@@ -239,7 +241,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)

 QTestState *qtest_init(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    QTestState *s = qtest_init_without_qmp_handshake(false, extra_args);

     /* Read the QMP greeting and then do the handshake */
     qtest_qmp_discard_response(s, "");
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 8de99a4727e..2134d95db97 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -81,7 +81,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;

-    qts = qtest_init_without_qmp_handshake(common_args);
+    qts = qtest_init_without_qmp_handshake(false, common_args);

     /* Test greeting */
     resp = qtest_qmp_receive(qts);
-- 
2.14.3
