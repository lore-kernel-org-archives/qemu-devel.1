Received: from eggs.gnu.org ([209.51.188.92]:48079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhd-0007On-1Y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhc-0006ip-29
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:13 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  1 Apr 2019 15:06:02 +0300
Message-Id: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block/stream: get rid of the base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com, berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

v2:
The function bdrv_find_overlay() with the same functionality has been
used in the qmp_block_stream() to find a bottom node.
The algorithm in the bdrv_do_is_allocated_above() was simplified.
The commit messages were modified.

Discussed in the e-mail threads with the message IDs
<1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (2):
  block: include base when checking image chain for block allocation
  block/stream: introduce a bottom node

Vladimir Sementsov-Ogievskiy (1):
  block/stream: refactor stream_run: drop goto

 block/io.c                | 32 ++++++++++++++++++----
 block/stream.c            | 67 ++++++++++++++++++++++-------------------------
 block/trace-events        |  2 +-
 blockdev.c                |  7 ++++-
 include/block/block.h     |  5 +++-
 include/block/block_int.h |  6 ++---
 tests/qemu-iotests/245    |  4 +--
 7 files changed, 74 insertions(+), 49 deletions(-)

-- 
1.8.3.1
