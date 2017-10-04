Received: from eggs.gnu.org ([2001:4830:134:3::10]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzlYq-0004fh-RE
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzlYp-000129-Uc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:26:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  4 Oct 2017 17:25:47 +0200
Message-Id: <20171004152553.30263-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

bdrv_reopen_prepare() assumes that all BDS options are strings, which is
not necessarily correct. This series introduces a new qobject_is_equal()
function which can be used to test whether any options have changed,
independently of their type.


v6:
- Patch 2: Added corresponding Coccinelle rule [Eric]
- Patch 6:
  - Added .gitignore entry [Eric]
  - Removed leading underscore [Markus]
  - Replaced test_equality() by check_equal()+check_unequal() [Markus]
  - Put type conversion (or rather non-conversion) tests into an own
    function [Markus]
  - Fixed a line > 80 characters


git-backport-diff against v5:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[----] [--] 'qapi/qnull: Add own header'
002/6:[0001] [FC] 'qapi/qlist: Add qlist_append_null() macro'
003/6:[----] [--] 'qapi: Add qobject_is_equal()'
004/6:[----] [--] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
005/6:[----] [--] 'iotests: Add test for non-string option reopening'
006/6:[0097] [FC] 'tests: Add check-qobject for equality tests'


Max Reitz (6):
  qapi/qnull: Add own header
  qapi/qlist: Add qlist_append_null() macro
  qapi: Add qobject_is_equal()
  block: qobject_is_equal() in bdrv_reopen_prepare()
  iotests: Add test for non-string option reopening
  tests: Add check-qobject for equality tests

 tests/Makefile.include           |   4 +-
 include/qapi/qmp/qbool.h         |   1 +
 include/qapi/qmp/qdict.h         |   2 +
 include/qapi/qmp/qlist.h         |   4 +
 include/qapi/qmp/qnull.h         |  32 ++++
 include/qapi/qmp/qnum.h          |   1 +
 include/qapi/qmp/qobject.h       |  21 ++-
 include/qapi/qmp/qstring.h       |   1 +
 include/qapi/qmp/types.h         |   1 +
 block.c                          |  29 ++--
 qapi/qapi-clone-visitor.c        |   1 +
 qapi/string-input-visitor.c      |   1 +
 qobject/qbool.c                  |   8 +
 qobject/qdict.c                  |  29 ++++
 qobject/qlist.c                  |  32 ++++
 qobject/qnull.c                  |  11 +-
 qobject/qnum.c                   |  54 +++++++
 qobject/qobject.c                |  29 ++++
 qobject/qstring.c                |   9 ++
 tests/check-qnull.c              |   2 +-
 tests/check-qobject.c            | 325 +++++++++++++++++++++++++++++++++++++++
 scripts/coccinelle/qobject.cocci |   3 +
 tests/.gitignore                 |   1 +
 tests/qemu-iotests/133           |   9 ++
 tests/qemu-iotests/133.out       |   5 +
 25 files changed, 589 insertions(+), 26 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c

-- 
2.13.6
