Received: from eggs.gnu.org ([2001:4830:134:3::10]:53999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgQk-0001fC-Px
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgQj-0000EC-Tw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:14 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 16 Nov 2018 16:52:59 +0100
Message-Id: <20181116155302.22472-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1? 0/3] block: Fix two minor reopen issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

These are fixes for issues I found when looking after something Berto
has reported.  The second patch fixes that issue Berto found, the first
one is only kind of related.

For the first patch:  bdrv_reopen_abort() or bdrv_reopen_commit() are
called only if the respective bdrv_reopen_prepare() has succeeded.
However, bdrv_reopen_prepare() can fail even if the block driver=E2=80=99=
s
.bdrv_reopen_prepare() succeeded.  In that case, the block driver is
expecting a .bdrv_reopen_abort() or .bdrv_reopen_commit(), but will
never get it.

This is fixed by making bdrv_reopen_prepare() call .bdrv_reopen_abort()
if an error occurs after .bdrv_reopen_prepare() has already succeeded.

In practice this just prevents resource leaks, so nothing too dramatic
(fine for qemu-next).  It also means I=E2=80=99ve been incapable of writi=
ng a
test, sorry.


The second issue is more severe: file-posix applies the inverse share
locks when reopening.  Now the user can only directly do reopens from
the monitor for now, so that wouldn=E2=80=99t be so bad.  But of course t=
here
are other places in qemu that implicitly reopen nodes, like dropping
R/W to RO or gaining R/W from RO.  Most of these places are symmetrical
at least (they=E2=80=99ll get R/W on an RO image for a short period of ti=
me and
then drop back to RO), so you=E2=80=99ll see the wrong shared permission =
locks
only for a short duration.  But at least blockdev-snapshot and
blockdev-snapshot-sync are one way; they drop R/W to RO and stay there.
So if you do a blockdev-snapshot*, the shared permission bits will be
flipped.  This is therefore very much user-visible.

It=E2=80=99s not catastrophic, though, so I=E2=80=99m not sure whether we=
 need it in
3.1.  It=E2=80=99s definitely a bugfix, and I think we have patches queue=
d for
the next RC already, so I think it makes sense to include at least
patches 2 and 3 as well.


Max Reitz (3):
  block: Always abort reopen after prepare succeeded
  file-posix: Fix shared locks on reopen commit
  iotests: Test file-posix locking and reopen

 block.c                    | 17 +++++++--
 block/file-posix.c         |  2 +-
 tests/qemu-iotests/182     | 71 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  9 +++++
 4 files changed, 96 insertions(+), 3 deletions(-)

--=20
2.17.2
