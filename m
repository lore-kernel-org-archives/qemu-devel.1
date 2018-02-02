Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehihQ-00042T-0T
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehihP-0000Kb-4r
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:16:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  2 Feb 2018 22:16:26 +0100
Message-Id: <20180202211628.3661-2-stefanha@redhat.com>
In-Reply-To: <20180202211628.3661-1-stefanha@redhat.com>
References: <20180202211628.3661-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] block/iscsi: drop unused IscsiAIOCB->buf
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The IscsiAIOCB->buf field has not been used since commit
e49ab19fcaa617ad6cdfe1ac401327326b6a2552 ("block/iscsi: bump libiscsi
requirement to 1.9.0").  It used to be a linear buffer for old libiscsi
versions that didn't support scatter-gather.  The minimum libiscsi
version supports scatter-gather so we don't linearize buffers anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6a1c53711a..cd0738942c 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -112,7 +112,6 @@ typedef struct IscsiAIOCB {
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
-    uint8_t *buf;
     int status;
     int64_t sector_num;
     int nb_sectors;
@@ -145,9 +144,6 @@ iscsi_bh_cb(void *p)
 
     qemu_bh_delete(acb->bh);
 
-    g_free(acb->buf);
-    acb->buf = NULL;
-
     acb->common.cb(acb->common.opaque, acb->status);
 
     if (acb->task != NULL) {
@@ -925,9 +921,6 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
 {
     IscsiAIOCB *acb = opaque;
 
-    g_free(acb->buf);
-    acb->buf = NULL;
-
     acb->status = 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
@@ -1002,7 +995,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb->iscsilun = iscsilun;
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
-    acb->buf         = NULL;
     acb->ioh         = buf;
 
     if (req != SG_IO) {
-- 
2.14.3
