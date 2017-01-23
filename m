Received: from eggs.gnu.org ([2001:4830:134:3::10]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSR-0002H7-K8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005BL-Kv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:47 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:21348 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00057K-5H
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:12 +0300
Message-Id: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 00/24] qcow2: persistent dirty bitmaps
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

There is a new update of qcow2-bitmap series - v11.

web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=qcow2-bitmap-v11
git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-v11)

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

Vladimir Sementsov-Ogievskiy (24):
  specs/qcow2: fix bitmap granularity qemu-specific note
  specs/qcow2: do not use wording 'bitmap header'
  hbitmap: improve dirty iter
  tests: add hbitmap iter test
  block: fix bdrv_dirty_bitmap_granularity signature
  block/dirty-bitmap: add deserialize_ones func
  qcow2: add bitmaps extension
  block: introduce auto-loading bitmaps
  qcow2: add .bdrv_load_autoloading_dirty_bitmaps
  block/dirty-bitmap: add autoload field to BdrvDirtyBitmap
  block: introduce persistent dirty bitmaps
  block/dirty-bitmap: add bdrv_dirty_bitmap_next()
  qcow2: add .bdrv_store_persistent_dirty_bitmaps()
  block: add bdrv_can_store_new_dirty_bitmap
  qcow2: add .bdrv_can_store_new_dirty_bitmap
  qmp: add persistent flag to block-dirty-bitmap-add
  qmp: add autoload parameter to block-dirty-bitmap-add
  qmp: add x-debug-block-dirty-bitmap-sha256
  iotests: test qcow2 persistent dirty bitmap
  qcow2-refcount: rename inc_refcounts() and make it public
  qcow2-bitmap: refcounts
  block/dirty-bitmap: deep release dirty bitmaps
  qcow2: add .bdrv_remove_persistent_dirty_bitmap
  qcow2-bitmap: cache bitmap list in BDRVQcow2State

 block.c                      |   68 ++
 block/Makefile.objs          |    2 +-
 block/dirty-bitmap.c         |   84 ++-
 block/qcow2-bitmap.c         | 1395 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c       |   59 +-
 block/qcow2.c                |  126 +++-
 block/qcow2.h                |   46 ++
 blockdev.c                   |   61 +-
 docs/qmp-commands.txt        |    7 +
 docs/specs/qcow2.txt         |    8 +-
 include/block/block.h        |    5 +
 include/block/block_int.h    |   10 +
 include/block/dirty-bitmap.h |   18 +-
 include/qemu/hbitmap.h       |   49 +-
 qapi/block-core.json         |   38 +-
 tests/Makefile.include       |    2 +-
 tests/qemu-iotests/165       |   89 +++
 tests/qemu-iotests/165.out   |    5 +
 tests/qemu-iotests/group     |    1 +
 tests/test-hbitmap.c         |   19 +
 util/hbitmap.c               |   51 +-
 21 files changed, 2079 insertions(+), 64 deletions(-)
 create mode 100644 block/qcow2-bitmap.c
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out

-- 
2.11.0
