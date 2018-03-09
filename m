Received: from eggs.gnu.org ([2001:4830:134:3::10]:41749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDts-000857-78
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtn-000884-R1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDtn-00087o-L3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:11 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:53 +0800
Message-Id: <20180309090006.10018-11-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 10/23] qmp: introduce QMPCapability
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
 monitor.c        | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 qapi/misc.json   | 32 ++++++++++++++++++++---
 tests/qmp-test.c | 10 +++++++-
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6a5270dcd8..74eb1d8b8b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,6 +59,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace-root.h"
 #include "trace/control.h"
@@ -170,6 +171,7 @@ typedef struct {
      * mode.
      */
     QmpCommandList *commands;
+    bool qmp_caps[QMP_CAPABILITY__MAX];
 } MonitorQMP;
 
 /*
@@ -1039,8 +1041,42 @@ static void monitor_init_qmp_commands(void)
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
@@ -1048,6 +1084,21 @@ void qmp_qmp_capabilities(Error **errp)
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
 
@@ -3893,14 +3944,29 @@ void monitor_resume(Monitor *mon)
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
@@ -3911,7 +3977,8 @@ static void monitor_qmp_event(void *opaque, int event)
     switch (event) {
     case CHR_EVENT_OPENED:
         mon->qmp.commands = &qmp_cap_negotiation_commands;
-        data = get_qmp_greeting();
+        monitor_qmp_caps_reset(mon);
+        data = get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
         qobject_decref(data);
         mon_refcount++;
diff --git a/qapi/misc.json b/qapi/misc.json
index bd04469a4b..0123143d4b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -10,21 +10,47 @@
 #
 # Enable QMP capabilities.
 #
-# Arguments: None.
+# Arguments:
+#
+# @enable:   An optional list of QMPCapability values to enable.  The
+#            client must not enable any capability that is not
+#            mentioned in the QMP greeting message.  If the field is not
+#            provided, it means no QMP capabilities will be enabled.
+#            (since 2.12)
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
+# The QMP client needs to explicitly enable QMP capabilities, otherwise
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
index 22445d9ec2..70d1152d32 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/util.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qstring.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
@@ -79,6 +80,8 @@ static void test_qmp_protocol(void)
     QDict *resp, *q, *ret;
     QList *capabilities;
     QTestState *qts;
+    const QListEntry *entry;
+    QString *qstr;
 
     qts = qtest_init_without_qmp_handshake(common_args);
 
@@ -88,7 +91,12 @@ static void test_qmp_protocol(void)
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
