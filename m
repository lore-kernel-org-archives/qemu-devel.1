Received: from eggs.gnu.org ([2001:4830:134:3::10]:39522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gEaeC-0002xW-IW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gEaeB-000690-5D
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:53:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 Oct 2018 14:52:58 +0100
Message-Id: <20181022135307.14398-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/9] iotests: Make them work for both Python
 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This series prepares the iotests to work with both Python 2 and 3.  In
some places, it adds version-specific code and decides what to do based
on the version (for instance, whether to import the StringIO or the
BytesIO class from 'io' for use with the test runner), but most of the
time, it just makes code work for both versions in general.

And when we make the switch to make Python 3 mandatory, we can simply
drop the Python 2 branches.


v3:
- Patch 5: s/list comprehension/a generator expression/ in the commit
           message [Eduardo]
- Patch 6: s/inherit/bequeath/ in commit title (the Python script
           bequeathes, it does not inherit)
- Patch 8: s/StringIO()/io.StringIO/ [Eduardo]


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[----] [--] 'iotests: Make nbd-fault-injector flush'
002/9:[----] [--] 'iotests: Flush in iotests.py's QemuIoInteractive'
003/9:[----] [--] 'iotests: Use Python byte strings where appropriate'
004/9:[----] [--] 'iotests: Use // for Python integer division'
005/9:[----] [--] 'iotests: Different iterator behavior in Python 3'
006/9:[down] 'iotests: Explicitly bequeath FDs in Python'
       ^^^^ Changed commit title, actually [----] [--]
007/9:[----] [--] 'iotests: 'new' module replacement in 169'
008/9:[0002] [FC] 'iotests: Modify imports for Python 3'
009/9:[----] [--] 'iotests: Unify log outputs between Python 2 and 3'


Max Reitz (9):
  iotests: Make nbd-fault-injector flush
  iotests: Flush in iotests.py's QemuIoInteractive
  iotests: Use Python byte strings where appropriate
  iotests: Use // for Python integer division
  iotests: Different iterator behavior in Python 3
  iotests: Explicitly bequeath FDs in Python
  iotests: 'new' module replacement in 169
  iotests: Modify imports for Python 3
  iotests: Unify log outputs between Python 2 and 3

 scripts/qemu.py                          |  34 +-
 scripts/qtest.py                         |   2 +-
 tests/qemu-iotests/030                   |   2 +-
 tests/qemu-iotests/040                   |   4 +-
 tests/qemu-iotests/041                   |   4 +-
 tests/qemu-iotests/044                   |  24 +-
 tests/qemu-iotests/045                   |   2 +-
 tests/qemu-iotests/056                   |   2 +-
 tests/qemu-iotests/065                   |   4 +-
 tests/qemu-iotests/083.out               |   9 +
 tests/qemu-iotests/093                   |  18 +-
 tests/qemu-iotests/124                   |   4 +-
 tests/qemu-iotests/136                   |   2 +-
 tests/qemu-iotests/139                   |   2 +-
 tests/qemu-iotests/147                   |   2 +-
 tests/qemu-iotests/149                   |  14 +-
 tests/qemu-iotests/151                   |  12 +-
 tests/qemu-iotests/163                   |  13 +-
 tests/qemu-iotests/169                   |   3 +-
 tests/qemu-iotests/194.out               |  22 +-
 tests/qemu-iotests/202.out               |  12 +-
 tests/qemu-iotests/203.out               |  14 +-
 tests/qemu-iotests/206.out               | 218 +++++-----
 tests/qemu-iotests/207                   |   6 +-
 tests/qemu-iotests/207.out               |  72 ++--
 tests/qemu-iotests/208.out               |   8 +-
 tests/qemu-iotests/210.out               |  94 ++--
 tests/qemu-iotests/211.out               | 102 ++---
 tests/qemu-iotests/212.out               | 174 ++++----
 tests/qemu-iotests/213.out               | 182 ++++----
 tests/qemu-iotests/216.out               |   4 +-
 tests/qemu-iotests/218.out               |  20 +-
 tests/qemu-iotests/219.out               | 526 +++++++++++------------
 tests/qemu-iotests/222.out               |  24 +-
 tests/qemu-iotests/iotests.py            |  37 +-
 tests/qemu-iotests/nbd-fault-injector.py |  12 +-
 tests/qemu-iotests/qcow2.py              |  10 +-
 tests/qemu-iotests/qed.py                |   6 +-
 38 files changed, 879 insertions(+), 821 deletions(-)

-- 
2.17.1
