Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCR2i-0003tC-IB
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 10:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCR2h-0004jf-NL
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 10:41:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 28 Apr 2018 16:41:18 +0200
Message-Id: <20180428144123.30333-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] qemu-io: Exit with error when a command
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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


Max Reitz (5):
  qemu-io: Drop command functions' return values
  qemu-io: Let command functions return error code
  qemu-io: Exit with error when a command failed
  iotests.py: Add qemu_io_silent
  iotests: Let 216 make use of qemu-io's exit code

 include/qemu-io.h             |   4 +-
 qemu-io-cmds.c                | 276 ++++++++++++++++++++++++------------------
 qemu-io.c                     |  62 +++++++---
 tests/qemu-iotests/216        |  23 ++--
 tests/qemu-iotests/216.out    |  17 +--
 tests/qemu-iotests/iotests.py |   9 ++
 6 files changed, 226 insertions(+), 165 deletions(-)

-- 
2.14.3
