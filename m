Received: from eggs.gnu.org ([2001:4830:134:3::10]:52652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d4Hz8-0007t0-UV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 22:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d4Hz6-0004xh-Fo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 22:19:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 28 Apr 2017 16:51:56 +0000
Message-ID: <DB6PR0801MB20560FFB773DDCEA6F2F070FC1130@DB6PR0801MB2056.eurprd08.prod.outlook.com>
References: <20170426113038.60044-1-vsementsov@virtuozzo.com>,
	<e0e881e2-1766-705d-4dba-bc1d69e3cfbf@redhat.com>
In-Reply-To: <e0e881e2-1766-705d-4dba-bc1d69e3cfbf@redhat.com>
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v17 00/24] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis
	Lunev <den@virtuozzo.com>

This is fixed by not fail on ! can_write() if there are no persistent BdrvD=
irtyBitmap's. But the problem is, what if we have readonly image with bitma=
ps? This should not fail. I'll have to add bool 'changed' field to BdrvDirt=
yBitmap to handle this. Or refactor all bool's to int flags

Best regards,=20
Vladimir.=20
________________________________________
=EF=D4: John Snow [jsnow@redhat.com]
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 27 =C1=D0=D2=C5=CC=D1 2017 =C7. 19:43
=EB=CF=CD=D5: Vladimir Sementsov-Ogievskiy; qemu-block@nongnu.org; qemu-dev=
el@nongnu.org
=EB=CF=D0=C9=D1: kwolf@redhat.com; famz@redhat.com; armbru@redhat.com; mrei=
tz@redhat.com; stefanha@redhat.com; pbonzini@redhat.com; Denis Lunev
=F4=C5=CD=C1: Re: [Qemu-devel] [PATCH v17 00/24] qcow2: persistent dirty bi=
tmaps

On 04/26/2017 07:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>
> There is a new update of qcow2-bitmap series - v17.
>
> web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3Dqcow2=
-bitmap-v17
> git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-v1=
7)
>

Hm, what is this branch based on? My patches tools are having trouble
finding common ancestors -- 2d6752d38d8acda6aae674a72b72be05482a58eb I
guess, but that's pre-rc0, and the histories don't quite match up.

I did a rebase myself, but I notice that patch 14/24; "qcow2: add
persistent dirty bitmaps support" causes a large number of iotest
regressions:

Failures: 007 009 010 011 012 013 014 015 017 018 019 020 022 023 024
025 026 028 029 030 031 032 034 035 037 038 039 040 041 042 043 044 046
047 048 050 051 052 053 055 056 058 060 061 062 063 065 066 073 074 080
082 086 089 090 095 097 098 102 104 110 112 114 115 117 121 122 124 129
130 132 133 138 140 141 142 150 152 154 155 156 158 159 170 176

Can you give that a look and if you respin, rebase on top of origin/master?

Thanks,
-John

