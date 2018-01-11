Received: from eggs.gnu.org ([2001:4830:134:3::10]:51738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWs-0007xX-Bb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWn-0005Tb-SF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWn-0005S4-Jj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD86F7F41E
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 21:36:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:37 +0100
Message-Id: <20180111213250.16511-39-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 38/51] qapi: add conditions to SPICE
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
index 05f1db27c8..17f673d7d1 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -110,7 +110,8 @@
 { 'struct': 'SpiceBasicInfo',
   'data': { 'host': 'str',
             'port': 'str',
-            'family': 'NetworkAddressFamily' } }
+            'family': 'NetworkAddressFamily' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceServerInfo:
@@ -123,7 +124,8 @@
 ##
 { 'struct': 'SpiceServerInfo',
   'base': 'SpiceBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceChannel:
@@ -148,7 +150,8 @@
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
@@ -167,7 +170,8 @@
 # Since: 1.1
 ##
 { 'enum': 'SpiceQueryMouseMode',
-  'data': [ 'client', 'server', 'unknown' ] }
+  'data': [ 'client', 'server', 'unknown' ],
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceInfo:
@@ -204,7 +208,8 @@
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
@@ -249,7 +254,8 @@
 #    }
 #
 ##
-{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
+{ 'command': 'query-spice', 'returns': 'SpiceInfo',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_CONNECTED:
@@ -274,7 +280,8 @@
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_INITIALIZED:
@@ -302,7 +309,8 @@
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
-            'client': 'SpiceChannel' } }
+            'client': 'SpiceChannel' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_DISCONNECTED:
@@ -327,7 +335,8 @@
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_MIGRATE_COMPLETED:
@@ -342,7 +351,8 @@
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
index b8931364f2..9dd1ee3c86 100644
--- a/monitor.c
+++ b/monitor.c
@@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
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
index d26debcd75..2a8dfa5058 100644
--- a/qmp.c
+++ b/qmp.c
@@ -125,22 +125,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
=20
-#ifndef CONFIG_SPICE
-/*
- * qmp-commands.hx ensures that QMP command query-spice exists only
- * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
- * result.  However, the QAPI schema is blissfully unaware of that,
- * and the QAPI code generator happily generates a dead
- * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
- * one, or else linking fails.  FIXME Educate the QAPI schema on
- * CONFIG_SPICE.
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
2.16.0.rc1.1.gef27df75a1
