Received: from eggs.gnu.org ([2001:4830:134:3::10]:36717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXy-00083M-7x
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXv-0001WH-6e
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  4 Jun 2018 12:20:31 +0100
Message-Id: <20180604112036.2715-7-stefanha@redhat.com>
In-Reply-To: <20180604112036.2715-1-stefanha@redhat.com>
References: <20180604112036.2715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] iscsi: Query and save device designator
 when opening
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

The device designator data returned in INQUIRY command will be useful to
fill in source/target fields during copy offloading. Do this when
connecting to the target and save the data for later use.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180601092648.24614-7-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 3fd7203916..6d0035d4b9 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -68,6 +68,7 @@ typedef struct IscsiLun {
     QemuMutex mutex;
     struct scsi_inquiry_logical_block_provisioning lbp;
     struct scsi_inquiry_block_limits bl;
+    struct scsi_inquiry_device_designator *dd;
     unsigned char *zeroblock;
     /* The allocmap tracks which clusters (pages) on the iSCSI target are
      * allocated and which are not. In case a target returns zeros for
@@ -1740,6 +1741,30 @@ static QemuOptsList runtime_opts = {
     },
 };
 
+static void iscsi_save_designator(IscsiLun *lun,
+                                  struct scsi_inquiry_device_identification *inq_di)
+{
+    struct scsi_inquiry_device_designator *desig, *copy = NULL;
+
+    for (desig = inq_di->designators; desig; desig = desig->next) {
+        if (desig->association ||
+            desig->designator_type > SCSI_DESIGNATOR_TYPE_NAA) {
+            continue;
+        }
+        /* NAA works better than T10 vendor ID based designator. */
+        if (!copy || copy->designator_type < desig->designator_type) {
+            copy = desig;
+        }
+    }
+    if (copy) {
+        lun->dd = g_new(struct scsi_inquiry_device_designator, 1);
+        *lun->dd = *copy;
+        lun->dd->next = NULL;
+        lun->dd->designator = g_malloc(copy->designator_length);
+        memcpy(lun->dd->designator, copy->designator, copy->designator_length);
+    }
+}
+
 static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
@@ -1922,6 +1947,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         struct scsi_task *inq_task;
         struct scsi_inquiry_logical_block_provisioning *inq_lbp;
         struct scsi_inquiry_block_limits *inq_bl;
+        struct scsi_inquiry_device_identification *inq_di;
         switch (inq_vpd->pages[i]) {
         case SCSI_INQUIRY_PAGECODE_LOGICAL_BLOCK_PROVISIONING:
             inq_task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 1,
@@ -1947,6 +1973,17 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
                    sizeof(struct scsi_inquiry_block_limits));
             scsi_free_scsi_task(inq_task);
             break;
+        case SCSI_INQUIRY_PAGECODE_DEVICE_IDENTIFICATION:
+            inq_task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 1,
+                                    SCSI_INQUIRY_PAGECODE_DEVICE_IDENTIFICATION,
+                                    (void **) &inq_di, errp);
+            if (inq_task == NULL) {
+                ret = -EINVAL;
+                goto out;
+            }
+            iscsi_save_designator(iscsilun, inq_di);
+            scsi_free_scsi_task(inq_task);
+            break;
         default:
             break;
         }
@@ -2003,6 +2040,10 @@ static void iscsi_close(BlockDriverState *bs)
         iscsi_logout_sync(iscsi);
     }
     iscsi_destroy_context(iscsi);
+    if (iscsilun->dd) {
+        g_free(iscsilun->dd->designator);
+        g_free(iscsilun->dd);
+    }
     g_free(iscsilun->zeroblock);
     iscsi_allocmap_free(iscsilun);
     qemu_mutex_destroy(&iscsilun->mutex);
-- 
2.17.1
