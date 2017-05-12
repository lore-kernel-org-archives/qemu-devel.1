Received: from eggs.gnu.org ([2001:4830:134:3::10]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afj-0005OA-6Q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afe-00072j-NS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d9Afe-00070o-Hm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00GMPDKPLB10@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 14:31:49 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 16:31:25 +0300
Message-id: <1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133148eucas1p2c04111d415b1fbd6fb702cfc2a3ed6f9@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V5 8/9] migration: add postcopy total blocktime
 into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

Postcopy total blocktime is available on destination side only.
But query-migrate was possible only for source. This patch
adds ability to call query-migrate on destination. To distinguish
src/dst, state of the MigrationState is using, query-migrate prepares
MigrationInfo for source machine only in case of migration's state is different
than MIGRATION_STATUS_NONE.

To be able to see postcopy blocktime, need to request postcopy-blocktime
capability.

The query-migrate command will show following sample result:
{"return":
    "postcopy_vcpu_blocktime": [115, 100],
    "status": "completed",
    "postcopy_blocktime": 100
}}

postcopy_vcpu_blocktime contains list, where the first item is the first
vCPU in QEMU.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h |  4 +++
 migration/migration.c         | 47 ++++++++++++++++++++++++++--
 migration/postcopy-ram.c      | 73 +++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events        |  1 +
 qapi-schema.json              |  6 +++-
 5 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7e69a2d..aba0535 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -135,6 +135,10 @@ struct MigrationIncomingState {
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+/*
+ * Functions to work with blocktime context
+ */
+void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 struct MigrationState
 {
diff --git a/migration/migration.c b/migration/migration.c
index c0443ce..7a4f33f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -666,9 +666,15 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
-MigrationInfo *qmp_query_migrate(Error **errp)
+/* TODO improve this assumption */
+static bool is_source_migration(void)
+{
+    MigrationState *ms = migrate_get_current();
+    return ms->state != MIGRATION_STATUS_NONE;
+}
+
+static void fill_source_migration_info(MigrationInfo *info)
 {
-    MigrationInfo *info = g_malloc0(sizeof(*info));
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
@@ -759,10 +765,45 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         break;
     }
     info->status = s->state;
+}
+
+static void fill_destination_migration_info(MigrationInfo *info)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
-    return info;
+    switch (mis->state) {
+    case MIGRATION_STATUS_NONE:
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
+    if (is_source_migration()) {
+        fill_source_migration_info(info);
+    } else {
+        fill_destination_migration_info(info);
+    }
+
+     return info;
+ }
+
 void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
                                   Error **errp)
 {
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e2660ae..fe047c8 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -129,6 +129,71 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
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
+
+    if (!mis->blocktime_ctx) {
+        return;
+    }
+
+    info->has_postcopy_blocktime = true;
+    info->postcopy_blocktime = mis->blocktime_ctx->total_blocktime;
+    info->has_postcopy_vcpu_blocktime = true;
+    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(mis->blocktime_ctx);
+}
+
+static uint64_t get_postcopy_total_blocktime(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->blocktime_ctx) {
+        return 0;
+    }
+
+    return mis->blocktime_ctx->total_blocktime;
+}
+
 /*
  * Check userfault fd features, to request only supported features in
  * future.
@@ -462,6 +527,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
+    /* here should be blocktime receiving back operation */
+    trace_postcopy_ram_incoming_cleanup_blocktime(
+            get_postcopy_total_blocktime());
     migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
@@ -876,6 +944,11 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
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
index 9424e3e..bdaca1d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -193,6 +193,7 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu64
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
diff --git a/qapi-schema.json b/qapi-schema.json
index fde6d63..e11c5f2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -712,6 +712,8 @@
 #              @status is 'failed'. Clients should not attempt to parse the
 #              error strings. (Since 2.7)
 #
+# @postcopy_vcpu_blocktime: list of the postcopy blocktime per vCPU (Since 2.9)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
@@ -723,7 +725,9 @@
            '*downtime': 'int',
            '*setup-time': 'int',
            '*cpu-throttle-percentage': 'int',
-           '*error-desc': 'str'} }
+           '*error-desc': 'str',
+           '*postcopy_blocktime' : 'int64',
+           '*postcopy_vcpu_blocktime': ['int64']} }
 
 ##
 # @query-migrate:
-- 
1.9.1
