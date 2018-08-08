Received: from eggs.gnu.org ([2001:4830:134:3::10]:47101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnId4-00043n-3z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnId0-0003BX-TC
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:34 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed,  8 Aug 2018 10:10:49 +0300
Message-Id: <20180808071051.30628-4-lbloch@janustech.com>
In-Reply-To: <20180808071051.30628-1-lbloch@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/5] qcow2: Resize the cache upon image
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

The caches are now recalculated upon image resizing. This is done
because the new default behavior of assigning a sufficient L2 cache to
cover the entire image implies that the cache will still be sufficient
after an image resizing.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 98cb96aaca..f60cb92169 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3639,6 +3639,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         }
     }
 
+    bs->total_sectors = offset / BDRV_SECTOR_SIZE;
+
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
@@ -3649,6 +3651,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     s->l1_vm_state_index = new_l1_size;
+    /* Update cache sizes */
+    QDict *options = qdict_clone_shallow(bs->options);
+    ret = qcow2_update_options(bs, options, s->flags, errp);
+    if (ret < 0) {
+        goto fail;
+    }
     ret = 0;
 fail:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.17.1
