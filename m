Received: from eggs.gnu.org ([2001:4830:134:3::10]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA3-0008IZ-FO
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA0-00075m-8S
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elz9z-00074j-VP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:33 +0000
Message-Id: <20180214153938.5410-6-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] tests/migration: Add test for migration
 to bad destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check the source survives.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180212160340.15333-3-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 65 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 97fdb1988e..74f9361bdd 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -434,28 +434,31 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     g_free(cmd_dst);
 }
 
-static void test_migrate_end(QTestState *from, QTestState *to)
+static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
     qtest_quit(from);
 
-    qtest_memread(to, start_address, &dest_byte_a, 1);
+    if (test_dest) {
+        qtest_memread(to, start_address, &dest_byte_a, 1);
 
-    /* Destination still running, wait for a byte to change */
-    do {
-        qtest_memread(to, start_address, &dest_byte_b, 1);
-        usleep(1000 * 10);
-    } while (dest_byte_a == dest_byte_b);
+        /* Destination still running, wait for a byte to change */
+        do {
+            qtest_memread(to, start_address, &dest_byte_b, 1);
+            usleep(1000 * 10);
+        } while (dest_byte_a == dest_byte_b);
+
+        qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
 
-    qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
-    /* With it stopped, check nothing changes */
-    qtest_memread(to, start_address, &dest_byte_c, 1);
-    usleep(1000 * 200);
-    qtest_memread(to, start_address, &dest_byte_d, 1);
-    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+        /* With it stopped, check nothing changes */
+        qtest_memread(to, start_address, &dest_byte_c, 1);
+        usleep(1000 * 200);
+        qtest_memread(to, start_address, &dest_byte_d, 1);
+        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
 
-    check_guests_ram(to);
+        check_guests_ram(to);
+    }
 
     qtest_quit(to);
 
@@ -547,7 +550,38 @@ static void test_migrate(void)
 
     g_free(uri);
 
-    test_migrate_end(from, to);
+    test_migrate_end(from, to, true);
+}
+
+static void test_baddest(void)
+{
+    QTestState *from, *to;
+    QDict *rsp, *rsp_return;
+    const char *status;
+    bool failed;
+
+    test_migrate_start(&from, &to, "tcp:0:0");
+    migrate(from, "tcp:0:0");
+    do {
+        rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
+        rsp_return = qdict_get_qdict(rsp, "return");
+
+        status = qdict_get_str(rsp_return, "status");
+
+        g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
+        failed = !strcmp(status, "failed");
+        QDECREF(rsp);
+    } while (!failed);
+
+    /* Is the machine currently running? */
+    rsp = wait_command(from, "{ 'execute': 'query-status' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    rsp_return = qdict_get_qdict(rsp, "return");
+    g_assert(qdict_haskey(rsp_return, "running"));
+    g_assert(qdict_get_bool(rsp_return, "running"));
+    QDECREF(rsp);
+
+    test_migrate_end(from, to, false);
 }
 
 int main(int argc, char **argv)
@@ -571,6 +605,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/migration/postcopy/unix", test_migrate);
     qtest_add_func("/migration/deprecated", test_deprecated);
+    qtest_add_func("/migration/bad_dest", test_baddest);
 
     ret = g_test_run();
 
-- 
2.14.3
