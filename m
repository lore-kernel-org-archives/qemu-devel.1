Received: from eggs.gnu.org ([2001:4830:134:3::10]:42634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1av-0004Ti-9N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0006e2-Sf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1aq-0006cV-G9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0402D40250FF
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:57 +0200
Message-Id: <20180702162218.13678-12-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 11/32] qmp qemu-ga: Fix qemu-ga not to accept
 "control"
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

Commit cf869d53172 "qmp: support out-of-band (oob) execution"
accidentally made qemu-ga accept and ignore "control".  Fix that.

Out-of-band execution in a monitor that doesn't support it now fails
with

    {"error": {"class": "GenericError", "desc": "QMP input member 'control' is unexpected"}}

instead of

    {"error": {"class": "GenericError", "desc": "Please enable out-of-band first for the session during capabilities negotiation"}}

The old description is suboptimal when out-of-band cannot not be
enabled, or the command doesn't support out-of-band execution.

The new description is a bit unspecific, but it'll do.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h |  6 ++++--
 monitor.c                   |  9 ++-------
 qapi/qmp-dispatch.c         | 14 ++++++++------
 qga/main.c                  |  2 +-
 tests/test-qga.c            |  9 +++++----
 tests/test-qmp-cmds.c       |  8 ++++----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index b366bb48bd..303a15ba84 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -41,7 +41,6 @@ void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options);
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
 
@@ -49,7 +48,10 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
-QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
+QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
+                              Error **errp);
+QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                      bool allow_oob);
 bool qmp_is_oob(QDict *dict);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
diff --git a/monitor.c b/monitor.c
index 4659399b55..2c28b05ecb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1318,11 +1318,6 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
     }
 
     if (qmp_is_oob(req)) {
-        if (!qmp_oob_enabled(mon)) {
-            error_setg(errp, "Please enable out-of-band first "
-                       "for the session during capabilities negotiation");
-            return false;
-        }
         if (!(cmd->options & QCO_ALLOW_OOB)) {
             error_setg(errp, "The command %s does not support OOB",
                        command);
@@ -4194,7 +4189,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
     old_mon = cur_mon;
     cur_mon = mon;
 
-    rsp = qmp_dispatch(mon->qmp.commands, req);
+    rsp = qmp_dispatch(mon->qmp.commands, req, qmp_oob_enabled(mon));
 
     cur_mon = old_mon;
 
@@ -4285,7 +4280,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     } /* else will fail qmp_dispatch() */
 
     /* Check against the request in general layout */
-    qdict = qmp_dispatch_check_obj(req, &err);
+    qdict = qmp_dispatch_check_obj(req, qmp_oob_enabled(mon), &err);
     if (!qdict) {
         goto err;
     }
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 3d5d5e110f..0ad0fab8ed 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -20,7 +20,8 @@
 #include "qapi/qmp/qbool.h"
 #include "sysemu/sysemu.h"
 
-QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
+QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
+                              Error **errp)
 {
     const QDictEntry *ent;
     const char *arg_name;
@@ -52,7 +53,7 @@ QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
-        } else if (!strcmp(arg_name, "control")) {
+        } else if (!strcmp(arg_name, "control") && allow_oob) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
                 error_setg(errp,
                            "QMP input member 'control' must be a dict");
@@ -74,7 +75,7 @@ QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 }
 
 static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
-                                Error **errp)
+                                bool allow_oob, Error **errp)
 {
     Error *local_err = NULL;
     const char *command;
@@ -82,7 +83,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
     QmpCommand *cmd;
     QObject *ret = NULL;
 
-    dict = qmp_dispatch_check_obj(request, errp);
+    dict = qmp_dispatch_check_obj(request, allow_oob, errp);
     if (!dict) {
         return NULL;
     }
@@ -157,13 +158,14 @@ bool qmp_is_oob(QDict *dict)
     return qbool_get_bool(bool_obj);
 }
 
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request)
+QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                      bool allow_oob)
 {
     Error *err = NULL;
     QObject *ret;
     QDict *rsp;
 
-    ret = do_qmp_dispatch(cmds, request, &err);
+    ret = do_qmp_dispatch(cmds, request, allow_oob, &err);
 
     rsp = qdict_new();
     if (err) {
diff --git a/qga/main.c b/qga/main.c
index ea7540edcc..d332bacce5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -586,7 +586,7 @@ static void process_command(GAState *s, QDict *req)
 
     g_assert(req);
     g_debug("processing command");
-    rsp = qmp_dispatch(&ga_commands, QOBJECT(req));
+    rsp = qmp_dispatch(&ga_commands, QOBJECT(req), false);
     if (rsp) {
         ret = send_response(s, rsp);
         if (ret < 0) {
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 2e9e0f73bb..febabc7ad5 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -245,16 +245,17 @@ static void test_qga_invalid_id(gconstpointer fix)
 
 static void test_qga_invalid_oob(gconstpointer fix)
 {
-    /* FIXME "control" is ignored; it should be rejected */
     const TestFixture *fixture = fix;
-    QDict *ret;
+    QDict *ret, *error;
+    const char *class;
 
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping',"
                  " 'control': {'run-oob': true}}");
     g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
 
-    qdict_get_qdict(ret, "return");
+    error = qdict_get_qdict(ret, "error");
+    class = qdict_get_try_str(error, "class");
+    g_assert_cmpstr(class, ==, "GenericError");
 
     qobject_unref(ret);
 }
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 491b0c4a44..10c7ba40c1 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -102,7 +102,7 @@ static void test_dispatch_cmd(void)
 
     qdict_put_str(req, "execute", "user_def_cmd");
 
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
     assert(!qdict_haskey(qobject_to(QDict, resp), "error"));
 
@@ -119,7 +119,7 @@ static void test_dispatch_cmd_failure(void)
 
     qdict_put_str(req, "execute", "user_def_cmd2");
 
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
     assert(qdict_haskey(qobject_to(QDict, resp), "error"));
 
@@ -133,7 +133,7 @@ static void test_dispatch_cmd_failure(void)
 
     qdict_put_str(req, "execute", "user_def_cmd");
 
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
     assert(qdict_haskey(qobject_to(QDict, resp), "error"));
 
@@ -147,7 +147,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QDict *resp;
     QObject *ret;
 
-    resp_obj = qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp_obj = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp_obj);
     resp = qobject_to(QDict, resp_obj);
     assert(resp && !qdict_haskey(resp, "error"));
-- 
2.17.1
