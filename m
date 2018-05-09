Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUzV-0002JQ-DQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUzU-0004O2-D8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:43:09 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 21:42:57 +0200
Message-Id: <20180509194302.21585-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] qemu-io: Exit with error when a command
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Right now, qemu-io's exit code is rather useless as it is usually 0.
Except sometimes, then it's 1 in case of an error (mostly when you
specify a filename as an argument and it cannot open that).

At the same time, most command functions' return values are rather
useless as they are usually 0 (meaning "continue execution").  There is
only a single function that breaks that pattern, which is "quit".  On
one hand, this is pointless because "quit" is in qemu-io.c, so it can
easily signal that fact through a global (yet static) variable.  On the
other, it breaks the usual pattern of I/O functions returning error
codes.

This series resolves the overlap between both issues by making the
command functions' return error values instead of whether to continue
execution or not, and thus makes qemu-io return 1 if any of the commands
executed has failed and 0 only if all of them have succeeded.

Patch 5 showcases how that may be useful for iotests.


See also: https://bugzilla.redhat.com/show_bug.cgi?id=1519617


v2:
- Patch 2: Added a comment on the interface of command functions (their
           parameters and their return value) [Eric]
- (Decided against replacing 0/1 by EXIT_SUCCESS/EXIT_FAILURE, because
   although I personally would prefer them slightly, neither are ever
   used in qemu-io so far.)

git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [-C] 'qemu-io: Drop command functions' return values'
002/5:[0005] [FC] 'qemu-io: Let command functions return error code'
003/5:[----] [--] 'qemu-io: Exit with error when a command failed'
004/5:[----] [--] 'iotests.py: Add qemu_io_silent'
005/5:[----] [-C] 'iotests: Let 216 make use of qemu-io's exit code'


Max Reitz (5):
  qemu-io: Drop command functions' return values
  qemu-io: Let command functions return error code
  qemu-io: Exit with error when a command failed
  iotests.py: Add qemu_io_silent
  iotests: Let 216 make use of qemu-io's exit code

 include/qemu-io.h             |   9 +-
 qemu-io-cmds.c                | 276 ++++++++++++++++++++++++------------------
 qemu-io.c                     |  62 +++++++---
 tests/qemu-iotests/216        |  23 ++--
 tests/qemu-iotests/216.out    |  17 +--
 tests/qemu-iotests/iotests.py |   9 ++
 6 files changed, 231 insertions(+), 165 deletions(-)

-- 
2.14.3
