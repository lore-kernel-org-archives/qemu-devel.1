Received: from eggs.gnu.org ([2001:4830:134:3::10]:38405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvE-0002P1-6x
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvC-0003H9-Qj
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZvC-0003Fp-EQ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E1CD4E906
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:53:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:40 +0100
Message-Id: <20180105215246.908-6-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/11] tests: Add deprecated commands
 migration test
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

We add deprecated commands on a new test, so we don't have to add it
on normal tests.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index f469235d0b..bcb0a82d42 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -513,6 +513,64 @@ static void test_migrate_end(QTestState *from, QTestState *to)
     cleanup("dest_serial");
 }
 
+static void deprecated_set_downtime(QTestState *who, const double value)
+{
+    QDict *rsp;
+    gchar *cmd;
+    char *expected;
+    int64_t result_int;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
+                          "'arguments': { 'value': %g } }", value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+    result_int = value * 1000L;
+    expected = g_strdup_printf("%" PRId64, result_int);
+    migrate_check_parameter(who, "downtime-limit", expected);
+    g_free(expected);
+}
+
+static void deprecated_set_speed(QTestState *who, const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
+                          "'arguments': { 'value': %s } }", value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+    migrate_check_parameter(who, "max-bandwidth", value);
+}
+
+static void test_deprecated(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    /* Create source and destination guests.  This way we can reuse
+     * test_migrate_start */
+    test_migrate_start(&from, &to, uri);
+
+    deprecated_set_downtime(from, 0.12345);
+    deprecated_set_downtime(to, 0.12345);
+    deprecated_set_speed(from, "12345");
+    deprecated_set_speed(to, "12345");
+
+    g_free(uri);
+
+    qtest_quit(from);
+    qtest_quit(to);
+
+    cleanup("bootsect");
+    cleanup("migsocket");
+    cleanup("src_serial");
+    cleanup("dest_serial");
+}
+
 static void test_migrate(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -580,6 +638,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/postcopy/unix", test_migrate);
+    qtest_add_func("/migration/deprecated", test_deprecated);
 
     ret = g_test_run();
 
-- 
2.14.3
