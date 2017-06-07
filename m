Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVj-00048D-6B
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVh-0000v0-Oq
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVh-0000uF-H2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600M6U2G89R80@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:08 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:30 +0300
Message-id: <1496820931-27416-11-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607073606eucas1p28da48135181e1a31e909ba7b102ee90b@eucas1p2.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 10/11] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

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
---
 hmp.c                         | 15 ++++++++++++
 include/migration/migration.h |  4 +++
 migration/migration.c         | 40 +++++++++++++++++++++++++++---
 migration/postcopy-ram.c      | 57 +++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events        |  1 +
 qapi-schema.json              |  9 ++++++-
 6 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8c72c58..e0c4fdf 100644
--- a/hmp.c
+++ b/hmp.c
@@ -262,6 +262,21 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->cpu_throttle_percentage);
     }
 
+    if (info->has_postcopy_blocktime) {
+        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
+                       info->postcopy_blocktime);
+    }
+
+    if (info->has_postcopy_vcpu_blocktime) {
+        Visitor *v;
+        char *str;
+        v = string_output_visitor_new(false, &str);
+        visit_type_int64List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
+        visit_complete(v, &str);
+        monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
+        g_free(str);
+        visit_free(v);
+    }
     qapi_free_MigrationInfo(info);
     qapi_free_MigrationCapabilityStatusList(caps);
 }
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 766e802..7d20470 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -98,6 +98,10 @@ struct MigrationIncomingState {
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+/*
+ * Functions to work with blocktime context
+ */
+void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 struct MigrationState
 {
diff --git a/migration/migration.c b/migration/migration.c
index d1cc34f..b80d5b5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -625,14 +625,15 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
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
@@ -718,10 +719,43 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         break;
     }
     info->status = s->state;
+}
 
-    return info;
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
 }
 
+MigrationInfo *qmp_query_migrate(Error **errp)
+{
+    MigrationInfo *info = g_malloc0(sizeof(*info));
+
+    fill_destination_migration_info(info);
+    fill_source_migration_info(info);
+
+    return info;
+ }
+
 void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
                                   Error **errp)
 {
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0ad9f9f..7f5b402 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -117,6 +117,55 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
+static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
+{
+    int64List *list = NULL, *entry = NULL;
+    int i;
+
+    for (i = smp_cpus - 1; i >= 0; i--) {
+        entry = g_new0(int64List, 1);
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
+static uint64_t get_postcopy_total_blocktime(void)
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
@@ -491,6 +540,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         munmap(mis->postcopy_tmp_zero_page, mis->largest_page_size);
         mis->postcopy_tmp_zero_page = NULL;
     }
+    trace_postcopy_ram_incoming_cleanup_blocktime(
+            get_postcopy_total_blocktime());
+
     trace_postcopy_ram_incoming_cleanup_exit();
     return 0;
 }
@@ -950,6 +1002,11 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 #else
 /* No target OS support, stubs just fail */
+void fill_destination_postcopy_migration_info(MigrationInfo *info)
+{
+    error_report("%s: No OS support", __func__);
+}
+
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     error_report("%s: No OS support", __func__);
diff --git a/migration/trace-events b/migration/trace-events
index 7bdadbb..55a3b6e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -195,6 +195,7 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu64
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
diff --git a/qapi-schema.json b/qapi-schema.json
index e906953..9229bbc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -712,6 +712,11 @@
 #              @status is 'failed'. Clients should not attempt to parse the
 #              error strings. (Since 2.7)
 #
+# @postcopy-blocktime: total time when all vCPU were blocked during postcopy
+#           live migration (Since 2.10)
+#
+# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.10)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
@@ -723,7 +728,9 @@
            '*downtime': 'int',
            '*setup-time': 'int',
            '*cpu-throttle-percentage': 'int',
-           '*error-desc': 'str'} }
+           '*error-desc': 'str',
+           '*postcopy-blocktime' : 'int64',
+           '*postcopy-vcpu-blocktime': ['int64']} }
 
 ##
 # @query-migrate:
-- 
1.9.1
