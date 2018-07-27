Received: from eggs.gnu.org ([2001:4830:134:3::10]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4Ra-00069P-OI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RY-0000He-NP
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RY-0000AJ-9n
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:50 +0200
Message-Id: <20180727151359.29061-15-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/23] migration-test: Make wait_command()
 return the "return" member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

All callers of wait_command() are only interested in the success
response's "return" member.  Lift its extraction into wait_command().

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index c6c7089ce1..e336399a71 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -152,7 +152,7 @@ static void wait_for_serial(const char *side)
 static QDict *wait_command(QTestState *who, const char *command)
 {
     const char *event_string;
-    QDict *response;
+    QDict *response, *ret;
 
     response = qtest_qmp(who, command);
 
@@ -165,7 +165,12 @@ static QDict *wait_command(QTestState *who, const char *command)
         qobject_unref(response);
         response = qtest_qmp_receive(who);
     }
-    return response;
+
+    ret = qdict_get_qdict(response, "return");
+    g_assert(ret);
+    qobject_ref(ret);
+    qobject_unref(response);
+    return ret;
 }
 
 /*
@@ -174,15 +179,7 @@ static QDict *wait_command(QTestState *who, const char *command)
  */
 static QDict *migrate_query(QTestState *who)
 {
-    QDict *rsp, *rsp_return;
-
-    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
-    rsp_return = qdict_get_qdict(rsp, "return");
-    g_assert(rsp_return);
-    qobject_ref(rsp_return);
-    qobject_unref(rsp);
-
-    return rsp_return;
+    return wait_command(who, "{ 'execute': 'query-migrate' }");
 }
 
 /*
@@ -324,16 +321,16 @@ static void cleanup(const char *filename)
 static void migrate_check_parameter(QTestState *who, const char *parameter,
                                     const char *value)
 {
-    QDict *rsp, *rsp_return;
+    QDict *rsp_return;
     char *result;
 
-    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
-    rsp_return = qdict_get_qdict(rsp, "return");
+    rsp_return = wait_command(who,
+                              "{ 'execute': 'query-migrate-parameters' }");
     result = g_strdup_printf("%" PRId64,
                              qdict_get_try_int(rsp_return,  parameter, -1));
     g_assert_cmpstr(result, ==, value);
     g_free(result);
-    qobject_unref(rsp);
+    qobject_unref(rsp_return);
 }
 
 static void migrate_set_parameter(QTestState *who, const char *parameter,
@@ -357,7 +354,6 @@ static void migrate_pause(QTestState *who)
     QDict *rsp;
 
     rsp = wait_command(who, "{ 'execute': 'migrate-pause' }");
-    g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
 
@@ -370,7 +366,6 @@ static void migrate_recover(QTestState *who, const char *uri)
         "  'arguments': { 'uri': '%s' } }", uri);
 
     rsp = wait_command(who, cmd);
-    g_assert(qdict_haskey(rsp, "return"));
     g_free(cmd);
     qobject_unref(rsp);
 }
@@ -411,7 +406,6 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     QDict *rsp;
 
     rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
     if (!got_stop) {
@@ -689,7 +683,7 @@ static void test_postcopy_recovery(void)
 static void test_baddest(void)
 {
     QTestState *from, *to;
-    QDict *rsp, *rsp_return;
+    QDict *rsp_return;
     char *status;
     bool failed;
 
@@ -705,12 +699,10 @@ static void test_baddest(void)
     } while (!failed);
 
     /* Is the machine currently running? */
-    rsp = wait_command(from, "{ 'execute': 'query-status' }");
-    g_assert(qdict_haskey(rsp, "return"));
-    rsp_return = qdict_get_qdict(rsp, "return");
+    rsp_return = wait_command(from, "{ 'execute': 'query-status' }");
     g_assert(qdict_haskey(rsp_return, "running"));
     g_assert(qdict_get_bool(rsp_return, "running"));
-    qobject_unref(rsp);
+    qobject_unref(rsp_return);
 
     test_migrate_end(from, to, false);
 }
-- 
2.17.1
