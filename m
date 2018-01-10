Received: from eggs.gnu.org ([2001:4830:134:3::10]:40444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnO-0006Fb-GO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnL-0004h8-Am
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnL-0004gM-49
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 387607C840
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:19 +0100
Message-Id: <20180110124723.11879-11-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 10/14] migration: Add multifd test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We set the x-multifd-page-count and x-multifd-channels.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index eb44a95aa9..488ae89f34 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -826,6 +826,55 @@ static void test_compress_unix(void)
     g_free(uri);
 }
 
+static void test_multifd_tcp(void)
+{
+    char *uri;
+    char *port;
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, "tcp:127.0.0.1:0");
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", "100000000");
+
+    migrate_set_parameter(from, "x-multifd-channels", "4");
+    migrate_set_parameter(to, "x-multifd-channels", "4");
+
+    migrate_set_parameter(from, "x-multifd-page-count", "64");
+    migrate_set_parameter(to, "x-multifd-page-count", "64");
+
+    migrate_set_capability(from, "x-multifd", "true");
+    migrate_set_capability(to, "x-multifd", "true");
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    port = migrate_get_parameter(to, "tcp-port");
+    uri = g_strdup_printf("tcp:127.0.0.1:%s", port);
+
+    migrate(from, uri);
+
+    wait_for_migration_pass(from);
+
+    /* 300ms it should converge */
+    migrate_set_parameter(from, "downtime-limit", "300");
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -853,6 +902,7 @@ int main(int argc, char **argv)
     if (0) {
         qtest_add_func("/migration/compress/unix", test_compress_unix);
     }
+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
 
     ret = g_test_run();
 
-- 
2.14.3
