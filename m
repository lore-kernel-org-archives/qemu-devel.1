Received: from eggs.gnu.org ([2001:4830:134:3::10]:57808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0002Uf-Sd
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rA-0007HT-8s
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:55 +0200
Message-Id: <20181001171901.11004-18-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/23] qcow2: Resize the cache upon image
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

The caches are now recalculated upon image resizing. This is done
because the new default behavior of assigning L2 cache relatively to
the image size, implies that the cache will be adapted accordingly
after an image resize.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 589f6c1b1c..20b5093269 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3418,6 +3418,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     uint64_t old_length;
     int64_t new_l1_size;
     int ret;
+    QDict *options;
 
     if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA &&
         prealloc != PREALLOC_MODE_FALLOC && prealloc != PREALLOC_MODE_FULL)
@@ -3642,6 +3643,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         }
     }
 
+    bs->total_sectors = offset / BDRV_SECTOR_SIZE;
+
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
@@ -3652,6 +3655,14 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     s->l1_vm_state_index = new_l1_size;
+
+    /* Update cache sizes */
+    options = qdict_clone_shallow(bs->options);
+    ret = qcow2_update_options(bs, options, s->flags, errp);
+    qobject_unref(options);
+    if (ret < 0) {
+        goto fail;
+    }
     ret = 0;
 fail:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.13.6
