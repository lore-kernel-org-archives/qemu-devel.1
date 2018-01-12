Received: from eggs.gnu.org ([2001:4830:134:3::10]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZN-00082t-LQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZK-00063f-09
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:21 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZJ-000636-Pz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:17 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so5008647wrc.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:13 +0100
Message-Id: <1515756676-3860-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 49/52] block/iscsi: fix initialization of iTask
 in iscsi_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>

From: Peter Lieven <pl@kamp.de>

in case of unaligned requests or on a target that does not support
block provisioning we leave iTask uninitialized and check iTask.task
for NULL later.

Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1515425247-21730-1-git-send-email-pl@kamp.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
