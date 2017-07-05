Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXj-0004ni-GI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXi-0002c9-6p
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:21 -0500
Message-Id: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/21] make bdrv_is_allocated[_above]
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
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (this series, v3 was at [1])
part 2: dirty-bitmap (v4 is posted [2]; needs reviews)
part 3: bdrv_get_block_status (v2 is posted [3] and is mostly reviewed)
part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [4])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v4

Depends on Max's block branch (which in turn includes Kevin's)

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06077.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00269.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

Changes since v3:
new patch 4/21 to avoid a semantic change in 5/21 [Kevin]
new assertion in 8/21 [Kevin]
whitespace rebase churn in vvfat in 19/21

Most patches are now reviewed multiple times, although Kevin has not yet
reviewed the second half of the series.

001/21:[----] [--] 'blockjob: Track job ratelimits via bytes, not sectors'
002/21:[----] [--] 'trace: Show blockjob actions via bytes, not sectors'
003/21:[----] [--] 'stream: Switch stream_populate() to byte-based'
004/21:[down] 'stream: Drop reached_end for stream_complete()'
005/21:[0002] [FC] 'stream: Switch stream_run() to byte-based'
006/21:[----] [--] 'commit: Switch commit_populate() to byte-based'
007/21:[----] [--] 'commit: Switch commit_run() to byte-based'
008/21:[0005] [FC] 'mirror: Switch MirrorBlockJob to byte-based'
009/21:[----] [--] 'mirror: Switch mirror_do_zero_or_discard() to byte-based'
010/21:[----] [--] 'mirror: Update signature of mirror_clip_sectors()'
011/21:[----] [--] 'mirror: Switch mirror_cow_align() to byte-based'
012/21:[----] [--] 'mirror: Switch mirror_do_read() to byte-based'
013/21:[----] [--] 'mirror: Switch mirror_iteration() to byte-based'
014/21:[----] [--] 'block: Drop unused bdrv_round_sectors_to_clusters()'
015/21:[----] [--] 'backup: Switch BackupBlockJob to byte-based'
016/21:[----] [--] 'backup: Switch block_backup.h to byte-based'
017/21:[----] [--] 'backup: Switch backup_do_cow() to byte-based'
018/21:[----] [--] 'backup: Switch backup_run() to byte-based'
019/21:[0004] [FC] 'block: Make bdrv_is_allocated() byte-based'
020/21:[----] [--] 'block: Minimize raw use of bds->total_sectors'
021/21:[----] [--] 'block: Make bdrv_is_allocated_above() byte-based'

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
 block/backup.c               | 130 ++++++++----------
 block/commit.c               |  54 ++++----
 block/io.c                   |  92 +++++++------
 block/mirror.c               | 305 ++++++++++++++++++++++---------------------
 block/replication.c          |  29 ++--
 block/stream.c               |  37 +++---
 block/vvfat.c                |  34 +++--
 migration/block.c            |   9 +-
 qemu-img.c                   |  15 ++-
 qemu-io-cmds.c               |  70 +++++-----
 block/trace-events           |  14 +-
 14 files changed, 400 insertions(+), 413 deletions(-)

-- 
2.9.4
