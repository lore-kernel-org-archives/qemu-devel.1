Received: from eggs.gnu.org ([2001:4830:134:3::10]:35571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgL-0007gk-6a
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgG-0005UG-7o
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 24 Apr 2018 16:08:18 +0300
Message-Id: <20180424130821.50987-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC 0/3] NBD reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, famz@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

Here is a draft of NBD reconnect, to negotiate overall design. It is done
through implementing new error action: reconnect.

New action works as follows:

Firstly, not stopping the vm, it tries to bdrv_reconnect several times
with given pause. Then, if we failed to reconnect fallthrough to 'stop'
error action.

My RFC doubts:
1. introducing new .bdrv_reconnect(). Is bdrv_reopen() appropriate for
   the feature? I'm not sure, because it is not recursive, and don't
   really reopen files..
2. introducing new error action. Anyway, I'll have to add some configuration
   parameters (see 03), so, the feature may be just an option to 'stop'
   action, rather than separate error action.

Vladimir Sementsov-Ogievskiy (3):
  block: add bdrv_reconnect
  nbd: add .bdrv_reconnect handler
  blk: add 'reconnect' error action

 qapi/block-core.json      |  4 ++--
 include/block/block.h     |  2 ++
 include/block/block_int.h |  3 +++
 block.c                   | 22 +++++++++++++++++
 block/block-backend.c     | 48 ++++++++++++++++++++++++++++++++++++-
 block/nbd.c               | 60 ++++++++++++++++++++++++++++++++++-------------
 hw/scsi/scsi-disk.c       |  4 +++-
 7 files changed, 123 insertions(+), 20 deletions(-)

-- 
2.11.1
