Received: from eggs.gnu.org ([2001:4830:134:3::10]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1y-0005lP-3M
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1x-0002cN-AH
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 13:14:21 +0200
Message-Id: <20180713111424.23670-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input base
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

This series allows using qemu-img rebase on images that do not have a
backing file.  Right now, this fails with the rather cryptic error
message:

$ qemu-img rebase -b base.qcow2 foo.qcow2
qemu-img: Could not open old backing file '': The 'file' block driver req=
uires a file name

Yeah, well, OK.

With how rebase currently works, this would lead to the overlay being
filled with zeroes, however.  This is where patch 2 comes in and instead
makes rebase use blk_pwrite_zeroes() whenever it handles an area past
the input=E2=80=99s backing file=E2=80=99s EOF.

(Note that additionally we could try to punch holes in the overlay
whenever it matches the new backing file, but that=E2=80=99s something I=E2=
=80=99ll put
off for later.  (We don=E2=80=99t even have a reliable method for punchin=
g holes
into an overlay yet, although I would like to have such because it could
make active commit more efficient.))


And patch 3 adds the usual test.


Max Reitz (3):
  qemu-img: Allow rebase with no input base
  qemu-img: Use zero writes after source backing EOF
  iotests: Add test for rebase without input base

 qemu-img.c                 | 72 +++++++++++++++++++++++---------------
 tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
 3 files changed, 150 insertions(+), 29 deletions(-)

--=20
2.17.1
