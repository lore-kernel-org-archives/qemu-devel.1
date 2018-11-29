Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSJP0-0007sj-Ba
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSJOz-0005E9-Ca
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:34 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 29 Nov 2018 13:17:59 +0300
Message-Id: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, vsementsov@virtuozzo.com, qemu-stable@nongnu.org

Hi all!

v2: add fix:)

We've faced the following mirror bug:

Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.

Dead lock described in 01, in short, we have extra aio_context_acquire
and aio_context_release around blk_aio_pwritev in mirror_read_complete.
So, write may yield to the main loop, and aio context is acquired. Main
loop than hangs on trying to lock BQL, which is locked by cpu thread,
and the cpu thread hangs on trying to acquire aio context.

Hm, now the thing looks fixed, by I still have a questions:

Is it a common thing, that we can't yield inside
aio_context_acquire/release ?

Was commit b9e413dd3756 
"block: explicitly acquire aiocontext in aio callbacks that need it"
wrong? Why it added these acquire/release, when it is written in 
multiple-iothreads.txt, that "Side note: the best way to schedule a function
call across threads is to call aio_bh_schedule_oneshot().  No acquire/release
or locking is needed."

Can someone in short describe, what BQL and aio context lock means, what they
protect, and haw they should cooperate?

Vladimir Sementsov-Ogievskiy (2):
  mirror: fix dead-lock
  iotests: simple mirror test with kvm on 1G image

 block/mirror.c             | 13 ++++-----
 tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/235.out |  1 +
 tests/qemu-iotests/group   |  1 +
 4 files changed, 66 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out

-- 
2.18.0
