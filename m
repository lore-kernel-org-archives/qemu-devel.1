Received: from eggs.gnu.org ([2001:4830:134:3::10]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAu-0007B5-Ui
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAp-0007mj-US
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAp-0007m5-OB
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:11 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:43 +0800
Message-Id: <20170929033844.26935-22-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 21/22] qmp: introduce QMPCapability
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

There was no QMP capabilities defined.  Define the first "oob" as
capability to allow out-of-band messages.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 15 +++++++++++++--
 qapi-schema.json | 13 +++++++++++++
 tests/qmp-test.c |  2 +-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 649491a2ce..e33f7fa069 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4160,12 +4160,23 @@ void monitor_resume(Monitor *mon)
 
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
index 0b04e06a4c..82122986d9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -119,6 +119,19 @@
 { 'command': 'qmp_capabilities' }
 
 ##
+# @QMPCapability:
+#
+# QMP supported capabilities to be broadcasted to the clients.
+#
+# @oob:   QMP ability to support Out-Of-Band requests.
+#
+# Since: 2.11
+#
+##
+{ 'enum': 'QMPCapability',
+  'data': [ 'oob' ] }
+
+##
 # @VersionTriple:
 #
 # A three-part version number.
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index c5a5c10b41..91049ab215 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -84,7 +84,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
     QDECREF(resp);
 
     /* Test valid command before handshake */
-- 
2.13.5
