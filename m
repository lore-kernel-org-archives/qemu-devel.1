Received: from eggs.gnu.org ([2001:4830:134:3::10]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CW-0007lB-29
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CU-0004bs-Ix
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch1CU-0004bA-AI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FEFAC04B30F
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D16C2D653
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 22:45:01 +0100
Message-Id: <1487886317-27400-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-1-git-send-email-armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/21] qmp: Clean up how we enforce capability
 negotiation
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
bothersome.  Instead, start without all the other commands, by
registering only qmp_qmp_capabilities().  Register the others in
qmp_qmp_capabilities().

Additionally, replace the generic human-readable error message for
CommandNotFound by one that reminds the user to run qmp_capabilities.
Without that, we'd regress commit 2d5a834.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 70 ++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/monitor.c b/monitor.c
index 5be71d6..dcf2de7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -563,11 +563,6 @@ static void monitor_qapi_event_init(void)
     qmp_event_set_func_emit(monitor_qapi_event_queue);
 }
 
-void qmp_qmp_capabilities(Error **errp)
-{
-    cur_mon->qmp.in_command_mode = true;
-}
-
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
 static void monitor_data_init(Monitor *mon)
@@ -995,7 +990,7 @@ static void qmp_unregister_commands_hack(void)
 #endif
 }
 
-void monitor_init_qmp_commands(void)
+static void monitor_init_real_qmp_commands(void)
 {
     qmp_init_marshal();
 
@@ -1009,6 +1004,32 @@ void monitor_init_qmp_commands(void)
     qmp_unregister_commands_hack();
 }
 
+void monitor_init_qmp_commands(void)
+{
+    /*
+     * Start with just qmp_capabilities, to enforce capability
+     * negotiation.  qmp_capabilities will register the other
+     * commands.  See also the error message replacement hack in
+     * handle_qmp_command().
+     */
+    qmp_register_command("qmp_capabilities",
+                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
+}
+
+void qmp_qmp_capabilities(Error **errp)
+{
+    if (cur_mon->qmp.in_command_mode) {
+        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                  "Capabilities negotiation is already complete, command "
+                  "ignored");
+        return;
+    }
+
+    cur_mon->qmp.in_command_mode = true;
+    qmp_unregister_command("qmp_capabilities");
+    monitor_init_real_qmp_commands();
+}
+
 /* set the current CPU defined by the user */
 int monitor_set_cpu(int cpu_index)
 {
@@ -3676,26 +3697,6 @@ static int monitor_can_read(void *opaque)
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
@@ -3781,12 +3782,21 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     cmd_name = qdict_get_str(qdict, "execute");
     trace_handle_qmp_command(mon, cmd_name);
 
-    if (invalid_qmp_mode(mon, cmd_name, &err)) {
-        goto err_out;
-    }
-
     rsp = qmp_dispatch(req);
 
+    qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
+    if (qdict) {
+        if (!mon->qmp.in_command_mode
+            && !strcmp(qdict_get_try_str(qdict, "class"),
+                       QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
+            /* Provide a more useful error message */
+            qdict_del(qdict, "desc");
+            qdict_put(qdict, "desc",
+                      qstring_from_str("Expecting capabilities negotiation"
+                                       " with 'qmp_capabilities'"));
+        }
+    }
+
 err_out:
     if (err) {
         qdict = qdict_new();
-- 
2.7.4
