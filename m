Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edZXH-0002FS-TA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edZXE-0005EP-KZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:41:07 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Jan 2018 13:41:00 +0300
Message-Id: <20180122104100.3674-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] block: maintain persistent disabled bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

To maintain load/store disabled bitmap there is new approach:

 - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
 - store enabled bitmaps as "auto" to qcow2
 - store disabled bitmaps without "auto" flag to qcow2
 - on qcow2 open load "auto" bitmaps as enabled and others
   as disabled (except in_use bitmaps)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---

v2: add John's r-b
    fix spelling

bitmaps-api and bitmaps-postcopy migrations depend on this patch, so
let's discuss (and merge if in case of consent) as soon as possible.

Reasoning:

Firstly, consider only enabled bitmaps (for now, actually, we can't
get disabled bitmap in Qemu, as block-dirty-bitmap-enable command
is not merged yet).

We (Virtuozzo) always use persistent=true and autoload=true. As, to
maintain dirty bitmap (enabled) valid, we must to load it every time,
when we load our disk for r/w, to track disk changes. I do not think,
that something like "not loading enabled dirty bitmaps, when open disk
for read-only" gives real benefits (and now it is not possible,
anyway, as loading depends on qcow2 bitmap "auto" flag, not on r-w
mode).

So, this flag is useless for now. Moreover, if we save bitmap with
autoload=false, it will not be loaded next time, and will become
invalid on first write to the disk. Creating bitmap with flags
"persistent=true, autoload=false", actually means "make it disabled
after storing" (weird semantic, isn't it?), so it will not be
automatically updated more. So, this flag is a bit dangerous.

Let's move to disabled bitmaps. Assume, that my patches will be
merged, and we will really have a possibility of enable/disable
bitmaps when we want. So, it's natural to expect, that if we have
persistent-enabled bitmaps and persistent-disabled bitmaps, then
enabled one will be enabled on next Qemu start and disabled will be
disabled.

How to achieve this?

Let's start from qcow2. We need a stored information on "is this
bitmap enabled or not". But we actually have it. Let's look on qcow2
"auto" flag definiton:
1: auto
   The bitmap must reflect all changes of the virtual
   disk by any application that would write to this qcow2
   file (including writes, snapshot switching, etc.). The
   type of this bitmap must be 'dirty tracking bitmap'.

Isn't it a definition of "enabled" bitmap?
And yes, current mapping from qapi flag "autoload" to qcow2 flag
"auto" is not good mapping.

So, it looks ok, to map !BdrvDirtyBitmap.disabled to "auto". If we
have in future some bitmaps in qcow2, which are not enabled and
not disabled (something more complicated), we can introduce new flags
or even new bitmap type.
(from qcow2 spec):
16:    type
       This field describes the sort of the bitmap.
       Values:
         1: Dirty tracking bitmap

       Values 0, 2 - 255 are reserved.
So, it looks like we _do not need_ qcow2 format changing for now. It
already maintain enabled (auto=true) and disabled (auto=false) bitmaps
(may be, additional note in spec about mapping of this flag in Qemu
will be not bad)

And actually, we do not have anything about "load this bitmap or not"
in qcow2.  And I do not think that we need. Qemu (and user) should
decide, which bitmaps to load. (and it is obvious, that we must load
"auto" bitmaps, to not break them)

Then about qapi. What will occur, if we store
disabled-persistent-autolading bitmap? It will be enabled on next
Qemu start! And it shows that mapping "autoload"->"auto" is definitely
bad. So, as we do not want information on "load or not the bitmap" in
qcow2 (ok, I don't want, but I think Kevin and Max will agree, as it
keeps qcow2 format more generic and separated from Qemu specifics), we
see again, that "autoload" is useless, dangerous and wrong.

If we agreed, that for now auto = !BdrvDirtyBitmap.disabled and
"autoload" is deprecated, we need to decide, which disabled bitmaps we
want to load.

The simplest way to solve the problem is to load all bitmaps, mapping
BdrvDirtyBitmap.disabled = !auto. In future, if we need, we'll be able
to introduce some cmd-line flags to select disabled bitmaps for
loading or separate qmp-command to load them (and do not load them on
start).

Or we can go another way, and continue loading all disabled bitmaps,
but in "lazy mode", so bitmap is not actually loaded, only its name
and some metadata. And we can actually load it, if user enables or
exports it. It looks very interesting approach, as we do not lose RAM
on (possibly) a lot of not needed bitmaps, but we can manage them (for
example, remove).

