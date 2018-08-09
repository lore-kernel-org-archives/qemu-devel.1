Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSq-0007uT-6w
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSo-0002Xo-SR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:06 +0200
Message-Id: <20180809223117.7846-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] block: Deal with filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Note 1: This series depends on v10 of my =E2=80=9Cblock: Fix some filenam=
e
generation issues=E2=80=9D series.

Based-on: <20180809213528.14738-1-mreitz@redhat.com>

Note 2: This is technically the first part of my active mirror followup.
But just very technically.  I noticed that that followup started to
consist of two parts, namely (A) fix filtery things in the block layer,
and (B) fix active mirror.  So I decided to split it.  This is part A.
Part B comes later.


When we introduced filters, we did it a bit casually.  Sure, we talked a
lot about them before, but that was mostly discussion about where
implicit filters should be added to the graph (note that we currently
only have two implicit filters, those being mirror and commit).  But in
the end, we really just designated some drivers filters (Quorum,
blkdebug, etc.) and added some specifically (throttle, COR), without
really looking through the block layer to see where issues might occur.

It turns out vast areas of the block layer just don't know about filters
and cannot really handle them.  Many cases will work in practice, in
others, well, too bad, you cannot use some feature because some part
deep inside the block layer looks at your filters and thinks they are
format nodes.

This series sets out to correct a bit of that.  I lost my head many
times and I'm sure this series is incomplete in many ways, but it really
doesn't do any good if it sits on my disk any longer, it needs to go out
now.

The most important patches of this series are patches 3 and 4.  These
introduce functions to encapsulate bs->backing and bs->file accesses.
Because sometimes, bs->backing means COW, sometimes it means filtered
node.  And sometimes, bs->file means metadata storage, and sometimes it
means filtered node.  With this functions, it's always clear what the
caller wants, and it will always get what it wants.

Besides that, patch 3 introduces functions to skip filters which may be
used by parts of the block layer that just don't care about them.


Secondly, the restraints put on mirror's @replaces parameter are
revisited and fixed.


Thirdly, BDS.backing_file is changed to be constant.  I don't quite know
why we modify it whenever we change a BDS's backing file, but that's
definitely not quite right.  This fixes things like being able to
perform a commit on a file (using relative filenames) in a directory
that's not qemu's CWD.


Finally, a number of tests are added.


There are probably many things that are worthy of discussion, of which
only some come to my head, e.g.:

- In which cases do we want to skip filters, in which cases do we want
  to skip implicit filters?
  My approach was to basically never skip explicitly added filters,
  except when it's about finding a file in some tree (e.g. in a backing
  chain).  Maybe there are cases where you think we should skip even
  explicitly added filters.

- I made interesting decisions like =E2=80=9CWhen you mirror from a node,=
 we
  should indeed mirror from that node, but when replacing it, we should
  skip leave all implicit filters on top intact.=E2=80=9D  You may disagr=
ee with
  that.
  (My reasoning here is that users aren't supposed to know about
  implicit filters, and therefore, they should not intend to remove
  them.  Also, mirror accepts only root nodes as the source, so you
  cannot really specify the node below the implicit filters.  But you
  can use @replaces to drop the implicit filters, if you know they are
  there.)


v2:
- Patch 4: We must clear BDS.exact_filename for filter nodes, or we
  basically end up with a random filename for them.  This is achieved by
  pulling the !drv->is_filter check into an inner condition.
  (Fixes iotests 40 and 184)

- Patch 7: iotest 228 tried to use QAPI's backing_file information
  (which was very inconsistent, so with 228 doing some funky backing
  stuff, it really showed) to get some idea of what qemu thinks about
  the image header.  Let's make it use full-backing-filename (and that
  now really reflects the image header).


Max Reitz (11):
  block: Mark commit and mirror as filter drivers
  blockdev: Check @replaces in blockdev_mirror_common
  block: Filtered children access functions
  block: Storage child access function
  block: Fix check_to_replace_node()
  iotests: Add tests for mirror @replaces loops
  block: Leave BDS.backing_file constant
  iotests: Add filter commit test cases
  iotests: Add filter mirror test cases
  iotests: Add test for commit in sub directory
  iotests: Test committing to overridden backing

 qapi/block-core.json           |   4 +
 include/block/block.h          |   2 +
 include/block/block_int.h      |  53 ++++-
 block.c                        | 341 ++++++++++++++++++++++++++++-----
 block/backup.c                 |   8 +-
 block/block-backend.c          |  16 +-
 block/commit.c                 |  38 ++--
 block/io.c                     |  47 +++--
 block/mirror.c                 |  39 ++--
 block/qapi.c                   |  38 ++--
 block/snapshot.c               |  40 ++--
 block/stream.c                 |  15 +-
 blockdev.c                     | 167 ++++++++++++----
 migration/block-dirty-bitmap.c |   4 +-
 nbd/server.c                   |   8 +-
 qemu-img.c                     |  24 ++-
 tests/qemu-iotests/020         |  36 ++++
 tests/qemu-iotests/020.out     |  10 +
 tests/qemu-iotests/040         | 191 ++++++++++++++++++
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/041         | 270 +++++++++++++++++++++++++-
 tests/qemu-iotests/041.out     |   4 +-
 tests/qemu-iotests/191.out     |   1 -
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/228.out     |   6 +-
 25 files changed, 1141 insertions(+), 231 deletions(-)

--=20
2.17.1
