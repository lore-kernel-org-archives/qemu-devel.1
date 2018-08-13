Received: from eggs.gnu.org ([2001:4830:134:3::10]:44550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fP-1M
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lh-0001jY-DN
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:27 +0300
Message-Id: <20180813010729.4844-7-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 6/8] qcow2: Resize the cache upon image
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
because the new default behavior of assigning L2 cache relatively to
the image size, implies that the cache will be adapted accordingly
after an image resize.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 01c39c56c0..1445cd5360 100644
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
@@ -3652,6 +3655,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     s->l1_vm_state_index = new_l1_size;
+
+    /* Update cache sizes */
+    options = qdict_clone_shallow(bs->options);
+    ret = qcow2_update_options(bs, options, s->flags, errp);
+    if (ret < 0) {
+        goto fail;
+    }
     ret = 0;
 fail:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.17.1
