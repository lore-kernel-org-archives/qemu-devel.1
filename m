Received: from eggs.gnu.org ([2001:4830:134:3::10]:57240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dCpSC-00028w-TY
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dCpS7-0005Iu-Ir
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:41:04 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 May 2017 17:40:54 +0200
Message-Id: <1495467654-30911-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tests/libqtest: Print error instead of
 aborting when env variable is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org

When you currently try to run a test directly from the command line
without setting the QTEST_QEMU_BINARY environment variable first,
you are presented with an unhelpful assertion message like this:

 ERROR:tests/libqtest.c:163:qtest_init_without_qmp_handshake:
 assertion failed: (qemu_binary != NULL)
 Aborted (core dumped)

Let's replace the assert() with a more user friendly error message
instead.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Changed the error message text according to Markus' suggestion

 tests/libqtest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 84ecbd2..4a5492a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -160,7 +160,10 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     const char *qemu_binary;
 
     qemu_binary = getenv("QTEST_QEMU_BINARY");
-    g_assert(qemu_binary != NULL);
+    if (!qemu_binary) {
+        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required\n");
+        exit(1);
+    }
 
     s = g_malloc(sizeof(*s));
 
-- 
1.8.3.1
