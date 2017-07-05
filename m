Received: from eggs.gnu.org ([2001:4830:134:3::10]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpaw-0003xh-Di
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpav-0005t6-Gm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:14 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  5 Jul 2017 21:03:59 +0200
Message-Id: <20170705190404.22449-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/5] block: Don't compare strings in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

bdrv_reopen_prepare() assumes that all BDS options are strings, which is
not necessarily correct. This series introduces a new qobject_is_equal()
function which can be used to test whether any options have changed,
independently of their type.


v4:
- Patch 1: Kept, because Markus gave his R-b already...
- Patch 2: Check that doubles match integers exactly, not just after the
           integer has been (lossily) converted to a double
           [Markus/Eric]
- Patch 3: Winged comment and s/simply can not/can simply omit/ (:-()
           [Markus/Eric]
- Patch 5:
  - Mention (at least one) reason for the non-reflexivity of
    qobject_is_equal() (that being NaN) [Eric]
  - Mention that NaN cannot occur in JSON [Eric]
  - Tests for integer values that cannot be exactly represented as a
    double


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'qapi/qnull: Add own header'
002/5:[0032] [FC] 'qapi: Add qobject_is_equal()'
003/5:[0022] [FC] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
004/5:[----] [--] 'iotests: Add test for non-string option reopening'
005/5:[0114] [FC] 'tests: Add check-qobject for equality tests'


Max Reitz (5):
  qapi/qnull: Add own header
  qapi: Add qobject_is_equal()
  block: qobject_is_equal() in bdrv_reopen_prepare()
  iotests: Add test for non-string option reopening
  tests: Add check-qobject for equality tests

 tests/Makefile.include     |   4 +-
 include/qapi/qmp/qbool.h   |   1 +
 include/qapi/qmp/qdict.h   |   1 +
 include/qapi/qmp/qlist.h   |   1 +
 include/qapi/qmp/qnull.h   |  28 ++++
 include/qapi/qmp/qnum.h    |   1 +
 include/qapi/qmp/qobject.h |  17 +-
 include/qapi/qmp/qstring.h |   1 +
 include/qapi/qmp/types.h   |   1 +
 block.c                    |  29 ++--
 qobject/qbool.c            |   8 +
 qobject/qdict.c            |  29 ++++
 qobject/qlist.c            |  32 ++++
 qobject/qnull.c            |  11 +-
 qobject/qnum.c             |  77 +++++++++
 qobject/qobject.c          |  29 ++++
 qobject/qstring.c          |   9 +
 tests/check-qnull.c        |   2 +-
 tests/check-qobject.c      | 404 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/133     |   9 +
 tests/qemu-iotests/133.out |   5 +
 21 files changed, 677 insertions(+), 22 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c

-- 
2.9.4
