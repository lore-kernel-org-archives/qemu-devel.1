Received: from eggs.gnu.org ([2001:4830:134:3::10]:58253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fazC1-0006Zq-TB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fazBv-0000WP-VY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fazBv-0000US-MT
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w657sKGO024762
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 04:00:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1c6tq07x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 04:00:37 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Thu, 5 Jul 2018 09:00:35 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Thu,  5 Jul 2018 13:30:16 +0530
In-Reply-To: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
References: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
Message-Id: <20180705080017.31123-2-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] tests: add precopy multifd migration test
 with unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

multifd migration feature is in with commit: 35374cbdff, this patch
adds test for it using unix socket.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tests/migration-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 3a85446f95..e2434e70ea 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -619,6 +619,36 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
 
+static void test_multifd_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    test_migrate_start(&from, &to, uri, false);
+
+    /* set multifd capability on source and target */
+    migrate_set_capability(from, "x-multifd", "true");
+    migrate_set_capability(to, "x-multifd", "true");
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /* perform migration */
+    migrate(from, uri);
+
+    wait_for_migration_pass(from);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to, true);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -642,6 +672,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/multifd/unix", test_multifd_unix);
 
     ret = g_test_run();
 
-- 
2.14.3
