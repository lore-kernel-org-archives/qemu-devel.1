Received: from eggs.gnu.org ([2001:4830:134:3::10]:43896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF7-00036Y-1J
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF5-0007zS-Mu
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Jun 2018 21:36:59 +0200
Message-Id: <20180606193702.7113-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qcow2: Do not mark inactive images
 corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The non-public logs in
https://bugzilla.redhat.com/show_bug.cgi?id=1583346 (sorry...) reveal
this problem:

$ (Create a qcow2 file "foo.qcow2" with a corrupted first L1 entry)
$ echo 'qemu-io none0 "read 0 512"' \
    | x86_64-softmmu/qemu-system-x86_64 -drive if=none,file=foo.qcow2 \
                                        -monitor stdio \
                                        -incoming exec:'cat /dev/null'
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "read 0 512"
qcow2: Marking image as corrupt: L2 table offset 0x44200 unaligned (L1 index: 0); further corruption events will be suppressed
qemu-system-x86_64: block/io.c:1691: bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
[1]    18444 done                 echo 'qemu-io none0 "read 0 512"' |
       18445 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -drive if=none,file=foo.qcow2 -monitor stdi

Oops.


The first patch in this series makes a function public that the second
patch uses to fix the issue by treating all non-writable images like
read-only images (yes, there is a difference...) in this regard (which
most importantly means not trying to set the corrupt flag on them).
Inactive images count as non-writable images, but not as read-only
images, so that fixes it.

The third patch adds an iotest case.


v2:
- Use bdrv_is_writable() instead of copying its functionality [Jeff]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[down] 'block: Make bdrv_is_writable() public'
002/3:[0004] [FC] 'qcow2: Do not mark inactive images corrupt'
003/3:[----] [--] 'iotests: Add case for a corrupted inactive image'


Max Reitz (3):
  block: Make bdrv_is_writable() public
  qcow2: Do not mark inactive images corrupt
  iotests: Add case for a corrupted inactive image

 include/block/block.h      |  1 +
 block.c                    | 17 ++++++++++++++---
 block/qcow2.c              |  2 +-
 tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 14 ++++++++++++++
 5 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.17.0
