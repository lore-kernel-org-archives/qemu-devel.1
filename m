Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQde-0003ZY-9d
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002zA-5y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002yn-1e
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:12 +0100
Message-Id: <20180425200326.72337-3-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 02/16] migration: add postcopy blocktime ctx
 into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Alexey Perevalov <a.perevalov@samsung.com>

This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID, in
case this feature is provided by kernel.

PostcopyBlocktimeContext is encapsulated inside postcopy-ram.c,
due to it being a postcopy-only feature.
Also it defines PostcopyBlocktimeContext's instance live time.
Information from PostcopyBlocktimeContext instance will be provided
much after postcopy migration end, instance of PostcopyBlocktimeContext
will live till QEMU exit, but part of it (vcpu_addr,
page_fault_vcpu_time) used only during calculation, will be released
when postcopy ended or failed.

To enable postcopy blocktime calculation on destination, need to
request proper compatibility (Patch for documentation will be at the
tail of the patch set).

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1521742647-25550-3-git-send-email-a.perevalov@samsung.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.h    |  8 ++++++
 migration/postcopy-ram.c | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 46a50bc789..6d9aaeb480 100644
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
@@ -65,6 +67,12 @@ struct MigrationIncomingState {
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
index 4a0b33b373..eddba05b57 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -90,6 +90,54 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+typedef struct PostcopyBlocktimeContext {
+    /* time when page fault initiated per vCPU */
+    uint32_t *page_fault_vcpu_time;
+    /* page address per vCPU */
+    uintptr_t *vcpu_addr;
+    uint32_t total_blocktime;
+    /* blocktime per vCPU */
+    uint32_t *vcpu_blocktime;
+    /* point in time when last page fault was initiated */
+    uint32_t last_begin;
+    /* number of vCPU are suspended */
+    int smp_cpus_down;
+    uint64_t start_time;
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
+    ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
+    ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->vcpu_blocktime = g_new0(uint32_t, smp_cpus);
+
+    ctx->exit_notifier.notify = migration_exit_cb;
+    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    qemu_add_exit_notifier(&ctx->exit_notifier);
+    return ctx;
+}
 
 /**
  * receive_ufd_features: check userfault fd features, to request only supported
@@ -182,6 +230,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
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
2.17.0
