Received: from eggs.gnu.org ([2001:4830:134:3::10]:52989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001Ra-91
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4T-0007BK-0q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4S-0007Ax-RC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:27 +0200
Message-Id: <20180703085358.13941-2-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/32] qmp: Say "out-of-band" instead of
 "Out-Of-Band"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Affects documentation and a few error messages.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt            |  2 +-
 docs/interop/qmp-spec.txt               |  2 +-
 monitor.c                               | 14 +++++++-------
 qapi/misc.json                          |  2 +-
 tests/qapi-schema/qapi-schema-test.json |  2 +-
 tests/qmp-test.c                        |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 94a7e8f4d0..9625798d16 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -641,7 +641,7 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
-A command can be declared to support Out-Of-Band (OOB) execution.  By
+A command can be declared to support out-of-band (OOB) execution.  By
 default, commands do not support OOB.  To declare a command that
 supports it, the schema includes an extra 'allow-oob' field.  For
 example:
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 6fa193a80b..2bb492d1ea 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -85,7 +85,7 @@ The greeting message format is:
 
 Currently supported capabilities are:
 
-- "oob": the QMP server supports "Out-Of-Band" (OOB) command
+- "oob": the QMP server supports "out-of-band" (OOB) command
   execution.  For more details, please see the "run-oob" parameter in
   the "Issuing Commands" section below.  Not all commands allow this
   "oob" execution.  The "query-qmp-schema" command can be used to
diff --git a/monitor.c b/monitor.c
index 567668a0e7..f5f20e36e3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1267,11 +1267,11 @@ static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
         case QMP_CAPABILITY_OOB:
             if (!mon->use_io_thr) {
                 /*
-                 * Out-Of-Band only works with monitors that are
+                 * Out-of-band only works with monitors that are
                  * running on dedicated IOThread.
                  */
                 error_setg(errp, "This monitor does not support "
-                           "Out-Of-Band (OOB)");
+                           "out-of-band (OOB)");
                 return;
             }
             break;
@@ -1319,7 +1319,7 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
 
     if (qmp_is_oob(req)) {
         if (!qmp_oob_enabled(mon)) {
-            error_setg(errp, "Please enable Out-Of-Band first "
+            error_setg(errp, "Please enable out-of-band first "
                        "for the session during capabilities negotiation");
             return false;
         }
@@ -4293,7 +4293,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 
     /* When OOB is enabled, the "id" field is mandatory. */
     if (qmp_oob_enabled(mon) && !id) {
-        error_setg(&err, "Out-Of-Band capability requires that "
+        error_setg(&err, "Out-of-band capability requires that "
                    "every command contains an 'id' field");
         goto err;
     }
@@ -4307,7 +4307,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     qdict_del(qdict, "id");
 
     if (qmp_is_oob(qdict)) {
-        /* Out-Of-Band (OOB) requests are executed directly in parser. */
+        /* Out-of-band (OOB) requests are executed directly in parser. */
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id)
                                           ?: "");
         monitor_qmp_dispatch_one(req_obj);
@@ -4683,12 +4683,12 @@ void monitor_init(Chardev *chr, int flags)
 
     if (use_oob) {
         if (CHARDEV_IS_MUX(chr)) {
-            error_report("Monitor Out-Of-Band is not supported with "
+            error_report("Monitor out-of-band is not supported with "
                          "MUX typed chardev backend");
             exit(1);
         }
         if (use_readline) {
-            error_report("Monitor Out-Of-band is only supported by QMP");
+            error_report("Monitor out-of-band is only supported by QMP");
             exit(1);
         }
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index 29da7856e3..0446c3e48e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -46,7 +46,7 @@
 # Enumeration of capabilities to be advertised during initial client
 # connection, used for agreeing on particular QMP extension behaviors.
 #
-# @oob:   QMP ability to support Out-Of-Band requests.
+# @oob:   QMP ability to support out-of-band requests.
 #         (Please refer to qmp-spec.txt for more information on OOB)
 #
 # Since: 2.12
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 7b59817f04..e9e401c01f 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -141,7 +141,7 @@
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': true }
 
-# Smoke test on Out-Of-Band and allow-preconfig-test
+# Smoke test on out-of-band and allow-preconfig-test
 { 'command': 'test-flags-command', 'allow-oob': true, 'allow-preconfig': true }
 
 # For testing integer range flattening in opts-visitor. The following schema
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index a49cbc6fde..5206b14ca6 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -135,7 +135,7 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
-/* Tests for Out-Of-Band support. */
+/* Tests for out-of-band support. */
 static void test_qmp_oob(void)
 {
     QTestState *qts;
-- 
2.17.1
