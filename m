Received: from eggs.gnu.org ([2001:4830:134:3::10]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1au-0004Sz-Ld
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0006e7-Sd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1aq-0006cT-GB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3657805A530
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:58 +0200
Message-Id: <20180702162218.13678-13-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/32] qmp: Redo how the client requests
 out-of-band execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Commit cf869d53172 "qmp: support out-of-band (oob) execution" added a
general mechanism for command-independent arguments just for an
out-of-band flag:

    The "control" key is introduced to store this extra flag.  "control"
    field is used to store arguments that are shared by all the commands,
    rather than command specific arguments.  Let "run-oob" be the first.

However, it failed to reject unknown members of "control".  For
instance, in QMP command

    {"execute": "query-name", "id": 42, "control": {"crap": true}}

"crap" gets silently ignored.

Instead of fixing this, revert the general "control" mechanism
(because YAGNI), and do it the way I initially proposed, with key
"exec-oob".  Simpler code, simper interface.

An out-of-band command

    {"execute": "migrate-pause", "id": 42, "control": {"run-oob": true}}

becomes

    {"exec-oob": "migrate-pause", "id": 42}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 10 +++----
 docs/interop/qmp-spec.txt    | 18 ++++++-------
 monitor.c                    |  3 +++
 qapi/qmp-dispatch.c          | 51 +++++++++++++++---------------------
 tests/qmp-test.c             |  7 ++---
 tests/test-qga.c             |  3 +--
 6 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9625798d16..f020f6bab2 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -649,13 +649,11 @@ example:
  { 'command': 'migrate_recover',
    'data': { 'uri': 'str' }, 'allow-oob': true }
 
-To execute a command with out-of-band priority, the client specifies
-the "control" field in the request, with "run-oob" set to
-true. Example:
+To execute a command with out-of-band priority, the client uses key
+"exec-oob" instead of "execute".  Example:
 
