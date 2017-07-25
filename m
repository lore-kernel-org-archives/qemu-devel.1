Received: from eggs.gnu.org ([2001:4830:134:3::10]:56397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1dZtAl-0008Cx-97
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1dZtAi-0002w1-3q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:18:23 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:40897)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1dZtAh-0002rB-Gy
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:18:20 -0400
From: Wang guang <wang.guang55@zte.com.cn>
Date: Wed, 26 Jul 2017 06:36:57 +0800
Message-Id: <1501022217-2783-1-git-send-email-wang.guang55@zte.com.cn>
Subject: [Qemu-devel] [PATCH] COLO: use condtion variable instead of
 semaphore in colo_checkpoint_notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Wang guang <wang.guang55@zte.com.cn>, Wang Yong <wang.yong155@zte.com.cn>

Colo_checkpoint_notify use semaphore to notify COLO thread to do checkpoint.
If x-checkpoint-delay is set to be a very small value,The semaphore will
be accumulated.Even we change x-checkpoint-delay to be a big one,the checkpoint
will continue work for a long time.So we use condtion variable instead.

Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
---
 migration/colo.c      | 19 ++++++++++++++++---
 migration/migration.h |  7 +++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a425543..617ef23 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -442,7 +442,13 @@ static void colo_process_checkpoint(MigrationState *s)
             goto out;
         }
 
-        qemu_sem_wait(&s->colo_checkpoint_sem);
+        qemu_mutex_lock(&s->colo_checkpoint_mutex);
+        while (!s->colo_checkpoint_is_signaled) {
+            qemu_cond_wait(&s->colo_checkpoint_cond,
+                          &s->colo_checkpoint_mutex);
+        }
+        s->colo_checkpoint_is_signaled = false;
+        qemu_mutex_unlock(&s->colo_checkpoint_mutex);
 
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
@@ -465,6 +471,8 @@ out:
     /* Hope this not to be too long to wait here */
     qemu_sem_wait(&s->colo_exit_sem);
     qemu_sem_destroy(&s->colo_exit_sem);
+    qemu_cond_destroy(&s->colo_checkpoint_cond);
+    qemu_mutex_destroy(&s->colo_checkpoint_mutex);
     /*
      * Must be called after failover BH is completed,
      * Or the failover BH may shutdown the wrong fd that
@@ -480,7 +488,10 @@ void colo_checkpoint_notify(void *opaque)
     MigrationState *s = opaque;
     int64_t next_notify_time;
 
-    qemu_sem_post(&s->colo_checkpoint_sem);
+    qemu_mutex_lock(&s->colo_checkpoint_mutex);
+    s->colo_checkpoint_is_signaled = true;
+    qemu_cond_signal(&s->colo_checkpoint_cond);
+    qemu_mutex_unlock(&s->colo_checkpoint_mutex);
     s->colo_checkpoint_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     next_notify_time = s->colo_checkpoint_time +
                     s->parameters.x_checkpoint_delay;
@@ -490,10 +501,12 @@ void colo_checkpoint_notify(void *opaque)
 void migrate_start_colo_process(MigrationState *s)
 {
     qemu_mutex_unlock_iothread();
-    qemu_sem_init(&s->colo_checkpoint_sem, 0);
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify, s);
 
+    qemu_cond_init(&s->colo_checkpoint_cond);
+    qemu_mutex_init(&s->colo_checkpoint_mutex);
+    s->colo_checkpoint_is_signaled = false;
     qemu_sem_init(&s->colo_exit_sem, 0);
     migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
diff --git a/migration/migration.h b/migration/migration.h
index 148c9fa..9cdfedb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -123,8 +123,11 @@ struct MigrationState
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
 
-    /* The semaphore is used to notify COLO thread to do checkpoint */
-    QemuSemaphore colo_checkpoint_sem;
+    /* The Condtion Variable is used to notify COLO thread to do checkpoint */
+    QemuMutex colo_checkpoint_mutex;
+    QemuCond colo_checkpoint_cond;
+    bool colo_checkpoint_is_signaled;
+
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
 
-- 
1.8.3.1
