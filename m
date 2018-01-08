Received: from eggs.gnu.org ([2001:4830:134:3::10]:35020)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eYZL0-0000JF-It
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eYZKw-0004nP-L2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:27:46 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:57327 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eYZKw-0004m6-Cf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:27:42 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Mon, 8 Jan 2018 16:27:36 +0100
From: Peter Lieven <pl@kamp.de>
Date: Mon,  8 Jan 2018 16:27:27 +0100
Message-Id: <1515425247-21730-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] block/iscsi: fix initialization of iTask in
 iscsi_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

in case of unaligned requests or on a target that does not support
block provisioning we leave iTask uninitialized and check iTask.task
for NULL later.

Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/iscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5c0a9e5..6a1c537 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -658,6 +658,8 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
     uint64_t lba;
     int64_t ret;
 
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+
     if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
         ret = -EINVAL;
         goto out;
@@ -675,7 +677,6 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
 
     lba = sector_qemu2lun(sector_num, iscsilun);
 
-    iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
-- 
1.9.1
