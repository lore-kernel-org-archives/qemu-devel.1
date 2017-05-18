Received: from eggs.gnu.org ([2001:4830:134:3::10]:57141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAs-00007Y-WA
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAn-0006ZZ-WE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPAn-0006ZM-MS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C830C01C700
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:25:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:24:48 +0200
Message-Id: <20170518172453.32599-5-quintela@redhat.com>
In-Reply-To: <20170518172453.32599-1-quintela@redhat.com>
References: <20170518172453.32599-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/18] migration: Create block capability
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

Create one capability for block migration and one parameter for
incremental block migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

---

- address all Markus comments
- use Markus and Eric text descriptions
- change logic another time
- improve text messages
---
 hmp.c                         | 13 ++++++++
 include/migration/block.h     |  2 ++
 include/migration/migration.h |  6 ++++
 migration/migration.c         | 71 +++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json              | 28 +++++++++++++++--
 5 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 83e45c8..20f5dab 100644
--- a/hmp.c
+++ b/hmp.c
@@ -327,6 +327,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
             params->x_checkpoint_delay);
+        assert(params->has_block_incremental);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMENTAL],
+                       params->block_incremental ? "on" : "off");
     }
 
     qapi_free_MigrationParameters(params);
@@ -1528,6 +1532,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     Visitor *v = string_input_visitor_new(valuestr);
     uint64_t valuebw = 0;
     int64_t valueint = 0;
+    bool valuebool = false;
     Error *err = NULL;
     bool use_int_value = false;
     int i, ret;
@@ -1582,6 +1587,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_checkpoint_delay = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
+                p.has_block_incremental = true;
+                visit_type_bool(v, param, &valuebool, &err);
+                if (err) {
+                    goto cleanup;
+                }
+                p.block_incremental = valuebool;
+                break;
             }
 
             if (use_int_value) {
diff --git a/include/migration/block.h b/include/migration/block.h
index 41a1ac8..5225af9 100644
--- a/include/migration/block.h
+++ b/include/migration/block.h
@@ -20,4 +20,6 @@ uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
+void migrate_set_block_enabled(bool value, Error **errp);
+
 #endif /* MIGRATION_BLOCK_H */
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 49ec501..024a048 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -153,6 +153,9 @@ struct MigrationState
 
     /* The last error that occurred */
     Error *error;
+    /* Do we have to clean up -b/-i from old migrate parameters */
+    /* This feature is deprecated and will be removed */
+    bool must_remove_block_options;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -265,6 +268,9 @@ bool migrate_colo_enabled(void);
 
 int64_t xbzrle_cache_resize(int64_t new_size);
 
+bool migrate_use_block(void);
+bool migrate_use_block_incremental(void);
+
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
diff --git a/migration/migration.c b/migration/migration.c
index 0304c01..c13c0a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -592,6 +592,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_block_incremental = true;
+    params->block_incremental = s->parameters.block_incremental;
 
     return params;
 }
@@ -900,6 +902,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
             colo_checkpoint_notify(s);
         }
     }
+    if (params->has_block_incremental) {
+        s->parameters.block_incremental = params->block_incremental;
+    }
 }
 
 
@@ -935,6 +940,33 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+void migrate_set_block_enabled(bool value, Error **errp)
+{
+    MigrationCapabilityStatusList *cap;
+
+    cap = g_new0(MigrationCapabilityStatusList, 1);
+    cap->value = g_new0(MigrationCapabilityStatus, 1);
+    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
+    cap->value->state = value;
+    qmp_migrate_set_capabilities(cap, errp);
+    qapi_free_MigrationCapabilityStatusList(cap);
+}
+
+static void migrate_set_block_incremental(MigrationState *s, bool value)
+{
+    s->parameters.block_incremental = value;
+}
+
+static void block_cleanup_parameters(MigrationState *s)
+{
+    if (s->must_remove_block_options) {
+        /* setting to false can never fail */
+        migrate_set_block_enabled(false, &error_abort);
+        migrate_set_block_incremental(s, false);
+        s->must_remove_block_options = false;
+    }
+}
+
 static void migrate_fd_cleanup(void *opaque)
 {
     MigrationState *s = opaque;
@@ -967,6 +999,7 @@ static void migrate_fd_cleanup(void *opaque)
     }
 
     notifier_list_notify(&migration_state_notifiers, s);
+    block_cleanup_parameters(s);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
@@ -979,6 +1012,7 @@ void migrate_fd_error(MigrationState *s, const Error *error)
         s->error = error_copy(error);
     }
     notifier_list_notify(&migration_state_notifiers, s);
+    block_cleanup_parameters(s);
 }
 
 static void migrate_fd_cancel(MigrationState *s)
@@ -1020,6 +1054,7 @@ static void migrate_fd_cancel(MigrationState *s)
             s->block_inactive = false;
         }
     }
+    block_cleanup_parameters(s);
 }
 
 void add_migration_state_change_notifier(Notifier *notify)
@@ -1207,6 +1242,24 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
+    if ((has_blk && blk) || (has_inc && inc)) {
+        if (migrate_use_block() || migrate_use_block_incremental()) {
+            error_setg(errp, "Command options are incompatible with "
+                       "current migration capabilities");
+            return;
+        }
+        migrate_set_block_enabled(true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        s->must_remove_block_options = true;
+    }
+
+    if (has_inc && inc) {
+        migrate_set_block_incremental(s, true);
+    }
+
     s = migrate_init(&params);
 
     if (strstart(uri, "tcp:", &p)) {
@@ -1404,6 +1457,24 @@ int64_t migrate_xbzrle_cache_size(void)
     return s->xbzrle_cache_size;
 }
 
+bool migrate_use_block(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK];
+}
+
+bool migrate_use_block_incremental(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.block_incremental;
+}
+
 /* migration thread support */
 /*
  * Something bad happened to the RP stream, mark an error
diff --git a/qapi-schema.json b/qapi-schema.json
index 80603cf..e38c5f0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -894,11 +894,18 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
 #        during postcopy-ram migration. (since 2.9)
 #
+# @block: If enabled, QEMU will also migrate the contents of all block
+#          devices.  Default is disabled.  A possible alternative uses
+#          mirror jobs to a builtin NBD server on the destination, which
+#          offers more flexibility.
+#          (Since 2.10)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
+           'block' ] }
 
 ##
 # @MigrationCapabilityStatus:
@@ -1009,13 +1016,20 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
 #          periodic mode. (Since 2.8)
 #
+# @block-incremental: Affects how much storage is migrated when the
+# 	block migration capability is enabled.  When false, the entire
+# 	storage backing chain is migrated into a flattened image at
+# 	the destination; when true, only the active qcow2 layer is
+# 	migrated and the destination must already have access to the
+# 	same backing chain as was used on the source.  (since 2.10)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay' ] }
+           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
 
 ##
 # @migrate-set-parameters:
@@ -1082,6 +1096,13 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+# @block-incremental: Affects how much storage is migrated when the
+# 	block migration capability is enabled.  When false, the entire
+# 	storage backing chain is migrated into a flattened image at
+# 	the destination; when true, only the active qcow2 layer is
+# 	migrated and the destination must already have access to the
+# 	same backing chain as was used on the source.  (since 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1094,7 +1115,8 @@
             '*tls-hostname': 'str',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
-            '*x-checkpoint-delay': 'int'} }
+            '*x-checkpoint-delay': 'int',
+            '*block-incremental': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.9.3
