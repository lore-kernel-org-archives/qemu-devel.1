Received: from eggs.gnu.org ([2001:4830:134:3::10]:60367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj6-0006QM-Ka
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj2-00030p-7S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18240 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj1-0002wO-HS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:00 +0300
Message-Id: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Hi all!

There is a new update of qcow2-bitmap series - v22.

web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=qcow2-bitmap-v22
git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-v22)

v22:

Rebase on master, so changes, mostly related to new dirty bitmaps mutex:

10: - asserts now in bdrv_{re,}set_dirty_bitmap_locked functions.
    - also add assert into bdrv_undo_clear_dirty_bitmap (the only change, not related to rebase)
    - add mutex lock into bdrv_dirty_bitmap_set_readonly (as it changes bitmap list,
      so the lock should be taken)
    - return instead of go-to in qmp_block_dirty_bitmap_clear
    - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_readonly before block
      "Functions that require manual locking", move
      bdrv_dirty_bitmap_readonly and bdrv_has_readonly_bitmaps into this block
15: - add mutex lock/unlock into bdrv_dirty_bitmap_set_autoload
    - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_autoload before block
      "Functions that require manual locking", move
      bdrv_dirty_bitmap_get_autoload into this block
17: - add mutex lock/unlock into bdrv_dirty_bitmap_set_persistance
    - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_persistance before block
      "Functions that require manual locking", move 
      bdrv_dirty_bitmap_get_persistance and
      bdrv_has_changed_persistent_bitmaps into this block
18: in dirty-bitmaps.h, move bdrv_dirty_bitmap_next into block
    "Functions that require manual locking". (do not remove r-b, as it is 
    just one empty line removed before function declaration)
23: return instead of go-to in qmp_block_dirty_bitmap_add
24: return instead of go-to in qmp_block_dirty_bitmap_add
25: - return instead of go-to
    - remove aio_context_acquire/release calls
    - no aio_context parameter for block_dirty_bitmap_lookup
    - in dirty-bitmaps.h, move bdrv_dirty_bitmap_sha256 into block
        "Functions that require manual locking".
29: - return instead of go-to in qmp_block_dirty_bitmap_remove

r-b's are dropped from 10,15,17,25.

v21:

09,10: improve comment, add r-b's by Max and John
10: improve comment,k
11,12: add r-b by John
13: prepend local_err with additional info (Max), add r-b by John
14: add r-b's by Max and John
20,30: add r-b by Max


v20:

handle reopening images ro and rw.

On reopening ro: store bitmaps (storing sets 'IN_USE'=0 in the image)
and mark them readonly (set readonly flag in BlockDirtyBitmap)

After reopening rw: mark bitmaps IN_USE in the image
and unset readonly flag in BlockDirtyBitmap

09: new
10: improve comment
    add parameter 'value' to bdrv_dirty_bitmap_set_readonly
11: use new parameter of bdrv_dirty_bitmap_set_readonly
12-14, 20: new

v19:

rebased on master

05: move 'sign-off' over 'reviewed-by's
08: error_report -> error_setg in qcow2_truncate (because of rebase)
09: return EPERM in bdrv_aligned_pwritev and bdrv_co_pdiscard if there
    are readonly bitmaps. EPERM is chosen because it is already used for
    readonly image in bdrv_co_pdiscard.
    Also handle readonly bitmap in block_dirty_bitmap_clear_prepare and
    qmp_block_dirty_bitmap_clear
    Max's r-b is not added
10: fix grammar in comment
    add Max's r-b
12, 13, 15, 21: add Max's r-b
24: fix grammar in comment
25: fix grammar and wording in comment
    also, I see contextual changes in inactiavate mechanism. Hope, they do not
    affect these series.

v18:

rebased on master (sorry for v17)

08: contextual: qcow2_do_open is changed instead of qcow2_open
    rename s/need_update_header/update_header/ in qcow2_do_open, to not do it in 10
    save r-b's by Max and John
09: new patch
10: load_bitmap_data: do not clear bitmap parameter - it should be already cleared
    (it actually created before single load_bitmap_data() call)
    if some bitmaps are loaded, but we can't write the image (it is readonly
    or inactive), so we can't mark bitmaps "in use" in the image, mark
    corresponding BdrvDirtyBitmap read-only.
    change error_setg to error_setg_errno for "Can't update bitmap directory"
    no needs to rename s/need_update_header/update_header/ here, as it done in 08
