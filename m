Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNnG-0008QO-9x
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNnF-0005Wx-CQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:02:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNnF-0005Vl-6G
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4B28A1BD4
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:02:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 14:01:40 +0200
Message-Id: <20180509120140.6612-4-quintela@redhat.com>
In-Reply-To: <20180509120140.6612-1-quintela@redhat.com>
References: <20180509120140.6612-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 3/3] migration: Add multifd test
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 27a7c2dbf0..dab1f1705f 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -777,6 +777,53 @@ static void test_precopy_tcp(void)
     g_free(uri);
 }
 
+static void test_multifd_tcp(void)
+{
+    char *uri;
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false);
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", "1000000000");
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
+    uri = migrate_get_socket_address(to, "socket-address");
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
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -802,6 +849,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
 
     ret = g_test_run();
 
-- 
2.17.0
