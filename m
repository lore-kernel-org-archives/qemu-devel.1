Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f83P5-00009h-Tm
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f83P4-0008JN-Tj
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:38:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 14:38:21 +0200
Message-Id: <20180416123822.11744-2-mreitz@redhat.com>
In-Reply-To: <20180416123822.11744-1-mreitz@redhat.com>
References: <20180416123822.11744-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] qcow2: try load bitmaps only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Checking reopen by existence of some bitmaps is wrong, as it may be
some other bitmaps, or on the other hand, user may remove bitmaps. This
criteria is bad. To simplify things and make behavior more predictable
let's just add a flag to remember, that we've already tried to load
bitmaps on open and do not want do it again.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180411122606.367301-2-vsementsov@virtuozzo.com
[mreitz: Changed comment wording according to Eric Blake's suggestion]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h |  1 +
 block/qcow2.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index d301f77cea..adf5c3950f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -298,6 +298,7 @@ typedef struct BDRVQcow2State {
     uint32_t nb_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
+    bool dirty_bitmaps_loaded;
 
     int flags;
     int qcow_version;
diff --git a/block/qcow2.c b/block/qcow2.c
index 486f3e83b7..ef68772aca 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1142,6 +1142,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
+    bool header_updated = false;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -1480,10 +1481,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (bdrv_dirty_bitmap_next(bs, NULL)) {
-        /* It's some kind of reopen with already existing dirty bitmaps. There
-         * are no known cases where we need loading bitmaps in such situation,
-         * so it's safer don't load them.
+    if (s->dirty_bitmaps_loaded) {
+        /* It's some kind of reopen. There are no known cases where we need to
+         * reload bitmaps in such a situation, so it's safer to skip them.
          *
          * Moreover, if we have some readonly bitmaps and we are reopening for
          * rw we should reopen bitmaps correspondingly.
@@ -1491,13 +1491,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         if (bdrv_has_readonly_bitmaps(bs) &&
             !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
         {
-            bool header_updated = false;
             qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
-            update_header = update_header && !header_updated;
         }
-    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
-        update_header = false;
+    } else {
+        header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
+        s->dirty_bitmaps_loaded = true;
     }
+    update_header = update_header && !header_updated;
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
-- 
2.14.3
