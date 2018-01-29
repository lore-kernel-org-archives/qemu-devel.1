Received: from eggs.gnu.org ([2001:4830:134:3::10]:43708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8O8-0004be-JG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8O3-000175-Tr
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8O3-00016k-Ni
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13E1372665
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:18:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:17:54 +0100
Message-Id: <20180129121754.13033-6-quintela@redhat.com>
In-Reply-To: <20180129121754.13033-1-quintela@redhat.com>
References: <20180129121754.13033-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/5] [RFH] tests: Add migration compress
 threads tests
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

Yeap, it is still not working. trying to learn how to debug threads
for guests running from the testt hardness.

For some reason, compression is not working at the moment, test is
disabled until I found why.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 355e6d18e9..02d8ae7cb6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -715,6 +715,55 @@ static void test_precopy_tcp(void)
     g_free(port);
 }
 
+static void test_compress(const char *uri)
+{
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, uri);
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
+    migrate_set_parameter(from, "compress-threads", "4");
+    migrate_set_parameter(to, "decompress-threads", "3");
+
+    migrate_set_capability(from, "compress", "true");
+    migrate_set_capability(to, "compress", "true");
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri);
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
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
+static void test_compress_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    test_compress(uri);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -739,6 +788,9 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    if (0) {
+        qtest_add_func("/migration/compress/unix", test_compress_unix);
+    }
 
     ret = g_test_run();
 
-- 
2.14.3
