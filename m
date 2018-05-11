Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6rc-0003AZ-Co
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6rb-0003Th-FV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 11 May 2018 20:08:20 +0800
Message-Id: <20180511120823.7892-8-famz@redhat.com>
In-Reply-To: <20180511120823.7892-1-famz@redhat.com>
References: <20180511120823.7892-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/10] iscsi: Create and use
 iscsi_co_wait_for_task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

This loop is repeated a growing number times. Make a helper.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/iscsi.c | 54 +++++++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5811ff1d51..32e755c021 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -556,6 +556,17 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
                                offset / iscsilun->cluster_size) == size);
 }
 
+static void coroutine_fn iscsi_co_wait_for_task(IscsiTask *iTask,
+                                                IscsiLun *iscsilun)
+{
+    while (!iTask->complete) {
+        iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
+        qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
+    }
+}
+
 static int coroutine_fn
 iscsi_co_writev_flags(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                       QEMUIOVector *iov, int flags)
@@ -617,12 +628,7 @@ retry:
     scsi_task_set_iov_out(iTask.task, (struct scsi_iovec *) iov->iov,
                           iov->niov);
 #endif
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
@@ -693,13 +699,7 @@ retry:
         ret = -ENOMEM;
         goto out_unlock;
     }
-
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.do_retry) {
         if (iTask.task != NULL) {
@@ -863,13 +863,8 @@ retry:
 #if LIBISCSI_API_VERSION < (20160603)
     scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *) iov->iov, iov->niov);
 #endif
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
 
+    iscsi_co_wait_for_task(&iTask, iscsilun);
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
         iTask.task = NULL;
@@ -906,12 +901,7 @@ retry:
         return -ENOMEM;
     }
 
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
@@ -1143,12 +1133,7 @@ retry:
         goto out_unlock;
     }
 
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
@@ -1244,12 +1229,7 @@ retry:
         return -ENOMEM;
     }
 
-    while (!iTask.complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.status == SCSI_STATUS_CHECK_CONDITION &&
         iTask.task->sense.key == SCSI_SENSE_ILLEGAL_REQUEST &&
-- 
2.14.3