- => { "execute": "command-support-oob",
-      "arguments": { ... },
-      "control": { "run-oob": true } }
+ => { "exec-oob": "migrate-recover",
+      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
  <= { "return": { } }
 
 Without it, even the commands that support out-of-band execution will
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 794c95838f..113c9dcf51 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -92,12 +92,16 @@ Currently supported capabilities are:
 
 The format for command execution is:
 
-{ "execute": json-string, "arguments": json-object, "id": json-value,
-  "control": json-object }
+{ "execute": json-string, "arguments": json-object, "id": json-value }
+
+or
+
+{ "exec-oob": json-string, "arguments": json-object, "id": json-value }
 
  Where,
 
-- The "execute" member identifies the command to be executed by the Server
+- The "execute" or "exec-oob" member identifies the command to be
+  executed by the server.  The latter requests out-of-band execution.
 - The "arguments" member is used to pass any arguments required for the
   execution of the command, it is optional when no arguments are
   required. Each command documents what contents will be considered
@@ -106,9 +110,6 @@ The format for command execution is:
   command execution, it is optional and will be part of the response
   if provided.  The "id" member can be any json-value.  A json-number
   incremented for each successive command works fine.
-- The optional "control" member further specifies how the command is
-  to be executed.  Currently, its only member is optional "run-oob".
-  See section "2.3.1 Out-of-band execution" for details.
 
 2.3.1 Out-of-band execution
 ---------------------------
@@ -125,9 +126,6 @@ possibly overtaking prior in-band commands.  The client may therefore
 receive such a command's response before responses from prior in-band
 commands.
 
-To execute a command out-of-band, the client puts "run-oob": true into
-execute's member "control".
-
 If the client sends in-band commands faster than the server can
 execute them, the server will eventually drop commands to limit the
 queue length.  The sever sends event COMMAND_DROPPED then.
@@ -270,7 +268,7 @@ S: { "timestamp": { "seconds": 1258551470, "microseconds": 802384 },
 3.7 Out-of-band execution
 -------------------------
 
-C: { "execute": "migrate-pause", "id": 42, "control": { "run-oob": true } }
+C: { "exec-oob": "migrate-pause", "id": 42 }
 S: { "id": 42,
      "error": { "class": "GenericError",
       "desc": "migrate-pause is currently only supported during postcopy-active state" } }
diff --git a/monitor.c b/monitor.c
index 2c28b05ecb..8b0c29ce06 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1299,6 +1299,9 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
     QmpCommand *cmd;
 
     command = qdict_get_try_str(req, "execute");
+    if (!command) {
+        command = qdict_get_try_str(req, "exec-oob");
+    }
     if (!command) {
         error_setg(errp, "Command field 'execute' missing");
         return false;
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 0ad0fab8ed..12be120fe7 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -23,11 +23,11 @@
 QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
                               Error **errp)
 {
+    const char *exec_key = NULL;
     const QDictEntry *ent;
     const char *arg_name;
     const QObject *arg_obj;
-    bool has_exec_key = false;
-    QDict *dict = NULL;
+    QDict *dict;
 
     dict = qobject_to(QDict, request);
     if (!dict) {
@@ -40,25 +40,25 @@ QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
         arg_name = qdict_entry_key(ent);
         arg_obj = qdict_entry_value(ent);
 
-        if (!strcmp(arg_name, "execute")) {
+        if (!strcmp(arg_name, "execute")
+            || (!strcmp(arg_name, "exec-oob") && allow_oob)) {
             if (qobject_type(arg_obj) != QTYPE_QSTRING) {
-                error_setg(errp,
-                           "QMP input member 'execute' must be a string");
+                error_setg(errp, "QMP input member '%s' must be a string",
+                           arg_name);
                 return NULL;
             }
-            has_exec_key = true;
+            if (exec_key) {
+                error_setg(errp, "QMP input member '%s' clashes with '%s'",
+                           arg_name, exec_key);
+                return NULL;
+            }
+            exec_key = arg_name;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
                 error_setg(errp,
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
-        } else if (!strcmp(arg_name, "control") && allow_oob) {
-            if (qobject_type(arg_obj) != QTYPE_QDICT) {
-                error_setg(errp,
-                           "QMP input member 'control' must be a dict");
-                return NULL;
-            }
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
@@ -66,7 +66,7 @@ QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
         }
     }
 
-    if (!has_exec_key) {
+    if (!exec_key) {
         error_setg(errp, "QMP input lacks member 'execute'");
         return NULL;
     }
@@ -88,7 +88,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         return NULL;
     }
 
-    command = qdict_get_str(dict, "execute");
+    command = qdict_get_try_str(dict, "execute");
+    if (!command) {
+        assert(allow_oob);
+        command = qdict_get_str(dict, "exec-oob");
+    }
     cmd = qmp_find_command(cmds, command);
     if (cmd == NULL) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
@@ -137,25 +141,12 @@ QObject *qmp_build_error_object(Error *err)
 }
 
 /*
- * Detect whether a request should be run out-of-band, by quickly
- * peeking at whether we have: { "control": { "run-oob": true } }. By
- * default commands are run in-band.
+ * Does @qdict look like a command to be run out-of-band?
  */
 bool qmp_is_oob(QDict *dict)
 {
-    QBool *bool_obj;
-
-    dict = qdict_get_qdict(dict, "control");
-    if (!dict) {
-        return false;
-    }
-
-    bool_obj = qobject_to(QBool, qdict_get(dict, "run-oob"));
-    if (!bool_obj) {
-        return false;
-    }
-
-    return qbool_get_bool(bool_obj);
+    return qdict_haskey(dict, "exec-oob")
+        && !qdict_haskey(dict, "execute");
 }
 
 QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 3932901146..dc30930201 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -174,8 +174,7 @@ static void unblock_blocked_cmd(void)
 
 static void send_oob_cmd(QTestState *s, const char *id)
 {
-    qtest_async_qmp(s, "{ 'execute': 'migrate-pause', 'id': %s,"
-                    "  'control': { 'run-oob': true } }", id);
+    qtest_async_qmp(s, "{ 'exec-oob': 'migrate-pause', 'id': %s }", id);
 }
 
 static void recv_cmd_id(QTestState *s, const char *id)
@@ -227,9 +226,7 @@ static void test_qmp_oob(void)
      * Try any command that does not support OOB but with OOB flag. We
      * should get failure.
      */
-    resp = qtest_qmp(qts,
-                     "{ 'execute': 'query-cpus',"
-                     "  'control': { 'run-oob': true } }");
+    resp = qtest_qmp(qts, "{ 'exec-oob': 'query-cpus' }");
     g_assert(qdict_haskey(resp, "error"));
     qobject_unref(resp);
 
diff --git a/tests/test-qga.c b/tests/test-qga.c
index febabc7ad5..daadf22ea3 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -249,8 +249,7 @@ static void test_qga_invalid_oob(gconstpointer fix)
     QDict *ret, *error;
     const char *class;
 
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping',"
-                 " 'control': {'run-oob': true}}");
+    ret = qmp_fd(fixture->fd, "{'exec-oob': 'guest-ping'}");
     g_assert_nonnull(ret);
 
     error = qdict_get_qdict(ret, "error");
-- 
2.17.1
