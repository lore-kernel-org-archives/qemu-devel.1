Received: from eggs.gnu.org ([2001:4830:134:3::10]:41475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Umm-0006cr-Iy
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Umk-0005sF-SO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:08 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 12:31:45 -0400
Message-Id: <cover.1508257445.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/10] qemu-iotests improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com


Previous series subject: "qemu-iotests: place output in unique dir"


Changes v4 -> v5:
-------------------

Relatively minor changes:

    * line-too-long complaint by patchew

    * fixed running from out-of-tree

    * fixed 2 other bugs found: one test was forgotten,
      and some QEMU process FIFOs were left behind.

    * output formatting changes

git-backport-diff -r qemu/master.. -u devel-iotests-v4
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/10:[----] [--] 'qemu-iotests: refuse to run if TEST_DIR contains spac=
es'
002/10:[0012] [FC] 'qemu-iotests: set TEST_DIR to a unique dir for each t=
est'
003/10:[----] [-C] 'qemu-iotests: automatically clean up bash protocol se=
rvers'
004/10:[----] [--] 'qemu-iotests: remove file cleanup from bash tests'
005/10:[0064] [FC] 'qemu-iotests: change qemu pid and fd tracking / clean=
up'
006/10:[0007] [FC] 'qemu-iotests: make ./check automatically reap QEMU pr=
ocesses'
007/10:[0003] [FC] 'qemu-iotests: run python tests in own subdirectories'
008/10:[0002] [FC] 'qemu-iotests: modify python tests to run from subdir'
009/10:[----] [--] 'qemu-iotests: add option to save temp files on error'
010/10:[0066] [FC] 'qemu-iotests: add support for running multi-threaded =
iotests'




Changes v3 -> v4:
-------------------

Significant changes from v3.  Highlights of the major changes from v3:

    * Python tests are properly run in hierarchial sub-directories now
       (Thanks Stefan, John)

    * Protocol servers are cleaned up automatically (Thanks Kevin)

    * Prevent running qemu-iotests if TEST_DIR contains spaces

    * common.qemu process reaping overhauled, and qemu processes
      also automatically killed on test conclusion

    * multi-thread iotest job support.  Here is an example of the
      speedup:


Previous, single-thread run of everything qcow2:


# ./check -qcow2

[...]

Not run: 045 059 064 070 075 076 077 078 081 083 084 088 092 093 094 101
         106 109 113 116 119 123 128 131 135 136 146 148 149 160 171 173 =
175
Failures: 191
Failed 1 of 149 tests

real    8m22.077s
user    4m48.177s
sys     1m16.553s


Multi-process run:

# ./check -qcow2 -j 5

[...]

Not run: 045 059 064 070 075 076 077 078 081 083 084 088 092 093 094 101
         106 109 113 116 119 123 128 131 135 136 146 148 149 160 171 173 =
175
Failures: 183 191
Failed 2 of 149 tests

real    3m7.458s
user    5m29.678s
sys     1m55.007s


(See commit message on patch 10 for why there is an additional test
 failure)


git-backport-diff -r qemu/master.. -u devel-iotests-v3
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/10:[down] 'qemu-iotests: refuse to run if TEST_DIR contains spaces'
002/10:[----] [--] 'qemu-iotests: set TEST_DIR to a unique dir for each t=
est'
003/10:[down] 'qemu-iotests: automatically clean up bash protocol servers=
'
004/10:[0073] [FC] 'qemu-iotests: remove file cleanup from bash tests'
005/10:[down] 'qemu-iotests: change qemu pid and fd tracking / cleanup'
006/10:[down] 'qemu-iotests: make ./check automatically reap QEMU process=
es'
007/10:[down] 'qemu-iotests: run python tests in own subdirectories'
008/10:[down] 'qemu-iotests: modify python tests to run from subdir'
009/10:[0017] [FC] 'qemu-iotests: add option to save temp files on error'
010/10:[down] 'qemu-iotests: add support for running multi-threaded iotes=
ts'


