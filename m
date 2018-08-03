Received: from eggs.gnu.org ([2001:4830:134:3::10]:43740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAJ-00007O-E5
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAE-0008Q6-GM
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Aug 2018 20:46:48 +0300
Message-Id: <20180803174654.278336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/6] dirty-bitmap: rewrite
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

1. bdrv_dirty_iter_next_area don't use hbitmap_next_zero and uses
inefficient loop instead. Let's improve it.

2. bdrv_dirty_iter_next_area don't handle unaligned offset and
max_offset correctly. I'm not sure that it is a real bug. But if it is,
we need these series in 3.0.

Details are in 03 commit message.

Vladimir Sementsov-Ogievskiy (6):
  dirty-bitmap: improve bdrv_dirty_bitmap_next_zero
  dirty-bitmap: add bdrv_dirty_bitmap_next_dirty_area
  block/mirror: fix and improve do_sync_target_write
  Revert "block/dirty-bitmap: Add bdrv_dirty_iter_next_area"
  Revert "test-hbitmap: Add non-advancing iter_next tests"
  Revert "hbitmap: Add @advance param to hbitmap_iter_next()"

 include/block/dirty-bitmap.h |  8 +++--
 include/qemu/hbitmap.h       | 27 +++++++++++++----
 block/backup.c               |  4 +--
 block/dirty-bitmap.c         | 69 +++++++-------------------------------------
 block/mirror.c               | 16 +++++-----
 nbd/server.c                 |  2 +-
 tests/test-hbitmap.c         | 38 +++++++++---------------
 util/hbitmap.c               | 62 ++++++++++++++++++++++++++++++++-------
 8 files changed, 112 insertions(+), 114 deletions(-)

-- 
2.11.1
