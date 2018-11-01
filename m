Received: from eggs.gnu.org ([2001:4830:134:3::10]:48977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gI2TQ-0003Cc-B3
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 22:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gI2TN-0001Fo-7e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 22:12:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:47011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gI2TN-0001F1-00
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 22:12:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id c13-v6so313048plz.13
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 19:12:36 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  1 Nov 2018 10:12:26 +0800
Message-Id: <20181101021226.6353-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Thomas Huth <thuth@redhat.com>

This compilation issue will occur when user use --disable-replication
to config Qemu.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 migration/colo.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index 956ac236b7..fcff04c78c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -59,6 +59,8 @@ static bool colo_runstate_is_stopped(void)
 
 static void secondary_vm_do_failover(void)
 {
+/* COLO needs enable block-replication */
+#ifdef CONFIG_REPLICATION
     int old_state;
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
@@ -121,10 +123,14 @@ static void secondary_vm_do_failover(void)
     if (mis->migration_incoming_co) {
         qemu_coroutine_enter(mis->migration_incoming_co);
     }
+#else
+    abort();
+#endif
 }
 
 static void primary_vm_do_failover(void)
 {
+#ifdef CONFIG_REPLICATION
     MigrationState *s = migrate_get_current();
     int old_state;
     Error *local_err = NULL;
@@ -165,6 +171,9 @@ static void primary_vm_do_failover(void)
 
     /* Notify COLO thread that failover work is finished */
     qemu_sem_post(&s->colo_exit_sem);
+#else
+    abort();
+#endif
 }
 
 COLOMode get_colo_mode(void)
@@ -415,11 +424,16 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
     qemu_mutex_lock_iothread();
+
+#ifdef CONFIG_REPLICATION
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
 
     colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &local_err);
     if (local_err) {
@@ -523,11 +537,15 @@ static void colo_process_checkpoint(MigrationState *s)
     object_unref(OBJECT(bioc));
 
     qemu_mutex_lock_iothread();
+#ifdef CONFIG_REPLICATION
     replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
 
     vm_start();
     qemu_mutex_unlock_iothread();
@@ -690,11 +708,15 @@ void *colo_process_incoming_thread(void *opaque)
     object_unref(OBJECT(bioc));
 
     qemu_mutex_lock_iothread();
+#ifdef CONFIG_REPLICATION
     replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
     vm_start();
     trace_colo_vm_state_change("stop", "run");
     qemu_mutex_unlock_iothread();
@@ -785,18 +807,22 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+#ifdef CONFIG_REPLICATION
         replication_get_error_all(&local_err);
         if (local_err) {
             qemu_mutex_unlock_iothread();
             goto out;
         }
+
         /* discard colo disk buffer */
         replication_do_checkpoint_all(&local_err);
         if (local_err) {
             qemu_mutex_unlock_iothread();
             goto out;
         }
-
+#else
+        abort();
+#endif
         /* Notify all filters of all NIC to do checkpoint */
         colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
 
-- 
2.17.1
