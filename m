Received: from eggs.gnu.org ([2001:4830:134:3::10]:44182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVC-0000yU-IX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV8-0000Pd-55
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV7-0000Ou-VU
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 955F24078B8F
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:13 +0200
Message-Id: <20180703210613.25619-15-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add #if defined(CONFIG_SPICE) in generated code, and adjust the
qmp/hmp code accordingly.

query-qmp-schema no longer reports the command/events etc as
available when disabled at compile time.

Commands made conditional:

* query-spice

  Before the patch, the command for !CONFIG_SPICE is unregistered. It
  will fail with the same error.

Events made conditional:

* SPICE_CONNECTED, SPICE_INITIALIZED, SPICE_DISCONNECTED,
  SPICE_MIGRATE_COMPLETED

Add TODO for conditional SPICE chardevs, delayed until the supports
for conditional members lands.

No HMP change, the code was already conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-15-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c      |  3 ---
 qapi/char.json |  8 ++++++--
 qapi/ui.json   | 30 ++++++++++++++++++++----------
 qmp.c          | 16 ----------------
 4 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3a0ea0c602..8e1aea7826 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1191,9 +1191,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef CONFIG_SPICE
-    qmp_unregister_command(&qmp_commands, "query-spice");
-#endif
 #ifndef CONFIG_REPLICATION
     qmp_unregister_command(&qmp_commands, "xen-set-replication");
     qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
diff --git a/qapi/char.json b/qapi/char.json
index 60f31d83fc..b7b2a05766 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -320,6 +320,7 @@
 ##
 { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
   'base': 'ChardevCommon' }
+# TODO: 'if': 'defined(CONFIG_SPICE)'
=20
 ##
 # @ChardevSpicePort:
@@ -332,6 +333,7 @@
 ##
 { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
   'base': 'ChardevCommon' }
+# TODO: 'if': 'defined(CONFIG_SPICE)'
=20
 ##
 # @ChardevVC:
@@ -385,8 +387,10 @@
                                        'testdev': 'ChardevCommon',
                                        'stdio'  : 'ChardevStdio',
                                        'console': 'ChardevCommon',
-                                       'spicevmc' : 'ChardevSpiceChannel=
',
-                                       'spiceport' : 'ChardevSpicePort',
+                                       'spicevmc': 'ChardevSpiceChannel'=
,
+# TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' }=
,
+                                       'spiceport': 'ChardevSpicePort',
+# TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
                                        'vc'     : 'ChardevVC',
                                        'ringbuf': 'ChardevRingbuf',
                                        # next one is just for compatibil=
ity
diff --git a/qapi/ui.json b/qapi/ui.json
index ee90c1880b..4ca91bb45a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -118,7 +118,8 @@
 { 'struct': 'SpiceBasicInfo',
   'data': { 'host': 'str',
             'port': 'str',
-            'family': 'NetworkAddressFamily' } }
+            'family': 'NetworkAddressFamily' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceServerInfo:
@@ -131,7 +132,8 @@
 ##
 { 'struct': 'SpiceServerInfo',
   'base': 'SpiceBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceChannel:
@@ -156,7 +158,8 @@
 { 'struct': 'SpiceChannel',
   'base': 'SpiceBasicInfo',
   'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': =
'int',
-           'tls': 'bool'} }
+           'tls': 'bool'},
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceQueryMouseMode:
@@ -175,7 +178,8 @@
 # Since: 1.1
 ##
 { 'enum': 'SpiceQueryMouseMode',
-  'data': [ 'client', 'server', 'unknown' ] }
+  'data': [ 'client', 'server', 'unknown' ],
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceInfo:
@@ -212,7 +216,8 @@
 { 'struct': 'SpiceInfo',
   'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port=
': 'int',
            '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str=
',
-           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']} }
+           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']},
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @query-spice:
@@ -257,7 +262,8 @@
 #    }
 #
 ##
-{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
+{ 'command': 'query-spice', 'returns': 'SpiceInfo',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_CONNECTED:
@@ -282,7 +288,8 @@
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_INITIALIZED:
@@ -310,7 +317,8 @@
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
-            'client': 'SpiceChannel' } }
+            'client': 'SpiceChannel' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_DISCONNECTED:
@@ -335,7 +343,8 @@
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_MIGRATE_COMPLETED:
@@ -350,7 +359,8 @@
 #      "event": "SPICE_MIGRATE_COMPLETED" }
 #
 ##
-{ 'event': 'SPICE_MIGRATE_COMPLETED' }
+{ 'event': 'SPICE_MIGRATE_COMPLETED',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # =3D=3D VNC
diff --git a/qmp.c b/qmp.c
index bc5537b221..162bc2e30d 100644
--- a/qmp.c
+++ b/qmp.c
@@ -129,22 +129,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
=20
-#ifndef CONFIG_SPICE
-/*
- * qmp_unregister_commands_hack() ensures that QMP command query-spice
- * exists only #ifdef CONFIG_SPICE.  Necessary for an accurate
- * query-commands result.  However, the QAPI schema is blissfully
- * unaware of that, and the QAPI code generator happily generates a
- * dead qmp_marshal_query_spice() that calls qmp_query_spice().
- * Provide it one, or else linking fails.  FIXME Educate the QAPI
- * schema on CONFIG_SPICE.
- */
-SpiceInfo *qmp_query_spice(Error **errp)
-{
-    abort();
-};
-#endif
-
 void qmp_exit_preconfig(Error **errp)
 {
     if (!runstate_check(RUN_STATE_PRECONFIG)) {
--=20
2.17.1
