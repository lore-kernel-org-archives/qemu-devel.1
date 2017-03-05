Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReB-0000Ok-DB
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe7-0002xw-Cq
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe7-0002wX-2P
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B20637EEB
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB9772D653
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:38 +0100
Message-Id: <1488702958-24336-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/27] qmp: Clean up how we enforce
 capability negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

To enforce capability negotiation before normal operation,
handle_qmp_command() inspects every command before it's handed off to
qmp_dispatch().  This is a bit of a layering violation, and results in
duplicated code.

Before capability negotiation (!cur_mon->in_command_mode), we fail
commands other than "qmp_capabilities".  This is what enforces
capability negotiation.

Afterwards, we fail command "qmp_capabilities".

Clean this up as follows.

The obvious place to fail a command is the command itself, so move the
"afterwards" check to qmp_qmp_capabilities().

We do the "before" check in every other command, but that would be
bothersome.  Instead, start with an alternate list of commands that
contains only "qmp_capabilities".  Switch to the full list in
qmp_qmp_capabilities().

Additionally, replace the generic human-readable error message for
CommandNotFound by one that reminds the user to run qmp_capabilities.
Without that, we'd regress commit 2d5a834.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488544368-30622-8-git-send-email-armbru@redhat.com>
[Mirco-optimization squashed in, commit message typo fixed]
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 76 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/monitor.c b/monitor.c
index c7f7602..0c06dc7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -165,7 +165,7 @@ typedef struct {
      * When command qmp_capabilities succeeds, we go into command
      * mode.
      */
-    bool in_command_mode;       /* are we in command mode? */
+    QmpCommandList *commands;
 } MonitorQMP;
 
 /*
@@ -221,7 +221,7 @@ static int mon_refcount;
 static mon_cmd_t mon_cmds[];
 static mon_cmd_t info_cmds[];
 
-QmpCommandList qmp_commands;
+QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
 Monitor *cur_mon;
 
@@ -416,7 +416,8 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 
     trace_monitor_protocol_event_emit(event, qdict);
     QLIST_FOREACH(mon, &mon_list, entry) {
-        if (monitor_is_qmp(mon) && mon->qmp.in_command_mode) {
+        if (monitor_is_qmp(mon)
+            && mon->qmp.commands != &qmp_cap_negotiation_commands) {
             monitor_json_emitter(mon, QOBJECT(qdict));
         }
     }
@@ -565,11 +566,6 @@ static void monitor_qapi_event_init(void)
     qmp_event_set_func_emit(monitor_qapi_event_queue);
 }
 
-void qmp_qmp_capabilities(Error **errp)
-{
-    cur_mon->qmp.in_command_mode = true;
-}
-
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
 static void monitor_data_init(Monitor *mon)
@@ -921,7 +917,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list = NULL;
 
-    qmp_for_each_command(&qmp_commands, query_commands_cb, &list);
+    qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list);
 
     return list;
 }
@@ -1001,6 +997,13 @@ static void qmp_unregister_commands_hack(void)
 
 void monitor_init_qmp_commands(void)
 {
+    /*
+     * Two command lists:
+     * - qmp_commands contains all QMP commands
+     * - qmp_cap_negotiation_commands contains just
+     *   "qmp_capabilities", to enforce capability negotiation
+     */
+
     qmp_init_marshal(&qmp_commands);
 
     qmp_register_command(&qmp_commands, "query-qmp-schema",
@@ -1012,6 +1015,22 @@ void monitor_init_qmp_commands(void)
                          QCO_NO_OPTIONS);
 
     qmp_unregister_commands_hack();
+
+    QTAILQ_INIT(&qmp_cap_negotiation_commands);
+    qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
+                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
+}
+
+void qmp_qmp_capabilities(Error **errp)
+{
+    if (cur_mon->qmp.commands == &qmp_commands) {
+        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                  "Capabilities negotiation is already complete, command "
+                  "ignored");
+        return;
+    }
+
+    cur_mon->qmp.commands = &qmp_commands;
 }
 
 /* set the current CPU defined by the user */
@@ -3681,26 +3700,6 @@ static int monitor_can_read(void *opaque)
     return (mon->suspend_cnt == 0) ? 1 : 0;
 }
 
-static bool invalid_qmp_mode(const Monitor *mon, const char *cmd,
-                             Error **errp)
-{
-    bool is_cap = g_str_equal(cmd, "qmp_capabilities");
-
-    if (is_cap && mon->qmp.in_command_mode) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                  "Capabilities negotiation is already complete, command "
-                  "'%s' ignored", cmd);
-        return true;
-    }
-    if (!is_cap && !mon->qmp.in_command_mode) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                  "Expecting capabilities negotiation with "
-                  "'qmp_capabilities' before command '%s'", cmd);
-        return true;
-    }
-    return false;
-}
-
 /*
  * Input object checking rules
  *
@@ -3786,11 +3785,20 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     cmd_name = qdict_get_str(qdict, "execute");
     trace_handle_qmp_command(mon, cmd_name);
 
-    if (invalid_qmp_mode(mon, cmd_name, &err)) {
-        goto err_out;
-    }
+    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
 
-    rsp = qmp_dispatch(&qmp_commands, req);
+    if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
+        qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
+        if (qdict
+            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
+            /* Provide a more useful error message */
+            qdict_del(qdict, "desc");
+            qdict_put(qdict, "desc",
+                      qstring_from_str("Expecting capabilities negotiation"
+                                       " with 'qmp_capabilities'"));
+        }
+    }
 
 err_out:
     if (err) {
@@ -3888,7 +3896,7 @@ static void monitor_qmp_event(void *opaque, int event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->qmp.in_command_mode = false;
+        mon->qmp.commands = &qmp_cap_negotiation_commands;
         data = get_qmp_greeting();
         monitor_json_emitter(mon, data);
         qobject_decref(data);
-- 
2.7.4
