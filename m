Received: from eggs.gnu.org ([2001:4830:134:3::10]:58649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORo-0000I4-9Y
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORm-0001M0-UW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORm-0001L6-Ow
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CA88401DEAB
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:53 +0200
Message-Id: <20180706105753.26700-28-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 27/27] qapi: add conditions to REPLICATION
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index 38b31250f9..6baeac23a7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2542,7 +2542,9 @@
             'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks=
',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'q=
cow',
-            'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'shee=
pdog',
+            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
+            'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'v=
xhs' ] }
=20
 ##
@@ -3292,7 +3294,8 @@
 #
 # Since: 2.9
 ##
-{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
+{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ],
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @BlockdevOptionsReplication:
@@ -3310,7 +3313,8 @@
 { 'struct': 'BlockdevOptionsReplication',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'mode': 'ReplicationMode',
-            '*top-id': 'str' } }
+            '*top-id': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @NFSTransport:
@@ -3616,7 +3620,8 @@
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
index 186e8a7303..554231a2f4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1163,7 +1163,8 @@
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
@@ -1178,7 +1179,8 @@
 # Since: 2.9
 ##
 { 'struct': 'ReplicationStatus',
-  'data': { 'error': 'bool', '*desc': 'str' } }
+  'data': { 'error': 'bool', '*desc': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @query-xen-replication-status:
@@ -1195,7 +1197,8 @@
 # Since: 2.9
 ##
 { 'command': 'query-xen-replication-status',
-  'returns': 'ReplicationStatus' }
+  'returns': 'ReplicationStatus',
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @xen-colo-do-checkpoint:
@@ -1211,7 +1214,8 @@
 #
 # Since: 2.9
 ##
-{ 'command': 'xen-colo-do-checkpoint' }
+{ 'command': 'xen-colo-do-checkpoint',
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @migrate-recover:
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
index 3c9c97b73f..c3414377f9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1194,11 +1194,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QOb=
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
2.18.0.rc1
