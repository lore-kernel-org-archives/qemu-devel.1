Received: from eggs.gnu.org ([2001:4830:134:3::10]:57833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlDQ-0005tw-B8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlDP-00071T-Jr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:47:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 15:47:22 +0100
Message-Id: <20180313144730.2184-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] block: .bdrv_co_create for format
 drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This series adds a .bdrv_co_create implementation to almost all format
drivers that support creating images where its still missing. The only
exception is VMDK because its support for extents will make the QAPI
design a bit more complicated.

The other format driver not covered in this series are qcow2 (already
merged) and luks (already posted in a separate series).

v2:
- Rebased, the vdi patch consists just of some cosmetic cleanups now
- vhdx, vpc: Don't do any silent rounding in .bdrv_co_create, error out
  if the passed size isn't properly aligned yet. The legacy code paths
  compensate for this.

Kevin Wolf (8):
  parallels: Support .bdrv_co_create
  qemu-iotests: Enable write tests for parallels
  qcow: Support .bdrv_co_create
  qed: Support .bdrv_co_create
  vdi: Make comments consistent with other drivers
  vhdx: Support .bdrv_co_create
  vpc: Support .bdrv_co_create
  vpc: Require aligned size in .bdrv_co_create

 qapi/block-core.json     | 137 ++++++++++++++++++++++++++-
 block/parallels.c        | 199 ++++++++++++++++++++++++++++----------
 block/qcow.c             | 196 +++++++++++++++++++++++++-------------
 block/qed.c              | 204 ++++++++++++++++++++++++++-------------
 block/vdi.c              |  12 ++-
 block/vhdx.c             | 216 ++++++++++++++++++++++++++++++++----------
 block/vpc.c              | 241 ++++++++++++++++++++++++++++++++++++-----------
 tests/qemu-iotests/181   |   2 +-
 tests/qemu-iotests/check |   1 -
 9 files changed, 910 insertions(+), 298 deletions(-)

-- 
2.13.6
