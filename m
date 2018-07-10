Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub7-0003GW-KI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub5-0003Ra-G9
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcub5-0003RE-Ad
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBF3E77889
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:14 +0100
Message-Id: <20180710153016.131258-14-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] tests: add postcopy recovery test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

Test the postcopy recovery procedure by emulating a network failure
using migrate-pause command.

Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-10-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 4c15071893..d8b2633fce 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -352,6 +352,29 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
     migrate_check_parameter(who, parameter, value);
 }
 
+static void migrate_pause(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who, "{ 'execute': 'migrate-pause' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+static void migrate_recover(QTestState *who, const char *uri)
+{
+    QDict *rsp;
+    gchar *cmd = g_strdup_printf(
+        "{ 'execute': 'migrate-recover', "
+        "  'id': 'recover-cmd', "
+        "  'arguments': { 'uri': '%s' } }", uri);
+
+    rsp = wait_command(who, cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    g_free(cmd);
+    qobject_unref(rsp);
+}
+
 static void migrate_set_capability(QTestState *who, const char *capability,
                                    const char *value)
 {
@@ -608,6 +631,62 @@ static void test_postcopy(void)
     migrate_postcopy_complete(from, to);
 }
 
+static void test_postcopy_recovery(void)
+{
+    QTestState *from, *to;
+    char *uri;
+
+    if (migrate_postcopy_prepare(&from, &to)) {
+        return;
+    }
+
+    /* Turn postcopy speed down, 4K/s is slow enough on any machines */
+    migrate_set_parameter(from, "max-postcopy-bandwidth", "4096");
+
+    /* Now we start the postcopy */
+    migrate_postcopy_start(from, to);
+
+    /*
+     * Wait until postcopy is really started; we can only run the
+     * migrate-pause command during a postcopy
+     */
+    wait_for_migration_status(from, "postcopy-active");
+
+    /*
+     * Manually stop the postcopy migration. This emulates a network
+     * failure with the migration socket
+     */
+    migrate_pause(from);
+
+    /*
+     * Wait for destination side to reach postcopy-paused state.  The
+     * migrate-recover command can only succeed if destination machine
+     * is in the paused state
+     */
+    wait_for_migration_status(to, "postcopy-paused");
+
+    /*
+     * Create a new socket to emulate a new channel that is different
+     * from the broken migration channel; tell the destination to
+     * listen to the new port
+     */
+    uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
+    migrate_recover(to, uri);
+
+    /*
+     * Try to rebuild the migration channel using the resume flag and
+     * the newly created channel
+     */
+    wait_for_migration_status(from, "postcopy-paused");
+    migrate(from, uri, ", 'resume': true");
+    g_free(uri);
+
+    /* Restore the postcopy bandwidth to unlimited */
+    migrate_set_parameter(from, "max-postcopy-bandwidth", "0");
+
+    migrate_postcopy_complete(from, to);
+}
+
 static void test_baddest(void)
 {
     QTestState *from, *to;
@@ -698,6 +777,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
+    qtest_add_func("/migration/postcopy/recovery", test_postcopy_recovery);
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
-- 
2.17.1
