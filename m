Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Ma-0000ri-Rs
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000HI-1v
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MY-0008TD-C1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id a62so6178136wmh.4
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:33 +0100
Message-Id: <1544628195-37728-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/54] block/iscsi: drop unused IscsiAIOCB->buf
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The IscsiAIOCB->buf field has not been used since commit
e49ab19fcaa617ad6cdfe1ac401327326b6a2552 ("block/iscsi: bump libiscsi
requirement to 1.9.0").  It used to be a linear buffer for old libiscsi
versions that didn't support scatter-gather.  The minimum libiscsi
version supports scatter-gather so we don't linearize buffers anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180203061621.7033-2-stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 727dee5..a4e3730 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -117,7 +117,6 @@ typedef struct IscsiAIOCB {
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
-    uint8_t *buf;
     int status;
     int64_t sector_num;
     int nb_sectors;
@@ -150,9 +149,6 @@ iscsi_bh_cb(void *p)
 
     qemu_bh_delete(acb->bh);
 
-    g_free(acb->buf);
-    acb->buf = NULL;
-
     acb->common.cb(acb->common.opaque, acb->status);
 
     if (acb->task != NULL) {
@@ -933,9 +929,6 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
 {
     IscsiAIOCB *acb = opaque;
 
-    g_free(acb->buf);
-    acb->buf = NULL;
-
     acb->status = 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
@@ -1010,7 +1003,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb->iscsilun = iscsilun;
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
-    acb->buf         = NULL;
     acb->ioh         = buf;
 
     if (req != SG_IO) {
-- 
1.8.3.1
