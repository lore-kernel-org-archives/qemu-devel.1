Received: from eggs.gnu.org ([2001:4830:134:3::10]:37565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDYy-00019J-Ph
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDYx-00011J-JK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDYx-00010n-AW
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:47 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:42 +0800
Message-Id: <20171219084557.9801-13-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 12/27] qmp: negotiate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

After this patch, we will allow QMP clients to enable QMP capabilities
when sending the first "qmp_capabilities" command.  Originally we are
starting QMP session with no arguments like:

  { "execute": "qmp_capabilities" }

Now we can enable some QMP capabilities using (take OOB as example,
which is the only one capability that we support):

  { "execute": "qmp_capabilities",
    "argument": { "enable": [ "oob" ] } }

When the "argument" key is not provided, no capability is enabled.

For capability "oob", the monitor needs to be run on dedicated IO
thread, otherwise the command will fail.  For example, trying to enable
OOB on a MUXed typed QMP monitor will fail.

One thing to mention is that, QMP capabilities are per-monitor, and also
when the connection is closed due to some reason, the capabilities will
be reset.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 qapi-schema.json | 15 ++++++++++---
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 81fb0a42b4..c88a11cd69 100644
--- a/monitor.c
+++ b/monitor.c
@@ -166,6 +166,7 @@ typedef struct {
      * mode.
      */
     QmpCommandList *commands;
+    bool qmp_caps[QMP_CAPABILITY__MAX];
 } MonitorQMP;
 
 /*
@@ -1035,8 +1036,42 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
 }
 
-void qmp_qmp_capabilities(Error **errp)
+static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
+                           Error **errp)
+{
+    for (; list; list = list->next) {
+        assert(list->value < QMP_CAPABILITY__MAX);
+        switch (list->value) {
+        case QMP_CAPABILITY_OOB:
+            if (!mon->use_io_thr) {
+                /*
+                 * Out-Of-Band only works with monitors that are
+                 * running on dedicated IOThread.
+                 */
+                error_setg(errp, "This monitor does not support "
+                           "Out-Of-Band (OOB)");
+                return;
+            }
+            break;
+        default:
+            break;
+        }
+    }
+}
+
+/* This function should only be called after capabilities are checked. */
+static void qmp_caps_apply(Monitor *mon, QMPCapabilityList *list)
+{
+    for (; list; list = list->next) {
+        mon->qmp.qmp_caps[list->value] = true;
+    }
+}
+
+void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
+                          Error **errp)
 {
+    Error *local_err = NULL;
+
     if (cur_mon->qmp.commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
@@ -1044,6 +1079,20 @@ void qmp_qmp_capabilities(Error **errp)
         return;
     }
 
+    /* Enable QMP capabilities provided by the guest if applicable. */
+    if (has_enable) {
+        qmp_caps_check(cur_mon, enable, &local_err);
+        if (local_err) {
+            /*
+             * Failed check on either of the capabilities will fail
+             * the apply of all.
+             */
+            error_propagate(errp, local_err);
+            return;
+        }
+        qmp_caps_apply(cur_mon, enable);
+    }
+
     cur_mon->qmp.commands = &qmp_commands;
 }
 
@@ -3941,7 +3990,7 @@ void monitor_resume(Monitor *mon)
         readline_show_prompt(mon->rs);
 }
 
-static QObject *get_qmp_greeting(void)
+static QObject *get_qmp_greeting(Monitor *mon)
 {
     QList *cap_list = qlist_new();
     QObject *ver = NULL;
@@ -3950,6 +3999,10 @@ static QObject *get_qmp_greeting(void)
     qmp_marshal_query_version(NULL, &ver, NULL);
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
+        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
+            /* Monitors that are not using IOThread won't support OOB */
+            continue;
+        }
         qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
     }
 
@@ -3957,6 +4010,11 @@ static QObject *get_qmp_greeting(void)
                               ver, cap_list);
 }
 
+static void monitor_qmp_caps_reset(Monitor *mon)
+{
+    memset(mon->qmp.qmp_caps, 0, sizeof(mon->qmp.qmp_caps));
+}
+
 static void monitor_qmp_event(void *opaque, int event)
 {
     QObject *data;
@@ -3965,7 +4023,8 @@ static void monitor_qmp_event(void *opaque, int event)
     switch (event) {
     case CHR_EVENT_OPENED:
         mon->qmp.commands = &qmp_cap_negotiation_commands;
-        data = get_qmp_greeting();
+        monitor_qmp_caps_reset(mon);
+        data = get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
         qobject_decref(data);
         mon_refcount++;
diff --git a/qapi-schema.json b/qapi-schema.json
index 03201578b4..531fd4c0db 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -102,21 +102,30 @@
 #
 # Enable QMP capabilities.
 #
-# Arguments: None.
+# Arguments:
+#
+# @enable:    List of QMPCapabilities to enable, which is optional.
+#             If not provided, it means no QMP capabilities will be
+#             enabled.  (since 2.12)
 #
 # Example:
 #
-# -> { "execute": "qmp_capabilities" }
+# -> { "execute": "qmp_capabilities",
+#      "arguments": { "enable": [ "oob" ] } }
 # <- { "return": {} }
 #
 # Notes: This command is valid exactly when first connecting: it must be
 # issued before any other command will be accepted, and will fail once the
 # monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
 #
+# QMP client needs to explicitly enable QMP capabilities, otherwise
+# all the QMP capabilities will be turned off by default.
+#
 # Since: 0.13
 #
 ##
-{ 'command': 'qmp_capabilities' }
+{ 'command': 'qmp_capabilities',
+  'data': { '*enable': [ 'QMPCapability' ] } }
 
 ##
 # @QMPCapability:
-- 
2.14.3
