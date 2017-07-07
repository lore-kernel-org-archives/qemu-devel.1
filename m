Received: from eggs.gnu.org ([2001:4830:134:3::10]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdI-0000ON-Lz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdH-0000Ps-HN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:16 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:38 -0500
Message-Id: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/21] make bdrv_is_allocated[_above]
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (this series, v4 was at [1])
part 2: dirty-bitmap (v4 is posted [2]; needs reviews)
part 3: bdrv_get_block_status (v2 is posted [3] and is mostly reviewed)
part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [4])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v5

Depends on Max's block branch (which in turn includes Kevin's)

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01151.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00269.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

Changes since v4:
- patches 8, 11: formatting tweak [Kevin], R-b kept
- patches 12, 19, 21: fix/add assertions [Kevin], R-b dropped
- patch 16: tweak parameter naming [Kevin], R-b kept
- patch 20: kill confusing comment [Kevin], R-b kept

001/21:[----] [--] 'blockjob: Track job ratelimits via bytes, not sectors'
002/21:[----] [--] 'trace: Show blockjob actions via bytes, not sectors'
003/21:[----] [--] 'stream: Switch stream_populate() to byte-based'
004/21:[----] [--] 'stream: Drop reached_end for stream_complete()'
005/21:[----] [--] 'stream: Switch stream_run() to byte-based'
006/21:[----] [--] 'commit: Switch commit_populate() to byte-based'
007/21:[----] [--] 'commit: Switch commit_run() to byte-based'
008/21:[0004] [FC] 'mirror: Switch MirrorBlockJob to byte-based'
009/21:[----] [--] 'mirror: Switch mirror_do_zero_or_discard() to byte-based'
010/21:[----] [--] 'mirror: Update signature of mirror_clip_sectors()'
011/21:[0003] [FC] 'mirror: Switch mirror_cow_align() to byte-based'
012/21:[0007] [FC] 'mirror: Switch mirror_do_read() to byte-based'
013/21:[----] [--] 'mirror: Switch mirror_iteration() to byte-based'
014/21:[----] [--] 'block: Drop unused bdrv_round_sectors_to_clusters()'
015/21:[----] [--] 'backup: Switch BackupBlockJob to byte-based'
016/21:[0008] [FC] 'backup: Switch block_backup.h to byte-based'
017/21:[----] [--] 'backup: Switch backup_do_cow() to byte-based'
018/21:[----] [--] 'backup: Switch backup_run() to byte-based'
019/21:[0035] [FC] 'block: Make bdrv_is_allocated() byte-based'
020/21:[0004] [FC] 'block: Minimize raw use of bds->total_sectors'
021/21:[0020] [FC] 'block: Make bdrv_is_allocated_above() byte-based'

Eric Blake (21):
  blockjob: Track job ratelimits via bytes, not sectors
  trace: Show blockjob actions via bytes, not sectors
  stream: Switch stream_populate() to byte-based
  stream: Drop reached_end for stream_complete()
  stream: Switch stream_run() to byte-based
  commit: Switch commit_populate() to byte-based
  commit: Switch commit_run() to byte-based
  mirror: Switch MirrorBlockJob to byte-based
  mirror: Switch mirror_do_zero_or_discard() to byte-based
  mirror: Update signature of mirror_clip_sectors()
  mirror: Switch mirror_cow_align() to byte-based
  mirror: Switch mirror_do_read() to byte-based
  mirror: Switch mirror_iteration() to byte-based
  block: Drop unused bdrv_round_sectors_to_clusters()
  backup: Switch BackupBlockJob to byte-based
  backup: Switch block_backup.h to byte-based
  backup: Switch backup_do_cow() to byte-based
  backup: Switch backup_run() to byte-based
  block: Make bdrv_is_allocated() byte-based
  block: Minimize raw use of bds->total_sectors
  block: Make bdrv_is_allocated_above() byte-based

 include/block/block.h        |  10 +-
 include/block/block_backup.h |  11 +-
 include/qemu/ratelimit.h     |   3 +-
 block/backup.c               | 128 ++++++++----------
 block/commit.c               |  54 ++++----
 block/io.c                   |  97 +++++++-------
 block/mirror.c               | 308 ++++++++++++++++++++++---------------------
 block/replication.c          |  29 ++--
 block/stream.c               |  37 +++---
 block/vvfat.c                |  34 +++--
 migration/block.c            |  16 ++-
 qemu-img.c                   |  21 ++-
 qemu-io-cmds.c               |  70 +++++-----
 block/trace-events           |  14 +-
 14 files changed, 413 insertions(+), 419 deletions(-)

-- 
2.9.4
