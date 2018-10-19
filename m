Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDaFf-0003xm-Lw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDaFe-0005PQ-NR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:16:03 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 21:15:14 +0200
Message-Id: <20181019191523.12157-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/9] iotests: Make them work for both Python
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This series prepares the iotests to work with both Python 2 and 3.  In
some places, it adds version-specific code and decides what to do based
on the version (for instance, whether to import the StringIO or the
BytesIO class from 'io' for use with the test runner), but most of the
time, it just makes code work for both versions in general.

And when we make the switch to make Python 3 mandatory, we can simply
drop the Python 2 branches.


v2:
- Patch 3: Commit message fix [Philippe]
- Patch 4: Really convert all places that use / [Cleber]
- Patch 5:
  - Use list comprehension expressions where that makes sense [Eduardo]
  - Make 'range' an alias for 'xrange' in 044 and 163 [Cleber]
- Patch 6:
  - %s/3\.2/3.4/g [Cleber]
  - Use hasattr() instead of catching AttributeError [Cleber]
  - Call set_inheritable in send_fd_scm() for both the QMP socket FD and
    the FD to be passed (if any) [Eduardo]
- Patch 7: Kept as-is, because it's just the minimal amount of change
- Patch 8: Use io.BytesIO in Python 2 [Cleber]
- Patch 9: Use json.dumps(..., sort_keys=True) instead of homegrown
           stringification function [Eduardo]

(Also kept the order, because one vote against, one vote for, so I go
for what's simplest for me. O:-))


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[----] [--] 'iotests: Make nbd-fault-injector flush'
002/9:[----] [--] 'iotests: Flush in iotests.py's QemuIoInteractive'
003/9:[----] [--] 'iotests: Use Python byte strings where appropriate'
004/9:[0014] [FC] 'iotests: Use // for Python integer division'
005/9:[0013] [FC] 'iotests: Different iterator behavior in Python 3'
006/9:[0049] [FC] 'iotests: Explicitly inherit FDs in Python'
007/9:[----] [--] 'iotests: 'new' module replacement in 169'
008/9:[0017] [FC] 'iotests: Modify imports for Python 3'
009/9:[1644] [FC] 'iotests: Unify log outputs between Python 2 and 3'


Max Reitz (9):
  iotests: Make nbd-fault-injector flush
  iotests: Flush in iotests.py's QemuIoInteractive
  iotests: Use Python byte strings where appropriate
  iotests: Use // for Python integer division
  iotests: Different iterator behavior in Python 3
  iotests: Explicitly inherit FDs in Python
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
