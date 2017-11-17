Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCg-0001QW-22
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCf-0002XP-7l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:45 +0100
Message-Id: <20171117181653.20651-18-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/25] qcow2: reject unaligned offsets in write
 compressed
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

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Misaligned compressed write is not supported.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index f2731a7cb5..811b913233 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3358,6 +3358,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
     }
 
+    if (offset_into_cluster(s, offset)) {
+        return -EINVAL;
+    }
+
     buf = qemu_blockalign(bs, s->cluster_size);
     if (bytes != s->cluster_size) {
         if (bytes > s->cluster_size ||
-- 
2.13.6
