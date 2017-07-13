Received: from eggs.gnu.org ([2001:4830:134:3::10]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVD-0002cI-7a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVC-0002hE-Bi
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:41:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 13:41:26 +0200
Message-Id: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/9] block: -device drive=<node-name> fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Since 2.9 it is possible for a user to care only about nodes and qdev devices,
but not about BlockBackends, by defining with -blockdev and using their node
name in -device. Devices create an anonymous BlockBackend internally then.

One of the major problems in this setup is that such devices are not listed in
query-block or HMP 'info block' because the BBs are not monitor-owned. A recent
discussion concluded that we really want to replace query-block and friends
with something that matches QEMU's internals better, but there's no way to do
that in 2.10 (and I wouldn't bet on it to be completed for 2.11). So for now,
just make the devices appear in query-block and add the qdev ID there in order
to make the devices identifiable (they have 'device': '' because the BB is
anonymous).

With the additional qdev field, it turned out that with empty drives, ide-cd
and scsi-cd weren't even properly attached to the BlockBackend. If you do it
right, this even results in crashes. (Floppy already gets it right, in case you
wondered.)

After this series, -device drive=<node-name> should be reasonably usable
without a major loss of functionality like before.

v2:
- Updated example QMP outputs in schema comments [Eric]
- Added missing "since" tag in schema [Eric]
- Improved some commit messages [Eric]

Kevin Wolf (9):
  block: Make blk_get_attached_dev_id() public
  block/qapi: Add qdev device name to query-block
  block: Make blk_all_next() public
  block/qapi: Use blk_all_next() for query-block
  block: List anonymous device BBs in query-block
  ide: bdrv_attach_dev() for empty CD-ROM
  scsi-disk: bdrv_attach_dev() for empty CD-ROM
  qemu-iotests: Test 'info block'
  qemu-iotests: Test unplug of -device without drive

 block/block-backend.c          |   5 +-
 block/qapi.c                   |  20 +-
 hmp.c                          |  11 +-
 hw/ide/qdev.c                  |   3 +
 hw/scsi/scsi-disk.c            |   5 +
 include/sysemu/block-backend.h |   2 +
 qapi/block-core.json           |   9 +-
 tests/qemu-iotests/067         |  13 ++
 tests/qemu-iotests/067.out     |  40 ++++
 tests/qemu-iotests/186         | 147 +++++++++++++
 tests/qemu-iotests/186.out     | 489 +++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |   1 +
 12 files changed, 735 insertions(+), 10 deletions(-)
 create mode 100755 tests/qemu-iotests/186
 create mode 100644 tests/qemu-iotests/186.out

-- 
1.8.3.1
