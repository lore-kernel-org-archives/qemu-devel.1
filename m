Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLp-0002LI-G7
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLk-0003CL-Oz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:59:01 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:55451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLj-00038p-Tb
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:58:56 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 17 Jan 2017 20:57:42 +0800
Message-ID: <1484657864-21708-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] COLO: fix setting checkpoint-delay not
 working properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

If we set checkpoint-delay through command 'migrate-set-parameters',
It will not take effect until we finish last sleep chekpoint-delay,
That's will be offensive espeically when we want to change its value
from an extreme big one to a proper value.

Fix it by using timer to realize checkpoint-delay.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 include/migration/colo.h      |  2 ++
 include/migration/migration.h |  5 +++++
 migration/colo.c              | 33 +++++++++++++++++++++++----------
 migration/migration.c         |  3 +++
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index e32eef4..2bbff9e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -35,4 +35,6 @@ COLOMode get_colo_mode(void);
 
 /* failover */
 void colo_do_failover(MigrationState *s);
+
+void colo_checkpoint_notify(void *opaque);
 #endif
diff --git a/include/migration/migration.h b/include/migration/migration.h
index c309d23..487ac1e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -183,6 +183,11 @@ struct MigrationState
     /* The RAMBlock used in the last src_page_request */
     RAMBlock *last_req_rb;
 
+    /* The semaphore is used to notify COLO thread to do checkpoint */
+    QemuSemaphore colo_checkpoint_sem;
+    int64_t colo_checkpoint_time;
+    QEMUTimer *colo_delay_timer;
+
     /* The last error that occurred */
     Error *error;
 };
diff --git a/migration/colo.c b/migration/colo.c
index 93c85c5..08b2e46 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -302,7 +302,7 @@ static void colo_process_checkpoint(MigrationState *s)
 {
     QIOChannelBuffer *bioc;
     QEMUFile *fb = NULL;
-    int64_t current_time, checkpoint_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    int64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     Error *local_err = NULL;
     int ret;
 
@@ -332,26 +332,21 @@ static void colo_process_checkpoint(MigrationState *s)
     qemu_mutex_unlock_iothread();
     trace_colo_vm_state_change("stop", "run");
 
+    timer_mod(s->colo_delay_timer,
+            current_time + s->parameters.x_checkpoint_delay);
+
     while (s->state == MIGRATION_STATUS_COLO) {
         if (failover_get_state() != FAILOVER_STATUS_NONE) {
             error_report("failover request");
             goto out;
         }
 
-        current_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-        if (current_time - checkpoint_time <
-            s->parameters.x_checkpoint_delay) {
-            int64_t delay_ms;
+        qemu_sem_wait(&s->colo_checkpoint_sem);
 
-            delay_ms = s->parameters.x_checkpoint_delay -
-                       (current_time - checkpoint_time);
-            g_usleep(delay_ms * 1000);
-        }
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
             goto out;
         }
-        checkpoint_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     }
 
 out:
@@ -364,14 +359,32 @@ out:
         qemu_fclose(fb);
     }
 
+    timer_del(s->colo_delay_timer);
+
     if (s->rp_state.from_dst_file) {
         qemu_fclose(s->rp_state.from_dst_file);
     }
 }
 
+void colo_checkpoint_notify(void *opaque)
+{
+    MigrationState *s = opaque;
+    int64_t next_notify_time;
+
+    qemu_sem_post(&s->colo_checkpoint_sem);
+    s->colo_checkpoint_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    next_notify_time = s->colo_checkpoint_time +
+                    s->parameters.x_checkpoint_delay;
+    timer_mod(s->colo_delay_timer, next_notify_time);
+}
+
 void migrate_start_colo_process(MigrationState *s)
 {
     qemu_mutex_unlock_iothread();
+    qemu_sem_init(&s->colo_checkpoint_sem, 0);
+    s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
+                                colo_checkpoint_notify, s);
+
     migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
     colo_process_checkpoint(s);
diff --git a/migration/migration.c b/migration/migration.c
index f498ab8..a4861da 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -895,6 +895,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
+        if (migration_in_colo_state()) {
+            colo_checkpoint_notify(s);
+        }
     }
 }
 
-- 
1.8.3.1
