Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duerJ-0002g6-9n
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duer9-0000r4-45
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1duer8-0000qU-RN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB7BC80468
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:46:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:29 +0200
Message-Id: <20170920104639.2335-7-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-1-quintela@redhat.com>
References: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/16] migration: Create x-multifd-channels
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Indicates the number of channels that we will create.  By default we
create 2 channels.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>

--

Catch inconsistent defaults (eric).
Improve comment stating that number of threads is the same than number
of sockets
Use new DEFIN_PROP_*
Rename x-multifd-threads to x-multifd-threads
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 26 ++++++++++++++++++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   | 24 +++++++++++++++++++++---
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 0fb2bc7043..bebe19ebe4 100644
--- a/hmp.c
+++ b/hmp.c
@@ -336,6 +336,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNELS),
+            params->x_multifd_channels);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1621,6 +1624,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_block_incremental = true;
         visit_type_bool(v, param, &p->block_incremental, &err);
         break;
+    case MIGRATION_PARAMETER_X_MULTIFD_CHANNELS:
+        p->has_x_multifd_channels = true;
+        visit_type_int(v, param, &p->x_multifd_channels, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 958b783bcf..7e79310d03 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -77,6 +77,7 @@
  * Note: Please change this default value to 10000 when we support hybrid mode.
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -481,6 +482,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_x_multifd_channels = true;
+    params->x_multifd_channels = s->parameters.x_multifd_channels;
 
     return params;
 }
@@ -762,6 +765,13 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
                     "is invalid, it should be positive");
         return false;
     }
+    if (params->has_x_multifd_channels &&
+        (params->x_multifd_channels < 1 || params->x_multifd_channels > 255)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_channels",
+                   "is invalid, it should be in the range of 1 to 255");
+        return false;
+    }
 
     return true;
 }
@@ -880,6 +890,9 @@ static void migrate_params_apply(MigrateSetParameters *params)
     if (params->has_block_incremental) {
         s->parameters.block_incremental = params->block_incremental;
     }
+    if (params->has_x_multifd_channels) {
+        s->parameters.x_multifd_channels = params->x_multifd_channels;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1458,6 +1471,15 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
 }
 
+int migrate_multifd_channels(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.x_multifd_channels;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -2223,6 +2245,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
                       parameters.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
+    DEFINE_PROP_INT64("x-multifd-channels", MigrationState,
+                      parameters.x_multifd_channels,
+                      DEFAULT_MIGRATE_MULTIFD_CHANNELS),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -2280,6 +2305,7 @@ static void migration_instance_init(Object *obj)
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
+    params->has_x_multifd_channels = true;
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index b7437f16ce..3060cbc374 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -175,6 +175,7 @@ bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+int migrate_multifd_channels(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index ec4a88a43a..c766fb1e52 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -466,13 +466,19 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
+# @x-multifd-channels: Number of channels used to migrate data in
+#                     parallel. This is the same number that the
+#                     number of sockets used for migration.  The
+#                     default value is 2 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
+           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
+           'x-multifd-channels'] }
 
 ##
 # @MigrateSetParameters:
@@ -528,6 +534,11 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
+# @x-multifd-channels: Number of channels used to migrate data in
+#                     parallel. This is the same number that the
+#                     number of sockets used for migration.  The
+#                     default value is 2 (since 2.11)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -543,7 +554,8 @@
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
-            '*block-incremental': 'bool' } }
+            '*block-incremental': 'bool',
+            '*x-multifd-channels': 'int' } }
 
 ##
 # @migrate-set-parameters:
@@ -614,6 +626,11 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
+# @x-multifd-channels: Number of channels used to migrate data in
+#                     parallel. This is the same number that the
+#                     number of sockets used for migration.
+#                     The default value is 2 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -627,7 +644,8 @@
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
-            '*block-incremental': 'bool' } }
+            '*block-incremental': 'bool' ,
+            '*x-multifd-channels': 'int' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.13.5
