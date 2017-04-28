Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbT-0002F8-BT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbP-0001Xl-Dz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:37 +0200
Message-Id: <1493411622-5343-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 29/34] block: assert no image modification under
 BDRV_O_INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

As long as BDRV_O_INACTIVE is set, the image file is only opened so we
have a file descriptor for it. We're definitely not supposed to modify
the image, it's still owned by the migration source.

This commit is an addition to 09e0c771 but the assert() is added to
bdrv_truncate().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
Message-id: 1491405505-31620-3-git-send-email-den@openvz.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 76bf00f..6c6bb3e 100644
--- a/block.c
+++ b/block.c
@@ -3328,6 +3328,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         return -EACCES;
     }
 
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+
     ret = drv->bdrv_truncate(bs, offset, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
-- 
1.8.3.1
