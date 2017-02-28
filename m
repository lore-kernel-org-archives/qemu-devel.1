Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkG-0003eG-JA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkD-0005Qi-2t
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilkC-0005Pt-Qn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:25 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 049227E9FA
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:39:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 18:39:00 +0100
Message-Id: <1488303560-18803-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-1-git-send-email-armbru@redhat.com>
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/26] qmp: Drop duplicated QMP command
 object checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qmp_check_input_obj() duplicates qmp_dispatch_check_obj(), except the
latter screws up an error message.  handle_qmp_command() runs first
the former, then the latter via qmp_dispatch(), masking the screwup.

qemu-ga also masks the screwup, because it also duplicates checks,
just differently.

qmp_check_input_obj() exists because handle_qmp_command() needs to
examine the command before dispatching it.  The previous commit got
rid of this need, except for a tracepoint, and a bit of "id" code that
relies on qdict not being null.

Fix up the error message in qmp_dispatch_check_obj(), drop
qmp_check_input_obj() and the tracepoint.  Protect the "id" code with
a conditional.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c           | 74 +++++------------------------------------------------
 qapi/qmp-dispatch.c |  3 +--
 trace-events        |  1 -
 3 files changed, 7 insertions(+), 71 deletions(-)

diff --git a/monitor.c b/monitor.c
index e522b6f..97b73ab 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3697,67 +3697,10 @@ static int monitor_can_read(void *opaque)
     return (mon->suspend_cnt == 0) ? 1 : 0;
 }
 
-/*
- * Input object checking rules
- *
- * 1. Input object must be a dict
- * 2. The "execute" key must exist
- * 3. The "execute" key must be a string
- * 4. If the "arguments" key exists, it must be a dict
- * 5. If the "id" key exists, it can be anything (ie. json-value)
- * 6. Any argument not listed above is considered invalid
- */
-static QDict *qmp_check_input_obj(QObject *input_obj, Error **errp)
-{
-    const QDictEntry *ent;
-    int has_exec_key = 0;
-    QDict *input_dict;
-
-    input_dict = qobject_to_qdict(input_obj);
-    if (!input_dict) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
-        return NULL;
-    }
-
-
-    for (ent = qdict_first(input_dict); ent; ent = qdict_next(input_dict, ent)){
-        const char *arg_name = qdict_entry_key(ent);
-        const QObject *arg_obj = qdict_entry_value(ent);
-
-        if (!strcmp(arg_name, "execute")) {
-            if (qobject_type(arg_obj) != QTYPE_QSTRING) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
-                           "execute", "string");
-                return NULL;
-            }
-            has_exec_key = 1;
-        } else if (!strcmp(arg_name, "arguments")) {
-            if (qobject_type(arg_obj) != QTYPE_QDICT) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
-                           "arguments", "object");
-                return NULL;
-            }
-        } else if (!strcmp(arg_name, "id")) {
-            /* Any string is acceptable as "id", so nothing to check */
-        } else {
-            error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
-            return NULL;
-        }
-    }
-
-    if (!has_exec_key) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "execute");
-        return NULL;
-    }
-
-    return input_dict;
-}
-
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
-    const char *cmd_name;
     Monitor *mon = cur_mon;
     Error *err = NULL;
 
@@ -3770,17 +3713,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err_out;
     }
 
-    qdict = qmp_check_input_obj(req, &err);
-    if (!qdict) {
-        goto err_out;
-    }
-
-    id = qdict_get(qdict, "id");
-    qobject_incref(id);
-    qdict_del(qdict, "id");
-
-    cmd_name = qdict_get_str(qdict, "execute");
-    trace_handle_qmp_command(mon, cmd_name);
+    qdict = qobject_to_qdict(req);
+    if (qdict) {
+        id = qdict_get(qdict, "id");
+        qobject_incref(id);
+        qdict_del(qdict, "id");
+    } /* else will fail qmp_dispatch() */
 
     rsp = qmp_dispatch(req);
 
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 621922f..4fc1122 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,8 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
     dict = qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT,
-                   "request is not a dictionary");
+        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
         return NULL;
     }
 
diff --git a/trace-events b/trace-events
index 7288557..b07a09b 100644
--- a/trace-events
+++ b/trace-events
@@ -65,7 +65,6 @@ xen_remap_bucket(uint64_t index) "index %#"PRIx64
 xen_map_cache_return(void* ptr) "%p"
 
 # monitor.c
-handle_qmp_command(void *mon, const char *cmd_name) "mon %p cmd_name \"%s\""
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
-- 
2.7.4
