Received: from eggs.gnu.org ([2001:4830:134:3::10]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qA-00029E-1T
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8q8-0001s8-IH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:28 +0100
Message-Id: <20170113205237.30386-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/9] block: Drop BDS.filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

*** This series is based on v4 of my ***
*** "block: Fix some filename generation issues" series ***


The BDS filename field is generally only used when opening disk images
or emitting error or warning messages, the only exception to this rule
is the map command of qemu-img. However, using exact_filename there
instead should not be a problem. Therefore, we can drop the filename
field from the BlockDriverState and use a function instead which builds
the filename from scratch when called.

This is slower than reading a static char array but the problem of that
static array is that it may become obsolete due to changes in any
BlockDriverState or in the BDS graph. Using a function which rebuilds
the filename every time it is called resolves this problem.

The disadvantage of worse performance is negligible, on the other hand.
After patch 3 of this series, which replaces some queries of
BDS.filename by reads from somewhere else (mostly BDS.exact_filename),
the filename field is only used when a disk image is opened or some
message should be emitted, both of which cases do not suffer from the
performance hit.


http://lists.nongnu.org/archive/html/qemu-devel/2015-06/msg07025.html
gives an example of how to achieve an outdated filename, so we do need
this series. We can technically fix it differently (by appropriately
invoking bdrv_refresh_filename()), but that is pretty difficult=E2=84=A2.=
 I find
this series simpler and it it's something we wanted to do anyway.

Regarding the fear that this might change current behavior, especially
for libvirt which used filenames to identify nodes in the BDS graph:
Since bdrv_open() already calls bdrv_refresh_filename() today, and
apparently everything works fine, this series will most likely not break
anything. The only thing that will change is if the BDS graph is
dynamically reconfigured at runtime, and in that case it's most likely a
bug fix. Also, I don't think libvirt supports such cases already.


tl;dr: This series is a bug fix and I don't think it'll break legacy
management applications relying on the filename to identify a BDS; as
long as they are not trying to continue that practice with more advanced
configurations (e.g. with Quorum).


v6:
- Rebased after more than a year
- Patch 1 is newly required for patch 6
- Patch 3: Rebase conflicts
- Patch 4: Related bug fix; fits well into this series because it
           requires that format drivers do not query their
           bs->exact_filename, and this series can ensure exactly that
           (and after patch 3, we can be pretty sure this is the case)
- Patch 5: Rebase conflicts, improved a comment, noticed that I'm now
           replacing all of the existing bdrv_refresh_filename() calls
           and changed the commit message accordingly
- Patch 6: Rewritten because the affected code has been rewritten in the
           meantime.
- Patch 7: Rebase conflicts
- Patch 8: Added in this version. It makes the series a bit more
           rigorous, and I think that's good.
- Patch 9: Rebase conflict


git-backport-diff against v5:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/9:[down] 'block: Always set *file in get_block_status'
002/9:[----] [-C] 'block: Change bdrv_get_encrypted_filename()'
003/9:[0011] [FC] 'block: Avoid BlockDriverState.filename'
004/9:[down] 'block: Do not blindly copy filename from file'
005/9:[0020] [FC] 'block: Add bdrv_filename()'
006/9:[0041] [FC] 'qemu-img: Use bdrv_filename() for map'
007/9:[0072] [FC] 'block: Drop BlockDriverState.filename'
008/9:[down] 'block: Complete move to pull filename updates'
009/9:[0003] [FC] 'iotests: Test changed Quorum filename'


Max Reitz (9):
  block: Always set *file in get_block_status
  block: Change bdrv_get_encrypted_filename()
  block: Avoid BlockDriverState.filename
  block: Do not blindly copy filename from file
  block: Add bdrv_filename()
  qemu-img: Use bdrv_filename() for map
  block: Drop BlockDriverState.filename
  block: Complete move to pull filename updates
  iotests: Test changed Quorum filename

 include/block/block.h     |  3 +-
 include/block/block_int.h | 13 ++++++-
 block.c                   | 96 ++++++++++++++++++++++++++++++++++-------=
------
 block/commit.c            |  4 +-
 block/file-posix.c        |  6 +--
 block/file-win32.c        |  4 +-
 block/gluster.c           |  3 +-
 block/io.c                |  6 ++-
 block/mirror.c            | 16 ++++++--
 block/nbd.c               |  5 ++-
 block/nfs.c               |  4 +-
 block/qapi.c              |  4 +-
 block/raw-format.c        |  4 +-
 block/replication.c       |  2 -
 block/vhdx-log.c          |  7 +++-
 block/vmdk.c              | 24 +++++++++---
 block/vpc.c               |  7 +++-
 blockdev.c                | 33 +++++++++++-----
 monitor.c                 |  5 ++-
 qemu-img.c                | 31 ++++++++++++---
 tests/qemu-iotests/041    | 16 ++++++--
 21 files changed, 215 insertions(+), 78 deletions(-)

--=20
2.11.0
