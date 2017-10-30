Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99w3-0002GP-9I
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99vx-00045I-8y
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1e99vw-00043W-VJ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:53 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 30 Oct 2017 16:16:26 +0300
Message-id: <1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p1b5fb0616e683e78fdca767d267400f50@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v12 2/6] migration: add postcopy blocktime ctx
 into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, quintela@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

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
proper capabiltiy (Patch for documentation will be at the tail of the patch
set).

As an example following command enable that capability, assume QEMU was
started with
-chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
option to control it

[root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
{\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
\"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock

Or just with HMP
(qemu) migrate_set_capability postcopy-blocktime on

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/migration.h    |  8 +++++++
 migration/postcopy-ram.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 5f5e527..fb8d2ef 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -22,6 +22,8 @@
 #include "hw/qdev.h"
 #include "io/channel.h"
 
+struct PostcopyBlocktimeContext;
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -59,6 +61,12 @@ struct MigrationIncomingState {
     /* The coroutine we should enter (back) after failover */
     Coroutine *migration_incoming_co;
     QemuSemaphore colo_incoming_sem;
+
+    /*
+     * PostcopyBlocktimeContext to keep information for postcopy
+     * live migration, to calculate vCPU block time
+     * */
+    struct PostcopyBlocktimeContext *blocktime_ctx;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index bec6c2c..c18ec5a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -61,6 +61,52 @@ struct PostcopyDiscardState {
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
+static void migration_exit_cb(Notifier *n, void *data)
+{
+    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
+                                                 exit_notifier);
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
+    qemu_add_exit_notifier(&ctx->exit_notifier);
+    return ctx;
+}
 
 /**
  * receive_ufd_features: check userfault fd features, to request only supported
@@ -153,6 +199,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
         }
     }
 
+#ifdef UFFD_FEATURE_THREAD_ID
+    if (migrate_postcopy_blocktime() && mis &&
+        UFFD_FEATURE_THREAD_ID & supported_features) {
+        /* kernel supports that feature */
+        /* don't create blocktime_context if it exists */
+        if (!mis->blocktime_ctx) {
+            mis->blocktime_ctx = blocktime_context_new();
+        }
+
+        asked_features |= UFFD_FEATURE_THREAD_ID;
+    }
+#endif
+
     /*
      * request features, even if asked_features is 0, due to
      * kernel expects UFFD_API before UFFDIO_REGISTER, per
-- 
2.7.4
