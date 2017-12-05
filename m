Received: from eggs.gnu.org ([2001:4830:134:3::10]:33752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM6Ak-0003b3-Ku
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM6Ai-00021y-39
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:53:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM6Ah-00021m-Qo
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:53:36 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 13:51:45 +0800
Message-Id: <20171205055200.16305-12-peterx@redhat.com>
In-Reply-To: <20171205055200.16305-1-peterx@redhat.com>
References: <20171205055200.16305-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v5 11/26] qmp: introduce QMPCapability
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

There was no QMP capabilities defined.  Define the first "oob" as
capability to allow out-of-band messages.

Also, touch up qmp-test.c to test the new bits.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 15 +++++++++++++--
 qapi-schema.json | 13 +++++++++++++
 tests/qmp-test.c | 10 +++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index e8f5a586e4..bad6ee8dd1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3944,12 +3944,23 @@ void monitor_resume(Monitor *mon)
 
 static QObject *get_qmp_greeting(void)
 {
+    QDict *result = qdict_new(), *qmp = qdict_new();
+    QList *cap_list = qlist_new();
     QObject *ver = NULL;
+    QMPCapability cap;
+
+    qdict_put(result, "QMP", qmp);
 
     qmp_marshal_query_version(NULL, &ver, NULL);
+    qdict_put_obj(qmp, "version", ver);
+
+    for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
+        qlist_append(cap_list, qstring_from_str(
+                         QMPCapability_str(cap)));
+    }
+    qdict_put(qmp, "capabilities", cap_list);
 
-    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': []}}",
-                              ver);
+    return QOBJECT(result);
 }
 
 static void monitor_qmp_event(void *opaque, int event)
diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..03201578b4 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -118,6 +118,19 @@
 ##
 { 'command': 'qmp_capabilities' }
 
+##
+# @QMPCapability:
+#
+# QMP supported capabilities to be broadcasted to the clients.
+#
+# @oob:   QMP ability to support Out-Of-Band requests.
+#
+# Since: 2.12
+#
+##
+{ 'enum': 'QMPCapability',
+  'data': [ 'oob' ] }
+
 ##
 # @VersionTriple:
 #
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index c5a5c10b41..292c5f135a 100644
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
