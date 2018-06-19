Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVLTB-0007i3-HQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVLTA-0005ZR-Em
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:35:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 19 Jun 2018 21:34:52 +0300
Message-Id: <20180619183457.371081-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180619183457.371081-1-vsementsov@virtuozzo.com>
References: <20180619183457.371081-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/7] block/qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
unpredicted amount of memory on corrupted table entries, which are
referencing regions far beyond the end of file.

Prevent this, by skipping such regions from further processing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f9d095aa2d..28d21bedc3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1505,6 +1505,14 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
         return 0;
     }
 
+    if (offset + size - bdrv_getlength(bs->file->bs) > s->cluster_size) {
+        fprintf(stderr, "ERROR: counting reference for region exceeding the "
+                "end of the file by more than one cluster: offset 0x%" PRIx64
+                " size 0x%" PRIx64 "\n", offset, size);
+        res->corruptions++;
+        return 0;
+    }
+
     start = start_of_cluster(s, offset);
     last = start_of_cluster(s, offset + size - 1);
     for(cluster_offset = start; cluster_offset <= last;
-- 
2.11.1
