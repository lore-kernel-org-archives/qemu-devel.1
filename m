Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9a-0003FI-DW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O88-0007Qk-LW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:07 +0100
Message-Id: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

We introduced the auto-read-only option to fix the problem that block
jobs that reopen a backing file read-write don't work any more when all
nodes are created individually with -blockdev. The reason is that
bs->file of these backing files doesn't inherit the read-only option
from the format layer node any more if it's created separately.

The way auto-read-only was designed to fix this is that it just always
opens the file node read-write if it can, so reopening the format layer
node is enough to make the backing file writable when necessary.

This works in principle, but not when libvirt uses sVirt: Then QEMU
doesn't even have the permissions to open the image file read-write
until libvirt performs an operation where write access is needed.

This series changes auto-read-only so that it works dynamically and
automatically reopens the file read-only or read-write depending on the
permissions that users attached to the node requested.

See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1685989

v2:
- Added test for and fixed snapshot=3Don,read-only=3Don regression [Berto=
]
- Added test for and fixed commit regression [Peter]

Kevin Wolf (10):
  tests/virtio-blk-test: Disable auto-read-only
  qemu-iotests: commit to backing file with auto-read-only
  block: Avoid useless local_err
  block: Make permission changes in reopen less wrong
  file-posix: Fix bdrv_open_flags() for snapshot=3Don
  file-posix: Factor out raw_reconfigure_getfd()
  file-posix: Store BDRVRawState.reopen_state during reopen
  file-posix: Lock new fd in raw_reopen_prepare()
  file-posix: Prepare permission code for fd switching
  file-posix: Make auto-read-only dynamic

 block.c                       |  46 ++++---
 block/file-posix.c            | 248 ++++++++++++++++++++++++----------
 tests/virtio-blk-test.c       |   2 +-
 tests/qemu-iotests/051        |   7 +
 tests/qemu-iotests/051.out    |   9 ++
 tests/qemu-iotests/051.pc.out |   9 ++
 tests/qemu-iotests/232        |  31 +++++
 tests/qemu-iotests/232.out    |  32 ++++-
 8 files changed, 284 insertions(+), 100 deletions(-)

--=20
2.20.1
