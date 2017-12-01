Received: from eggs.gnu.org ([2001:4830:134:3::10]:54955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoJR-0005Bf-T8
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoJP-0003YL-3W
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoJO-0003XN-RG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED91D7E430
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:58:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:58:13 +0100
Message-Id: <20171201125813.1437-7-quintela@redhat.com>
In-Reply-To: <20171201125813.1437-1-quintela@redhat.com>
References: <20171201125813.1437-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/6] [RFH] tests: Add migration compress
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
 tests/migration-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 41dee78a9a..eab3b146a4 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -739,6 +739,54 @@ static void test_xbzrle_unix(void)
     g_free(uri);
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
+    /* 100 ms */
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1MB/s slow*/
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
+static void test_compress_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    test_compress(uri);
+    g_free(uri);
+}
 
 int main(int argc, char **argv)
 {
@@ -763,6 +811,9 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    if (0) {
+        qtest_add_func("/migration/compress/unix", test_compress_unix);
+    }
 
     ret = g_test_run();
 
-- 
2.14.3
