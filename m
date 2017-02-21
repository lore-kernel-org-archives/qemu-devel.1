Received: from eggs.gnu.org ([2001:4830:134:3::10]:40628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Pq-0005Ps-1x
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Pp-0003O4-1C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:42:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:40 -0600
Message-Id: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/8] Implement NBD_OPT_GO,
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
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

A bit later than I planned, but still in time for soft freeze if
we like it. The NBD protocol has a proposed extension that fixes
several shortcomings with NBD_OPT_EXPORT_NAME (namely, no error
reporting, no way for the server to advertise block sizes to the
client):
https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md

This sort of overlaps with the work Vladimir is proposing for
implementing NBD_CMD_BLOCK_STATUS (in fact, I included his CVE
fix because it was my bug that introduced the hole), but an initial
version of my work has been on the list a lot longer; where it was
posted as v3 of a larger series (see patches 37-44):
https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg03526.html

Difference since v3 (if it is even worth comparing):

001/8:[down] 'nbd/client: fix drop_sync [CVE-2017-2630]'
002/8:[0034] [FC] 'nbd: Create struct for tracking export info'
003/8:[down] 'block: Add blk_get_opt_transfer()'
004/8:[down] 'nbd: Expose and debug more NBD constants'
005/8:[0187] [FC] 'nbd: Implement NBD_OPT_GO on server'
006/8:[0030] [FC] 'nbd: Implement NBD_OPT_GO on client'
007/8:[down] 'nbd: Implement NBD_INFO_BLOCK_SIZE on server'
008/8:[down] 'nbd: Implement NBD_INFO_BLOCK_SIZE on client'

I built this on top of my blkdebug enhancements for testing
purposes; I did not test this one without that but the two
series should be relatively orthogonal:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03042.html

Also available as a tag at this location:
git fetch git://repo.or.cz/qemu/ericb.git nbd-go-v4

Eric Blake (7):
  nbd: Create struct for tracking export info
  block: Add blk_get_opt_transfer()
  nbd: Expose and debug more NBD constants
  nbd: Implement NBD_OPT_GO on server
  nbd: Implement NBD_OPT_GO on client
  nbd: Implement NBD_INFO_BLOCK_SIZE on server
  nbd: Implement NBD_INFO_BLOCK_SIZE on client

Vladimir Sementsov-Ogievskiy (1):
  nbd/client: fix drop_sync [CVE-2017-2630]

 block/nbd-client.h             |   3 +-
 include/block/nbd.h            |  55 ++++++--
 include/sysemu/block-backend.h |   1 +
 nbd/nbd-internal.h             |  12 +-
 block/block-backend.c          |  12 ++
 block/nbd-client.c             |  22 +--
 block/nbd.c                    |  16 ++-
 nbd/client.c                   | 299 ++++++++++++++++++++++++++++++++++-------
 nbd/common.c                   |  69 ++++++++++
 nbd/server.c                   | 264 +++++++++++++++++++++++++++++++++---
 qemu-nbd.c                     |  10 +-
 11 files changed, 656 insertions(+), 107 deletions(-)

-- 
2.9.3
