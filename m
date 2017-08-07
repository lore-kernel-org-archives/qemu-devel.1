Received: from eggs.gnu.org ([2001:4830:134:3::10]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIj-0006wq-KE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIY-0003fM-K3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:04 +0200
Message-Id: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/56] qapi: Use 'size' for byte counts &
 offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Byte sizes, offsets and the like should use QAPI type 'size'
(uint64_t).  This rule is more honored in the breach than in the
observance.  Fix the obvious offenders.

The series is RFC for at least two reasons:

1. It's only lightly tested.  Commit message claims like "FOO now
   works" haven't been verified, yet.

2. The block layer represents file offsets and sizes as int64_t in
   many places.  Must not be negative, except for function return
   values, where it means failure.

   If you pass negative values via QMP, things explode.  Rejecting
   them cleanly would be better, but we do that only haphazardly, as
   far as I can tell.

   Changing the QAPI schema from 'int' (C: int64_t) to 'size' (C:
   uint64_t) arguably makes things slightly worse: you can't
   reasonably expect negative offsets and sizes to work, but expecting
   offsets and sizes between 2^63 and 2^64-1 to work is less
   unreasonable.  The explosions stay the same.

   Perhaps we should have a dedicated QAPI type for file offsets, just
   like libc has off_t.  Which is also signed, by the way.

Based on "[PATCH v2 0/3] Proactive pow2floor() fix, and dead code
removal" and "[PATCH 0/3] Don't QAPI without need".

