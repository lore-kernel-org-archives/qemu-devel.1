Received: from eggs.gnu.org ([2001:4830:134:3::10]:35445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0Pk-0006V0-SC
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0Pk-00085o-25
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:25:16 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Jul 2017 14:25:00 +0200
Message-Id: <20170703122505.32017-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] block: Don't compare strings in
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


v3:
- Patch 1:
  - Fix copyright header [Markus]
  - Drop qobject.h include from qnull.c [Markus]
  - Replacing all QObject includes by qmp/types.h in target/i386/cpu.c
    became unnecessary due to 01b2ffcedd94ad7b42bc870e4c6936c87ad03429
    (kept R-b anyway, because v2 contained exactly the same change as
     that commit)
- Patch 2:
  - Move the code for QInt and QFloat to QNum
  - Write function descriptions in imperative mood [Markus]
  - Break comment lines after 70 characters [Markus]
  - Style changes [Markus]
- Patch 3: Add a comment on what will go wrong when using e.g. -blockdev
           and the qemu-io reopen command together [Markus]
- Patch 5: Added some test cases for qobject_is_equal() [Markus]


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[0017] [FC] 'qapi/qnull: Add own header'
002/5:[0120] [FC] 'qapi: Add qobject_is_equal()'
003/5:[0018] [FC] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
004/5:[----] [--] 'iotests: Add test for non-string option reopening'
005/5:[down] 'tests: Add check-qobject for equality tests'


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
 include/qapi/qmp/qobject.h |  17 +--
 include/qapi/qmp/qstring.h |   1 +
 include/qapi/qmp/types.h   |   1 +
 block.c                    |  31 +++--
 qobject/qbool.c            |   8 ++
 qobject/qdict.c            |  29 +++++
 qobject/qlist.c            |  32 +++++
 qobject/qnull.c            |  11 +-
 qobject/qnum.c             |  53 ++++++++
 qobject/qobject.c          |  29 +++++
 qobject/qstring.c          |   9 ++
 tests/check-qnull.c        |   2 +-
 tests/check-qobject.c      | 312 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/133     |   9 ++
 tests/qemu-iotests/133.out |   5 +
 21 files changed, 561 insertions(+), 24 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c

-- 
2.9.4
