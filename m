Received: from eggs.gnu.org ([2001:4830:134:3::10]:57693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afj-0005OF-AN
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afe-00072T-AI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d9Afe-00070o-4j
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00IELDL0FO10@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 14:31:48 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 16:31:23 +0300
Message-id: <1494595886-30912-7-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133147eucas1p1aca0281fc864bf6f3beb610e7ce2695b@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V5 6/9] migration: add postcopy vcpu blocktime
 context into MigrationIncomingState
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

This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
in case when this feature is provided by kernel.

PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,
due to it's postcopy only feature.
Also it defines PostcopyBlocktimeContext's instance live time.
Information from PostcopyBlocktimeContext instance will be provided
much after postcopy migration end, instance of PostcopyBlocktimeContext
will live till QEMU exit, but part of it (vcpu_addr,
page_fault_vcpu_time) used only during calculation, will be released
when postcopy ended or failed.

To enable postcopy blocktime calculation on destination, need to request
proper capabiltiy (Patch for documentation will at the tail of patch
set).

As an example following command enable that capability, assume qemu was
started with
-chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
option to control it

[root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
{\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
\"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h |  8 +++++
 migration/postcopy-ram.c      | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 82bbcd8..7e69a2d 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -83,6 +83,8 @@ typedef enum {
     POSTCOPY_INCOMING_END
 } PostcopyState;
 
+struct PostcopyBlocktimeContext;
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -123,6 +125,12 @@ struct MigrationIncomingState {
 
     /* See savevm.c */
     LoadStateEntry_Head loadvm_handlers;
+
+    /*
+     * PostcopyBlocktimeContext to keep information for postcopy
+     * live migration, to calculate vCPU block time
+     * */
+    struct PostcopyBlocktimeContext *blocktime_ctx;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c96d5f5..a1f1705 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -60,6 +60,73 @@ struct PostcopyDiscardState {
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+typedef struct PostcopyBlocktimeContext {
+    /* time when page fault initiated per vCPU */
+    int64_t *page_fault_vcpu_time;
+    /* page address per vCPU */
+    uint64_t *vcpu_addr;
+    int64_t total_blocktime;
+    /* blocktime per vCPU */
+    int64_t *vcpu_blocktime;
+    /* point in time when last page fault was initiated */
+    int64_t last_begin;
+    /* number of vCPU are suspended */
+    int smp_cpus_down;
+
+    /*
+     * Handler for exit event, necessary for
+     * releasing whole blocktime_ctx
+     */
+    Notifier exit_notifier;
+    /*
+     * Handler for postcopy event, necessary for
+     * releasing unnecessary part of blocktime_ctx
+     */
+    Notifier postcopy_notifier;
+} PostcopyBlocktimeContext;
+
+static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
+{
+    g_free(ctx->page_fault_vcpu_time);
+    g_free(ctx->vcpu_addr);
+    g_free(ctx->vcpu_blocktime);
+    g_free(ctx);
+}
+
+static void postcopy_migration_cb(Notifier *n, void *data)
+{
+    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
+                                               postcopy_notifier);
+    MigrationState *s = data;
+    if (migration_has_finished(s) || migration_has_failed(s)) {
+        g_free(ctx->page_fault_vcpu_time);
+        /* g_free is NULL robust */
+        ctx->page_fault_vcpu_time = NULL;
+        g_free(ctx->vcpu_addr);
+        ctx->vcpu_addr = NULL;
+    }
+}
+
+static void migration_exit_cb(Notifier *n, void *data)
+{
+    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
+                                               exit_notifier);
+    destroy_blocktime_context(ctx);
+}
+
+static struct PostcopyBlocktimeContext *blocktime_context_new(void)
+{
+    PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
+    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
+    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
+
+    ctx->exit_notifier.notify = migration_exit_cb;
+    ctx->postcopy_notifier.notify = postcopy_migration_cb;
+    qemu_add_exit_notifier(&ctx->exit_notifier);
+    add_migration_state_change_notifier(&ctx->postcopy_notifier);
+    return ctx;
+}
 
 /*
  * Check userfault fd features, to request only supported features in
@@ -134,6 +201,15 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
         return false;
     }
 
+#ifdef UFFD_FEATURE_THREAD_ID
+    if (migrate_postcopy_blocktime() && mis &&
+            UFFD_FEATURE_THREAD_ID & supported_features) {
+        /* kernel supports that feature */
+        mis->blocktime_ctx = blocktime_context_new();
+        asked_features |= UFFD_FEATURE_THREAD_ID;
+    }
+#endif
+
     /*
      * request features, even if asked_features is 0, due to
      * kernel expects UFFD_API before UFFDIO_REGISTER, per
-- 
1.9.1
