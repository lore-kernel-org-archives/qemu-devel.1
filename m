Received: from eggs.gnu.org ([2001:4830:134:3::10]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXns-0005E6-7w
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXno-00035u-DI
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:09 +0300
Message-Id: <7c933ad61b8f3f5133757c8cbaedd712e5be6f78.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 05/22] tests/libqtest: Print error instead of
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/libqtest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 84ecbd2bd8..4a5492a603 100644
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
2.11.0
