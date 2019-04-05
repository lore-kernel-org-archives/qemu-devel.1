Received: from eggs.gnu.org ([209.51.188.92]:51025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSXg-0002oH-06
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSXe-0003s2-Sz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:22:15 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri,  5 Apr 2019 19:56:16 +0300
Message-Id: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/3] block/stream: get rid of the base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

v3:
bottom = bdrv_find_overlay() moved into the stream_start()

v2:
The function bdrv_find_overlay() with the same functionality has been
used in the qmp_block_stream() to find a bottom node.
The algorithm in the bdrv_do_is_allocated_above() was simplified.
The commit messages were modified.

Discussed in the e-mail threads with the message IDs
<1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (3):
  block: include base when checking image chain for block allocation
  block/stream: refactor stream_run: drop goto
  block/stream: introduce a bottom node

 block/io.c             | 33 ++++++++++++++++++++----
 block/stream.c         | 69 +++++++++++++++++++++++++-------------------------
 block/trace-events     |  2 +-
 include/block/block.h  |  4 +++
 tests/qemu-iotests/245 |  4 +--
 5 files changed, 69 insertions(+), 43 deletions(-)

-- 
1.8.3.1
