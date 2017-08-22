Received: from eggs.gnu.org ([2001:4830:134:3::10]:56231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9M3-0001st-Cz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9M0-0000Cs-4P
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Lp-00009I-2O
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39B5A7E446
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:27:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:47 +0200
Message-Id: <20170822132255.23945-47-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 46/54] qapi: add conditions to SPICE
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Add #if defined(CONFIG_SPICE) in generated code, and adjust the
qmp/hmp code accordingly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 28 ++++++++++++++++++----------
 qapi/event.json  | 12 ++++++++----
 monitor.c        |  3 ---
 qmp.c            | 16 ----------------
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 4ffbe1d9ff..08e96bd93f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1878,7 +1878,8 @@
 { 'struct': 'SpiceBasicInfo',
   'data': { 'host': 'str',
             'port': 'str',
-            'family': 'NetworkAddressFamily' } }
+            'family': 'NetworkAddressFamily' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceServerInfo:
@@ -1891,7 +1892,8 @@
 ##
 { 'struct': 'SpiceServerInfo',
   'base': 'SpiceBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceChannel:
@@ -1916,7 +1918,8 @@
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
@@ -1935,7 +1938,8 @@
 # Since: 1.1
 ##
 { 'enum': 'SpiceQueryMouseMode',
-  'data': [ 'client', 'server', 'unknown' ] }
+  'data': [ 'client', 'server', 'unknown' ],
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SpiceInfo:
@@ -1972,7 +1976,8 @@
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
@@ -2017,7 +2022,8 @@
 #    }
 #
 ##
-{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
+{ 'command': 'query-spice', 'returns': 'SpiceInfo',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @BalloonInfo:
@@ -5091,7 +5097,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
-  'base': 'ChardevCommon' }
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevSpicePort:
@@ -5103,7 +5110,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
-  'base': 'ChardevCommon' }
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevVC:
@@ -5157,8 +5165,8 @@
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
diff --git a/qapi/event.json b/qapi/event.json
index c8b8e9f384..ff59551914 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -344,7 +344,8 @@
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_INITIALIZED:
@@ -372,7 +373,8 @@
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
-            'client': 'SpiceChannel' } }
+            'client': 'SpiceChannel' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_DISCONNECTED:
@@ -397,7 +399,8 @@
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
+            'client': 'SpiceBasicInfo' },
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @SPICE_MIGRATE_COMPLETED:
@@ -412,7 +415,8 @@
 #      "event": "SPICE_MIGRATE_COMPLETED" }
 #
 ##
-{ 'event': 'SPICE_MIGRATE_COMPLETED' }
+{ 'event': 'SPICE_MIGRATE_COMPLETED',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @MIGRATION:
diff --git a/monitor.c b/monitor.c
index 228f246fcc..e5a179d32e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,9 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
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
index 2c90dacb56..90816ba283 100644
--- a/qmp.c
+++ b/qmp.c
@@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
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
2.14.1.146.gd35faa819
