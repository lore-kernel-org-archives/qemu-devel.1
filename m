Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfz8-0005ud-4O
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfz7-0006Ki-EL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:47:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 15:47:40 +0200
Message-Id: <20170621134744.8047-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

bdrv_reopen_prepare() assumes that all BDS options are strings, which is
not necessarily correct. This series introduces a new qobject_is_equal()
function which can be used to test whether any options have changed,
independently of their type.


v2:
- Add comments detailing when QDicts and QLists are considered equal
  [Kevin]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/4:[----] [--] 'qapi/qnull: Add own header'
002/4:[0009] [FC] 'qapi: Add qobject_is_equal()'
003/4:[----] [--] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
004/4:[----] [--] 'iotests: Add test for non-string option reopening'


Max Reitz (4):
  qapi/qnull: Add own header
  qapi: Add qobject_is_equal()
  block: qobject_is_equal() in bdrv_reopen_prepare()
  iotests: Add test for non-string option reopening

 include/qapi/qmp/qbool.h   |  1 +
 include/qapi/qmp/qdict.h   |  1 +
 include/qapi/qmp/qfloat.h  |  1 +
 include/qapi/qmp/qint.h    |  1 +
 include/qapi/qmp/qlist.h   |  1 +
 include/qapi/qmp/qnull.h   | 28 ++++++++++++++++++++++++++++
 include/qapi/qmp/qobject.h | 17 +++++++++--------
 include/qapi/qmp/qstring.h |  1 +
 include/qapi/qmp/types.h   |  1 +
 block.c                    | 15 +++------------
 qobject/qbool.c            |  8 ++++++++
 qobject/qdict.c            | 28 ++++++++++++++++++++++++++++
 qobject/qfloat.c           |  8 ++++++++
 qobject/qint.c             |  8 ++++++++
 qobject/qlist.c            | 30 ++++++++++++++++++++++++++++++
 qobject/qnull.c            |  6 ++++++
 qobject/qobject.c          | 30 ++++++++++++++++++++++++++++++
 qobject/qstring.c          |  9 +++++++++
 target/i386/cpu.c          |  6 +-----
 tests/check-qnull.c        |  2 +-
 tests/qemu-iotests/133     |  9 +++++++++
 tests/qemu-iotests/133.out |  5 +++++
 22 files changed, 190 insertions(+), 26 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h

-- 
2.9.4
