Received: from eggs.gnu.org ([209.51.188.92]:44376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gzHy5-0001ND-S0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gzHy4-00022s-TB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:27:05 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 28 Feb 2019 12:26:59 +0300
Message-Id: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

When a bitmap is removed, we can clean some space on the disk. The size
of a cluster may be larger, so is the size of the bitmap that includes
many clusters. Some bitmaps can be as large as tens of megabytes.
The flag QCOW2_DISCARD_ALWAYS allows a call to the raw_co_pdiscard()
that does the actual cleaning of the image on disk, while with the flag
QCOW2_DISCARD_OTHER, a reference count of the cluster is updated only.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
v1: Discard old bitmap directories in QCOW2 image

In the first version of the patch, any call to qcow2_free_clusters() in
block/qcow2-bitmap.c was with the flag QCOW2_DISCARD_ALWAYS, even in the
cases when the cleaned space is insignificant, particularly, in case of
bitmap directories.
Discussed in the email thread with the message ID
<1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>

 block/qcow2-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3ee524d..162744e 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -202,7 +202,7 @@ static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
             continue;
         }
 
-        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_OTHER);
+        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_ALWAYS);
         bitmap_table[i] = 0;
     }
 }
-- 
1.8.3.1
