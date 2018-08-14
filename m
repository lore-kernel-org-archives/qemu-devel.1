Received: from eggs.gnu.org ([2001:4830:134:3::10]:37582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDs-0002e7-Sg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDn-000522-Rh
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:14:35 +0300
Message-Id: <20180814121443.33114-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/8] dirty-bitmap: rewrite
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

Details are in 05 commit message.

v3:
01: - change interface to start/end, and -1 as special end-marker instead of 0
    - "not found" for invalid regions instead of assert
02: rebase on 01 changes
03: - fix mistake in hbitmap_iter_init arguments (mistake in
      hbitmap_next_zero arguments is fixed automatically due to 01 changes)
04: new


v2:

01: - improve comment
    - s/bytes/count/
    - fix forgotten function call in test
    - introduce orig_size field here for HBitmap,
      make checking in hbitmap_next_zero more effective and safe
02: new
03: - orig_size already introduced in 01
    - fix hbitmap_next_dirty_area to not return value less than
      offset on unaligned requests

Vladimir Sementsov-Ogievskiy (8):
  dirty-bitmap: improve bdrv_dirty_bitmap_next_zero
  tests: add tests for hbitmap_next_zero with specified end parameter
  dirty-bitmap: add bdrv_dirty_bitmap_next_dirty_area
  tests: add tests for hbitmap_next_dirty_area
  block/mirror: fix and improve do_sync_target_write
  Revert "block/dirty-bitmap: Add bdrv_dirty_iter_next_area"
  Revert "test-hbitmap: Add non-advancing iter_next tests"
  Revert "hbitmap: Add @advance param to hbitmap_iter_next()"

 include/block/dirty-bitmap.h |   8 +-
 include/qemu/hbitmap.h       |  30 ++++++--
 block/backup.c               |   4 +-
 block/dirty-bitmap.c         |  69 +++--------------
 block/mirror.c               |  16 ++--
 nbd/server.c                 |   2 +-
 tests/test-hbitmap.c         | 176 ++++++++++++++++++++++++++++++++++++-------
 util/hbitmap.c               |  73 +++++++++++++++---
 8 files changed, 258 insertions(+), 120 deletions(-)

-- 
2.11.1