Jeff Cody (10):
  qemu-iotests: refuse to run if TEST_DIR contains spaces
  qemu-iotests: set TEST_DIR to a unique dir for each test
  qemu-iotests: automatically clean up bash protocol servers
  qemu-iotests: remove file cleanup from bash tests
  qemu-iotests: change qemu pid and fd tracking / cleanup
  qemu-iotests: make ./check automatically reap QEMU processes
  qemu-iotests: run python tests in own subdirectories
  qemu-iotests: modify python tests to run from subdir
  qemu-iotests: add option to save temp files on error
  qemu-iotests: add support for running multi-threaded iotests

 tests/qemu-iotests/001         |   6 -
 tests/qemu-iotests/002         |   6 -
 tests/qemu-iotests/003         |   6 -
 tests/qemu-iotests/004         |   6 -
 tests/qemu-iotests/005         |   6 -
 tests/qemu-iotests/007         |   7 -
 tests/qemu-iotests/008         |   6 -
 tests/qemu-iotests/009         |   6 -
 tests/qemu-iotests/010         |   6 -
 tests/qemu-iotests/011         |   6 -
 tests/qemu-iotests/012         |   6 -
 tests/qemu-iotests/013         |   6 -
 tests/qemu-iotests/014         |   6 -
 tests/qemu-iotests/015         |   7 -
 tests/qemu-iotests/017         |   6 -
 tests/qemu-iotests/018         |   6 -
 tests/qemu-iotests/019         |   8 -
 tests/qemu-iotests/020         |   8 -
 tests/qemu-iotests/021         |   6 -
 tests/qemu-iotests/022         |   6 -
 tests/qemu-iotests/023         |   6 -
 tests/qemu-iotests/024         |   8 -
 tests/qemu-iotests/025         |   6 -
 tests/qemu-iotests/026         |   7 -
 tests/qemu-iotests/027         |   6 -
 tests/qemu-iotests/028         |   8 -
 tests/qemu-iotests/029         |   7 -
 tests/qemu-iotests/030         |  82 ++++-----
 tests/qemu-iotests/031         |   6 -
 tests/qemu-iotests/032         |   6 -
 tests/qemu-iotests/033         |   6 -
 tests/qemu-iotests/034         |   6 -
 tests/qemu-iotests/035         |   6 -
 tests/qemu-iotests/036         |   6 -
 tests/qemu-iotests/037         |   6 -
 tests/qemu-iotests/038         |   6 -
 tests/qemu-iotests/039         |   6 -
 tests/qemu-iotests/040         | 128 ++++++-------
 tests/qemu-iotests/041         | 333 ++++++++++++++++-----------------
 tests/qemu-iotests/042         |   6 -
 tests/qemu-iotests/043         |   7 -
 tests/qemu-iotests/044         |  11 +-
 tests/qemu-iotests/045         |  42 ++---
 tests/qemu-iotests/046         |   6 -
 tests/qemu-iotests/047         |   6 -
 tests/qemu-iotests/048         |   8 -
 tests/qemu-iotests/048.out     |   1 -
 tests/qemu-iotests/049         |   6 -
 tests/qemu-iotests/050         |   8 -
 tests/qemu-iotests/051         |   6 -
 tests/qemu-iotests/052         |   6 -
 tests/qemu-iotests/053         |   7 -
 tests/qemu-iotests/054         |   6 -
 tests/qemu-iotests/055         |  97 +++++-----
 tests/qemu-iotests/056         |  39 ++--
 tests/qemu-iotests/057         |   4 +-
 tests/qemu-iotests/058         |  47 ++---
 tests/qemu-iotests/059         |   7 -
 tests/qemu-iotests/060         |   6 -
 tests/qemu-iotests/061         |   6 -
 tests/qemu-iotests/062         |   6 -
 tests/qemu-iotests/063         |   7 -
 tests/qemu-iotests/064         |   6 -
 tests/qemu-iotests/065         |  13 +-
 tests/qemu-iotests/066         |   6 -
 tests/qemu-iotests/068         |   6 -
 tests/qemu-iotests/069         |   6 -
 tests/qemu-iotests/070         |   6 -
 tests/qemu-iotests/071         |   6 -
 tests/qemu-iotests/072         |   6 -
 tests/qemu-iotests/073         |   6 -
 tests/qemu-iotests/074         |   9 -
 tests/qemu-iotests/074.out     |   1 -
 tests/qemu-iotests/075         |   6 -
 tests/qemu-iotests/076         |   6 -
 tests/qemu-iotests/077         |   6 -
 tests/qemu-iotests/078         |   6 -
 tests/qemu-iotests/079         |   6 -
 tests/qemu-iotests/080         |   7 -
 tests/qemu-iotests/081         |   8 -
 tests/qemu-iotests/082         |   6 -
 tests/qemu-iotests/083         |   8 -
 tests/qemu-iotests/084         |   6 -
 tests/qemu-iotests/085         |  13 --
 tests/qemu-iotests/086         |   6 -
 tests/qemu-iotests/088         |   7 -
 tests/qemu-iotests/089         |   6 -
 tests/qemu-iotests/090         |   6 -
 tests/qemu-iotests/091         |   8 -
 tests/qemu-iotests/092         |   7 -
 tests/qemu-iotests/094         |   9 -
 tests/qemu-iotests/095         |   8 -
 tests/qemu-iotests/096         |   8 +-
 tests/qemu-iotests/097         |   7 -
 tests/qemu-iotests/098         |   7 -
 tests/qemu-iotests/099         |   6 -
 tests/qemu-iotests/101         |   6 -
 tests/qemu-iotests/102         |   7 -
 tests/qemu-iotests/103         |   6 -
 tests/qemu-iotests/104         |   2 -
 tests/qemu-iotests/105         |   6 -
 tests/qemu-iotests/106         |   6 -
 tests/qemu-iotests/107         |   6 -
 tests/qemu-iotests/108         |   6 -
 tests/qemu-iotests/109         |   8 -
 tests/qemu-iotests/110         |   6 -
 tests/qemu-iotests/111         |   6 -
 tests/qemu-iotests/112         |   6 -
 tests/qemu-iotests/113         |   6 -
 tests/qemu-iotests/114         |   6 -
 tests/qemu-iotests/115         |   6 -
 tests/qemu-iotests/116         |   6 -
 tests/qemu-iotests/117         |   7 -
 tests/qemu-iotests/118         | 200 ++++++++++----------
 tests/qemu-iotests/119         |   6 -
 tests/qemu-iotests/120         |   6 -
 tests/qemu-iotests/121         |   6 -
 tests/qemu-iotests/122         |   7 -
 tests/qemu-iotests/123         |   7 -
 tests/qemu-iotests/124         |  24 +--
 tests/qemu-iotests/125         |   6 -
 tests/qemu-iotests/129         |   6 +-
 tests/qemu-iotests/130         |   7 -
 tests/qemu-iotests/131         |   6 -
 tests/qemu-iotests/132         |  19 +-
 tests/qemu-iotests/133         |   6 -
 tests/qemu-iotests/134         |   6 -
 tests/qemu-iotests/135         |   6 -
 tests/qemu-iotests/136         |   7 +-
 tests/qemu-iotests/137         |   6 -
 tests/qemu-iotests/138         |   6 -
 tests/qemu-iotests/139         |  33 ++--
 tests/qemu-iotests/140         |   8 -
 tests/qemu-iotests/141         |   8 -
 tests/qemu-iotests/142         |   7 -
 tests/qemu-iotests/143         |   7 -
 tests/qemu-iotests/144         |   8 -
 tests/qemu-iotests/145         |   7 -
 tests/qemu-iotests/146         |   7 -
 tests/qemu-iotests/147         |  41 ++---
 tests/qemu-iotests/148         |  33 ++--
 tests/qemu-iotests/150         |   6 -
 tests/qemu-iotests/152         |  21 +--
 tests/qemu-iotests/153         |  12 --
 tests/qemu-iotests/154         |   6 -
 tests/qemu-iotests/155         |  54 +++---
 tests/qemu-iotests/156         |   7 -
 tests/qemu-iotests/157         |   6 -
 tests/qemu-iotests/158         |   6 -
 tests/qemu-iotests/159         |   7 -
 tests/qemu-iotests/160         |   7 -
 tests/qemu-iotests/162         |   7 -
 tests/qemu-iotests/163         |  42 ++---
 tests/qemu-iotests/165         |  11 +-
 tests/qemu-iotests/170         |   7 -
 tests/qemu-iotests/171         |   6 -
 tests/qemu-iotests/172         |   8 -
 tests/qemu-iotests/173         |   8 -
 tests/qemu-iotests/174         |   6 -
 tests/qemu-iotests/175         |   6 -
 tests/qemu-iotests/176         |   7 -
 tests/qemu-iotests/177         |   6 -
 tests/qemu-iotests/178         |   7 -
 tests/qemu-iotests/179         |   7 -
 tests/qemu-iotests/181         |   8 -
 tests/qemu-iotests/182         |   6 -
 tests/qemu-iotests/183         |   9 -
 tests/qemu-iotests/184         |   6 -
 tests/qemu-iotests/185         |   9 -
 tests/qemu-iotests/186         |   6 -
 tests/qemu-iotests/187         |   8 -
 tests/qemu-iotests/188         |   6 -
 tests/qemu-iotests/189         |   6 -
 tests/qemu-iotests/190         |   7 -
 tests/qemu-iotests/191         |  10 -
 tests/qemu-iotests/192         |   6 -
 tests/qemu-iotests/195         |   7 -
 tests/qemu-iotests/197         |   7 -
 tests/qemu-iotests/check       | 409 +++++++++++++++++++++++++++++++----=
------
 tests/qemu-iotests/common.qemu |  82 +++++++--
 tests/qemu-iotests/common.rc   |  98 ++++++----
 tests/qemu-iotests/iotests.py  |  15 +-
 182 files changed, 1044 insertions(+), 1869 deletions(-)

--=20
2.9.5
