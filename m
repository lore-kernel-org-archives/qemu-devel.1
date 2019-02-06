Received: from eggs.gnu.org ([209.51.188.92]:55211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBg-0006tZ-Vz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBf-0007lH-Jo
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1grNBf-0007l5-Bh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95596C0528BD
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 13:24:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Feb 2019 14:23:30 +0100
Message-Id: <20190206132331.1694-4-quintela@redhat.com>
In-Reply-To: <20190206132331.1694-1-quintela@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] multifd: Drop x-
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We make it supported from now on.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 | 10 +++++-----
 migration/migration.c | 26 +++++++++++++-------------
 qapi/migration.json   | 34 +++++++++++++++++-----------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/hmp.c b/hmp.c
index 73b8443a8e..0cafce9713 100644
--- a/hmp.c
+++ b/hmp.c
@@ -424,8 +424,8 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL=
),
             params->block_incremental ? "on" : "off");
         monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNEL=
S),
-            params->x_multifd_channels);
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS)=
,
+            params->multifd_channels);
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
             params->xbzrle_cache_size);
@@ -1769,9 +1769,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
         p->has_block_incremental =3D true;
         visit_type_bool(v, param, &p->block_incremental, &err);
         break;
-    case MIGRATION_PARAMETER_X_MULTIFD_CHANNELS:
-        p->has_x_multifd_channels =3D true;
-        visit_type_int(v, param, &p->x_multifd_channels, &err);
+    case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
+        p->has_multifd_channels =3D true;
+        visit_type_int(v, param, &p->multifd_channels, &err);
         break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
diff --git a/migration/migration.c b/migration/migration.c
index 65df9b566e..c7dbc44562 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -746,8 +746,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->x_checkpoint_delay =3D s->parameters.x_checkpoint_delay;
     params->has_block_incremental =3D true;
     params->block_incremental =3D s->parameters.block_incremental;
-    params->has_x_multifd_channels =3D true;
-    params->x_multifd_channels =3D s->parameters.x_multifd_channels;
+    params->has_multifd_channels =3D true;
+    params->multifd_channels =3D s->parameters.multifd_channels;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1103,7 +1103,7 @@ static bool migrate_params_check(MigrationParameter=
s *params, Error **errp)
=20
     /* x_checkpoint_delay is now always positive */
=20
-    if (params->has_x_multifd_channels && (params->x_multifd_channels < =
1)) {
+    if (params->has_multifd_channels && (params->multifd_channels < 1)) =
{
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
                    "is invalid, it should be in the range of 1 to 255");
@@ -1188,8 +1188,8 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental =3D params->block_incremental;
     }
-    if (params->has_x_multifd_channels) {
-        dest->x_multifd_channels =3D params->x_multifd_channels;
+    if (params->has_multifd_channels) {
+        dest->multifd_channels =3D params->multifd_channels;
     }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
@@ -1266,8 +1266,8 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
     if (params->has_block_incremental) {
         s->parameters.block_incremental =3D params->block_incremental;
     }
-    if (params->has_x_multifd_channels) {
-        s->parameters.x_multifd_channels =3D params->x_multifd_channels;
+    if (params->has_multifd_channels) {
+        s->parameters.multifd_channels =3D params->multifd_channels;
     }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
@@ -2005,7 +2005,7 @@ bool migrate_use_multifd(void)
=20
     s =3D migrate_get_current();
=20
-    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
=20
 bool migrate_pause_before_switchover(void)
@@ -2024,7 +2024,7 @@ int migrate_multifd_channels(void)
=20
     s =3D migrate_get_current();
=20
-    return s->parameters.x_multifd_channels;
+    return s->parameters.multifd_channels;
 }
=20
 int migrate_use_xbzrle(void)
@@ -3257,8 +3257,8 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT32("x-checkpoint-delay", MigrationState,
                       parameters.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
-    DEFINE_PROP_UINT8("x-multifd-channels", MigrationState,
-                      parameters.x_multifd_channels,
+    DEFINE_PROP_UINT8("multifd-channels", MigrationState,
+                      parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
@@ -3282,7 +3282,7 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RA=
M),
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PAT=
H),
-    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_X_MULTIFD),
+    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
=20
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -3336,7 +3336,7 @@ static void migration_instance_init(Object *obj)
     params->has_downtime_limit =3D true;
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
-    params->has_x_multifd_channels =3D true;
+    params->has_multifd_channels =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c5db60406..c202703889 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -401,7 +401,7 @@
 # @pause-before-switchover: Pause outgoing migration before serialising =
device
 #          state and before disabling block IO (since 2.11)
 #
-# @x-multifd: Use more than one fd for migration (since 2.11)
+# @multifd: Use more than one fd for migration (since 4.0)
 #
 # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
 #                 (since 2.12)
@@ -418,7 +418,7 @@
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
-           'block', 'return-path', 'pause-before-switchover', 'x-multifd=
',
+           'block', 'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' =
] }
=20
 ##
@@ -542,10 +542,10 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
-# @x-multifd-channels: Number of channels used to migrate data in
-#                     parallel. This is the same number that the
-#                     number of sockets used for migration.  The
-#                     default value is 2 (since 2.11)
+# @multifd-channels: Number of channels used to migrate data in
+#                    parallel. This is the same number that the
+#                    number of sockets used for migration.  The
+#                    default value is 2 (since 4.0)
 #
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
@@ -566,7 +566,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-channels',
+           'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle' ] }
=20
@@ -629,10 +629,10 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
-# @x-multifd-channels: Number of channels used to migrate data in
-#                     parallel. This is the same number that the
-#                     number of sockets used for migration.  The
-#                     default value is 2 (since 2.11)
+# @multifd-channels: Number of channels used to migrate data in
+#                    parallel. This is the same number that the
+#                    number of sockets used for migration.  The
+#                    default value is 2 (since 4.0)
 #
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
@@ -663,7 +663,7 @@
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
-            '*x-multifd-channels': 'int',
+            '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
 	    '*max-cpu-throttle': 'int' } }
@@ -742,10 +742,10 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
-# @x-multifd-channels: Number of channels used to migrate data in
-#                     parallel. This is the same number that the
-#                     number of sockets used for migration.
-#                     The default value is 2 (since 2.11)
+# @multifd-channels: Number of channels used to migrate data in
+#                    parallel. This is the same number that the
+#                    number of sockets used for migration.
+#                    The default value is 2 (since 4.0)
 #
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
@@ -775,7 +775,7 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': 'uint32',
             '*block-incremental': 'bool' ,
-            '*x-multifd-channels': 'uint8',
+            '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
 	    '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle':'uint8'} }
--=20
2.20.1
