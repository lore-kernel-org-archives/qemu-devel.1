Received: from eggs.gnu.org ([209.51.188.92]:39656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjM-0006Ei-J6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjL-0005BD-Bd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 30 Jan 2019 16:24:24 +0100
Message-Id: <20190130152434.17283-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] iotests: Fix some issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

A couple of iotests for not-so-common formats/protocols are broken for
me, so this series fixes them.

The last patch in this series is not required, but it seemed like a good
thing to do to me.


There are more issues, but those should be fixed separately (and these
are only the ones I know of):
- 093 and 136 are flaky if the system is under load, I=E2=80=99ve reporte=
d this
  to Berto, and he seems to be working on it O:-)

- I=E2=80=99ve seen aborts in 169; Vladimir has sent patches for this, I=E2=
=80=99m just
  not sure yet who=E2=80=99s going to take them (the iotest patch is good=
, the
  QMP patch, well, is a QMP patch, so it isn=E2=80=99t my immediate terri=
torry)

- 129 is broken because it uses BB throttling underneath block jobs;
  unfortunately at least the mirror job completely ignores that
  throttling (and has done so for a while), so we need to get something
  working with a filter node there.  But that=E2=80=99s not so easy, for =
a
  couple of reasons:
  (1) The commit job doesn=E2=80=99t work with that right now because it =
cannot
      deal with such a filter in the commit chain (I have to look at
      this in the context of my =E2=80=9CDeal with filters=E2=80=9D serie=
s)
  (2) Also, such a change results in a failed assertion:
      http://lists.nongnu.org/archive/html/qemu-block/2019-01/msg01006.ht=
ml

Finally, note that tcp_chr_disconnect() has a bit of a problem with
running concurrently, so that causes tests to fail, too:
http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html


v2:
- Added a note to patch 1 that even with this patch, 237 will fail on
  Python 2.x [John]
- Put patch 5 (which fixes that) right after patch 1 [John]
- Added a note to patch 2 (which used to be patch 5) on what the exact
  issue is [John]
- Patch 6: Dropped the test for =E2=80=9Cbytes=E2=80=9D, because you cann=
ot use such
  objects like normal strings anyway [John?]
- Patch 9: Added


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/10:[----] [--] 'iotests: Re-add filename filters'
002/10:[----] [--] 'iotests: Fix 237 for Python 2.x'
003/10:[----] [--] 'iotests: Remove superfluous rm from 232'
004/10:[----] [--] 'iotests: Fix 232 for LUKS'
005/10:[----] [--] 'iotests: Fix 207 to use QMP filters for qmp_log'
006/10:[0002] [FC] 'iotests.py: Add is_str()'
007/10:[----] [--] 'iotests.py: Filter filename in any string value'
008/10:[----] [--] 'iotests: Filter SSH paths'
009/10:[down] 'iotests: Let 045 be run concurrently'
010/10:[----] [--] 'iotests.py: s/_/-/g on keys in qmp_log()'


Max Reitz (10):
  iotests: Re-add filename filters
  iotests: Fix 237 for Python 2.x
  iotests: Remove superfluous rm from 232
  iotests: Fix 232 for LUKS
  iotests: Fix 207 to use QMP filters for qmp_log
  iotests.py: Add is_str()
  iotests.py: Filter filename in any string value
  iotests: Filter SSH paths
  iotests: Let 045 be run concurrently
  iotests.py: s/_/-/g on keys in qmp_log()

 scripts/qemu.py               |  5 ++--
 tests/qemu-iotests/045        |  2 +-
 tests/qemu-iotests/206.out    | 56 +++++++++++++++++------------------
 tests/qemu-iotests/207        | 10 +++++--
 tests/qemu-iotests/207.out    | 18 +++++------
 tests/qemu-iotests/210        |  5 ++--
 tests/qemu-iotests/210.out    | 28 +++++++++---------
 tests/qemu-iotests/211        |  5 ++--
 tests/qemu-iotests/211.out    | 26 ++++++++--------
 tests/qemu-iotests/212        |  5 ++--
 tests/qemu-iotests/212.out    | 44 +++++++++++++--------------
 tests/qemu-iotests/213        |  5 ++--
 tests/qemu-iotests/213.out    | 46 ++++++++++++++--------------
 tests/qemu-iotests/232        |  5 +++-
 tests/qemu-iotests/237        |  7 +++--
 tests/qemu-iotests/237.out    | 54 ++++++++++++++++-----------------
 tests/qemu-iotests/common.rc  |  1 +
 tests/qemu-iotests/iotests.py | 14 +++++++--
 18 files changed, 178 insertions(+), 158 deletions(-)

--=20
2.20.1
