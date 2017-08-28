Received: from eggs.gnu.org ([2001:4830:134:3::10]:48541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmHOm-00019f-Qr
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmHOj-0001yT-Jy
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:36:04 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 28 Aug 2017 12:35:57 +0200
Message-Id: <1503916557-1292-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/libqtest: Use a proper error message if
 QTEST_QEMU_BINARY is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

The user can currently still cause an abort() if running certain tests
(like the prom-env-test) without setting the QTEST_QEMU_BINARY first.
A similar problem has been fixed with commit 7c933ad61b8f3f51337
already, but forgot to also take care of the qtest_get_arch() function,
so let's introduce a proper wrapper around getenv("QTEST_QEMU_BINARY")
that can be used in both locations now.

Buglink: https://bugs.launchpad.net/qemu/+bug/1713434
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index b9a1f18..342a77b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -150,6 +150,19 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     g_hook_prepend(&abrt_hooks, hook);
 }
 
+static const char *qtest_qemu_binary(void)
+{
+    const char *qemu_bin;
+
+    qemu_bin = getenv("QTEST_QEMU_BINARY");
+    if (!qemu_bin) {
+        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required\n");
+        exit(1);
+    }
+
+    return qemu_bin;
+}
+
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
@@ -157,13 +170,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     gchar *socket_path;
     gchar *qmp_socket_path;
     gchar *command;
-    const char *qemu_binary;
-
-    qemu_binary = getenv("QTEST_QEMU_BINARY");
-    if (!qemu_binary) {
-        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required\n");
-        exit(1);
-    }
+    const char *qemu_binary = qtest_qemu_binary();
 
     s = g_malloc(sizeof(*s));
 
@@ -624,8 +631,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 
 const char *qtest_get_arch(void)
 {
-    const char *qemu = getenv("QTEST_QEMU_BINARY");
-    g_assert(qemu != NULL);
+    const char *qemu = qtest_qemu_binary();
     const char *end = strrchr(qemu, '/');
 
     return end + strlen("/qemu-system-");
-- 
1.8.3.1
