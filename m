Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLAGQ-0007Gg-AG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLAGK-0003r4-Df
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:31:22 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 14 Jun 2017 17:30:58 +0200
Message-Id: <20170614153102.9077-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Don't compare strings in
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
 qobject/qdict.c            | 24 ++++++++++++++++++++++++
 qobject/qfloat.c           |  8 ++++++++
 qobject/qint.c             |  8 ++++++++
 qobject/qlist.c            | 25 +++++++++++++++++++++++++
 qobject/qnull.c            |  6 ++++++
 qobject/qobject.c          | 30 ++++++++++++++++++++++++++++++
 qobject/qstring.c          |  9 +++++++++
 target/i386/cpu.c          |  6 +-----
 tests/check-qnull.c        |  2 +-
 tests/qemu-iotests/133     |  9 +++++++++
 tests/qemu-iotests/133.out |  5 +++++
 22 files changed, 181 insertions(+), 26 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h

-- 
2.9.4
