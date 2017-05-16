Received: from eggs.gnu.org ([2001:4830:134:3::10]:51748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAaOI-0000Bf-W8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAaOG-00033U-FN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAaOG-00032a-7E
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 266EE80C31
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 11:11:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 16 May 2017 13:11:20 +0200
Message-Id: <20170516111123.17692-3-quintela@redhat.com>
In-Reply-To: <20170516111123.17692-1-quintela@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

Create one capability for block migration and one parameter for
incremental block migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                         | 13 +++++++
 include/migration/block.h     |  2 +
 include/migration/migration.h |  7 ++++
 migration/migration.c         | 88 +++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json              | 14 +++++--
 5 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index acbbc5c..208154c 100644
--- a/hmp.c
+++ b/hmp.c
@@ -326,6 +326,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
             params->x_checkpoint_delay);
+        assert(params->has_block_incremental);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMENTAL],
+                       params->block_incremental ? "on" : "off");
     }
 
     qapi_free_MigrationParameters(params);
@@ -1527,6 +1531,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     Visitor *v = string_input_visitor_new(valuestr);
     uint64_t valuebw = 0;
     int64_t valueint = 0;
+    bool valuebool = false;
     Error *err = NULL;
     bool use_int_value = false;
     int i, ret;
@@ -1581,6 +1586,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 47262bd..adcb8f6 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -179,6 +179,10 @@ struct MigrationState
 
     /* The last error that occurred */
     Error *error;
+    /* Do we have to clean up -b/-i from old migrate paramteres */
+    /* This feature is deprecated and will be removed */
+    bool must_remove_block;
+    bool must_remove_block_incremental;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -293,6 +297,9 @@ bool migrate_colo_enabled(void);
 
 int64_t xbzrle_cache_resize(int64_t new_size);
 
+bool migrate_use_block(void);
+bool migrate_use_block_incremental(void);
+
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
diff --git a/migration/migration.c b/migration/migration.c
index 5c92851..03f96df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -599,6 +599,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_block_incremental = true;
+    params->block_incremental = s->parameters.block_incremental;
 
     return params;
 }
@@ -907,6 +909,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
             colo_checkpoint_notify(s);
         }
     }
+    if (params->has_block_incremental) {
+        s->parameters.block_incremental = params->block_incremental;
+    }
 }
 
 
@@ -942,6 +947,35 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+void migrate_set_block_enabled(bool value, Error **errp)
+{
+    MigrationCapabilityStatusList *cap;
+
+    cap = g_malloc0(sizeof(*cap));
+    cap->value = g_malloc(sizeof(*cap->value));
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
+    if (s->must_remove_block) {
+        migrate_set_block_enabled(false, NULL);
+        s->must_remove_block = false;
+    }
+    if (s->must_remove_block_incremental) {
+        migrate_set_block_incremental(s, false);
+        s->must_remove_block_incremental = false;
+    }
+}
+
 static void migrate_fd_cleanup(void *opaque)
 {
     MigrationState *s = opaque;
@@ -974,6 +1008,7 @@ static void migrate_fd_cleanup(void *opaque)
     }
 
     notifier_list_notify(&migration_state_notifiers, s);
+    block_cleanup_parameters(s);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
@@ -986,6 +1021,7 @@ void migrate_fd_error(MigrationState *s, const Error *error)
         s->error = error_copy(error);
     }
     notifier_list_notify(&migration_state_notifiers, s);
+    block_cleanup_parameters(s);
 }
 
 static void migrate_fd_cancel(MigrationState *s)
@@ -1027,6 +1063,7 @@ static void migrate_fd_cancel(MigrationState *s)
             s->block_inactive = false;
         }
     }
+    block_cleanup_parameters(s);
 }
 
 void add_migration_state_change_notifier(Notifier *notify)
@@ -1209,6 +1246,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     MigrationParams params;
+    bool block_enabled = false;
     const char *p;
 
     params.blk = has_blk && blk;
@@ -1229,6 +1267,38 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
+    if (has_blk && blk) {
+        if (migrate_use_block() || migrate_use_block_incremental()) {
+            error_setg(errp, "You can't use block capability and -b/i");
+            return;
+        }
+        migrate_set_block_enabled(true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        block_enabled = true;
+        s->must_remove_block = true;
+    }
+
+    if (has_inc && inc) {
+        if ((migrate_use_block() && !block_enabled)
+            || migrate_use_block_incremental()) {
+            error_setg(errp, "You can't use block capability and -b/i");
+            return;
+        }
+        if (!block_enabled) {
+            migrate_set_block_enabled(true, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            s->must_remove_block = true;
+        }
+        migrate_set_block_incremental(s, true);
+        s->must_remove_block_incremental = true;
+    }
+
     s = migrate_init(&params);
 
     if (strstart(uri, "tcp:", &p)) {
@@ -1426,6 +1496,24 @@ int64_t migrate_xbzrle_cache_size(void)
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
index 5728b7f..62246bc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -894,11 +894,14 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
 #        during postcopy-ram migration. (since 2.9)
 #
+# @block: enable block migration (Since 2.10)
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
@@ -1009,13 +1012,15 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
 #          periodic mode. (Since 2.8)
 #
+# @block-incremental: enable block incremental migration (Since 2.10)
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
@@ -1082,6 +1087,8 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+# @block-incremental: enable block incremental migration (Since 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1094,7 +1101,8 @@
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
