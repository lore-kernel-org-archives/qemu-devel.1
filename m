Received: from eggs.gnu.org ([2001:4830:134:3::10]:36738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXz-00084c-DZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXy-0001XW-CY
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  4 Jun 2018 12:20:32 +0100
Message-Id: <20180604112036.2715-8-stefanha@redhat.com>
In-Reply-To: <20180604112036.2715-1-stefanha@redhat.com>
References: <20180604112036.2715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] iscsi: Create and use
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

This loop is repeated a growing number times. Make a helper.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180601092648.24614-8-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 54 ++++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6d0035d4b9..6a365cb07b 100644
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
 iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
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
2.17.1
