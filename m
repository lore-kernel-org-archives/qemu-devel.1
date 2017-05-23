Received: from eggs.gnu.org ([2001:4830:134:3::10]:48790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82L-0006m2-In
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82I-0003gM-27
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:37 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:54528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dD82H-0003eh-SQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQE003ZQLCKDH60@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:32 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 23 May 2017 14:31:10 +0300
Message-id: <1495539071-12995-10-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113131eucas1p1ec4e059c13ce977e3a3872c343e6b858@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V6 09/10] migration: add postcopy total
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
Cc: i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

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

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 hmp.c                         | 15 +++++++++
 include/migration/migration.h |  4 +++
 migration/migration.c         | 40 +++++++++++++++++++++--
 migration/postcopy-ram.c      | 75 +++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events        |  1 +
 qapi-schema.json              |  9 +++++-
 6 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 3dceaf8..25135e7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -260,6 +260,21 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->cpu_throttle_percentage);
     }
 
+    if (info->has_postcopy_blocktime) {
+        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
+                info->postcopy_blocktime);
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
index 4e05c83..c9d4954 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -123,6 +123,10 @@ struct MigrationIncomingState {
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+/*
+ * Functions to work with blocktime context
+ */
+void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 struct MigrationState
 {
diff --git a/migration/migration.c b/migration/migration.c
index e10284e..4da0c20 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -651,14 +651,15 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
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
@@ -744,10 +745,43 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
index e70c44b..3dc3869 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -139,6 +139,73 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
+static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
+{
+    int64List *list = NULL, *entry = NULL;
+    int i;
+
+    for (i = smp_cpus - 1; i >= 0; i--) {
+            entry = g_new0(int64List, 1);
+            entry->value = ctx->vcpu_blocktime[i];
+            entry->next = list;
+            list = entry;
+    }
+
+    return list;
+}
+
+/*
+ * This function just provide calculated blocktime per cpu and trace it.
+ * Total blocktime is calculated in mark_postcopy_blocktime_end.
+ *
+ *
+ * Assume we have 3 CPU
+ *
+ *      S1        E1           S1               E1
+ * -----***********------------xxx***************------------------------> CPU1
+ *
+ *             S2                E2
+ * ------------****************xxx---------------------------------------> CPU2
+ *
+ *                         S3            E3
+ * ------------------------****xxx********-------------------------------> CPU3
+ *
+ * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
+ * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
+ * S3,S1,E2 - sequence includes all CPUs, in this case overlap will be S1,E2 -
+ *            it's a part of total blocktime.
+ * S1 - here is last_begin
+ * Legend of the picture is following:
+ *              * - means blocktime per vCPU
+ *              x - means overlapped blocktime (total blocktime)
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
@@ -497,6 +564,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
+    /* here should be blocktime receiving back operation */
+    trace_postcopy_ram_incoming_cleanup_blocktime(
+            get_postcopy_total_blocktime());
     migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
@@ -926,6 +996,11 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
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
index 78617fe..4be0b09 100644
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
1.8.3.1
