Received: from eggs.gnu.org ([2001:4830:134:3::10]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGTB-0002KB-Cv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGTA-00061O-Hj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:33 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jul 2017 20:34:20 -0400
Message-Id: <20170718003422.4497-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/2] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

We do not currently guarantee that QEMU will or will not open a
backing file when creating a new overlay file. Presently, QEMU will
not open that file if you provide a filesize, because it has no reason
to want to open it in that case.

This series makes the contract more explicit: if '-u' is provided to
create, we will not open the backing image regardless, erroring out if
a size was not provided.

In the other case, if '-u' is not provided, we now endeavor to open the
backing image if possible to check that it exists. For now, if a size
is provided and the image does not exist, QEMU will only warn to maintain
compatibility with legacy behavior.

In the future, QEMU may treat the operation as a failure if '-u' was not
provided.

Tests are amended primarily to pass the '-u' flag where it makes sense;
which is when creating overlays for objects already open by QEMU. These
will now generally fail to succeed because of image locking. In this
case, they only warn instead of fail, but this keeps the output cleaner.

Test 111 is updated to accommodate a new error message.
082, 085, 139, 156 and 158 add '-u' just to suppress warnings.

John Snow (2):
  blockdev: move BDRV_O_NO_BACKING option forward
  qemu-img: Check for backing image if specified during create

 block.c                    | 96 +++++++++++++++++++++++++---------------------
 blockdev.c                 | 11 +++---
 qemu-img-cmds.hx           |  4 +-
 qemu-img.c                 | 16 +++++---
 tests/qemu-iotests/082     |  4 +-
 tests/qemu-iotests/082.out |  4 +-
 tests/qemu-iotests/085     |  2 +-
 tests/qemu-iotests/111.out |  1 +
 tests/qemu-iotests/139     |  2 +-
 tests/qemu-iotests/156     |  2 +-
 tests/qemu-iotests/158     |  2 +-
 11 files changed, 81 insertions(+), 63 deletions(-)

-- 
2.9.4
