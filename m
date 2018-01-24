Received: from eggs.gnu.org ([2001:4830:134:3::10]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDoX-0001p1-Ty
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDoV-0007tD-67
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeDoU-0007s4-T1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jan 2018 13:39:44 +0800
Message-Id: <20180124053957.29145-11-peterx@redhat.com>
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
References: <20180124053957.29145-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/23] qmp: introduce QMPCapability
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

There were no QMP capabilities defined.  Define the first "oob" as
capability to allow out-of-band messages.

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

Also, touch up qmp-test.c to test the new bits.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 qapi-schema.json | 32 +++++++++++++++++++++---
 tests/qmp-test.c | 10 +++++++-
 3 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index fd6e9a6d28..3e07798442 100644
--- a/monitor.c
+++ b/monitor.c
@@ -167,6 +167,7 @@ typedef struct {
      * mode.
      */
     QmpCommandList *commands;
+    bool qmp_caps[QMP_CAPABILITY__MAX];
 } MonitorQMP;
 
 /*
@@ -1036,8 +1037,42 @@ static void monitor_init_qmp_commands(void)
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
 {
+    for (; list; list = list->next) {
+        mon->qmp.qmp_caps[list->value] = true;
+    }
+}
+
+void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
+                          Error **errp)
+{
+    Error *local_err = NULL;
+
     if (cur_mon->qmp.commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
@@ -1045,6 +1080,21 @@ void qmp_qmp_capabilities(Error **errp)
         return;
     }
 
+    /* Enable QMP capabilities provided by the client if applicable. */
+    if (has_enable) {
+        qmp_caps_check(cur_mon, enable, &local_err);
+        if (local_err) {
+            /*
+             * Failed check on any of the capabilities will fail the
+             * entire command (and thus not apply any of the other
+             * capabilities that were also requested).
+             */
+            error_propagate(errp, local_err);
+            return;
+        }
+        qmp_caps_apply(cur_mon, enable);
+    }
+
     cur_mon->qmp.commands = &qmp_commands;
 }
 
@@ -3942,14 +3992,29 @@ void monitor_resume(Monitor *mon)
         readline_show_prompt(mon->rs);
 }
 
-static QObject *get_qmp_greeting(void)
+static QObject *get_qmp_greeting(Monitor *mon)
 {
+    QList *cap_list = qlist_new();
     QObject *ver = NULL;
+    QMPCapability cap;
 
     qmp_marshal_query_version(NULL, &ver, NULL);
 
-    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': []}}",
-                              ver);
+    for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
+        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
+            /* Monitors that are not using IOThread won't support OOB */
+            continue;
+        }
+        qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
+    }
+
+    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p}}",
+                              ver, cap_list);
+}
+
+static void monitor_qmp_caps_reset(Monitor *mon)
+{
+    memset(mon->qmp.qmp_caps, 0, sizeof(mon->qmp.qmp_caps));
 }
 
 static void monitor_qmp_event(void *opaque, int event)
@@ -3960,7 +4025,8 @@ static void monitor_qmp_event(void *opaque, int event)
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
index 5c06745c79..2490d5188e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -102,21 +102,47 @@
 #
 # Enable QMP capabilities.
 #
-# Arguments: None.
+# Arguments:
+#
+# @enable:    List of QMPCapabilities to enable, which is optional.
+#             Client must not enable any capability that is not
+#             mentioned in QMP greeting message.  If the field is not
+#             provided, it means no QMP capabilities will be enabled.
+#             (since 2.12)
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
+
+##
+# @QMPCapability:
+#
+# Enumeration of capabilities to be advertised during initial client
+# connection, used for agreeing on particular QMP extension behaviors.
+#
+# @oob:   QMP ability to support Out-Of-Band requests.
+#         (Please refer to qmp-spec.txt for more information on OOB)
+#
+# Since: 2.12
+#
+##
+{ 'enum': 'QMPCapability',
+  'data': [ 'oob' ] }
 
 ##
 # @VersionTriple:
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 36feb2204b..11b384c829 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -17,6 +17,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/util.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qstring.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
@@ -75,6 +76,8 @@ static void test_qmp_protocol(void)
 {
     QDict *resp, *q, *ret;
     QList *capabilities;
+    const QListEntry *entry;
+    QString *qstr;
 
     global_qtest = qtest_init_without_qmp_handshake(common_args);
 
@@ -84,7 +87,12 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
+    entry = qlist_first(capabilities);
+    g_assert(entry);
+    qstr = qobject_to_qstring(entry->value);
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "oob");
     QDECREF(resp);
 
     /* Test valid command before handshake */
-- 
2.14.3
