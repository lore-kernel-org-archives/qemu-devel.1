Received: from eggs.gnu.org ([2001:4830:134:3::10]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJU-0006Y4-Vv
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJT-0008VM-BA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJT-0008V8-5Z
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEE86406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:59 +0100
Message-Id: <20180321115211.17937-38-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 37/49] qapi: add conditions to REPLICATION
 type/commands on the schema
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

Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
code accordingly.

Made conditional:

* xen-set-replication, query-xen-replication-status,
  xen-colo-do-checkpoint

  Before the patch, we first register the commands unconditionally in
  generated code (requires a stub), then conditionally unregister in
  qmp_unregister_commands_hack().

  Afterwards, we register only when CONFIG_REPLICATION.  The command
  fails exactly the same, with CommandNotFound.

  Improvement, because now query-qmp-schema is accurate, and we're one
  step closer to killing qmp_unregister_commands_hack().

* enum BlockdevDriver value "replication" in command blockdev-add

* BlockdevOptions variant @replication

And related structures.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/block-core.json | 13 +++++++++----
 qapi/migration.json  | 12 ++++++++----
 migration/colo.c     | 16 ++++------------
 monitor.c            |  5 -----
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1088ab0c78..c20d39049b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2514,7 +2514,9 @@
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs=
',
             'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2',=
 'qed',
-            'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
+            'quorum', 'raw', 'rbd',
+            { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
+            'sheepdog', 'ssh',
             'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] =
}
=20
 ##
@@ -3228,7 +3230,8 @@
 #
 # Since: 2.9
 ##
-{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
+{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ],
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @BlockdevOptionsReplication:
@@ -3246,7 +3249,8 @@
 { 'struct': 'BlockdevOptionsReplication',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'mode': 'ReplicationMode',
-            '*top-id': 'str' } }
+            '*top-id': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @NFSTransport:
@@ -3545,7 +3549,8 @@
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
       'rbd':        'BlockdevOptionsRbd',
-      'replication':'BlockdevOptionsReplication',
+      'replication': { 'type': 'BlockdevOptionsReplication',
+                       'if': 'defined(CONFIG_REPLICATION)' },
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'throttle':   'BlockdevOptionsThrottle',
diff --git a/qapi/migration.json b/qapi/migration.json
index 9d0bf82cf4..d2c6e4d646 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1121,7 +1121,8 @@
 # Since: 2.9
 ##
 { 'command': 'xen-set-replication',
-  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } =
}
+  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @ReplicationStatus:
@@ -1136,7 +1137,8 @@
 # Since: 2.9
 ##
 { 'struct': 'ReplicationStatus',
-  'data': { 'error': 'bool', '*desc': 'str' } }
+  'data': { 'error': 'bool', '*desc': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @query-xen-replication-status:
@@ -1153,7 +1155,8 @@
 # Since: 2.9
 ##
 { 'command': 'query-xen-replication-status',
-  'returns': 'ReplicationStatus' }
+  'returns': 'ReplicationStatus',
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @xen-colo-do-checkpoint:
@@ -1169,4 +1172,5 @@
 #
 # Since: 2.9
 ##
-{ 'command': 'xen-colo-do-checkpoint' }
+{ 'command': 'xen-colo-do-checkpoint',
+  'if': 'defined(CONFIG_REPLICATION)' }
diff --git a/migration/colo.c b/migration/colo.c
index 4381067ed4..2329e78e7f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -24,7 +24,9 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/failover.h"
+#ifdef CONFIG_REPLICATION
 #include "replication.h"
+#endif
=20
 static bool vmstate_loading;
=20
@@ -148,11 +150,11 @@ void colo_do_failover(MigrationState *s)
     }
 }
=20
+#ifdef CONFIG_REPLICATION
 void qmp_xen_set_replication(bool enable, bool primary,
                              bool has_failover, bool failover,
                              Error **errp)
 {
-#ifdef CONFIG_REPLICATION
     ReplicationMode mode =3D primary ?
                            REPLICATION_MODE_PRIMARY :
                            REPLICATION_MODE_SECONDARY;
@@ -171,14 +173,10 @@ void qmp_xen_set_replication(bool enable, bool prim=
ary,
         }
         replication_stop_all(failover, failover ? NULL : errp);
     }
-#else
-    abort();
-#endif
 }
=20
 ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
 {
-#ifdef CONFIG_REPLICATION
     Error *err =3D NULL;
     ReplicationStatus *s =3D g_new0(ReplicationStatus, 1);
=20
@@ -193,19 +191,13 @@ ReplicationStatus *qmp_query_xen_replication_status=
(Error **errp)
=20
     error_free(err);
     return s;
-#else
-    abort();
-#endif
 }
=20
 void qmp_xen_colo_do_checkpoint(Error **errp)
 {
-#ifdef CONFIG_REPLICATION
     replication_do_checkpoint_all(errp);
-#else
-    abort();
-#endif
 }
+#endif
=20
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
diff --git a/monitor.c b/monitor.c
index 8a5539579b..88e6fd2e6f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1087,11 +1087,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QOb=
ject **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef CONFIG_REPLICATION
-    qmp_unregister_command(&qmp_commands, "xen-set-replication");
-    qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
-    qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
-#endif
 #ifndef TARGET_I386
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
     qmp_unregister_command(&qmp_commands, "query-sev");
--=20
2.16.2.521.g9aa15f885a
