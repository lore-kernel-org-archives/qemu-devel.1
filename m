Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiv-0003Jd-KA
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiu-0007lb-Md
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiu-0007lL-EP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D39D7C22F
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:20 +0400
Message-Id: <20170118160332.13390-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/25] monitor: add 'async' capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Declare that the server supports async.

Check if the client supports it: the following patch will suspend the
qmp monitor if an async command is ongoing but the client doesn't
support async.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json            | 16 ++++++++++++++--
 include/qapi/qmp/dispatch.h |  1 +
 monitor.c                   | 19 ++++++++++++++++---
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ddc878390e..8366206415 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -72,11 +72,23 @@
 ##
=20
 ##
+# @QMPCapability:
+#
+# QMP protocol capabilities
+#
+# @async: enables async messages
+#
+# Since: 2.9
+##
+{ 'enum': 'QMPCapability',
+  'data': ['async'] }
+
+##
 # @qmp_capabilities:
 #
 # Enable QMP capabilities.
 #
-# Arguments: None.
+# @capabilities: #optional an array of @QMPCapability (since 2.9)
 #
 # Example:
 #
@@ -90,7 +102,7 @@
 # Since: 0.13
 #
 ##
-{ 'command': 'qmp_capabilities' }
+{ 'command': 'qmp_capabilities', 'data': { '*capabilities': ['QMPCapabil=
ity'] } }
=20
 ##
 # @LostTickPolicy:
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index e13e381834..4dd6de5ab2 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -32,6 +32,7 @@ struct QmpClient {
     QmpDispatchReturn *return_cb;
=20
     QLIST_HEAD(, QmpReturn) pending;
+    bool has_async;             /* the client has async capability */
 };
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
diff --git a/monitor.c b/monitor.c
index 98ba40b573..585f7b6a1a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -563,9 +563,22 @@ static void monitor_qapi_event_init(void)
     qmp_event_set_func_emit(monitor_qapi_event_queue);
 }
=20
-void qmp_qmp_capabilities(Error **errp)
+void qmp_qmp_capabilities(bool has_capabilities,
+                          QMPCapabilityList *capabilities, Error **errp)
 {
+    bool has_async =3D false;
+
+    if (has_capabilities) {
+        while (capabilities) {
+            if (capabilities->value =3D=3D QMP_CAPABILITY_ASYNC) {
+                has_async =3D true;
+            }
+            capabilities =3D capabilities->next;
+        }
+    }
+
     cur_mon->qmp.in_command_mode =3D true;
+    cur_mon->qmp.client.has_async =3D has_async;
 }
=20
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
@@ -3845,8 +3858,8 @@ static QObject *get_qmp_greeting(void)
=20
     qmp_marshal_query_version(NULL, &ver, NULL);
=20
-    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': [=
]}}",
-                              ver);
+    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': [=
"
+                              "'async']}}", ver);
 }
=20
 static void monitor_qmp_event(void *opaque, int event)
--=20
2.11.0.295.gd7dffce1c
