Received: from eggs.gnu.org ([209.51.188.92]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHb-0000Zj-V3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHa-00085s-Ou
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:23 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 10 Apr 2019 22:57:09 +0200
Message-Id: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] qemu-img: Add salvaging mode to convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hi,

This series adds a --salvage option to qemu-img convert.  With this,
qemu-img will not abort when it encounters an I/O error.  Instead, it
tries to narrow it down and will treat the affected sectors as being
completely 0 (and print a warning).

Testing this is not so easy, because while real I/O errors during read
operations should be treated as described above, errors encountered
during bdrv_block_status() should just be ignored and the affected
sectors should be considered allocated.  But blkdebug does not yet have
a way to intercept this, and:

(1) Just adding a new block-status event would be silly, because I don't
    want an event, I want it to fail on a certain kind of operation, on
    a certain sector range, independently of any events, so why can't we
    just do that?  See patch 4.

(2) If we just make blkdebug intercept .bdrv_co_block_status() like all
    other kinds of operations, at least iotest 041 fails, which does
    exactly that silly thing: It uses the read_aio event to wait for any
    read.  But it turns out that there may be a bdrv_*block_status()
    call in between, so suddenly the wrong operation yields an error.
    As I said, the real fault here is that it does not really make sense
    to pray that the operation you want to fail is the one that is
    immediately executed after some event that you hope will trigger
    that operation.
    See patch 3.

So patch 3 allows blkdebug users to select which kind of I/O operation
they actually want to make fail, and patch 4 allows them to not use any
event, but to have a rule active all the time.

Together, we can then enable error injection for block-status in patch 5
and make use of event=3Dnone iotype=3Dblock-status in patch 6.


v2:
- Patch 2:
  - 2058c2ad261de7f58fae01d63d3d0efa484caf2a has added an error message
    when message when *block_status() fails.  Continue using this
    message (with the problematic offset instead of the sector index),
    and adjust my new messages to fit its style.
  - Context conflict due to c075a0af22442e88226a6cef22da3fafccfb5d7e
- Patch 3: %s/4\.0/4.1/
- Patch 4: %s/4\.0/4.1/
- Patch 6: Amendments necessitated by the changes to the warnings added
           in patch 2


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/6:[----] [--] 'qemu-img: Move quiet into ImgConvertState'
002/6:[0017] [FC] 'qemu-img: Add salvaging mode to convert'
003/6:[0004] [FC] 'blkdebug: Add @iotype error option'
004/6:[0002] [FC] 'blkdebug: Add "none" event'
005/6:[----] [-C] 'blkdebug: Inject errors on .bdrv_co_block_status()'
006/6:[0035] [FC] 'iotests: Test qemu-img convert --salvage'


Max Reitz (6):
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage

 qapi/block-core.json       |  33 +++++++-
 block/blkdebug.c           |  60 ++++++++++++--
 qemu-img.c                 |  98 ++++++++++++++++------
 qemu-img-cmds.hx           |   4 +-
 qemu-img.texi              |   5 ++
 tests/qemu-iotests/249     | 163 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 8 files changed, 368 insertions(+), 39 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

--=20
2.20.1
