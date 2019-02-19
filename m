Received: from eggs.gnu.org ([209.51.188.92]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyQ-0006A2-Er
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyP-0005j5-1w
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:42 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gwCyO-0005Ue-Iy
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:40 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 20 Feb 2019 02:53:15 +0530
Message-ID: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/5] Add migration support for VFIO device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

Add migration support for VFIO device

This Patch set include patches as below:
- Define KABI for VFIO device for migration support.
- Added save and restore functions for PCI configuration space
- Generic migration functionality for VFIO device.
  * This patch set adds functionality only for PCI devices, but can be
    extended to other VFIO devices.
  * Added all the basic functions required for pre-copy, stop-and-copy and
    resume phases of migration.
  * Added state change notifier and from that notifier function, VFIO
    device's state changed is conveyed to VFIO device driver.
  * During save setup phase and resume/load setup phase, migration region
    is queried and is used to read/write VFIO device data.
  * .save_live_pending and .save_live_iterate are implemented to use QEMU's
    functionality of iteration during pre-copy phase.
  * In .save_live_complete_precopy, that is in stop-and-copy phase,
    iteration to read data from VFIO device driver is implemented till pending
    bytes returned by driver are not zero.
  * Added function to get dirty pages bitmap for the pages which are used by
    driver.
- Add vfio_listerner_log_sync to mark dirty pages.
- Make VFIO PCI device migration capable. If migration region is not provided by
  driver, migration is blocked.

Below is the flow of state change for live migration where states in brackets
represent VM state, migration state and VFIO device state as:
    (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)

Live migration save path:
        QEMU normal running state
        (RUNNING, _NONE, _RUNNING)
                        |
    migrate_init spawns migration_thread.
    (RUNNING, _SETUP, _RUNNING|_SAVING)
    Migration thread then calls each device's .save_setup()
                        |
    (RUNNING, _ACTIVE, _RUNNING|_SAVING)
    If device is active, get pending bytes by .save_live_pending()
    if pending bytes >= threshold_size,  call save_live_iterate()
    Data of VFIO device for pre-copy phase is copied.
    Iterate till pending bytes converge and are less than threshold
                        |
    migration_completion() stops vCPUs and calls .save_live_complete_precopy
    for each active  device. VFIO device is then transitioned in
     _SAVING state.
    (FINISH_MIGRATE, _DEVICE, _SAVING)
    For VFIO device, iterate in  .save_live_complete_precopy  until
    pending data is 0.
    (FINISH_MIGRATE, _DEVICE, 0)
                        |
    (FINISH_MIGRATE, _COMPLETED, 0)
    Migraton thread schedule cleanup bottom half and exit

Live migration resume path:
    Incomming migration calls .load_setup for each device
    (RESTORE_VM, _ACTIVE, 0)
                        |
    For each device, .load_state is called for that device section data
                        |
    At the end, called .load_cleanup for each device and vCPUs are started.
    (RUNNING, _NONE, _RUNNING)

Note that:
- Migration post copy is not supported.
- VFIO device driver version compatibility is not taken care in this series.

v2 -> v3:
- Removed enum of VFIO device states. Defined VFIO device state with 2 bits.
- Re-structured vfio_device_migration_info to keep it minimal and defined action
  on read and write access on its members.

v1 -> v2:
- Defined MIGRATION region type and sub-type which should be used with region
  type capability.
- Re-structured vfio_device_migration_info. This structure will be placed at 0th
  offset of migration region.
- Replaced ioctl with read/write for trapped part of migration region.
- Added both type of access support, trapped or mmapped, for data section of the
  region.
- Moved PCI device functions to pci file.
- Added iteration to get dirty page bitmap until bitmap for all requested pages
  are copied.

Thanks,
Kirti

Kirti Wankhede (5):
  VFIO KABI for migration interface
  Add save and load functions for VFIO PCI devices
  Add migration functions for VFIO devices
  Add vfio_listerner_log_sync to mark dirty pages
  Make vfio-pci device migration capable.

 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/common.c              |  31 ++
 hw/vfio/migration.c           | 714 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 117 ++++++-
 hw/vfio/pci.h                 |  29 ++
 include/hw/vfio/vfio-common.h |  20 ++
 linux-headers/linux/vfio.h    |  65 ++++
 7 files changed, 971 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/migration.c

-- 
2.7.0
