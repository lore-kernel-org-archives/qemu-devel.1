Received: from eggs.gnu.org ([2001:4830:134:3::10]:60240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eSAw4-00068j-LP
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eSAw3-00081F-KP
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:11:36 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Thu, 21 Dec 2017 16:11:35 -0800
Message-Id: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH v1 0/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, karl.heubaum@oracle.com, konrad.wilk@oracle.com

Currently, BLOCK_IO_ERROR events have a string error "reason" field
which is derived from errno.  The proposed change adds errno itself
as a field to these events.  Figuring out the error by comparing the
(int) errno itself is easier than comparing a string.  There is also
a comment in the code that the reason field should not be parsed by
applications.

Sample QMP output of modified events adds the errno field as follows (see
last line):

{"timestamp": {"seconds": 1509071709, "microseconds": 563303}, "event":
"BLOCK_IO_ERROR", "data": {"device": "ide0-hd0", "node-name": "#block128",
"reason": "Input/output error", "operation": "write", "action": "ignore",
"errno": 5}}

Testing:
- Artificially created error conditions that emit BLOCK_IO_ERROR events.
Verified those events could be viewed by the QMP monitor and by the
qmp-shell; and that event behavior with those two utilities was identical.
- Ran tests via "make check" from the build root.  There were no changes
from vanilla build when building or running.

Homework:
- Looked through source and build trees for tests and scripts which
reference BLOCK_IO_ERROR events.  No direct references to such events were
found.  No direct references to BLOCK_IO_ERROR events implies there won't be
references to specific fields within those events.

- What about Windows?
  - The file block/block-backend.c is the only C file with a code change.
The file block/Makefile brings block-backend.o into both Windows and Linux
compilations.  The change introduces an additional reference to errno, which
strerror already calls, even with Windows.  That file's prior reference to
errno confirms that Windows will work with the code change.
  - If there would be a Linux vs Windows difference in mapping of errno to
error string values, that difference would have been in place before my
changes.

  Thanks,
  Jack

Jack Schwartz (1):
  block: Add numeric errno field to BLOCK_IO_ERROR events

 block/block-backend.c |  2 +-
 qapi/block-core.json  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
1.8.3.1