> v17:
>
> 08: add r-b's by Max and John
> 09: clear unknown autoclear features from BDRVQcow2State before calling
>     qcow2_load_autoloading_dirty_bitmaps(), and also do not extra update
>     header if it is updated by qcow2_load_autoloading_dirty_bitmaps().
> 11: new patch, splitted out from 16
> 12: rewrite commit message
> 14: changing bdrv_close moved to separate new patch 11
>     s/1/1ULL/ ; s/%u/%llu/ for two errors
> 16: s/No/Not/
>     add Max's r-b
> 24: new patch
>
>
> v16:
>
> mostly by Kevin's comments:
> 07: just moved here, as preparation for merging refcounts to 08
> 08: move "qcow2-bitmap: refcounts" staff to this patch, to not break qcow=
2-img check
>     drop r-b's
>     move necessary supporting static functions to this patch too (to not =
break compilation)
>     fprintf -> error_report
>     other small changes with error messages and comments
>     code style
>     for qcow2-bitmap.c:
>       'include "exec/log.h"' was dropped
>       s/1/(1U << 0) for BME_FLAG_IN_USE
>       add BME_TABLE_ENTRY_FLAG_ALL_ONES to replace magic 1
>       don't check 'cluster_size <=3D 0' in check_table_entry
> old "[PATCH v15 08/25] block: introduce auto-loading bitmaps" was dropped
> 09: was "[PATCH v15 09/25] qcow2: add .bdrv_load_autoloading_dirty_bitmap=
s"
>     drop r-b's
>     some staff was moved to 08
>     update_header_sync - error on bdrv_flush fail
>     rename disk_sectors_in_bitmap_cluster to sectors_covered_by_bitmap_cl=
uster
>      and adjust comment.
>      so, variable for storing this function result: s/dsc/sbc/
>     s/1/BME_TABLE_ENTRY_FLAG_ALL_ONES/
>     also, as Qcow2BitmapTable already introduced in 08,
>        s/table_offset/table.offset/ and s/table_size/table.size, etc..
>     update_ext_header_and_dir_in_place: add comments, add additional
>       update_header_sync, to reduce indeterminacy in case of error.
>     call qcow2_load_autoloading_dirty_bitmaps directly from qcow2_open
>     no .bdrv_load_autoloading_dirty_bitmaps
> 11: drop bdrv_store_persistent_dirty_bitmaps at all.
>     drop r-b's
> 13: rename patch, rewrite commit msg
>     drop r-b's
>     move bdrv_release_named_dirty_bitmaps in bdrv_close() after drv->bdrv=
_close()
>     Qcow2BitmapTable is already introduced, so no
>       s/table_offset/table.offset/ and s/table_size/table.size, etc.. her=
e
>     old 25 with check_constraints_on_bitmap() improvements merged here (E=
ric)
>     like in 09, s/dsc/sbc/ and s/disk_sectors_in_bitmap_cluster/sectors_c=
overed_by_bitmap_cluster/
>     no .bdrv_store_persistent_dirty_bitmaps
>     call qcow2_store_persistent_dirty_bitmaps directly from qcow2_inactiv=
ate
> 15: corresponding part of 25 merged here. Add John's r-b, as 25 was also =
reviewed by John.
> 16: add John's r-b
>
>
> v15:
> 13,14: add John's r-b
> 15: qcow2_can_store_new_dirty_bitmap:
>       - check max dirty bitmaps and bitmap directory overhead
>       - switch to error_prepend
>     rm Max's r-b
>     not add John's r-b
> 17-24: add John's r-b
> 25: changed because 15 changed,
>     not add John's r-b
>
>
> v14:
>
> 07: use '|=3D' to update need_update_header
>     add John's r-b
>     add Max's r-b
> 09: remove unused bitmap_table_to_cpu()
>     left Max's r-b, hope it's ok
>     add John's r-b
> 10: remove extra new line
>     add John's r-b
> 11: add John's r-b
> 12: add John's r-b
> 13: small fixes by John's review:
>        - remove weird g_free of NULL pointer from
>            if (tb =3D=3D NULL) {
>                g_free(tb);
>                return -EINVAL;
>            }
>        - remove extra comment "/* errp is already set */"
>        - s/"Too large bitmap directory"/"Bitmap directory is too large"/
>     left Max's r-b, hope you don't mind
> 22: add Max's r-b
> 23: add Max's r-b
> 24: add Max's r-b
> 25: new patch to improve error message on check_constraints_on_bitmap fai=
l
>
>
> v13: Just a fix for style checker.
> 13: line over 80
> 14: line over 80
> 22: s/if () \n{/if () {/
>
> v12:
> 07: do not update header in qcow2_read_extensions, instead do it in the
>     end of qcow2_open, where it is updated also to clear unknown
>     autoclear features.
>     Wrong bdrv_is_root_node used instead of bdrv_is_read_only is fixed
>     automatically.
> 08: add Max's r-b
> 09: contextual: s/raw_bsd/raw-format/
>     qcow2-bitmap.c: copyright s/2016/2017/
>     fix compilation: move update_header_sync() to this patch
>     add Max's r-b
> 13: update_header_sync() is moved to 09
>     add Max's r-b
> 15: add Max's r-b
> 16: As qmp-commands.txt is removed from master, remove it here too.
>     Sentence "For now only Qcow2 disks support persistent bitmaps.
>      Default is false." moved to qapi/block-core.json.
>     Hope that is OK, Max's r-b is not dropped.
> 17: qmp-commands.txt deleted, r-b is not dropped too.
> 18: s/is failed/has failed/, add Max's r-b
> 19: copyright: s/2016/2017/
> 21: drop "res->corruptions > 0 =3D> ret =3D -EINVAL", add Max's r-b
> 22: actually, patch is replaced with a new one, however some parts are th=
e same.
>     instead of changing bdrv_release_dirty_bitmap behaviour, create new
>     bdrv_remove_persistent_dirty_bitmap
> 23: improve comment, about not-exists is not an error
> 24: new patch
>
> Old 24 (qcow2-bitmap: cache bitmap list in BDRVQcow2State) will be sent
> separately, to be applied after these series.
>
> Also: about bdrv_dirty_bitmap_set_persistance: I've decided not change it=
s behaviour
> for now and just call bdrv_remove_persistent_dirty_bitmap from
> qmp_block_dirty_bitmap_remove. Reasons:
> 1. Do not change reviewed part.
> 2. I'm not sure, that this complication of BdrvDirtyBitmap.persistent sem=
antics
>    is good (current semantics are just: .persistent means that bitmap sho=
uld be
>    saved on disk close). .persistent actually is not very related to "is =
there
>    stored version of the bitmap in the image".
> 3. It may be done later.
> 4. It is not actually needed for now, as the only usage is dropping bitma=
p in
>    bdrv_remove_persistent_dirty_bitmap. May be in future it will be neede=
d,
>    when we will have qmp interfaces for finer control of persistent dirty=
 bitmaps.
>
>
> v11:
>
> Fix automatic build test fail.
>
> 18: wording - "ASCII representation of SHA256 ..."
> 24: fix redeclaration error. (This is still RFC, may be not needed patch,
>     see description in v10 below).
>
> v10:
>
> 07: rm John's r-b
>     not add Max's r-b
>     fix subject s/dirty bitmaps/bitmaps
>     improve WARNING message
>     remove header ext if autoclear bit is unset, through qcow2_updata_hea=
der() - r-b blocking change
> 08: move bdrv_load_autoloading_dirty_bitmaps under asserts block (Max)
>     fix typo in commit message
>     move bdrv_load_autoloading_dirty_bitmaps after asserts
>     John's r-b
> 09: rewrite check_dir_entry
>     remove extra feature cluster_size=3D0 from check_table_entry
>     which clears autoclear bit before trying to update bitmap directory
>     bitmap_list_store - do not free old clusters if in_place=3Dtrue
>     changes in comments, fix indents
>     add functions
>       bitmap_list_count
>       update_ext_header_and_dir_in_place (unset autoclear bit before tryi=
ng to
>                                           modify bitmap directory)
>        (for usage in qcow2_load_autoloading_dirty_bitmaps)
> 11: add node name to error report
>     Max's r-b
> 13: add type Qcow2BitmapTable
>     move from bm.table_* to bm.table.*
>     rewrite check_constraints_on_bitmap
>     flush(bs->file) instead of flush(bs) in update_ext_header_and_dir
>     assert(DIV_ROUND_UP(bm_size, dsc) =3D=3D tb_size);
>       and assert(write_size <=3D s->cluster_size); in store_bitmap_data
>     fix: s/tb_size/tb_size * sizeof(tb[0]) in store_bitmap
>     in qcow2_store_persistent_dirty_bitmaps:
>       fail if !can_write
>       fix counting of new_nb_bitmaps and new_dir_size
>       free old clusters _after_ successful directory update (aggregate ol=
d bitmap
>         tables into drop_tables)
> 2 14: rename to can_store_new_dirty_bitmap
>     Max's r-b
> 15: rename to can_store_new_dirty_bitmap
>     rm extra !!
> 16: Max's r-b
>     rename to can_store_new_dirty_bitmap
>     indenting
>     Since s/2.8/2.9
> 17: Max's r-b
>     Since s/2.8/2.9
> 18: hashing can fail in comment for qapi
>     Since s/2.8/2.9
>     remove dead comment
> 19: indentation
>     Max's r-b
> 20: Max's r-b
> 21: fix error handling
>     return 0 if nb_bitmaps =3D=3D 0
> new patches:
> 22-23: remove bitmap from file on bdrv_release_dirty_bitmap
> 24: experimental, RFC: cache bitmap list to bs, to not reload it from fil=
e.
>     I'm not sure that is needed now, but if you want I can merge it to ea=
rlier
>     patches.
>
> v9:
>
> rebase on master!
>
> 01-04,06,07: John's r-b
> 03: rewording in comment ("The concurrent resetting ..."), John's r-b
> 07: reword error messages
>     commit message: dirty bitmap -> bitmap
> 09: fix uninitialized ret in bitmap_list_store() (fix compilation warning=
)
> 18: fix compilation of tests/test-hbitmap
>
> also, change constants names for qcow2: DIRTY_BITMAP -> BITMAP (as it is =
not
> dirty bitmaps extension, but just bitmaps extension), QCOW -> QCOW2 (bitm=
aps
> are only for qcow2)
>
> v8:
>
> Patches 01-06 are mostly unchanged, except for spelling and wording.
> 02 - add Eric's r-b
> 03,04 - add Max's r-b
>
> 07-09 is refactored "bitmap-read" part of the feature. Main changes:
> - introduce bitmap list - normal list, which represents bitmap directory.
>   Function bitmap_list_load loads bitmap directory, checks everything and
>   creates normal list.
> - introduce .bdrv_load_autoloading_dirty_bitmaps : instead of loading bit=
maps
>   in qcow2_open, lets load them only in bdrv_open, to avoid reloading in
>   bdrv_snapshot_goto
> - do not delete bitmaps after read, but mark them IN_USE
>
> 10 has contextual changes and rewording of comment. I've added Max's r-b,=
 hope it's ok.
>
> 11: add error_report("Persistent bitmaps are lost") in case of failed bit=
map store
>
> 12: add Max's r-b
>
> 13 is refactored "bitmap-store" part of the feature. see 07-09 descriptio=
n
> - for now I just free old clusters and allocate new. This will be improve=
d
>   with a separate patch.
>
> patch about "delete bitmaps on truncate" is removed. This case will be ha=
ndled later.
> IN_USE, autoclear, check-constraints things are merged into other patches=
.
>
> 14-15 are mew patches, to early check possibility of creating persistent =
bitmap with
>   specified name and granularity in specified BDS
>
> 16-17: spelling, rewording, indenting, tiny code simplifying, check can_s=
tore (by 14-15),
>     s/if (autoload && !persistent)/if (has_autoload && !persistent)/,
>     rebase (deleted qmp-commands.hx)
>
> 18: alternative to md5 in query-block:
>   - separated qmp command -x-debug-block-dirty-bitmap-sha256
>   - as adviced by Daniel P. Berrange in my parallel thread:
>     - sha256 instead of md5
>     - use qcrypto_hash_* instead of GChecksum
>   - fix bug =3D) (size was wrong in hbitmap_md5)
>
> 19: s/3999/3fff/, use x-debug-block-dirty-bitmap-sha256
>
> 20: new patch to rename and publish inc_refcounts
>
> 21: some fixes and refactoring mostyly by Max's comments.
>
> Max, Eric, great tanks for your review!
> I hope, I've covered most of your comments by this update.
>
> TODO:
> - handle reopening image RO->RW and incoming migration, set IN_USE for ex=
isting loaded bitmaps
>   in these cases.
> - reuse old, already allocated data clusters for bitmaps storing
> - truncate bitmaps in the image on truncate
>
>
> v7:
>
> https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3Drefs%2Ftag=
s%2Fqcow2-bitmap-v7
> based on block-next (https://github.com/XanClic/qemu/commits/block-next)
>
> - a lot of refactoring and reordering of patches.
> - dead code removed (bdrv_dirty_bitmap_load, etc.)
> - do not maintain extra data for now
> - do not store dirty bitmap directory in memory
>   (as we use it seldom, we can just reread if needed)
>
> By Kevin's review:
> 01 - commit message changed: fix->improvement (as it was not a bug)
> 03 - r-b
> 04 - r-b
> 05 - add 21 patch to fix spec, also, removed all (I hope) mentions of
>      "Bitmap Header", switch to one unified name for it - "Bitmap
>      Directory Entry", to avoid misunderstanding with Qcow2 header.
>      (also, add patch 22, to fix it in spec)
> v6.06 - improve for_each_dir_entry loop, reorder patches, other small fix=
es
> v6.07 ~> v7.09 - dead code removed, I've moved to one function
>         .bdrv_store_persistent_bitmaps and have wrapper and callback in o=
ne
>         patch (with also some other staff. If it not ok, I can split them=
)
> v6.08 - about keeping bitmap directory instead of bitmap list: no I don't=
 keep
>         it at all.
> v6.16 - old bdrv_ bitmap-storing related functions are removed. The new o=
ne is
>         bdrv_store_persistent_bitmaps.
>
>
> v6:
> https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3Drefs%2Ftag=
s%2Fqcow2-bitmap-v6
> based on block-next (https://github.com/XanClic/qemu/commits/block-next)
>
> There are a lot of changes, reorderings and additions in comparement with=
 v5.
> One principal thing: now bitmaps are removed from image after loading ins=
tead
> of marking them in_use. It is simpler and we do not need to store superfl=
uous data.
> Also, we are no more interested in command line interface to dirty bitmap=
s.
> So it is dropped.  If someone needs it I can add it later.
>
> Vladimir Sementsov-Ogievskiy (24):
>   specs/qcow2: fix bitmap granularity qemu-specific note
>   specs/qcow2: do not use wording 'bitmap header'
>   hbitmap: improve dirty iter
>   tests: add hbitmap iter test
>   block: fix bdrv_dirty_bitmap_granularity signature
>   block/dirty-bitmap: add deserialize_ones func
>   qcow2-refcount: rename inc_refcounts() and make it public
>   qcow2: add bitmaps extension
>   qcow2: autoloading dirty bitmaps
>   block/dirty-bitmap: add autoload field to BdrvDirtyBitmap
>   block: bdrv_close: release bitmaps after drv->bdrv_close
>   block: introduce persistent dirty bitmaps
>   block/dirty-bitmap: add bdrv_dirty_bitmap_next()
>   qcow2: add persistent dirty bitmaps support
>   block: add bdrv_can_store_new_dirty_bitmap
>   qcow2: add .bdrv_can_store_new_dirty_bitmap
>   qmp: add persistent flag to block-dirty-bitmap-add
>   qmp: add autoload parameter to block-dirty-bitmap-add
>   qmp: add x-debug-block-dirty-bitmap-sha256
>   iotests: test qcow2 persistent dirty bitmap
>   block/dirty-bitmap: add bdrv_remove_persistent_dirty_bitmap
>   qcow2: add .bdrv_remove_persistent_dirty_bitmap
>   qmp: block-dirty-bitmap-remove: remove persistent
>   block: release persistent bitmaps on inactivate
>
>  block.c                      |   32 +-
>  block/Makefile.objs          |    2 +-
>  block/dirty-bitmap.c         |  109 +++-
>  block/qcow2-bitmap.c         | 1384 ++++++++++++++++++++++++++++++++++++=
++++++
>  block/qcow2-refcount.c       |   59 +-
>  block/qcow2.c                |  149 ++++-
>  block/qcow2.h                |   41 ++
>  blockdev.c                   |   71 ++-
>  docs/specs/qcow2.txt         |    8 +-
>  include/block/block.h        |    3 +
>  include/block/block_int.h    |    8 +
>  include/block/dirty-bitmap.h |   22 +-
>  include/qemu/hbitmap.h       |   49 +-
>  qapi/block-core.json         |   39 +-
>  tests/Makefile.include       |    2 +-
>  tests/qemu-iotests/165       |   89 +++
>  tests/qemu-iotests/165.out   |    5 +
>  tests/qemu-iotests/group     |    1 +
>  tests/test-hbitmap.c         |   19 +
>  util/hbitmap.c               |   51 +-
>  20 files changed, 2070 insertions(+), 73 deletions(-)
>  create mode 100644 block/qcow2-bitmap.c
>  create mode 100755 tests/qemu-iotests/165
>  create mode 100644 tests/qemu-iotests/165.out
>
