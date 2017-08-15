Received: from eggs.gnu.org ([2001:4830:134:3::10]:59062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbZs-0007wh-R0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbZp-0007Wa-EC
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 21:07:36 +0800
Message-Id: <20170815130740.31229-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2 0/4] block: Fix non-shared storage
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com

v2: Don't leak blk->vmsh when BB is deleted before the callback is called.
    [Stefan]
    From stub functions, don't return g_malloc0(1) which is risky, return NULL.
    [Eric]

"nbd-server-add -w" doesn't work when we are in "-incoming defer" state:

    (qemu) nbd_server_add -w drive-virtio-disk0
    Block node is read-only

Two problems are faced:

  - nbd_export_new() calls bdrv_invalidate_cache() too late.
  - bdrv_invalidate_cache() restores qdev permission (which are temporarily
    masked by BlockBackend.disable_perm during INMIGRATE) too early.

Fix both, and add a regression iotest.

Fam Zheng (3):
  stubs: Add vm state change handler stubs
  block-backend: Defer shared_perm tightening migration completion
  iotests: Add non-shared storage migration case 192

Kevin Wolf (1):
  nbd: Fix order of bdrv_set_perm and bdrv_invalidate_cache

 block/block-backend.c        | 41 ++++++++++++++++++++++++++++
 nbd/server.c                 | 20 +++++++-------
 stubs/Makefile.objs          |  1 +
 stubs/change-state-handler.c | 14 ++++++++++
 tests/qemu-iotests/192       | 63 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/192.out   |  7 +++++
 tests/qemu-iotests/group     |  1 +
 7 files changed, 138 insertions(+), 9 deletions(-)
 create mode 100644 stubs/change-state-handler.c
 create mode 100755 tests/qemu-iotests/192
 create mode 100644 tests/qemu-iotests/192.out

-- 
2.13.4
