Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D0B-0006N7-BO
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006cd-Lk
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:32:55 +0300
Message-Id: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 00/14] Dirty bitmaps postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Hi all!

There is a new version of dirty bitmap postcopy migration series.

v8

clone: tag postcopy-v8 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v8

- rebased on master
- patches 01-03 from v7 are already merged to master
- patch order is changed to make it possible to merge block/dirty-bitmap patches
  in separate if is needed
01: new patch
03: fixed to use _locked version of bdrv_release_dirty_bitmap
06: qapi-schema.json -> qapi/migration.json
    2.9 -> 2.11
10: protocol changed a bit:
  instead of 1 byte "bitmap enabled flag" this byte becomes just "flags"
  and have "enabled", "persistent" and "autoloading" flags inside.
  also, make all migrated bitmaps to be not persistent (to prevent their
  storing on source vm)
14: new patch


patches status:
01-04 - are only about block/dirty-bitmap and have no r-b. Fam, John, Paolo (about bitmap lock),
    please look at. These patches are ok to be merged in separate (but before 05-14)
other patches are about migration
05-09 has Juan's r-b (and some of them has John's and Eric's r-bs)
10 - the main patch (dirty bitmaps migration), has no r-b.
11 - preparation for tests, not related to migration directly, has Max's r-b, ok to be merged
    separately (but before 12-14)
12-14 - tests, 12 and 13 have Max's r-b, 14 is new


v7

clone: tag postcopy-v7 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v7

