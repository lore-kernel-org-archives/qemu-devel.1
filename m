Received: from eggs.gnu.org ([2001:4830:134:3::10]:46167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcau-0006lF-KT
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcas-0001YS-HR
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:51 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  1 May 2018 16:13:32 -0500
Message-Id: <20180501211336.986372-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Support larger NBD_CMD_WRITE_ZEROES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, vsementsov@virtuozzo.com

This is my counterproposal for:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02107.html
where Edgar pointed out that NBD write zero requests are rather
inefficient because the NBD spec was ambiguous on whether we could
exceed an advertised maximum request size even when the command
carries no payload, and so for maximum compatibility with unknown
NBD partners, we erred on the conservative side.

The NBD spec has since been improved to mention that a client can
try a larger WRITE_ZEROES if it is prepared to handle an EINVAL, and
that a server should not hang up on overlarge requests that did not
include a payload.  But in the process it was pointed out that even
better would be improving the spec to advertise both limits (the
READ/WRITE payload limit, and the larger TRIM/ZERO limit), as done
in this series.

With this in place, qemu as both NBD client and server can send
zero requests up to BDRV_REQUEST_MAX_BYTES (nearly 2G) in length,
rather than having to subdivide the request into 32M chunks.

This series is experimental until the NBD spec is actually modified
to document the feature added here; but that modification will be
easier now that I have a proof-of-concept implementation.

Eric Blake (4):
  nbd: Prepare for additional block sizing info
  nbd/client: Refactor in preparation for more limits
  nbd/client: Support requests of additional block sizing info
  nbd/server: Support requests of additional block sizing info

 include/block/nbd.h |   8 +++-
 block/nbd.c         |  15 +++++-
 nbd/client.c        | 135 +++++++++++++++++++++++++++++++++++++++++++++++-----
 nbd/common.c        |   4 ++
 nbd/server.c        |  30 ++++++++++++
 nbd/trace-events    |   4 ++
 6 files changed, 181 insertions(+), 15 deletions(-)

-- 
2.14.3