13: function bdrv_has_persistent_bitmaps becomes bdrv_has_changed_persistent_bitmaps,
    to handle readonly field.
14: declaration moved to the bottom of .h, save r-b's
15: firstly check bdrv_has_changed_persistent_bitmaps and only then fail on !can_write, and then QSIMPLEQ_INIT(&drop_tables)
    skip readonly bitmaps in saving loop
18: remove '#optional', 2.9 -> 2.10, save r-b's
19: remove '#optional', 2.9 -> 2.10, save r-b's
20: 2.9 -> 2.10, save r-b's
21: add check of read-only image open, drop r-b's
24: add comment to qapi/block-core.json, that block-dirty-bitmap-add removes bitmap
    from storage. r-b's by Max and John saved


v17:
08: add r-b's by Max and John
09: clear unknown autoclear features from BDRVQcow2State before calling
    qcow2_load_autoloading_dirty_bitmaps(), and also do not extra update
    header if it is updated by qcow2_load_autoloading_dirty_bitmaps().
11: new patch, splitted out from 16
12: rewrite commit message
14: changing bdrv_close moved to separate new patch 11
    s/1/1ULL/ ; s/%u/%llu/ for two errors
16: s/No/Not/
    add Max's r-b
24: new patch


v16:

mostly by Kevin's comments:
07: just moved here, as preparation for merging refcounts to 08
08: move "qcow2-bitmap: refcounts" staff to this patch, to not break qcow2-img check
    drop r-b's
    move necessary supporting static functions to this patch too (to not break compilation)
    fprintf -> error_report
    other small changes with error messages and comments
    code style
    for qcow2-bitmap.c:
      'include "exec/log.h"' was dropped
      s/1/(1U << 0) for BME_FLAG_IN_USE
      add BME_TABLE_ENTRY_FLAG_ALL_ONES to replace magic 1
      don't check 'cluster_size <= 0' in check_table_entry
old "[PATCH v15 08/25] block: introduce auto-loading bitmaps" was dropped
09: was "[PATCH v15 09/25] qcow2: add .bdrv_load_autoloading_dirty_bitmaps"
    drop r-b's
    some staff was moved to 08
    update_header_sync - error on bdrv_flush fail
    rename disk_sectors_in_bitmap_cluster to sectors_covered_by_bitmap_cluster
     and adjust comment.
     so, variable for storing this function result: s/dsc/sbc/
    s/1/BME_TABLE_ENTRY_FLAG_ALL_ONES/
    also, as Qcow2BitmapTable already introduced in 08,
       s/table_offset/table.offset/ and s/table_size/table.size, etc..
    update_ext_header_and_dir_in_place: add comments, add additional
      update_header_sync, to reduce indeterminacy in case of error.
    call qcow2_load_autoloading_dirty_bitmaps directly from qcow2_open
    no .bdrv_load_autoloading_dirty_bitmaps
11: drop bdrv_store_persistent_dirty_bitmaps at all.
    drop r-b's
13: rename patch, rewrite commit msg
    drop r-b's
    move bdrv_release_named_dirty_bitmaps in bdrv_close() after drv->bdrv_close()
    Qcow2BitmapTable is already introduced, so no
      s/table_offset/table.offset/ and s/table_size/table.size, etc.. here
    old 25 with check_constraints_on_bitmap() improvements merged here (Eric)
    like in 09, s/dsc/sbc/ and s/disk_sectors_in_bitmap_cluster/sectors_covered_by_bitmap_cluster/
    no .bdrv_store_persistent_dirty_bitmaps
    call qcow2_store_persistent_dirty_bitmaps directly from qcow2_inactivate
15: corresponding part of 25 merged here. Add John's r-b, as 25 was also reviewed by John.
16: add John's r-b


v15:
13,14: add John's r-b
15: qcow2_can_store_new_dirty_bitmap:
      - check max dirty bitmaps and bitmap directory overhead
      - switch to error_prepend
    rm Max's r-b
    not add John's r-b
17-24: add John's r-b
25: changed because 15 changed,
    not add John's r-b


v14:

07: use '|=' to update need_update_header
    add John's r-b
    add Max's r-b
09: remove unused bitmap_table_to_cpu()
    left Max's r-b, hope it's ok
    add John's r-b