Any way, loading all bitmaps looks like a good start.

 qapi/block-core.json         |  6 +++---
 block/qcow2.h                |  2 +-
 include/block/dirty-bitmap.h |  1 -
 block/dirty-bitmap.c         | 18 ------------------
 block/qcow2-bitmap.c         | 12 +++++++-----
 block/qcow2.c                |  2 +-
 blockdev.c                   | 10 ++--------
 7 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a6881b2..a3fffeac19 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1593,9 +1593,9 @@
 #              Qcow2 disks support persistent bitmaps. Default is false for
 #              block-dirty-bitmap-add. (Since: 2.10)
 #
-# @autoload: the bitmap will be automatically loaded when the image it is stored
-#            in is opened. This flag may only be specified for persistent
-#            bitmaps. Default is false for block-dirty-bitmap-add. (Since: 2.10)
+# @autoload: ignored and deprecated since 2.12.
+#            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
+#            open.
 #
 # Since: 2.4
 ##
diff --git a/block/qcow2.h b/block/qcow2.h
index 46c8cf44ec..016e87c81a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -663,7 +663,7 @@ void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
-bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a591c27213..89dc50946b 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -65,7 +65,6 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
-void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 7879d13ddb..909f0517f8 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -52,8 +52,6 @@ struct BdrvDirtyBitmap {
                                    Such operations must fail and both the image
                                    and this bitmap must remain unchanged while
                                    this flag is set. */
-    bool autoload;              /* For persistent bitmaps: bitmap must be
-                                   autoloaded on image opening */
     bool persistent;            /* bitmap must be saved to owner disk image */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
@@ -104,7 +102,6 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     g_free(bitmap->name);
     bitmap->name = NULL;
     bitmap->persistent = false;
-    bitmap->autoload = false;
 }
 
 /* Called with BQL taken.  */
@@ -261,8 +258,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
-    successor->autoload = bitmap->autoload;
-    bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
 }
 
 /* Called with BQL taken. */
-void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
-{
-    qemu_mutex_lock(bitmap->mutex);
-    bitmap->autoload = autoload;
-    qemu_mutex_unlock(bitmap->mutex);
-}
-
-bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
-{
-    return bitmap->autoload;
-}
-
-/* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
 {
     qemu_mutex_lock(bitmap->mutex);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f45e46cfbd..ae14464de6 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -933,14 +933,14 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
-/* qcow2_load_autoloading_dirty_bitmaps()
+/* qcow2_load_dirty_bitmaps()
  * Return value is a hint for caller: true means that the Qcow2 header was
  * updated. (false doesn't mean that the header should be updated by the
  * caller, it just means that updating was not needed or the image cannot be
  * written to).
  * On failure the function returns false.
  */
-bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
@@ -960,14 +960,16 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if ((bm->flags & BME_FLAG_AUTO) && !(bm->flags & BME_FLAG_IN_USE)) {
+        if (!(bm->flags & BME_FLAG_IN_USE)) {
             BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
             if (bitmap == NULL) {
                 goto fail;
             }
 
+            if (!(bm->flags & BME_FLAG_AUTO)) {
+                bdrv_disable_dirty_bitmap(bitmap);
+            }
             bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
                     g_slist_append(created_dirty_bitmaps, bitmap);
@@ -1369,7 +1371,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             bm->table.size = 0;
             QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
         }
-        bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
+        bm->flags = bdrv_dirty_bitmap_enabled(bitmap) ? BME_FLAG_AUTO : 0;
         bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
         bm->dirty_bitmap = bitmap;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c0c5..47df95b416 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1450,7 +1450,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
+    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
         update_header = false;
     }
     if (local_err != NULL) {
diff --git a/blockdev.c b/blockdev.c
index 29d569a24e..79aab74d27 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2805,14 +2805,9 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     if (!has_persistent) {
         persistent = false;
     }
-    if (!has_autoload) {
-        autoload = false;
-    }
 
-    if (has_autoload && !persistent) {
-        error_setg(errp, "Autoload flag must be used only for persistent "
-                         "bitmaps");
-        return;
+    if (has_autoload) {
+        warn_report("Autoload option is deprecated and its value is ignored");
     }
 
     if (persistent &&
@@ -2827,7 +2822,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
-    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
-- 
2.11.1
