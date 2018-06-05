Received: from eggs.gnu.org ([2001:4830:134:3::10]:40041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDsp-00085A-BP
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDso-0003pR-CC
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:27 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fQDso-0003pF-53
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:26 -0400
Received: by mail-pl0-x243.google.com with SMTP id 31-v6so1733848plc.4
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:28:26 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Tue,  5 Jun 2018 23:28:02 +0800
Message-Id: <1528212489-19137-4-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v5 03/10] migration: avoid concurrent invoke
 channel_close by different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, galsha@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The channel_close maybe invoked by different threads. For example, source
qemu invokes qemu_fclose in main thread, migration thread and return path
thread. Destination qemu invokes qemu_fclose in main thread, listen thread
and COLO incoming thread.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/migration.c | 2 ++
 migration/migration.h | 7 +++++++
 migration/qemu-file.c | 6 ++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9..1d0aaec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3075,6 +3075,7 @@ static void migration_instance_finalize(Object *obj)
 
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
+    qemu_mutex_destroy(&ms->qemu_file_close_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
@@ -3115,6 +3116,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
+    qemu_mutex_init(&ms->qemu_file_close_lock);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 5af57d6..7a6025a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -121,6 +121,13 @@ struct MigrationState
      */
     QemuMutex qemu_file_lock;
 
+    /*
+     * The to_src_file and from_dst_file point to one QIOChannelRDMA,
+     * And qemu_fclose maybe invoked by different threads. use this lock
+     * to avoid concurrent invoke channel_close by different threads.
+     */
+    QemuMutex qemu_file_close_lock;
+
     /* bytes already send at the beggining of current interation */
     uint64_t iteration_initial_bytes;
     /* time at the start of current iteration */
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae..74c48e0 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -323,12 +323,14 @@ void qemu_update_position(QEMUFile *f, size_t size)
  */
 int qemu_fclose(QEMUFile *f)
 {
-    int ret;
+    int ret, ret2;
     qemu_fflush(f);
     ret = qemu_file_get_error(f);
 
     if (f->ops->close) {
-        int ret2 = f->ops->close(f->opaque);
+        qemu_mutex_lock(&migrate_get_current()->qemu_file_close_lock);
+        ret2 = f->ops->close(f->opaque);
+        qemu_mutex_unlock(&migrate_get_current()->qemu_file_close_lock);
         if (ret >= 0) {
             ret = ret2;
         }
-- 
1.8.3.1
