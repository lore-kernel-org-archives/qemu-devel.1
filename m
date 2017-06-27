Received: from eggs.gnu.org ([2001:4830:134:3::10]:42298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw6q-0005oT-PZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw6p-0006h4-Na
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:38 -0500
Message-Id: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/20] make bdrv_is_allocated[_above]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

This is part one of that conversion: bdrv_is_allocated().
Other parts still need a v3, but here's the link to their most
recent posting:
tracking dirty bitmaps by bytes:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03859.html
replacing bdrv_get_block_status() with a byte based callback
in all the drivers:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v3

Depends on Kevin's block branch

Changes since v2 are limited to rebase artifacts (Paolo's conversion
to thread-safety being the biggest cause of context conflicts, and
also affecting patch 12 - but where I think the resolution is sane
enough to keep R-b).  Added R-b on patches where it has been given,
leaving 19/20 as the only unreviewed patch.

001/20:[----] [--] 'blockjob: Track job ratelimits via bytes, not sectors'
002/20:[----] [-C] 'trace: Show blockjob actions via bytes, not sectors'
003/20:[----] [--] 'stream: Switch stream_populate() to byte-based'
004/20:[----] [--] 'stream: Switch stream_run() to byte-based'
005/20:[----] [--] 'commit: Switch commit_populate() to byte-based'
006/20:[----] [--] 'commit: Switch commit_run() to byte-based'
007/20:[----] [-C] 'mirror: Switch MirrorBlockJob to byte-based'
008/20:[----] [--] 'mirror: Switch mirror_do_zero_or_discard() to byte-based'
009/20:[----] [--] 'mirror: Update signature of mirror_clip_sectors()'
010/20:[----] [--] 'mirror: Switch mirror_cow_align() to byte-based'
011/20:[----] [--] 'mirror: Switch mirror_do_read() to byte-based'
012/20:[0012] [FC] 'mirror: Switch mirror_iteration() to byte-based'
013/20:[----] [--] 'block: Drop unused bdrv_round_sectors_to_clusters()'
014/20:[----] [--] 'backup: Switch BackupBlockJob to byte-based'
015/20:[----] [--] 'backup: Switch block_backup.h to byte-based'
016/20:[----] [--] 'backup: Switch backup_do_cow() to byte-based'
017/20:[----] [--] 'backup: Switch backup_run() to byte-based'
018/20:[----] [--] 'block: Make bdrv_is_allocated() byte-based'
019/20:[----] [--] 'block: Minimize raw use of bds->total_sectors'
020/20:[----] [-C] 'block: Make bdrv_is_allocated_above() byte-based'

Eric Blake (20):
  blockjob: Track job ratelimits via bytes, not sectors
  trace: Show blockjob actions via bytes, not sectors
  stream: Switch stream_populate() to byte-based
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
 block/backup.c               | 130 ++++++++-----------
 block/commit.c               |  54 ++++----
 block/io.c                   |  92 +++++++------
 block/mirror.c               | 302 ++++++++++++++++++++++---------------------
 block/replication.c          |  29 +++--
 block/stream.c               |  35 +++--
 block/vvfat.c                |  34 +++--
 migration/block.c            |   9 +-
 qemu-img.c                   |  15 ++-
 qemu-io-cmds.c               |  70 +++++-----
 block/trace-events           |  14 +-
 14 files changed, 397 insertions(+), 411 deletions(-)

-- 
2.9.4
