Received: from eggs.gnu.org ([2001:4830:134:3::10]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtN-00006K-OJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtH-0007SD-Lk
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJtH-0007QN-CJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:55 +0800
Message-Id: <20171116130610.23582-13-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 12/27] qmp: negociate QMP capabilities
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 qapi-schema.json | 15 ++++++++++++---
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 468303b472..da03d1370f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -167,6 +167,7 @@ typedef struct {
      * mode.
      */
     QmpCommandList *commands;
+    bool qmp_caps[QMP_CAPABILITY__MAX];
 } MonitorQMP;
 
 /*
@@ -1037,8 +1038,42 @@ static void monitor_init_qmp_commands(void)
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
@@ -1046,6 +1081,20 @@ void qmp_qmp_capabilities(Error **errp)
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
 
@@ -3963,6 +4012,11 @@ static QObject *get_qmp_greeting(void)
     return QOBJECT(result);
 }
 
+static void monitor_qmp_caps_reset(Monitor *mon)
+{
+    memset(mon->qmp.qmp_caps, 0, sizeof(mon->qmp.qmp_caps));
+}
+
 static void monitor_qmp_event(void *opaque, int event)
 {
     QObject *data;
@@ -3971,6 +4025,7 @@ static void monitor_qmp_event(void *opaque, int event)
     switch (event) {
     case CHR_EVENT_OPENED:
         mon->qmp.commands = &qmp_cap_negotiation_commands;
+        monitor_qmp_caps_reset(mon);
         data = get_qmp_greeting();
         monitor_json_emitter(mon, data);
         qobject_decref(data);
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
2.13.6
