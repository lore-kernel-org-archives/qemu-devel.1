Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKK-00037m-52
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001n1-2F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001kh-8F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:37 +0200
Message-Id: <20180817150559.16243-39-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 38/60] json: Pass lexical errors and limit
 violations to callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

The callback to consume JSON values takes QObject *json, Error *err.
If both are null, the callback is supposed to make up an error by
itself.  This sucks.

qjson.c's consume_json() neglects to do so, which makes
qobject_from_json() null instead of failing.  I consider that a bug.

The culprit is json_message_process_token(): it passes two null
pointers when it runs into a lexical error or a limit violation.  Fix
it to pass a proper Error object then.  Update the callbacks:

* monitor.c's handle_qmp_command(): the code to make up an error is
  now dead, drop it.

* qga/main.c's process_event(): lumps the "both null" case together
  with the "not a JSON object" case.  The former is now gone.  The
  error message "Invalid JSON syntax" is misleading for the latter.
  Improve it to "Input must be a JSON object".

* qobject/qjson.c's consume_json(): no update; check-qjson
  demonstrates qobject_from_json() now sets an error on lexical
  errors, but still doesn't on some other errors.

* tests/libqtest.c's qmp_response(): the Error object is now reliable,
  so use it to improve the error message.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qerror.h |  3 ---
 monitor.c                 |  5 +----
 qga/main.c                |  3 ++-
 qobject/json-streamer.c   | 22 ++++++++++++++++------
 tests/check-qjson.c       | 15 ++++++++-------
 tests/libqtest.c          |  7 +++++--
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index c82360f429..145571f618 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -61,9 +61,6 @@
 #define QERR_IO_ERROR \
     "An IO error has occurred"
 
-#define QERR_JSON_PARSING \
-    "Invalid JSON syntax"
-
 #define QERR_MIGRATION_ACTIVE \
     "There's a migration process in progress"
 
diff --git a/monitor.c b/monitor.c
index 392659324f..c99dc4737d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4251,10 +4251,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
     QDict *qdict;
     QMPRequest *req_obj;
 
-    if (!req && !err) {
-        /* json_parser_parse() sucks: can fail without setting @err */
-        error_setg(&err, QERR_JSON_PARSING);
-    }
+    assert(!req != !err);
 
     qdict = qobject_to(QDict, req);
     if (qdict) {
diff --git a/qga/main.c b/qga/main.c
index 2fc49d00d8..b74e1241ef 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -603,12 +603,13 @@ static void process_event(void *opaque, QObject *obj, Error *err)
     int ret;
 
     g_debug("process_event: called");
+    assert(!obj != !err);
     if (err) {
         goto err;
     }
     req = qobject_to(QDict, obj);
     if (!req) {
-        error_setg(&err, QERR_JSON_PARSING);
+        error_setg(&err, "Input must be a JSON object");
         goto err;
     }
     if (!qdict_haskey(req, "execute")) {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index a373e0114a..e372ecc895 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
@@ -57,6 +58,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->bracket_count--;
         break;
     case JSON_ERROR:
+        error_setg(&err, "JSON parse error, stray '%s'", input->str);
         goto out_emit;
     default:
         break;
@@ -82,12 +84,20 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         goto out_emit;
     }
 
-    if (parser->token_size > MAX_TOKEN_SIZE ||
-               g_queue_get_length(parser->tokens) > MAX_TOKEN_COUNT ||
-               parser->bracket_count + parser->brace_count > MAX_NESTING) {
-        /* Security consideration, we limit total memory allocated per object
-         * and the maximum recursion depth that a message can force.
-         */
+    /*
+     * Security consideration, we limit total memory allocated per object
+     * and the maximum recursion depth that a message can force.
+     */
+    if (parser->token_size > MAX_TOKEN_SIZE) {
+        error_setg(&err, "JSON token size limit exceeded");
+        goto out_emit;
+    }
+    if (g_queue_get_length(parser->tokens) > MAX_TOKEN_COUNT) {
+        error_setg(&err, "JSON token count limit exceeded");
+        goto out_emit;
+    }
+    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
+        error_setg(&err, "JSON nesting depth limit exceeded");
         goto out_emit;
     }
 
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 8cccac838b..3bd216f357 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1021,6 +1021,7 @@ static void interpolation_unknown(void)
     }
     g_test_trap_subprocess(NULL, 0, 0);
     g_test_trap_assert_failed();
+    g_test_trap_assert_stderr("*Unexpected error*stray '%x'*");
 }
 
 static void interpolation_string(void)
@@ -1296,11 +1297,11 @@ static void junk_input(void)
     QObject *obj;
 
     obj = qobject_from_json("@", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 
     obj = qobject_from_json("{\x01", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 
     obj = qobject_from_json("[0\xFF]", &err);
@@ -1308,11 +1309,11 @@ static void junk_input(void)
     g_assert(obj == NULL);
 
     obj = qobject_from_json("00", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 
     obj = qobject_from_json("[1e", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 
     obj = qobject_from_json("truer", &err);
@@ -1324,7 +1325,7 @@ static void unterminated_string(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("\"abc", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1332,7 +1333,7 @@ static void unterminated_sq_string(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("'abc", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1340,7 +1341,7 @@ static void unterminated_escape(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("\"abc\\\"", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
diff --git a/tests/libqtest.c b/tests/libqtest.c
index e17fe4fbd2..6a9151eebd 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -450,8 +450,11 @@ static void qmp_response(void *opaque, QObject *obj, Error *err)
 {
     QMPResponseParser *qmp = opaque;
 
-    if (!obj) {
-        fprintf(stderr, "QMP JSON response parsing failed\n");
+    assert(!obj != !err);
+
+    if (err) {
+        error_prepend(&err, "QMP JSON response parsing failed: ");
+        error_report_err(err);
         abort();
     }
 
-- 
2.17.1
