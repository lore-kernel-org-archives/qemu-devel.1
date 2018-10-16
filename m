Received: from eggs.gnu.org ([2001:4830:134:3::10]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gCTwU-0006oP-Dc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gCTwT-0003vf-8x
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gCTwP-0003ff-NW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:38 -0400
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Tue, 16 Oct 2018 23:42:34 +0530
Message-ID: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH v1 0/4] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>

Add migration support for VFIO device

This Patch set include patches as below:
- Define KABI for VFIO device for migration support.
- Generic migration functionality for VFIO device.
  * This patch set adds functionality only for PCI devices, but can be
    extended to other VFIO devices.
  * Added all the basic functions required for pre-copy, stop-and-copy and
    resume phases of migration.
  * Added state change notifier and from that notifier function, VFIO
    device's state changed is conveyed to VFIO vendor driver.
  * During save setup phase and resume/load setup phase, migration region
    is queried from vendor driver and is mmaped by QEMU. This region is
    used to read/write data from and to vendor driver.
  * .save_live_pending, .save_live_iterate and .is_active_iterate are
    implemented to use QEMU's functionality of iteration during pre-copy
    phase.
  * In .save_live_complete_precopy, that is in stop-and-copy phase,
    iteration to read data from vendor driver is implemented till pending
    bytes returned by vendor driver are not zero.
  * .save_cleanup and .load_cleanup are implemented to unmap migration
    region that was setup duing setup phase.
  * Added function to get dirty pages bitmap from vendor driver.
- Add vfio_listerner_log_sync to mark dirty pages.
- Make VFIO PCI device migration capable.

Thanks,
Kirti

Kirti Wankhede (4):
  VFIO KABI for migration interface
  Add migration functions for VFIO devices
  Add vfio_listerner_log_sync to mark dirty pages
  Make vfio-pci device migration capable.

 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/common.c              |  32 ++
 hw/vfio/migration.c           | 716 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |  13 +-
 include/hw/vfio/vfio-common.h |  23 ++
 linux-headers/linux/vfio.h    |  91 ++++++
 6 files changed, 869 insertions(+), 8 deletions(-)
 create mode 100644 hw/vfio/migration.c

-- 
2.7.0
