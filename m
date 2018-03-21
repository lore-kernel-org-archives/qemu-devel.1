Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJS-0006W5-RH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJR-0008UA-Hm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJR-0008Tq-Cd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA726406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:58 +0100
Message-Id: <20180321115211.17937-37-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/49] qapi: add conditions to SPICE
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

Chardev made conditional:

* spiceport, spicevmc

  Before and after the patch for !CONFIG_SPICE, the error is the
  same ('spiceport' is not a valid char driver name).

No HMP change, the code was already conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi/char.json | 10 ++++++----
 qapi/ui.json   | 30 ++++++++++++++++++++----------
 monitor.c      |  3 ---
 qmp.c          | 16 ----------------
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index ae19dcd1ed..7fa1762ae5 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -318,7 +318,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
-  'base': 'ChardevCommon' }
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevSpicePort:
@@ -330,7 +331,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
-  'base': 'ChardevCommon' }
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevVC:
@@ -384,8 +386,8 @@
                                        'testdev': 'ChardevCommon',
                                        'stdio'  : 'ChardevStdio',
                                        'console': 'ChardevCommon',
-                                       'spicevmc' : 'ChardevSpiceChannel=
',
-                                       'spiceport' : 'ChardevSpicePort',
+                                       'spicevmc' : { 'type': 'ChardevSp=
iceChannel', 'if': 'defined(CONFIG_SPICE)' },
+                                       'spiceport' : { 'type': 'ChardevS=
picePort', 'if': 'defined(CONFIG_SPICE)' },
                                        'vc'     : 'ChardevVC',
                                        'ringbuf': 'ChardevRingbuf',
                                        # next one is just for compatibil=
ity
diff --git a/qapi/ui.json b/qapi/ui.json
index 4b96509446..e47fae2e90 100644
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
diff --git a/monitor.c b/monitor.c
index 6ccd2fc089..8a5539579b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1087,9 +1087,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
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
diff --git a/qmp.c b/qmp.c
index ee1a816a42..d8f80cb04e 100644
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
 void qmp_cont(Error **errp)
 {
     BlockBackend *blk;
--=20
2.16.2.521.g9aa15f885a
