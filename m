Received: from eggs.gnu.org ([2001:4830:134:3::10]:50522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QV-0007b2-Fb
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QU-0004Ov-HE
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QU-0004OY-Cw
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFC82406E946
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:37 +0100
Message-Id: <20180314163838.7158-8-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 7/8] migration: Add multifd test
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
 tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 8f367ea1d7..eba40812fc 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -738,6 +738,53 @@ static void test_precopy_tcp(void)
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
+    uri = migrate_get_socket_address(to, "x-socket-address");
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
@@ -763,6 +810,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
 
     ret = g_test_run();
 
-- 
2.14.3