Markus Armbruster (56):
  qobject: Touch up comments to say @param instead of 'param'
  qdict: New helpers to put and get unsigned integers
  monitor: Rewrite comment describing HMP .args_type
  char: Make ringbuf-read size unsigned in QAPI/QMP
  char: Make ringbuf size unsigned in QAPI
  char: Don't truncate -chardev and HMP chardev-add ringbuf size
  cpus: Make memsave, pmemsave sizes, addresses unsigned in QAPI/QMP
  dump: Make sizes and addresses unsigned in QAPI/QMP
  balloon: Make balloon size unsigned in QAPI/QMP
  hmp: Make balloon's argument unsigned
  monitor: Drop unused HMP .args_type 'M'
  pc-dimm: Make size and address unsigned in QAPI/QMP
  pci: Make PCI addresses and sizes unsigned in QAPI/QMP
  migration: Fix migrate-set-cache-size error reporting
  migration: Make XBZRLE cache size unsigned in QAPI/QMP
  migration: Make XBZRLE transferred size unsigned in QAPI/QMP
  migration: Make MigrationStats sizes unsigned in QAPI/QMP
  migration: Make parameter max-bandwidth unsigned in QAPI/QMP
  block: Make snapshot VM state size unsigned in QAPI/QMP
  block: Make ImageInfo sizes unsigned in QAPI/QMP
  block: Clean up get_human_readable_size()
  block: Mix up signed and unsigned less in bdrv_img_create()
  option: Fix type of qemu_opt_set_number() parameter @val
  block/qcow2: Change align_offset() to operate on uint64_t
  block/qcow2: Change qcow2_calc_prealloc_size() to uint64_t
  block: Make BlockMeasureInfo sizes unsigned in QAPI
  block/dirty-bitmap: Clean up signed vs. unsigned dirty counts
  block: Widen dirty bitmap granularity to uint64_t for safety
  block: Make BlockDirtyInfo byte count unsigned in QAPI/QMP
  block: Make write thresholds unsigned in QAPI/QMP
  block: Make throttle byte rates and sizes unsigned in QAPI/QMP
  hmp: Make block_set_io_throttle's arguments unsigned
  block: Make block_resize size unsigned in QAPI/QMP
  block: Make BlockDeviceStats sizes, offsets unsigned in QAPI/QMP
  blockjob: Lift speed sign conversion into block_job_set_speed()
  blockjob: Drop unused parameter @errp of method set_speed()
  blockjob: Make BlockJobInfo and event speed unsigned in QAPI/QMP
  blockjob: Lift speed sign conversion out of block_job_set_speed()
  blockjob: Lift speed sign conversion out of block_job_create()
  blockjob: Lift speed sign conversion out of backup_job_create()
  blockjob: Lift speed sign conversion out of mirror_start_job()
  blockjob: Lift speed sign conversion out of stream_start()
  blockjob: Lift speed sign conversion out of mirror_start()
  blockjob: Lift speed sign conversion out of blockdev_mirror_common()
  blockjob: Lift speed sign conversion out of commit_start() etc.
  blockjob: Make job commands' speed parameter unsigned in QAPI/QMP
  blockjob: Make BlockJobInfo and event offsets unsigned in QAPI/QMP
  block: Make mirror buffer size unsigned in QAPI/QMP
  block: Make ImageCheck file offset unsigned in QAPI
  block: Make BLOCK_IMAGE_CORRUPTED offset, size unsigned in QAPI/QMP
  block/nfs: Fix for readahead-size, page-cache-size > INT64_MAX
  block/nfs: Reject negative readahead-size, page-cache-size
  block: Make blockdev-add byte counts unsigned in QAPI/QMP
  qemu-img: blk_getlength() can fail, fix img_map() to check
  block: Make MapEntry offsets and size unsigned in QAPI
  crypto: Make QCryptoBlockInfoLUKS offsets unsigned in QAPI/QMP

 balloon.c                       |   2 +-
 block.c                         |  19 ++++---
 block/backup.c                  |  10 +---
 block/commit.c                  |   9 +--
 block/dirty-bitmap.c            |  23 +++-----
 block/mirror.c                  |  27 +++------
 block/nfs.c                     |  15 ++---
 block/null.c                    |   2 +-
 block/qapi.c                    |  20 ++++---
 block/qcow2-bitmap.c            |  18 +++---
 block/qcow2.c                   |  12 ++--
 block/qcow2.h                   |   7 +--
 block/raw-format.c              |  10 ++--
 block/stream.c                  |   8 +--
 block/trace-events              |   8 +--
 block/write-threshold.c         |   2 +-
 blockdev.c                      |  32 ++++++-----
 blockjob.c                      |  12 +---
 chardev/char-ringbuf.c          |  19 ++-----
 cpus.c                          |   6 +-
 dump.c                          |  26 ++++-----
 hmp-commands.hx                 |   4 +-
 hmp.c                           |  40 +++++++-------
 include/block/block.h           |   2 +-
 include/block/block_int.h       |  13 +++--
 include/block/blockjob.h        |   4 +-
 include/block/blockjob_int.h    |   4 +-
 include/block/dirty-bitmap.h    |  11 ++--
 include/qapi/qmp/qdict.h        |   5 ++
 include/qemu/option.h           |   2 +-
 include/sysemu/dump.h           |   8 +--
 include/sysemu/memory_mapping.h |   4 +-
 memory_mapping.c                |   4 +-
 migration/block.c               |   4 +-
 migration/migration.c           |  23 ++++----
 migration/migration.h           |   4 +-
 migration/page_cache.c          |  20 +++----
 migration/page_cache.h          |   2 +-
 migration/ram.c                 |  15 +++--
 migration/ram.h                 |   2 +-
 monitor.c                       |  80 +++++++++++++++------------
 qapi-schema.json                |  43 +++++++-------
 qapi/block-core.json            | 120 ++++++++++++++++++++--------------------
 qapi/crypto.json                |   4 +-
 qapi/event.json                 |   2 +-
 qemu-img.c                      |  10 +++-
 qobject/qdict.c                 | 101 +++++++++++++++++++++------------
 qobject/qlist.c                 |   2 +-
 tests/qemu-iotests/030          |  16 ------
 tests/qemu-iotests/030.out      |   4 +-
 tests/qemu-iotests/041          |  18 ------
 tests/qemu-iotests/041.out      |   4 +-
 tests/qemu-iotests/055          |  26 ---------
 tests/qemu-iotests/055.out      |   4 +-
 tests/test-hbitmap.c            |  16 +++---
 util/qemu-option.c              |   2 +-
 56 files changed, 439 insertions(+), 471 deletions(-)

-- 
2.7.5
