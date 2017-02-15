Received: from eggs.gnu.org ([2001:4830:134:3::10]:47585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce315-0008FO-QY
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce314-0004fF-N0
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:05:19 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2442d4fc-7dd9-7e25-2389-7dd602e2aa27@redhat.com>
Date: Wed, 15 Feb 2017 18:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/18] nbd: BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com



On 03/02/2017 16:47, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> We really need exporting dirty bitmaps feature as well as remote
> get_block_status for nbd devices. So, here is minimalistic and restricted
> realization of 'structured reply' and 'block status' nbd protocol extension
> (as second is developed over the first the combined spec may be found here:
> https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/proto.md)
> 
> What is done:
> 
> server:
>  - can send not fragmented structured replies for CMD_READ (this was done only
>    because the spec doesn't allow structure reply feature without maintaining
>    structured read)
>  - can export dirty bitmap through BLOCK_STATUS. Only one bitmap can be exported,
>    negotiation query should be 'qemu-dirty-bitmap:<bitmap name>'
>  - cab export block status through BLOCK_STATUS. Client can negotiate only one
>    entity for exporting through BLOCK_STATUS - bitmap _or_ block status.
>    negotiation query should be 'base:allocation', as defined in the spec.
>    server sends only one extent on each BLOCK_STATUS query.
> 
> client:
>  - can receive not fragmented structured replies for CMD_READ
>  - can get load dirty bitmap through nbd. Be careful: bitmap for export is
>    is selected during nbd negotiation - actually in open(). So, name argument for
>    qmp block-dirty-bitmap-load is just a _new_ name for loaded bitmap.
>    (any way, for us block-dirty-bitmap-load is just a way to test the feature,
>     really we need only server part)
>  - get_block_status works now through nbd CMD_BLOCK_STATUS, if base:allocation is
>    negotiated for export.
> 
> It should be minimal but fully compatible realization of the spec.

This will require v2, but it seems pretty close already.

Paolo

> web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=nbd-block-status-v1
> git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag nbd-block-status-v1)
> 
> Vladimir Sementsov-Ogievskiy (18):
>   nbd: rename NBD_REPLY_MAGIC to NBD_SIMPLE_REPLY_MAGIC
>   nbd-server: refactor simple reply sending
>   nbd: Minimal structured read for server
>   nbd/client: refactor nbd_receive_starttls
>   nbd/client: fix drop_sync
>   nbd/client: refactor drop_sync
>   nbd: Minimal structured read for client
>   hbitmap: add next_zero function
>   block/dirty-bitmap: add bdrv_dirty_bitmap_next()
>   block/dirty-bitmap: add bdrv_load_dirty_bitmap
>   nbd: BLOCK_STATUS for bitmap export: server part
>   nbd: BLOCK_STATUS for bitmap export: client part
>   nbd: add nbd_dirty_bitmap_load
>   qmp: add x-debug-block-dirty-bitmap-sha256
>   qmp: add block-dirty-bitmap-load
>   iotests: add test for nbd dirty bitmap export
>   nbd: BLOCK_STATUS for standard get_block_status function: server part
>   nbd: BLOCK_STATUS for standard get_block_status function: client part
> 
>  block/dirty-bitmap.c                     |  70 ++++
>  block/nbd-client.c                       | 230 ++++++++++-
>  block/nbd-client.h                       |  13 +
>  block/nbd.c                              |  44 +-
>  blockdev.c                               |  57 +++
>  include/block/block_int.h                |   4 +
>  include/block/dirty-bitmap.h             |  10 +
>  include/block/nbd.h                      |  73 +++-
>  include/qemu/hbitmap.h                   |  16 +
>  nbd/client.c                             | 373 ++++++++++++++---
>  nbd/nbd-internal.h                       |  25 +-
>  nbd/server.c                             | 661 ++++++++++++++++++++++++++++++-
>  qapi/block-core.json                     |  46 ++-
>  qemu-nbd.c                               |   2 +-
>  tests/Makefile.include                   |   2 +-
>  tests/qemu-iotests/180                   | 133 +++++++
>  tests/qemu-iotests/180.out               |   5 +
>  tests/qemu-iotests/group                 |   1 +
>  tests/qemu-iotests/nbd-fault-injector.py |   4 +-
>  util/hbitmap.c                           |  37 ++
>  20 files changed, 1713 insertions(+), 93 deletions(-)
>  create mode 100755 tests/qemu-iotests/180
>  create mode 100644 tests/qemu-iotests/180.out
> 
