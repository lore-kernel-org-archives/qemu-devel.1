Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZu2-0002oL-Ij
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZu1-0003fe-Id
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 15:30:40 -0500
Message-Id: <20170707203049.534-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/9] Implement NBD_OPT_GO,
 block size advertisement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

The NBD protocol has now finalized the extension that fixes
several shortcomings with NBD_OPT_EXPORT_NAME (namely, no error
reporting, no way for the server to advertise block sizes to the
client):
https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md

This sort of overlaps with the work Vladimir is proposing for
implementing NBD_CMD_BLOCK_STATUS, but initial versions of these
patches have been on the list for over a year now (see patches 37-44):
https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg03526.html

v4 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04528.html
Differences since then (if it is even worth comparing) include
rebasing on top of Vladimir's cleanups and final tweaks to match
the upstream NBD protocol that was finally promoted from experimental.

Depends on my NBD staging tree (currently Vladimir's v3 nbd refactoring):
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01805.html

001/9:[0047] [FC] 'nbd: Create struct for tracking export info'
002/9:[down] 'nbd: Don't bother tracing an NBD_OPT_ABORT response failure'
003/9:[0108] [FC] 'nbd: Expose and debug more NBD constants'
004/9:[down] 'nbd: Simplify trace of client flags in negotiation'
005/9:[down] 'nbd: Refactor reply to NBD_OPT_EXPORT_NAME'
006/9:[0146] [FC] 'nbd: Implement NBD_OPT_GO on server'
007/9:[0041] [FC] 'nbd: Implement NBD_OPT_GO on client'
008/9:[0014] [FC] 'nbd: Implement NBD_INFO_BLOCK_SIZE on server'
009/9:[0050] [FC] 'nbd: Implement NBD_INFO_BLOCK_SIZE on client'

Eric Blake (9):
  nbd: Create struct for tracking export info
  nbd: Don't bother tracing an NBD_OPT_ABORT response failure
  nbd: Expose and debug more NBD constants
  nbd: Simplify trace of client flags in negotiation
  nbd: Refactor reply to NBD_OPT_EXPORT_NAME
  nbd: Implement NBD_OPT_GO on server
  nbd: Implement NBD_OPT_GO on client
  nbd: Implement NBD_INFO_BLOCK_SIZE on server
  nbd: Implement NBD_INFO_BLOCK_SIZE on client

 block/nbd-client.h  |   3 +-
 include/block/nbd.h |  56 +++++++---
 nbd/nbd-internal.h  |  13 +--
 block/nbd-client.c  |  22 ++--
 block/nbd.c         |  16 ++-
 nbd/client.c        | 283 ++++++++++++++++++++++++++++++++++++++++--------
 nbd/common.c        |  92 ++++++++++++++++
 nbd/server.c        | 304 ++++++++++++++++++++++++++++++++++++++++++++--------
 qemu-nbd.c          |  10 +-
 nbd/trace-events    |  24 +++--
 10 files changed, 685 insertions(+), 138 deletions(-)

-- 
2.9.4
