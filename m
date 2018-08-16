Received: from eggs.gnu.org ([2001:4830:134:3::10]:50693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmq-0001AL-H7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmf-0005NL-Ho
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmV-0005CV-67
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A010D4028152
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:51 +0200
Message-Id: <20180816083701.3932-16-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/25] migration-test: Make wait_command()
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

All callers of wait_command() are only interested in the success
response's "return" member.  Lift its extraction into wait_command().

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-16-armbru@redhat.com>
---
 tests/migration-test.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 486059580c..db652e30a0 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -155,7 +155,7 @@ static void wait_for_serial(const char *side)
 static QDict *wait_command(QTestState *who, const char *command)
 {
     const char *event_string;
-    QDict *response;
+    QDict *response, *ret;
 
     response = qtest_qmp(who, command);
 
@@ -168,7 +168,12 @@ static QDict *wait_command(QTestState *who, const char *command)
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
@@ -177,15 +182,7 @@ static QDict *wait_command(QTestState *who, const char *command)
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
@@ -327,16 +324,16 @@ static void cleanup(const char *filename)
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
@@ -360,7 +357,6 @@ static void migrate_pause(QTestState *who)
     QDict *rsp;
 
     rsp = wait_command(who, "{ 'execute': 'migrate-pause' }");
-    g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
 
@@ -373,7 +369,6 @@ static void migrate_recover(QTestState *who, const char *uri)
         "  'arguments': { 'uri': '%s' } }", uri);
 
     rsp = wait_command(who, cmd);
-    g_assert(qdict_haskey(rsp, "return"));
     g_free(cmd);
     qobject_unref(rsp);
 }
@@ -414,7 +409,6 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     QDict *rsp;
 
     rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
     if (!got_stop) {
@@ -692,7 +686,7 @@ static void test_postcopy_recovery(void)
 static void test_baddest(void)
 {
     QTestState *from, *to;
-    QDict *rsp, *rsp_return;
+    QDict *rsp_return;
     char *status;
     bool failed;
 
@@ -708,12 +702,10 @@ static void test_baddest(void)
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
