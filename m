Received: from eggs.gnu.org ([2001:4830:134:3::10]:54983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eycib-00061k-4c
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyciW-0005ih-Vq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Mar 2018 15:19:36 +0300
Message-Id: <20180321121940.39426-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for-2.13 0/4] NBD export bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

This is a proposal and realization of new NBD meta context:
qemu-dirty-bitmap. (I'll send corresponding proposal to NBD protocol
after some negotiation here)

Corresponding queries will look like:
qemu-dirty-bitmap:<export-bitmap-name>

Mapping from export-bitmap-name to BdrvDirtyBitmap is done through qmp
command nbd-server-add-bitmap. For now, only one bitmap export is
allowed per NBD export, however it may be easily improved if needed 
(we don't have such cases for now)

Client and testing.
I wrote client code for Virtuozzo, but it turned out to be unused,
actually it's used only for tests. We don't have cases, where we need
to import dirty bitmap through qemu nbd-client. All this done for
exporting dirty bitmaps to the third tool. So, I think, it is not worth
refactoring, rebasing and merging client part upstream, if there are no
real usage cases.

Vladimir Sementsov-Ogievskiy (4):
  nbd/server: refactor nbd_negotiate_meta_query for several namespaces
  nbd/server: add nbd_meta_single_query helper
  nbd/server: implement dirty bitmap export
  qapi: new qmp command nbd-server-add-bitmap

 qapi/block.json     |  27 +++++
 include/block/nbd.h |   2 +
 blockdev-nbd.c      |  23 ++++
 nbd/server.c        | 308 ++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 324 insertions(+), 36 deletions(-)

-- 
2.11.1
