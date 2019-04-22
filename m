Received: from eggs.gnu.org ([209.51.188.92]:57986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2X-0002xT-SU
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2W-0006YF-SD
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 13:18:57 +0300
Message-Id: <20190422101900.13897-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/3] block/stream: get rid of the base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, berto@igalia.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

v5: [resend by Vladimir]
  01: use comment wording in block/io.c suggested by Alberto
  Now the whole series are reviewed-by Alberto and me.

v4:
trace_stream_start reverted to the base.
bdrv_is_allocated_above_inclusive() deleted and the new parameter
'bool include_base' was added to the bdrv_is_allocated_above().


Andrey Shinkevich (2):
  block: include base when checking image chain for block allocation
  block/stream: introduce a bottom node

Vladimir Sementsov-Ogievskiy (1):
  block/stream: refactor stream_run: drop goto

 include/block/block.h  |  3 +-
 block/commit.c         |  2 +-
 block/io.c             | 18 ++++++++----
 block/mirror.c         |  2 +-
 block/replication.c    |  2 +-
 block/stream.c         | 62 ++++++++++++++++++++----------------------
 tests/qemu-iotests/245 |  4 +--
 7 files changed, 49 insertions(+), 44 deletions(-)

-- 
2.18.0