10: remove extra new line
    add John's r-b
11: add John's r-b
12: add John's r-b
13: small fixes by John's review:
       - remove weird g_free of NULL pointer from
           if (tb == NULL) {
               g_free(tb);
               return -EINVAL;
           }
       - remove extra comment "/* errp is already set */"
       - s/"Too large bitmap directory"/"Bitmap directory is too large"/
    left Max's r-b, hope you don't mind 
22: add Max's r-b
23: add Max's r-b
24: add Max's r-b
25: new patch to improve error message on check_constraints_on_bitmap fail
    

v13: Just a fix for style checker.
13: line over 80
14: line over 80
22: s/if () \n{/if () {/

v12:
07: do not update header in qcow2_read_extensions, instead do it in the
    end of qcow2_open, where it is updated also to clear unknown
    autoclear features.
    Wrong bdrv_is_root_node used instead of bdrv_is_read_only is fixed
    automatically.
08: add Max's r-b
09: contextual: s/raw_bsd/raw-format/
    qcow2-bitmap.c: copyright s/2016/2017/
    fix compilation: move update_header_sync() to this patch
    add Max's r-b
13: update_header_sync() is moved to 09
    add Max's r-b
15: add Max's r-b
16: As qmp-commands.txt is removed from master, remove it here too.
    Sentence "For now only Qcow2 disks support persistent bitmaps.
     Default is false." moved to qapi/block-core.json.
    Hope that is OK, Max's r-b is not dropped.
17: qmp-commands.txt deleted, r-b is not dropped too.
18: s/is failed/has failed/, add Max's r-b
19: copyright: s/2016/2017/
21: drop "res->corruptions > 0 => ret = -EINVAL", add Max's r-b
22: actually, patch is replaced with a new one, however some parts are the same.
    instead of changing bdrv_release_dirty_bitmap behaviour, create new
    bdrv_remove_persistent_dirty_bitmap
23: improve comment, about not-exists is not an error
24: new patch

Old 24 (qcow2-bitmap: cache bitmap list in BDRVQcow2State) will be sent
separately, to be applied after these series.

Also: about bdrv_dirty_bitmap_set_persistance: I've decided not change its behaviour
for now and just call bdrv_remove_persistent_dirty_bitmap from
qmp_block_dirty_bitmap_remove. Reasons:
1. Do not change reviewed part.
2. I'm not sure, that this complication of BdrvDirtyBitmap.persistent semantics
   is good (current semantics are just: .persistent means that bitmap should be
   saved on disk close). .persistent actually is not very related to "is there 
   stored version of the bitmap in the image".
3. It may be done later.
4. It is not actually needed for now, as the only usage is dropping bitmap in
   bdrv_remove_persistent_dirty_bitmap. May be in future it will be needed,
   when we will have qmp interfaces for finer control of persistent dirty bitmaps.


v11:

Fix automatic build test fail.

18: wording - "ASCII representation of SHA256 ..."
24: fix redeclaration error. (This is still RFC, may be not needed patch,
    see description in v10 below).

v10:

07: rm John's r-b
    not add Max's r-b
    fix subject s/dirty bitmaps/bitmaps
    improve WARNING message
    remove header ext if autoclear bit is unset, through qcow2_updata_header() - r-b blocking change
08: move bdrv_load_autoloading_dirty_bitmaps under asserts block (Max)
    fix typo in commit message
    move bdrv_load_autoloading_dirty_bitmaps after asserts
    John's r-b
09: rewrite check_dir_entry
    remove extra feature cluster_size=0 from check_table_entry
    which clears autoclear bit before trying to update bitmap directory
    bitmap_list_store - do not free old clusters if in_place=true
    changes in comments, fix indents
    add functions
      bitmap_list_count
      update_ext_header_and_dir_in_place (unset autoclear bit before trying to
                                          modify bitmap directory)
       (for usage in qcow2_load_autoloading_dirty_bitmaps)
11: add node name to error report
    Max's r-b
13: add type Qcow2BitmapTable
    move from bm.table_* to bm.table.*
    rewrite check_constraints_on_bitmap
    flush(bs->file) instead of flush(bs) in update_ext_header_and_dir
    assert(DIV_ROUND_UP(bm_size, dsc) == tb_size);
      and assert(write_size <= s->cluster_size); in store_bitmap_data
    fix: s/tb_size/tb_size * sizeof(tb[0]) in store_bitmap
    in qcow2_store_persistent_dirty_bitmaps:
      fail if !can_write 
      fix counting of new_nb_bitmaps and new_dir_size
      free old clusters _after_ successful directory update (aggregate old bitmap
        tables into drop_tables)
2 14: rename to can_store_new_dirty_bitmap
    Max's r-b
15: rename to can_store_new_dirty_bitmap
    rm extra !!
16: Max's r-b
    rename to can_store_new_dirty_bitmap
    indenting
    Since s/2.8/2.9
17: Max's r-b
    Since s/2.8/2.9
18: hashing can fail in comment for qapi
    Since s/2.8/2.9
    remove dead comment
19: indentation
    Max's r-b
20: Max's r-b
21: fix error handling
    return 0 if nb_bitmaps == 0
new patches:
22-23: remove bitmap from file on bdrv_release_dirty_bitmap
24: experimental, RFC: cache bitmap list to bs, to not reload it from file.
    I'm not sure that is needed now, but if you want I can merge it to earlier
    patches.

v9:

rebase on master!

01-04,06,07: John's r-b
03: rewording in comment ("The concurrent resetting ..."), John's r-b
07: reword error messages
    commit message: dirty bitmap -> bitmap
09: fix uninitialized ret in bitmap_list_store() (fix compilation warning)
18: fix compilation of tests/test-hbitmap

also, change constants names for qcow2: DIRTY_BITMAP -> BITMAP (as it is not
dirty bitmaps extension, but just bitmaps extension), QCOW -> QCOW2 (bitmaps
are only for qcow2)

v8:

Patches 01-06 are mostly unchanged, except for spelling and wording.
02 - add Eric's r-b
03,04 - add Max's r-b

07-09 is refactored "bitmap-read" part of the feature. Main changes:
- introduce bitmap list - normal list, which represents bitmap directory.
  Function bitmap_list_load loads bitmap directory, checks everything and
  creates normal list.
- introduce .bdrv_load_autoloading_dirty_bitmaps : instead of loading bitmaps
  in qcow2_open, lets load them only in bdrv_open, to avoid reloading in 
  bdrv_snapshot_goto
- do not delete bitmaps after read, but mark them IN_USE

10 has contextual changes and rewording of comment. I've added Max's r-b, hope it's ok.

11: add error_report("Persistent bitmaps are lost") in case of failed bitmap store

12: add Max's r-b

13 is refactored "bitmap-store" part of the feature. see 07-09 description
- for now I just free old clusters and allocate new. This will be improved
  with a separate patch.

patch about "delete bitmaps on truncate" is removed. This case will be handled later.
IN_USE, autoclear, check-constraints things are merged into other patches.

14-15 are mew patches, to early check possibility of creating persistent bitmap with
  specified name and granularity in specified BDS

16-17: spelling, rewording, indenting, tiny code simplifying, check can_store (by 14-15),
    s/if (autoload && !persistent)/if (has_autoload && !persistent)/,
    rebase (deleted qmp-commands.hx)

18: alternative to md5 in query-block:
  - separated qmp command -x-debug-block-dirty-bitmap-sha256
  - as adviced by Daniel P. Berrange in my parallel thread:
    - sha256 instead of md5
    - use qcrypto_hash_* instead of GChecksum
  - fix bug =) (size was wrong in hbitmap_md5)

19: s/3999/3fff/, use x-debug-block-dirty-bitmap-sha256

20: new patch to rename and publish inc_refcounts

21: some fixes and refactoring mostyly by Max's comments.

Max, Eric, great tanks for your review!
I hope, I've covered most of your comments by this update.

TODO:
- handle reopening image RO->RW and incoming migration, set IN_USE for existing loaded bitmaps
  in these cases.
- reuse old, already allocated data clusters for bitmaps storing
- truncate bitmaps in the image on truncate


v7:

https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=refs%2Ftags%2Fqcow2-bitmap-v7
based on block-next (https://github.com/XanClic/qemu/commits/block-next)

- a lot of refactoring and reordering of patches.
- dead code removed (bdrv_dirty_bitmap_load, etc.)
- do not maintain extra data for now
- do not store dirty bitmap directory in memory
  (as we use it seldom, we can just reread if needed)

By Kevin's review:
01 - commit message changed: fix->improvement (as it was not a bug)
03 - r-b
04 - r-b
05 - add 21 patch to fix spec, also, removed all (I hope) mentions of
     "Bitmap Header", switch to one unified name for it - "Bitmap
     Directory Entry", to avoid misunderstanding with Qcow2 header.
     (also, add patch 22, to fix it in spec)
v6.06 - improve for_each_dir_entry loop, reorder patches, other small fixes
v6.07 ~> v7.09 - dead code removed, I've moved to one function 
        .bdrv_store_persistent_bitmaps and have wrapper and callback in one
        patch (with also some other staff. If it not ok, I can split them)
v6.08 - about keeping bitmap directory instead of bitmap list: no I don't keep
        it at all.
v6.16 - old bdrv_ bitmap-storing related functions are removed. The new one is
        bdrv_store_persistent_bitmaps.


v6:
https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=refs%2Ftags%2Fqcow2-bitmap-v6
based on block-next (https://github.com/XanClic/qemu/commits/block-next)

There are a lot of changes, reorderings and additions in comparement with v5.
One principal thing: now bitmaps are removed from image after loading instead
of marking them in_use. It is simpler and we do not need to store superfluous data.
Also, we are no more interested in command line interface to dirty bitmaps.
So it is dropped.  If someone needs it I can add it later.

Vladimir Sementsov-Ogievskiy (30):
  specs/qcow2: fix bitmap granularity qemu-specific note
  specs/qcow2: do not use wording 'bitmap header'
  hbitmap: improve dirty iter
  tests: add hbitmap iter test
  block: fix bdrv_dirty_bitmap_granularity signature
  block/dirty-bitmap: add deserialize_ones func
  qcow2-refcount: rename inc_refcounts() and make it public
  qcow2: add bitmaps extension
  block/dirty-bitmap: fix comment for BlockDirtyBitmap.disabled field
  block/dirty-bitmap: add readonly field to BdrvDirtyBitmap
  qcow2: autoloading dirty bitmaps
  block: refactor bdrv_reopen_commit
  block: new bdrv_reopen_bitmaps_rw interface
  qcow2: support .bdrv_reopen_bitmaps_rw
  block/dirty-bitmap: add autoload field to BdrvDirtyBitmap
  block: bdrv_close: release bitmaps after drv->bdrv_close
  block: introduce persistent dirty bitmaps
  block/dirty-bitmap: add bdrv_dirty_bitmap_next()
  qcow2: add persistent dirty bitmaps support
  qcow2: store bitmaps on reopening image as read-only
  block: add bdrv_can_store_new_dirty_bitmap
  qcow2: add .bdrv_can_store_new_dirty_bitmap
  qmp: add persistent flag to block-dirty-bitmap-add
  qmp: add autoload parameter to block-dirty-bitmap-add
  qmp: add x-debug-block-dirty-bitmap-sha256
  iotests: test qcow2 persistent dirty bitmap
  block/dirty-bitmap: add bdrv_remove_persistent_dirty_bitmap
  qcow2: add .bdrv_remove_persistent_dirty_bitmap
  qmp: block-dirty-bitmap-remove: remove persistent
  block: release persistent bitmaps on inactivate

 block.c                      |   65 +-
 block/Makefile.objs          |    2 +-
 block/dirty-bitmap.c         |  154 ++++-
 block/io.c                   |    8 +
 block/qcow2-bitmap.c         | 1481 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c       |   59 +-
 block/qcow2.c                |  155 ++++-
 block/qcow2.h                |   43 ++
 blockdev.c                   |   73 ++-
 docs/interop/qcow2.txt       |    8 +-
 include/block/block.h        |    3 +
 include/block/block_int.h    |   14 +
 include/block/dirty-bitmap.h |   22 +-
 include/qemu/hbitmap.h       |   49 +-
 qapi/block-core.json         |   42 +-
 tests/Makefile.include       |    2 +-
 tests/qemu-iotests/165       |  105 +++
 tests/qemu-iotests/165.out   |    5 +
 tests/qemu-iotests/group     |    1 +
 tests/test-hbitmap.c         |   19 +
 util/hbitmap.c               |   51 +-
 21 files changed, 2280 insertions(+), 81 deletions(-)
 create mode 100644 block/qcow2-bitmap.c
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out

-- 
2.11.1
