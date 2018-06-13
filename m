Received: from eggs.gnu.org ([2001:4830:134:3::10]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTALs-00033X-Mo
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTALr-0004PG-JA
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:18:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:09 +0200
Message-Id: <20180613181823.13618-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/14] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

This series implements an active and synchronous mirroring mode.

You can read the cover letter of v4 here (I don=E2=80=99t like to copy-pa=
ste
that because people who reviewed previous versions know it already and
this saves them from having to look out for potential changes):

http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00185.html


v5:
- Patch 3: Rebase conflict with Kevin=E2=80=99s job series (kept R-bs bec=
ause
    it=E2=80=99s just a change in removed code (and a trivial one on top)=
)
- Patch 6: Removed completely unused BdrvChildList typedef [Berto]
    (kept R-bs again because this isn=E2=80=99t even a functional change.=
..)
- Patch 11: Added, because jobs are no longer supposed to have direct
    access to their progress info, but we need some way of just adding
    an offset to the progress end value in the next patch
- Patch 12:
  - s/2.12/3.0/ [Eric]
  - Use job_progress_*() functions
  (kept R-b because I think those to be very obvious changes)
- Patch 13: s/2.13/3.0/ (kept R-b because come on)
- Patch 14:
  - s/2017/2018/ (hey, why not)
  - qmp_to_opts() has been moved to VM
  (kept R-bs because I consider those to be trivial or obvious changes,
  respectively)


git-backport-diff to v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/14:[----] [--] 'block/mirror: Pull out mirror_perform()'
002/14:[----] [--] 'block/mirror: Convert to coroutines'
003/14:[0002] [FC] 'block/mirror: Use CoQueue to wait on in-flight ops'
004/14:[----] [-C] 'block/mirror: Wait for in-flight op conflicts'
005/14:[----] [-C] 'block/mirror: Use source as a BdrvChild'
006/14:[0002] [FC] 'block: Generalize should_update_child() rule'
007/14:[----] [--] 'hbitmap: Add @advance param to hbitmap_iter_next()'
008/14:[----] [--] 'test-hbitmap: Add non-advancing iter_next tests'
009/14:[----] [--] 'block/dirty-bitmap: Add bdrv_dirty_iter_next_area'
010/14:[----] [-C] 'block/mirror: Add MirrorBDSOpaque'
011/14:[down] 'job: Add job_progress_increase_remaining()'
012/14:[0006] [FC] 'block/mirror: Add active mirroring'
013/14:[0004] [FC] 'block/mirror: Add copy mode QAPI interface'
014/14:[0006] [FC] 'iotests: Add test for active mirroring'


Max Reitz (14):
  block/mirror: Pull out mirror_perform()
  block/mirror: Convert to coroutines
  block/mirror: Use CoQueue to wait on in-flight ops
  block/mirror: Wait for in-flight op conflicts
  block/mirror: Use source as a BdrvChild
  block: Generalize should_update_child() rule
  hbitmap: Add @advance param to hbitmap_iter_next()
  test-hbitmap: Add non-advancing iter_next tests
  block/dirty-bitmap: Add bdrv_dirty_iter_next_area
  block/mirror: Add MirrorBDSOpaque
  job: Add job_progress_increase_remaining()
  block/mirror: Add active mirroring
  block/mirror: Add copy mode QAPI interface
  iotests: Add test for active mirroring

 qapi/block-core.json         |  29 +-
 include/block/block_int.h    |   4 +-
 include/block/dirty-bitmap.h |   2 +
 include/qemu/hbitmap.h       |   5 +-
 include/qemu/job.h           |  15 +
 block.c                      |  44 ++-
 block/backup.c               |   2 +-
 block/dirty-bitmap.c         |  57 +++-
 block/mirror.c               | 605 ++++++++++++++++++++++++++++-------
 blockdev.c                   |   9 +-
 job.c                        |   5 +
 tests/test-hbitmap.c         |  38 ++-
 util/hbitmap.c               |  10 +-
 tests/qemu-iotests/151       | 120 +++++++
 tests/qemu-iotests/151.out   |   5 +
 tests/qemu-iotests/group     |   1 +
 16 files changed, 799 insertions(+), 152 deletions(-)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out

--=20
2.17.1
