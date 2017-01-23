Received: from eggs.gnu.org ([2001:4830:134:3::10]:60570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cViP5-0004Y7-HM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cViP4-0007BO-0l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:27:39 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<f3a064b5-9d01-1e6d-af5d-cbe503edf974@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <41b78fe3-8257-7b03-f543-c6537bd83d23@redhat.com>
Date: Mon, 23 Jan 2017 12:27:29 -0500
MIME-Version: 1.0
In-Reply-To: <f3a064b5-9d01-1e6d-af5d-cbe503edf974@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ping2 Re: [PATCH v4 00/17] Dirty bitmaps postcopy
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com

I'm really sorry, but I personally don't have the time to review this
until February 6th.

Juan, David, does this look all-ok from your end? Are we just waiting
for block reviews at this point?

On 01/23/2017 06:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> Ping
> 
> Hi all! What about this?
> 
> 22.11.2016 20:54, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> There is a new version of dirty bitmap postcopy migration series.
>>
>> v4:
>>
>> clone: tag postcopy-v4 from
>> https://src.openvz.org/scm/~vsementsov/qemu.git
>> online:
>> https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v4
>>
>> reroll, to fix "failed automatic build test"
>>
>> rebase on master!
>>
>> 07: since 2.8 -> since 2.9
>> 14: fix build of test-hbitmap
>>      since 2.8 -> since 2.9 and small rewording of comment (this
>> change was not done for
>>      same patch in may parallels series about qcow2 bitmap extension)
>>
>> v3:
>>
>> rebased on Max's block branch:
>> https://github.com/XanClic/qemu/commits/block
>> clone: tag postcopy-v3 from
>> https://src.openvz.org/scm/~vsementsov/qemu.git
>> online:
>> https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v3
>>
>> 01  - r-b by Juan
>> 02  - r-b by Juan and David
>> 04  - fix indent
>> 07  - s/since 2.6/since 2.8/
>> 10  - change variable name s/buf/str/
>> 12  - improve copyright message and move it up
>>        fix memory loss (thanks to Juan)
>>        switch from DPRINTF to trace events
>> 14* - switch to sha256 and qcrypto_hash_*
>>        separate qmp command x-debug-block-dirty-bitmap-sha256
>> 16  - use path_suffix for multi-vm test
>>        fix indent
>>        fix copyright
>>        use x-debug-block-dirty-bitmap-sha256 instead of md5
>> 17  - use x-debug-block-dirty-bitmap-sha256 instead of md5
>>        remove not existing 170 test from qemu-iotests/group
>>
>> *Note: patch 14 is also used in my second series 'qcow2 persistent
>> dirty bitmaps'
>>
>>
>> v2:
>> some bugs fixed, iotests a bit changed and merged into one test.
>> based on block-next (https://github.com/XanClic/qemu/commits/block-next)
>> clone: tag postcopy-v2 from
>> https://src.openvz.org/scm/~vsementsov/qemu.git
>> online:
>> https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=refs%2Ftags%2Fpostcopy-v2
>>
>>
>> v1:
>>
>> These series are derived from my 'Dirty bitmaps migration' series. The
>> core idea is switch to postcopy migration and drop usage of meta
>> bitmaps.
>>
>> These patches provide dirty bitmap postcopy migration feature. Only
>> named dirty bitmaps are to be migrated. Migration may be enabled using
>> migration capabilities.
>>
>> The overall method (thanks to John Snow):
>>
>> 1. migrate bitmaps meta data in .save_live_setup
>>     - create/find related bitmaps on target
>>     - disable them
>>     - create successors (anonimous children) only for enabled migrated
>>       bitmaps
>> 2. do nothing in precopy stage
>> 3. just before target vm start: enable successors, created in (1)
>> 4. migrate bitmap data
>> 5. reclaime bitmaps (merge successors to their parents)
>> 6. enable bitmaps (only bitmaps, which was enabled in source)
>>
>>
>> Some patches are unchnaged from (v7) of 'Dirty bitmaps migration'
>> (DBMv7). I've left Reviewed-by's for them, if you don't like it, say me
>> and I'll drop them in the following version.
>>
>> So, relatively to last DBMv7:
>>
>> 01-04: new patches, splitting common postcopy migration out of ram
>>         postcopy migration
>>     05: equal to DBMv7.05
>>     06: new
>>     07: equal to DBMv7.06
>>     08: new
>>     09: equal to DBMv7.07
>>     10: new
>>     11: derived from DBMv7.08, see below
>> 12-15: equal to DBMv7.09-12
>>     16: derived from DBMv7.13
>>         - switch from fifo to socket, as postcopy don't work with fifo
>>           for now
>>         - change parameters: size, granularity, regions
>>         - add time.sleep, to wait for postcopy migration phase (bad
>>           temporary solution.
>>         - drop Reviewed-by
>>     17: new
>>
>>     11: the core patch of the series, it is derived from
>>         [DBMv7.08: migration: add migration_block-dirty-bitmap.c]
>>         There are a lot of changes related to switching from precopy to
>>         postcopy, but functions related to migration stream itself
>>         (structs, send/load sequences) are mostly unchnaged.
>>
>>         So, changes, to switch from precopy to postcopy:
>>         - removed all staff related to meta bitmaps and dirty phase!!!
>>         - add dirty_bitmap_mig_enable_successors, and call it before
>>           target vm start in loadvm_postcopy_handle_run
>>         - add enabled_bitmaps list of bitmaps for
>>           dirty_bitmap_mig_enable_successors
>>
>>         - enabled flag is send with start bitmap chunk instead of
>>           completion chunk
>>         - sectors_per_chunk is calculated directly from CHUNK_SIZE, not
>>           using meta bitmap granularity
>>
>>         - dirty_bitmap_save_iterate: remove dirty_phase, move bulk_phase
>>           to postcopy stage
>>         - dirty_bitmap_save_pending: remove dirty phase related pending,
>>           switch pending to non-postcopyable
>>         - dirty_bitmap_load_start: get enabled flag and prepare
>>           successors for enabled bitmaps, also add them to
>>           enabled_bitmaps list
>>         - dirty_bitmap_load_complete: for enabled bitmaps: merge them
>>           with successors and enable
>>
>>         - savevm handlers:
>>           * remove separate savevm_dirty_bitmap_live_iterate_handlers
>> state
>>             (it was bad idea, any way), and move its save_live_iterate to
>>             savevm_dirty_bitmap_handlers
>>           * add is_active_iterate savevm handler, which allows iterations
>>             only in postcopy stage (after stopping source vm)
>>           * add has_postcopy savevm handler. (ofcourse, just returning
>> true)
>>           * use save_live_complete_postcopy instead of
>>             save_live_complete_precopy
>>
>>         Other changes:
>>         - some debug output changed
>>         - remove MIN_LIVE_SIZE, is_live_iterative and related staff (it
>>           was needed to omit iterations if bitmap data is small, possibly
>>           this should be reimplemented)
>>
>> Vladimir Sementsov-Ogievskiy (17):
>>    migration: add has_postcopy savevm handler
>>    migration: fix ram_save_pending
>>    migration: split common postcopy out of ram postcopy
>>    migration: introduce postcopy-only pending
>>    block: add bdrv_next_dirty_bitmap()
>>    block: add bdrv_dirty_bitmap_enable_successor()
>>    qapi: add dirty-bitmaps migration capability
>>    block/dirty-bitmap: add bdrv_dirty_bitmap_release_successor
>>    migration: include migrate_dirty_bitmaps in migrate_postcopy
>>    migration/qemu-file: add qemu_put_counted_string()
>>    migration: add is_active_iterate handler
>>    migration: add postcopy migration of dirty bitmaps
>>    iotests: add add_incoming_migration to VM class
>>    qmp: add x-debug-block-dirty-bitmap-sha256
>>    iotests: add default node-name
>>    iotests: add dirty bitmap migration test
>>    iotests: add dirty bitmap postcopy test
>>
>>   block/dirty-bitmap.c           |  30 ++
>>   blockdev.c                     |  33 ++
>>   include/block/dirty-bitmap.h   |   8 +
>>   include/migration/block.h      |   1 +
>>   include/migration/migration.h  |   6 +
>>   include/migration/qemu-file.h  |   2 +
>>   include/migration/vmstate.h    |   7 +-
>>   include/qemu/hbitmap.h         |   8 +
>>   include/sysemu/sysemu.h        |   5 +-
>>   migration/Makefile.objs        |   2 +-
>>   migration/block-dirty-bitmap.c | 679
>> +++++++++++++++++++++++++++++++++++++++++
>>   migration/block.c              |   7 +-
>>   migration/migration.c          |  66 ++--
>>   migration/postcopy-ram.c       |   4 +-
>>   migration/qemu-file.c          |  13 +
>>   migration/ram.c                |  19 +-
>>   migration/savevm.c             |  58 ++--
>>   migration/trace-events         |  16 +-
>>   qapi-schema.json               |   4 +-
>>   qapi/block-core.json           |  26 ++
>>   tests/Makefile.include         |   2 +-
>>   tests/qemu-iotests/169         | 140 +++++++++
>>   tests/qemu-iotests/169.out     |   5 +
>>   tests/qemu-iotests/group       |   1 +
>>   tests/qemu-iotests/iotests.py  |  16 +-
>>   util/hbitmap.c                 |  11 +
>>   vl.c                           |   1 +
>>   27 files changed, 1116 insertions(+), 54 deletions(-)
>>   create mode 100644 migration/block-dirty-bitmap.c
>>   create mode 100755 tests/qemu-iotests/169
>>   create mode 100644 tests/qemu-iotests/169.out
>>
> 
> 
