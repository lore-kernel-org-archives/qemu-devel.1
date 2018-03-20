Received: from eggs.gnu.org ([2001:4830:134:3::10]:42634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKhW-0001Mh-8F
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKhS-0001KV-7x
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:05:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 20 Mar 2018 20:05:17 +0300
Message-Id: <20180320170521.32152-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 for 2.12 0/3] fix bitmaps migration through
 shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

This fixes bitmaps migration through shared storage. Look at 02 for
details.

The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
qemu-stable in CC. However I doubt that someone really suffered from this.

Do we need dirty bitmaps at all in inactive case? - that was a question in v2.
And, keeping in mind that we are going to use inactive mode not only for
incoming migration, I'm not sure that answer is NO (but, it may be "NO" for 
2.10, 2.11), so let's fix it in proposed here manner at least for 2.12.

v4:

01: r-b: Max
02: rewrite to do not load bitmaps if any bitmaps alredy exit, drop r-b
03: add missed change of 169.out

v3: tiny context changes in 01,02
    03: instead of a separate test, enable corresponding case in existent one

v2:
   John, thank you for reviewing v1.
   changes:
    add John's r-bs, change s/timeout=10/timeout=10.0/ in last patch
    and drop old 03 patch, related to this timeout fix.

Vladimir Sementsov-Ogievskiy (3):
  qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint()
  qcow2: fix bitmaps loading when bitmaps already exist
  iotests: enable shared migration cases in 169

 block/qcow2.h              |  2 ++
 block/qcow2-bitmap.c       | 15 ++++++++++++++-
 block/qcow2.c              | 17 ++++++++++++++++-
 tests/qemu-iotests/169     |  8 +++-----
 tests/qemu-iotests/169.out |  4 ++--
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.11.1
