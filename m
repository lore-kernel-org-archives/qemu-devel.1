Received: from eggs.gnu.org ([2001:4830:134:3::10]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtIBi-0004yK-NU
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtIBh-0000RW-GS
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:51:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 16 Sep 2017 20:51:17 +0200
Message-Id: <20170916185123.29255-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/6] block: Don't compare strings in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

bdrv_reopen_prepare() assumes that all BDS options are strings, which is
not necessarily correct. This series introduces a new qobject_is_equal()
function which can be used to test whether any options have changed,
independently of their type.


v5:
- Patch 1: Changes due to rebase
- Patch 2: Added
- Patch 3: Made double QNums always unequal to integer QNums [Markus]
- Patch 6:
  - Removed many tests because they no longer make sense with double
    QNums generally being unequal to integer QNums
  - Use NAN from math.h instead of 0.0 / 0.0 [Eric]
  - dm42 should be a double, not an int (and I didn't notice because
    -42.0 was supposed to be equal to -42 anyway)
  - Rebase changes because QNull is now an own type


git-backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[0023] [FC] 'qapi/qnull: Add own header'
002/6:[down] 'qapi/qlist: Add qlist_append_null() macro'
003/6:[0035] [FC] 'qapi: Add qobject_is_equal()'
004/6:[----] [--] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
005/6:[----] [--] 'iotests: Add test for non-string option reopening'
006/6:[0153] [FC] 'tests: Add check-qobject for equality tests'


Max Reitz (6):
  qapi/qnull: Add own header
  qapi/qlist: Add qlist_append_null() macro
  qapi: Add qobject_is_equal()
  block: qobject_is_equal() in bdrv_reopen_prepare()
  iotests: Add test for non-string option reopening
  tests: Add check-qobject for equality tests

 tests/Makefile.include      |   4 +-
 include/qapi/qmp/qbool.h    |   1 +
 include/qapi/qmp/qdict.h    |   2 +
 include/qapi/qmp/qlist.h    |   4 +
 include/qapi/qmp/qnull.h    |  32 +++++
 include/qapi/qmp/qnum.h     |   1 +
 include/qapi/qmp/qobject.h  |  21 ++-
 include/qapi/qmp/qstring.h  |   1 +
 include/qapi/qmp/types.h    |   1 +
 block.c                     |  29 ++--
 qapi/qapi-clone-visitor.c   |   1 +
 qapi/string-input-visitor.c |   1 +
 qobject/qbool.c             |   8 ++
 qobject/qdict.c             |  29 ++++
 qobject/qlist.c             |  32 +++++
 qobject/qnull.c             |  11 +-
 qobject/qnum.c              |  54 ++++++++
 qobject/qobject.c           |  29 ++++
 qobject/qstring.c           |   9 ++
 tests/check-qnull.c         |   2 +-
 tests/check-qobject.c       | 315 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/133      |   9 ++
 tests/qemu-iotests/133.out  |   5 +
 23 files changed, 575 insertions(+), 26 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c

-- 
2.13.5
