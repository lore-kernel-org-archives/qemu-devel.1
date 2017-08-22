Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9MU-0002Ge-Kw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9MP-0000Yr-5Q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9MO-0000YI-SC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:48 +0200
Message-Id: <20170822132255.23945-48-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 47/54] qapi: add conditions to REPLICATION
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

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
  step close to killing qmp_unregister_commands_hack().

* enum BlockdevDriver value "replication" in command blockdev-add

As well as enum BlockdevDriver value @replication BlockdevOptions
variant @replication, BlockdevOptionsReplication,
BlockdevOptionsReplicationMode.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 12 ++++++++----
 qapi/block-core.json | 13 +++++++++----
 migration/colo.c     | 14 ++------------
 monitor.c            |  5 -----
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 08e96bd93f..1091a80fd3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6361,7 +6361,8 @@
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
@@ -6376,7 +6377,8 @@
 # Since: 2.9
 ##
 { 'struct': 'ReplicationStatus',
-  'data': { 'error': 'bool', '*desc': 'str' } }
+  'data': { 'error': 'bool', '*desc': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @query-xen-replication-status:
@@ -6393,7 +6395,8 @@
 # Since: 2.9
 ##
 { 'command': 'query-xen-replication-status',
-  'returns': 'ReplicationStatus' }
+  'returns': 'ReplicationStatus',
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @xen-colo-do-checkpoint:
@@ -6409,7 +6412,8 @@
 #
 # Since: 2.9
 ##
-{ 'command': 'xen-colo-do-checkpoint' }
+{ 'command': 'xen-colo-do-checkpoint',
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @GICCapability:
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602150..f9a0834190 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2182,7 +2182,9 @@
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs=
',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
-            'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
+            'quorum', 'raw', 'rbd',
+            { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
+            'sheepdog', 'ssh',
             'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
=20
 ##
@@ -2805,7 +2807,8 @@
 #
 # Since: 2.9
 ##
-{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
+{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ],
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @BlockdevOptionsReplication:
@@ -2823,7 +2826,8 @@
 { 'struct': 'BlockdevOptionsReplication',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'mode': 'ReplicationMode',
-            '*top-id': 'str' } }
+            '*top-id': 'str' },
+  'if': 'defined(CONFIG_REPLICATION)' }
=20
 ##
 # @NFSTransport:
@@ -3104,7 +3108,8 @@
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
       'rbd':        'BlockdevOptionsRbd',
-      'replication':'BlockdevOptionsReplication',
+      'replication': { 'type': 'BlockdevOptionsReplication',
+                       'if': 'defined(CONFIG_REPLICATION)' },
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'vdi':        'BlockdevOptionsGenericFormat',
diff --git a/migration/colo.c b/migration/colo.c
index 8bd7ef0531..1f352a6d86 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -150,11 +150,11 @@ void colo_do_failover(MigrationState *s)
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
@@ -173,14 +173,10 @@ void qmp_xen_set_replication(bool enable, bool prim=
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
@@ -195,19 +191,13 @@ ReplicationStatus *qmp_query_xen_replication_status=
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
index e5a179d32e..008d7c2b06 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,11 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObje=
ct **ret_data,
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
 #endif
--=20
2.14.1.146.gd35faa819
