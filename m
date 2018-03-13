Received: from eggs.gnu.org ([2001:4830:134:3::10]:59160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJW-0003OR-Oz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJV-0001Nq-BS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evlJV-0001N5-1m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:05 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Mar 2018 17:53:44 +0300
Message-id: <1520952824-3172-7-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
References: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180313145401eucas1p2b7cbb73e2515551b9a0287df1335eeb9@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 6/6] migration: add postcopy total blocktime
 into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

Postcopy total blocktime is available on destination side only.
But query-migrate was possible only for source. This patch
adds ability to call query-migrate on destination.
To be able to see postcopy blocktime, need to request postcopy-blocktime
capability.

The query-migrate command will show following sample result:
{"return":
    "postcopy-vcpu-blocktime": [115, 100],
    "status": "completed",
    "postcopy-blocktime": 100
}}

postcopy_vcpu_blocktime contains list, where the first item is the first
vCPU in QEMU.

This patch has a drawback, it combines states of incoming and
outgoing migration. Ongoing migration state will overwrite incoming
state. Looks like better to separate query-migrate for incoming and
outgoing migration or add parameter to indicate type of migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                    | 15 +++++++++++++
 migration/migration.c    | 42 ++++++++++++++++++++++++++++++++----
 migration/migration.h    |  4 ++++
 migration/postcopy-ram.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events   |  1 +
 qapi/migration.json      | 11 +++++++++-
 6 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/hmp.c b/hmp.c
index 016cb5c..4539f77 100644
--- a/hmp.c
+++ b/hmp.c
@@ -274,6 +274,21 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->cpu_throttle_percentage);
     }
 
+    if (info->has_postcopy_blocktime) {
+        monitor_printf(mon, "postcopy blocktime: %u\n",
+                       info->postcopy_blocktime);
+    }
+
+    if (info->has_postcopy_vcpu_blocktime) {
+        Visitor *v;
+        char *str;
+        v = string_output_visitor_new(false, &str);
+        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
+        visit_complete(v, &str);
+        monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
+        g_free(str);
+        visit_free(v);
+    }
     qapi_free_MigrationInfo(info);
     qapi_free_MigrationCapabilityStatusList(caps);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 0ee9c1f..ae8890e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -619,14 +619,15 @@ static void populate_disk_info(MigrationInfo *info)
     }
 }
 
-MigrationInfo *qmp_query_migrate(Error **errp)
+static void fill_source_migration_info(MigrationInfo *info)
 {
-    MigrationInfo *info = g_malloc0(sizeof(*info));
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
     case MIGRATION_STATUS_NONE:
         /* no migration has happened ever */
+        /* do not overwrite destination migration status */
+        return;
         break;
     case MIGRATION_STATUS_SETUP:
         info->has_status = true;
@@ -677,8 +678,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         break;
     }
     info->status = s->state;
-
-    return info;
 }
 
 /**
@@ -742,6 +741,41 @@ static bool migrate_caps_check(bool *cap_list,
     return true;
 }
 
+static void fill_destination_migration_info(MigrationInfo *info)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    switch (mis->state) {
+    case MIGRATION_STATUS_NONE:
+        return;
+        break;
+    case MIGRATION_STATUS_SETUP:
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_COLO:
+        info->has_status = true;
+        break;
+    case MIGRATION_STATUS_COMPLETED:
+        info->has_status = true;
+        fill_destination_postcopy_migration_info(info);
+        break;
+    }
+    info->status = mis->state;
+}
+
+MigrationInfo *qmp_query_migrate(Error **errp)
+{
+    MigrationInfo *info = g_malloc0(sizeof(*info));
+
+    fill_destination_migration_info(info);
+    fill_source_migration_info(info);
+
+    return info;
+}
+
 void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
                                   Error **errp)
 {
diff --git a/migration/migration.h b/migration/migration.h
index 3ead619..a09277e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -73,6 +73,10 @@ struct MigrationIncomingState {
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+/*
+ * Functions to work with blocktime context
+ */
+void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 #define TYPE_MIGRATION "migration"
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9e51e84..c46225c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,55 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
+static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
+{
+    uint32List *list = NULL, *entry = NULL;
+    int i;
+
+    for (i = smp_cpus - 1; i >= 0; i--) {
+        entry = g_new0(uint32List, 1);
+        entry->value = ctx->vcpu_blocktime[i];
+        entry->next = list;
+        list = entry;
+    }
+
+    return list;
+}
+
+/*
+ * This function just populates MigrationInfo from postcopy's
+ * blocktime context. It will not populate MigrationInfo,
+ * unless postcopy-blocktime capability was set.
+ *
+ * @info: pointer to MigrationInfo to populate
+ */
+void fill_destination_postcopy_migration_info(MigrationInfo *info)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
+
+    if (!bc) {
+        return;
+    }
+
+    info->has_postcopy_blocktime = true;
+    info->postcopy_blocktime = bc->total_blocktime;
+    info->has_postcopy_vcpu_blocktime = true;
+    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
+}
+
+static uint32_t get_postcopy_total_blocktime(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
+
+    if (!bc) {
+        return 0;
+    }
+
+    return bc->total_blocktime;
+}
+
 /**
  * receive_ufd_features: check userfault fd features, to request only supported
  * features in the future.
@@ -475,6 +524,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         munmap(mis->postcopy_tmp_zero_page, mis->largest_page_size);
         mis->postcopy_tmp_zero_page = NULL;
     }
+    trace_postcopy_ram_incoming_cleanup_blocktime(
+            get_postcopy_total_blocktime());
+
     trace_postcopy_ram_incoming_cleanup_exit();
     return 0;
 }
@@ -968,6 +1020,10 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 #else
 /* No target OS support, stubs just fail */
+void fill_destination_postcopy_migration_info(MigrationInfo *info)
+{
+}
+
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     error_report("%s: No OS support", __func__);
diff --git a/migration/trace-events b/migration/trace-events
index 22ced40..def03c4 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu64
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
diff --git a/qapi/migration.json b/qapi/migration.json
index 676ef06..c4737f8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -156,6 +156,13 @@
 #              @status is 'failed'. Clients should not attempt to parse the
 #              error strings. (Since 2.7)
 #
+# @postcopy-blocktime: total time when all vCPU were blocked during postcopy
+#           live migration (Since 2.12)
+#
+# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.12)
+#
+
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
@@ -167,7 +174,9 @@
            '*downtime': 'int',
            '*setup-time': 'int',
            '*cpu-throttle-percentage': 'int',
-           '*error-desc': 'str'} }
+           '*error-desc': 'str',
+           '*postcopy-blocktime' : 'uint32',
+           '*postcopy-vcpu-blocktime': ['uint32']} }
 
 ##
 # @query-migrate:
-- 
2.7.4
