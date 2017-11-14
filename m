Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWn-0000IJ-Iu
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWj-00038Z-K4
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:41 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 19:01:22 +0100
Message-Id: <20171114180128.17076-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11? v7 0/6] block: Don't compare strings
 in bdrv_reopen_prepare()
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


v7:
- Patch 6: Fix a clang warning:
    tests/check-qobject.c:39:24: error: passing an object that undergoes
                                 default argument promotion to
                                 'va_start' has undefined behavior
  TIL: You cannot use va_start(ap, foo) if @foo is a bool.  An int
       works, however.
       Feel free to explain the long version to me, because I don't
       think I have fully understood the issue, but it's something like
       "Using bools for variadic arguments results in their promotion to
       an int, but you have to use a type that is promoted to itself
       (like int)."


git-backport-diff against v6:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[----] [--] 'qapi/qnull: Add own header'
002/6:[----] [--] 'qapi/qlist: Add qlist_append_null() macro'
003/6:[----] [--] 'qapi: Add qobject_is_equal()'
004/6:[----] [--] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
005/6:[----] [--] 'iotests: Add test for non-string option reopening'
006/6:[0011] [FC] 'tests: Add check-qobject for equality tests'


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
 tests/check-qobject.c            | 328 +++++++++++++++++++++++++++++++++++++++
 scripts/coccinelle/qobject.cocci |   3 +
 tests/.gitignore                 |   1 +
 tests/qemu-iotests/133           |   9 ++
 tests/qemu-iotests/133.out       |   5 +
 25 files changed, 592 insertions(+), 26 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c

-- 
2.13.6
