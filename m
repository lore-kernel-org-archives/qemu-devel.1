Received: from eggs.gnu.org ([2001:4830:134:3::10]:45875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYLV-0004zw-Fl
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYLU-0000Uw-Kq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:57:17 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Nov 2017 15:56:56 -0600
Message-Id: <20171108215703.9295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] various NBD fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, kwolf@redhat.com

Sparked by my question on whether we were handling zero-length
reads correctly according to the NBD spec, but grew to fix
other things as well such as some typos, tracing weaknesses,
and better handling of read-only exports.

The order these patches are listed here is bisection-friendly,
but applying the patches out of order is necessary to catch
some of the bad behavior being fixed.

As evidenced by the iotest 147 change, this WILL flag existing
clients with dodgy usage when connecting to a read-only server
(such as the default for nbd-server-add).  But on the bright side,
when libvirt drives storage migration via NBD, it is properly
setting up a read-write server with nbd-server-add.

Since v1 (https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00955.html):
- Tweak several commit messages now that NBD spec changes landed
- merge old 3/8 and 4/8 into single 2/7 that blocks read-write
connection to read-only export rather than magically downgrading it [Kevin]

001/7:[----] [--] 'nbd-client: Fix error message typos'
002/7:[down] 'nbd-client: Refuse read-only client with BDRV_O_RDWR'
003/7:[----] [--] 'nbd/client: Nicer trace of structured reply'
004/7:[----] [--] 'nbd: Fix struct name for structured reads'
005/7:[----] [-C] 'nbd-client: Short-circuit 0-length operations'
006/7:[----] [--] 'nbd-client: Stricter enforcing of structured reply spec'
007/7:[----] [--] 'nbd/server: Fix structured read of length 0'

Eric Blake (7):
  nbd-client: Fix error message typos
  nbd-client: Refuse read-only client with BDRV_O_RDWR
  nbd/client: Nicer trace of structured reply
  nbd: Fix struct name for structured reads
  nbd-client: Short-circuit 0-length operations
  nbd-client: Stricter enforcing of structured reply spec
  nbd/server: Fix structured read of length 0

 include/block/nbd.h    | 18 +++++++++++++-----
 block/nbd-client.c     | 38 +++++++++++++++++++++++++++++++-------
 nbd/client.c           |  4 +++-
 nbd/server.c           | 23 +++++++++++++++++++++--
 nbd/trace-events       |  3 ++-
 tests/qemu-iotests/147 |  1 +
 6 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.13.6
