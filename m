Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxx-00088k-EF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-0006CQ-2Z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxs-0006Ac-Md
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F0FD400ADE4
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C3FFC1C5B9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:46 +0200
Message-Id: <20180703213556.20619-23-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/32] qmp: De-duplicate error response
 building
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

All callers of qmp_build_error_object() duplicate the code to wrap it
in a response object.  Replace it by qmp_error_response() that
captures the duplicated code, including error_free().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-23-armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 +-
 monitor.c                   |  7 +------
 qapi/qmp-dispatch.c         | 20 +++++++++++---------
 qga/main.c                  |  8 ++------
 4 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 514bfc45b0..a53e11c9b1 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -47,7 +47,7 @@ void qmp_enable_command(QmpCommandList *cmds, const char *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
-QObject *qmp_build_error_object(Error *err);
+QDict *qmp_error_response(Error *err);
 QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
                       bool allow_oob);
 bool qmp_is_oob(QDict *dict);
diff --git a/monitor.c b/monitor.c
index 26de90e4d2..6284efe33e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4107,14 +4107,9 @@ static int monitor_can_read(void *opaque)
 static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
                                 Error *err, QObject *id)
 {
-    QDict *qdict = NULL;
-
     if (err) {
         assert(!rsp);
-        qdict = qdict_new();
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-        error_free(err);
-        rsp = QOBJECT(qdict);
+        rsp = QOBJECT(qmp_error_response(err));
     }
 
     if (rsp) {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 6d78f3e9f6..c85748a33f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -141,11 +141,15 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
     return ret;
 }
 
-QObject *qmp_build_error_object(Error *err)
+QDict *qmp_error_response(Error *err)
 {
-    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_str(error_get_class(err)),
-                              error_get_pretty(err));
+    QDict *rsp;
+
+    rsp = qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s } }",
+                                  QapiErrorClass_str(error_get_class(err)),
+                                  error_get_pretty(err));
+    error_free(err);
+    return rsp;
 }
 
 /*
@@ -166,15 +170,13 @@ QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
 
     ret = do_qmp_dispatch(cmds, request, allow_oob, &err);
 
-    rsp = qdict_new();
     if (err) {
-        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-        error_free(err);
+        rsp = qmp_error_response(err);
     } else if (ret) {
+        rsp = qdict_new();
         qdict_put_obj(rsp, "return", ret);
     } else {
-        qobject_unref(rsp);
-        return NULL;
+        rsp = NULL;
     }
 
     return QOBJECT(rsp);
diff --git a/qga/main.c b/qga/main.c
index d332bacce5..0e30e30248 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -610,15 +610,13 @@ static void process_event(JSONMessageParser *parser, GQueue *tokens)
     qdict = qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err));
     if (err || !qdict) {
         qobject_unref(qdict);
-        qdict = qdict_new();
         if (!err) {
             g_warning("failed to parse event: unknown error");
             error_setg(&err, QERR_JSON_PARSING);
         } else {
             g_warning("failed to parse event: %s", error_get_pretty(err));
         }
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-        error_free(err);
+        qdict = qmp_error_response(err);
     }
 
     /* handle host->guest commands */
@@ -627,11 +625,9 @@ static void process_event(JSONMessageParser *parser, GQueue *tokens)
     } else {
         if (!qdict_haskey(qdict, "error")) {
             qobject_unref(qdict);
-            qdict = qdict_new();
             g_warning("unrecognized payload format");
             error_setg(&err, QERR_UNSUPPORTED);
-            qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-            error_free(err);
+            qdict = qmp_error_response(err);
         }
         ret = send_response(s, QOBJECT(qdict));
         if (ret < 0) {
-- 
2.17.1
