Received: from eggs.gnu.org ([2001:4830:134:3::10]:60665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3FA2-0001xV-J3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3F9x-0002uA-Oh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:42 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3F9x-0002tk-Ih
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP000A5S3IZEN00@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:06:35 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 26 Apr 2017 08:06:18 +0300
Message-id: <1493183181-21962-5-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
References: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170426050634eucas1p1a1c95d312025c99453a185084b75396a@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V3 4/6] migration: add postcopy downtime into
 MigrationIncommingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com, qemu-devel@nongnu.org

This patch add request to kernel space for UFFD_FEATURE_THREAD_ID,
in case when this feature is provided by kernel.

DowntimeContext is incapsulated inside migration.c.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h | 12 ++++++++++++
 migration/migration.c         | 33 +++++++++++++++++++++++++++++++++
 migration/postcopy-ram.c      |  8 ++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..b1759f7 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -83,6 +83,8 @@ typedef enum {
     POSTCOPY_INCOMING_END
 } PostcopyState;
 
+struct DowntimeContext;
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -123,10 +125,20 @@ struct MigrationIncomingState {
 
     /* See savevm.c */
     LoadStateEntry_Head loadvm_handlers;
+
+    /*
+     * DowntimeContext to keep information for postcopy
+     * live migration, to calculate downtime
+     * */
+    struct DowntimeContext *downtime_ctx;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+/*
+ * Functions to work with downtime context
+ */
+struct DowntimeContext *downtime_context_new(void);
 
 /*
  * An outstanding page request, on the source, having been received
diff --git a/migration/migration.c b/migration/migration.c
index 79f6425..0309c2b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -77,6 +77,18 @@ static NotifierList migration_state_notifiers =
 
 static bool deferred_incoming;
 
+typedef struct DowntimeContext {
+    /* time when page fault initiated per vCPU */
+    int64_t *page_fault_vcpu_time;
+    /* page address per vCPU */
+    uint64_t *vcpu_addr;
+    int64_t total_downtime;
+    /* downtime per vCPU */
+    int64_t *vcpu_downtime;
+    /* point in time when last page fault was initiated */
+    int64_t last_begin;
+} DowntimeContext;
+
 /*
  * Current state of incoming postcopy; note this is not part of
  * MigrationIncomingState since it's state is used during cleanup
@@ -117,6 +129,23 @@ MigrationState *migrate_get_current(void)
     return &current_migration;
 }
 
+struct DowntimeContext *downtime_context_new(void)
+{
+    DowntimeContext *ctx = g_new0(DowntimeContext, 1);
+    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
+    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_downtime = g_new0(int64_t, smp_cpus);
+    return ctx;
+}
+
+static void destroy_downtime_context(struct DowntimeContext *ctx)
+{
+    g_free(ctx->page_fault_vcpu_time);
+    g_free(ctx->vcpu_addr);
+    g_free(ctx->vcpu_downtime);
+    g_free(ctx);
+}
+
 MigrationIncomingState *migration_incoming_get_current(void)
 {
     static bool once;
@@ -139,6 +168,10 @@ void migration_incoming_state_destroy(void)
 
     qemu_event_destroy(&mis->main_thread_load_event);
     loadvm_free_handlers(mis);
+    if (mis->downtime_ctx) {
+        destroy_downtime_context(mis->downtime_ctx);
+        mis->downtime_ctx = NULL;
+    }
 }
 
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 55b5243..ce1ea5d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -132,6 +132,14 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
         return false;
     }
 
+#ifdef UFFD_FEATURE_THREAD_ID
+    if (mis && UFFD_FEATURE_THREAD_ID & supported_features) {
+        /* kernel supports that feature */
+        mis->downtime_ctx = downtime_context_new();
+        new_features |= UFFD_FEATURE_THREAD_ID;
+    }
+#endif
+
     /* request features */
     if (new_features && !request_ufd_features(ufd, new_features)) {
         error_report("ufd_version_check failed: features %" PRIu64,
-- 
1.9.1
