Received: from eggs.gnu.org ([2001:4830:134:3::10]:45264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2B-00043o-9l
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF29-0002Iq-98
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF28-0002I8-Ny
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:51 -0400
Message-Id: <20181029212501.5897-10-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 09/19] bloc/qcow2: drop dirty_bitmaps_loaded
 state variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This variable doesn't work as it should, because it is actually cleared
in qcow2_co_invalidate_cache() by memset(). Drop it, as the following
patch will introduce new behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 19 ++-----------------
 block/qcow2.h |  1 -
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index eeb72ac362..3110bb0e20 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1153,7 +1153,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
-    bool header_updated = false;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -1492,23 +1491,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (s->dirty_bitmaps_loaded) {
-        /* It's some kind of reopen. There are no known cases where we need to
-         * reload bitmaps in such a situation, so it's safer to skip them.
-         *
-         * Moreover, if we have some readonly bitmaps and we are reopening for
-         * rw we should reopen bitmaps correspondingly.
-         */
-        if (bdrv_has_readonly_bitmaps(bs) &&
-            !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
-        {
-            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
-        }
-    } else {
-        header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
-        s->dirty_bitmaps_loaded = true;
+    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
+        update_header = false;
     }
-    update_header = update_header && !header_updated;
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
diff --git a/block/qcow2.h b/block/qcow2.h
index ba430316b9..29c98d87a0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -300,7 +300,6 @@ typedef struct BDRVQcow2State {
     uint32_t nb_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
-    bool dirty_bitmaps_loaded;
 
     int flags;
     int qcow_version;
-- 
2.14.5
