Received: from eggs.gnu.org ([2001:4830:134:3::10]:59082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYNpF-0002II-LJ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYNpE-0008B1-PA
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:10:13 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon,  8 Jan 2018 11:09:46 +0800
Message-Id: <20180108030946.14991-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

After the out label there is a check on iTask.task but it is not
initialized yet.

Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/iscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5c0a9e55b6..1cb8cc93c5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -659,8 +659,7 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
     int64_t ret;
 
     if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     /* default to all sectors allocated */
-- 
2.14.3
