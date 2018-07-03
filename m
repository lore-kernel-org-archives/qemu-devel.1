Received: from eggs.gnu.org ([2001:4830:134:3::10]:50469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxy-00089S-4T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-0006D4-C4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxt-0006BP-5y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9141210D42B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 512542166BA9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:36:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:54 +0200
Message-Id: <20180703213556.20619-31-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 30/32] qmp: Clean up capability negotiation
 after commit 02130314d8c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qmp_greeting() offers capabilities to the client, and
qmp_qmp_capabilities() accepts or denies capabilities requested by the
client.  The two compute the set of available capabilities
independently.  Not nice.

Clean this up as follows.  Compute available capabilities just once in
monitor_qmp_caps_reset(), and store them in Monitor member
qmp.capab_offered[].  Have qmp_greeting() and qmp_qmp_capabilities()
use that.  Both are now oblivious of capability details.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-31-armbru@redhat.com>
---
 monitor.c | 93 ++++++++++++++++++++++++-------------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1da7b8bebf..f8b88ba105 100644
--- a/monitor.c
+++ b/monitor.c
@@ -173,7 +173,8 @@ typedef struct {
      * mode.
      */
     QmpCommandList *commands;
-    bool qmp_caps[QMP_CAPABILITY__MAX];
+    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
+    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
      * Protects qmp request/response queue.  Please take monitor_lock
      * first when used together.
@@ -1253,52 +1254,56 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
 }
 
-static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
-{
-    return mon->qmp.qmp_caps[cap];
-}
-
 static bool qmp_oob_enabled(Monitor *mon)
 {
-    return qmp_cap_enabled(mon, QMP_CAPABILITY_OOB);
+    return mon->qmp.capab[QMP_CAPABILITY_OOB];
 }
 
-static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
-                           Error **errp)
+static void monitor_qmp_caps_reset(Monitor *mon)
 {
+    memset(mon->qmp.capab_offered, 0, sizeof(mon->qmp.capab_offered));
+    memset(mon->qmp.capab, 0, sizeof(mon->qmp.capab));
+    mon->qmp.capab_offered[QMP_CAPABILITY_OOB] = mon->use_io_thread;
+}
+
+/*
+ * Accept QMP capabilities in @list for @mon.
+ * On success, set mon->qmp.capab[], and return true.
+ * On error, set @errp, and return false.
+ */
+static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
+                            Error **errp)
+{
+    GString *unavailable = NULL;
+    bool capab[QMP_CAPABILITY__MAX];
+
+    memset(capab, 0, sizeof(capab));
+
     for (; list; list = list->next) {
-        assert(list->value < QMP_CAPABILITY__MAX);
-        switch (list->value) {
-        case QMP_CAPABILITY_OOB:
-            if (!mon->use_io_thread) {
-                /*
-                 * Out-of-band only works with monitors that are
-                 * running on dedicated I/O thread.
-                 */
-                error_setg(errp, "This monitor does not support "
-                           "out-of-band (OOB)");
-                return;
+        if (!mon->qmp.capab_offered[list->value]) {
+            if (!unavailable) {
+                unavailable = g_string_new(QMPCapability_str(list->value));
+            } else {
+                g_string_append_printf(unavailable, ", %s",
+                                      QMPCapability_str(list->value));
             }
-            break;
-        default:
-            break;
         }
+        capab[list->value] = true;
     }
-}
 
-/* This function should only be called after capabilities are checked. */
-static void qmp_caps_apply(Monitor *mon, QMPCapabilityList *list)
-{
-    for (; list; list = list->next) {
-        mon->qmp.qmp_caps[list->value] = true;
+    if (unavailable) {
+        error_setg(errp, "Capability %s not available", unavailable->str);
+        g_string_free(unavailable, true);
+        return false;
     }
+
+    memcpy(mon->qmp.capab, capab, sizeof(capab));
+    return true;
 }
 
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    Error *local_err = NULL;
-
     if (cur_mon->qmp.commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
@@ -1306,19 +1311,8 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
         return;
     }
 
-    /* Enable QMP capabilities provided by the client if applicable. */
-    if (has_enable) {
-        qmp_caps_check(cur_mon, enable, &local_err);
-        if (local_err) {
-            /*
-             * Failed check on any of the capabilities will fail the
-             * entire command (and thus not apply any of the other
-             * capabilities that were also requested).
-             */
-            error_propagate(errp, local_err);
-            return;
-        }
-        qmp_caps_apply(cur_mon, enable);
+    if (!qmp_caps_accept(cur_mon, enable, errp)) {
+        return;
     }
 
     cur_mon->qmp.commands = &qmp_commands;
@@ -4385,11 +4379,9 @@ static QDict *qmp_greeting(Monitor *mon)
     qmp_marshal_query_version(NULL, &ver, NULL);
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (!mon->use_io_thread && cap == QMP_CAPABILITY_OOB) {
-            /* Monitors that are not using I/O thread won't support OOB */
-            continue;
+        if (mon->qmp.capab_offered[cap]) {
+            qlist_append_str(cap_list, QMPCapability_str(cap));
         }
-        qlist_append_str(cap_list, QMPCapability_str(cap));
     }
 
     return qdict_from_jsonf_nofail(
@@ -4397,11 +4389,6 @@ static QDict *qmp_greeting(Monitor *mon)
         ver, cap_list);
 }
 
-static void monitor_qmp_caps_reset(Monitor *mon)
-{
-    memset(mon->qmp.qmp_caps, 0, sizeof(mon->qmp.qmp_caps));
-}
-
 static void monitor_qmp_event(void *opaque, int event)
 {
     QDict *data;
-- 
2.17.1