- rebased on dirty-bitmap byte-based interfaces
    (based on git://repo.or.cz/qemu/ericb.git branch nbd-byte-dirty-v4)
- migration of persistent bitmaps should fail for shared storage migration for now,
  as persistent dirty bitmaps are stored/load on inactivate/invalidate-cache.
  also, even for non-shared storage migration there would be useless saving of dirty
  bitmaps on source. This all will be optimized later.

01: staff from include/migration/vmstate.h moved to include/migration/register.h (rebase)
03: some structural changes due to rebase - drop r-b
04: staff from include/migration/vmstate.h moved to include/migration/register.h (rebase)
    staff from include/sysemu/sysemu.h moved to migration/savevm.h (rebase)
05: fix patch header: block -> block/dirty-bitmap
    add locking, drop r-b
06: staff from include/migration/migration.h moved to migration/migration.h (rebase)
07: add locking, drop r-b
09: staff from include/migration/qemu-file.h moved to migration/qemu-file.h (rebase)
10: staff from include/migration/vmstate.h moved to include/migration/register.h (rebase)
11: new patch
12: a lot of changes/fixes (mostly by Fam's comments) + rebase
    header-definition movement
    remove include <assert.h>
    add some includes
    fix/refactor bitmap flags send
    byte-based interface for dirty bitmaps (rebase)
    froze bitmaps on source
    init_dirty_bitmap_migration can return error, if some of bitmaps are already
      frozen
    bdrv_ref drives with bitmaps
    fprintf -> error_report
    check version_id in _load function

v6:

clone: tag postcopy-v6 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v6

rebase on master.

03 - tiny contextual change

12 - little change, but it should be reviewed. Call of init_dirty_bitmap_incoming_migration()
    (which only initialize mutex) moved from start of process_incoming_migration_co (it was
    immediately after "mis = migration_incoming_state_new(f)") to migration_incoming_get_current()
    to stay with initialization code.
    I remove r-b's, but hope that this will not be a problem. The only change in this patch - is moved
    call of init_dirty_bitmap_incoming_migration.
    I do so because of recent

commit b4b076daf324894dd288cbdb67ff1e3c7434df7b
Author: Juan Quintela <quintela@redhat.com>
Date:   Mon Jan 23 22:32:06 2017 +0100

    migration: create Migration Incoming State at init time

15 - add Max's r-b

v5:

clone: tag postcopy-v5 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v5

- move 'signed-off' over 'reviewed-by' in patches.

03,04 - add comments. Hope they will be ok for you, so add Juan's r-b.
    If not ok - let me know and I'll resend.

06,08,12 - add Max's r-b
07,09,10,11,12 - add Juan's r-b

14 - used last version of this patch from qcow2-bitmap series with 
     Max's r-b. It has contextual changes due to different base.

15 - fix 041 iotest, add default node-name only if path is specified and
     node-name is not specified
16 - handle whitespaces
       s/"exec: cat " + fifo/"exec: cat '" + fifo + "'"/
     fix indentation
     add Max's r-b
17 - fix typos, wrong size in comment, s/md5/sha256/
     add Max's r-b

v4:

clone: tag postcopy-v4 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v4

reroll, to fix "failed automatic build test"

rebase on master!

07: since 2.8 -> since 2.9
14: fix build of test-hbitmap
    since 2.8 -> since 2.9 and small rewording of comment (this change was not done for
    same patch in may parallels series about qcow2 bitmap extension)

v3:

rebased on Max's block branch: https://github.com/XanClic/qemu/commits/block
clone: tag postcopy-v3 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v3

01  - r-b by Juan
02  - r-b by Juan and David
04  - fix indent
07  - s/since 2.6/since 2.8/
10  - change variable name s/buf/str/
12  - improve copyright message and move it up
      fix memory loss (thanks to Juan)
      switch from DPRINTF to trace events
14* - switch to sha256 and qcrypto_hash_*
      separate qmp command x-debug-block-dirty-bitmap-sha256
16  - use path_suffix for multi-vm test
      fix indent
      fix copyright
      use x-debug-block-dirty-bitmap-sha256 instead of md5
17  - use x-debug-block-dirty-bitmap-sha256 instead of md5
      remove not existing 170 test from qemu-iotests/group

*Note: patch 14 is also used in my second series 'qcow2 persistent dirty bitmaps'


v2:
some bugs fixed, iotests a bit changed and merged into one test.
based on block-next (https://github.com/XanClic/qemu/commits/block-next)
clone: tag postcopy-v2 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=refs%2Ftags%2Fpostcopy-v2

v1:

These series are derived from my 'Dirty bitmaps migration' series. The
core idea is switch to postcopy migration and drop usage of meta
bitmaps.

These patches provide dirty bitmap postcopy migration feature. Only
named dirty bitmaps are to be migrated. Migration may be enabled using
migration capabilities.

The overall method (thanks to John Snow):

1. migrate bitmaps meta data in .save_live_setup
   - create/find related bitmaps on target
   - disable them
   - create successors (anonimous children) only for enabled migrated
     bitmaps
2. do nothing in precopy stage
3. just before target vm start: enable successors, created in (1)
4. migrate bitmap data
5. reclaime bitmaps (merge successors to their parents)
6. enable bitmaps (only bitmaps, which was enabled in source)


Some patches are unchnaged from (v7) of 'Dirty bitmaps migration'
(DBMv7). I've left Reviewed-by's for them, if you don't like it, say me
and I'll drop them in the following version.

So, relatively to last DBMv7: 

01-04: new patches, splitting common postcopy migration out of ram
       postcopy migration
   05: equal to DBMv7.05
   06: new
   07: equal to DBMv7.06
   08: new
   09: equal to DBMv7.07
   10: new
   11: derived from DBMv7.08, see below
12-15: equal to DBMv7.09-12
   16: derived from DBMv7.13
       - switch from fifo to socket, as postcopy don't work with fifo
         for now
       - change parameters: size, granularity, regions
       - add time.sleep, to wait for postcopy migration phase (bad
         temporary solution.
       - drop Reviewed-by
   17: new

   11: the core patch of the series, it is derived from
       [DBMv7.08: migration: add migration_block-dirty-bitmap.c]
       There are a lot of changes related to switching from precopy to
       postcopy, but functions related to migration stream itself
       (structs, send/load sequences) are mostly unchnaged.

       So, changes, to switch from precopy to postcopy:
       - removed all staff related to meta bitmaps and dirty phase!!!
       - add dirty_bitmap_mig_enable_successors, and call it before
         target vm start in loadvm_postcopy_handle_run
       - add enabled_bitmaps list of bitmaps for
         dirty_bitmap_mig_enable_successors

       - enabled flag is send with start bitmap chunk instead of
         completion chunk
       - sectors_per_chunk is calculated directly from CHUNK_SIZE, not
         using meta bitmap granularity

       - dirty_bitmap_save_iterate: remove dirty_phase, move bulk_phase
         to postcopy stage
       - dirty_bitmap_save_pending: remove dirty phase related pending,
         switch pending to non-postcopyable
       - dirty_bitmap_load_start: get enabled flag and prepare
         successors for enabled bitmaps, also add them to
         enabled_bitmaps list
       - dirty_bitmap_load_complete: for enabled bitmaps: merge them
         with successors and enable

       - savevm handlers:
         * remove separate savevm_dirty_bitmap_live_iterate_handlers state
           (it was bad idea, any way), and move its save_live_iterate to
           savevm_dirty_bitmap_handlers
         * add is_active_iterate savevm handler, which allows iterations
           only in postcopy stage (after stopping source vm)
         * add has_postcopy savevm handler. (ofcourse, just returning true)
         * use save_live_complete_postcopy instead of
           save_live_complete_precopy

       Other changes:
       - some debug output changed
       - remove MIN_LIVE_SIZE, is_live_iterative and related staff (it
         was needed to omit iterations if bitmap data is small, possibly
         this should be reimplemented)

Vladimir Sementsov-Ogievskiy (14):
  block/dirty-bitmap: add bdrv_dirty_bitmap_enable_successor()
  block/dirty-bitmap: add locked version of bdrv_release_dirty_bitmap
  block/dirty-bitmap: add bdrv_dirty_bitmap_release_successor
  block/dirty-bitmap: add bdrv_dirty_bitmap_set_frozen
  migration: introduce postcopy-only pending
  qapi: add dirty-bitmaps migration capability
  migration: include migrate_dirty_bitmaps in migrate_postcopy
  migration/qemu-file: add qemu_put_counted_string()
  migration: add is_active_iterate handler
  migration: add postcopy migration of dirty bitmaps
  iotests: add default node-name
  iotests: add dirty bitmap migration test
  iotests: add dirty bitmap postcopy test
  iotests: add persistent bitmap migration test

 qapi/migration.json            |   6 +-
 include/block/dirty-bitmap.h   |   4 +
 include/migration/misc.h       |   3 +
 include/migration/register.h   |  18 +-
 migration/migration.h          |   4 +
 migration/qemu-file.h          |   2 +
 migration/savevm.h             |   5 +-
 block/dirty-bitmap.c           |  69 +++-
 migration/block-dirty-bitmap.c | 734 +++++++++++++++++++++++++++++++++++++++++
 migration/block.c              |   7 +-
 migration/migration.c          |  29 +-
 migration/qemu-file.c          |  13 +
 migration/ram.c                |   9 +-
 migration/savevm.c             |  20 +-
 vl.c                           |   1 +
 migration/Makefile.objs        |   1 +
 migration/trace-events         |  16 +-
 tests/qemu-iotests/169         | 155 +++++++++
 tests/qemu-iotests/169.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |   9 +-
 21 files changed, 1077 insertions(+), 34 deletions(-)
 create mode 100644 migration/block-dirty-bitmap.c
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out

-- 
2.11.1
