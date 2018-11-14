Received: from eggs.gnu.org ([2001:4830:134:3::10]:33886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMpPh-0002Rr-1e
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 02:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMpPX-0001JX-VR
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gMpPV-0001Gw-9X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 02:16:26 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 14 Nov 2018 15:16:11 +0800
Message-Id: <20181114071611.5352-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] replication: Make --disable-replication compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Yanan Fu <yfu@redhat.com>, Markus Armbruster <armbru@redhat.com>

We've fixed it before like 38bb54f323 ("replication: Make
--disable-replication compile again", 2017-04-28) but it's failing
again.  So fix it again.

There could be even cleaner way to fix this but current way is the
simplest.  Let's start from simple.

CC: zhanghailiang <zhang.zhanghailiang@huawei.com>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Yanan Fu <yfu@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Reported-by: Yanan Fu <yfu@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 956ac236b7..78b64ef0cb 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -33,8 +33,10 @@
 #include "sysemu/cpus.h"
 #include "net/filter.h"
 
+#ifdef CONFIG_REPLICATION
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
+#endif
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -59,6 +61,7 @@ static bool colo_runstate_is_stopped(void)
 
 static void secondary_vm_do_failover(void)
 {
+#ifdef CONFIG_REPLICATION
     int old_state;
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
@@ -121,10 +124,14 @@ static void secondary_vm_do_failover(void)
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
@@ -165,6 +172,9 @@ static void primary_vm_do_failover(void)
 
     /* Notify COLO thread that failover work is finished */
     qemu_sem_post(&s->colo_exit_sem);
+#else
+    abort();
+#endif
 }
 
 COLOMode get_colo_mode(void)
@@ -271,6 +281,8 @@ COLOStatus *qmp_query_colo_status(Error **errp)
     return s;
 }
 
+#ifdef CONFIG_REPLICATION
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
@@ -489,9 +501,11 @@ static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
 {
     colo_checkpoint_notify(data);
 }
+#endif
 
 static void colo_process_checkpoint(MigrationState *s)
 {
+#ifdef CONFIG_REPLICATION
     QIOChannelBuffer *bioc;
     QEMUFile *fb = NULL;
     int64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
@@ -603,6 +617,9 @@ out:
     if (s->rp_state.from_dst_file) {
         qemu_fclose(s->rp_state.from_dst_file);
     }
+#else
+    abort();
+#endif
 }
 
 void colo_checkpoint_notify(void *opaque)
@@ -631,6 +648,7 @@ void migrate_start_colo_process(MigrationState *s)
     qemu_mutex_lock_iothread();
 }
 
+#ifdef CONFIG_REPLICATION
 static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
                                      Error **errp)
 {
@@ -653,9 +671,11 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
         break;
     }
 }
+#endif
 
 void *colo_process_incoming_thread(void *opaque)
 {
+#ifdef CONFIG_REPLICATION
     MigrationIncomingState *mis = opaque;
     QEMUFile *fb = NULL;
     QIOChannelBuffer *bioc = NULL; /* Cache incoming device state */
@@ -859,4 +879,7 @@ out:
 
     rcu_unregister_thread();
     return NULL;
+#else
+    abort();
+#endif
 }
-- 
2.17.1
