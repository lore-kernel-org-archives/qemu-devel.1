Received: from eggs.gnu.org ([2001:4830:134:3::10]:48473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etJWQ-0000nS-0V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etJWP-0005aV-90
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:49:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  6 Mar 2018 20:48:17 +0000
Message-Id: <20180306204819.11266-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: fix nbd-server-stop crash after
 blockdev-snapshot-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The blockdev-snapshot-sync command uses bdrv_append() to update all parents to
point at the external snapshot node.  This breaks BlockBackend's
blk_add/remove_aio_context_notifier(), which doesn't expect a BDS change.

Patch 1 fixes this by tracking AioContext notifiers in BlockBackend.

See the test case in Patch 2 for a reproducer.

Stefan Hajnoczi (2):
  block: let blk_add/remove_aio_context_notifier() tolerate BDS changes
  iotests: add 208 nbd-server + blockdev-snapshot-sync test case

 block/block-backend.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events         |  2 ++
 tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/208.out |  9 +++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 130 insertions(+)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out

-- 
2.14.3
