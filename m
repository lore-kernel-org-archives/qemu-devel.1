Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOQ-0006Eb-GP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOM-0007Jz-PW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:24 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 18:52:05 +0100
Message-Id: <20181203175211.8230-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 0/6] qemu-img: Add salvaging mode to
 convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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


Max Reitz (6):
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage

 qapi/block-core.json       |  33 +++++++-
 block/blkdebug.c           |  60 ++++++++++++--
 qemu-img.c                 |  97 ++++++++++++++++------
 qemu-img-cmds.hx           |   4 +-
 qemu-img.texi              |   5 ++
 tests/qemu-iotests/236     | 164 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/236.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 8 files changed, 370 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

--=20
2.19.2
