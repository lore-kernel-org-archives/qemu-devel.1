Received: from eggs.gnu.org ([2001:4830:134:3::10]:46314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vS-MD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrP-0004PH-Nx
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:49171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrP-0004Oi-E4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:07 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 0/9] drm/i915/gvt: Add the live
 migration support to VFIO mdev deivce - Intel vGPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:59:13 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

This series RFC patches give a sample about how to enable the live migration
on vfio mdev deivce with the new introduced vfio interface and vfio device
status region.

In order to fulfill the migration requirement we add the following
modifications to the mdev device driver.
1. Add the guest to host graphics address adjustment when guest 
   try to access gma through mmio or graphics commands, so after 
   migraiton the guest view of graphics address will remain the same.
2. Add handler for VFIO new ioctls to contorl the device stop/start and
   fetch the dirty page bitmap from device model.
3. Implement the function to save/retore the device context, which 
   is accessed through VFIO new region VFIO_PCI_DEVICE_STATE_REGION_INDEX
   to transfer device status during the migration.

Yulei Zhang (9):
  drm/i915/gvt: Apply g2h adjust for GTT mmio access
  drm/i915/gvt: Apply g2h adjustment during fence mmio access
  drm/i915/gvt: Adjust the gma parameter in gpu commands during command
    parser
  drm/i915/gvt: Retrieve the guest gm base address from PVINFO
  drm/i915/gvt: Align the guest gm aperture start offset for live
    migration
  drm/i915/gvt: Introduce new flag to indicate migration capability
  drm/i915/gvt: Introduce new VFIO ioctl for device status control
  drm/i915/gvt: Introduce new VFIO ioctl for mdev device dirty page sync
  drm/i915/gvt: Add support to VFIO region
    VFIO_PCI_DEVICE_STATE_REGION_INDEX

 drivers/gpu/drm/i915/gvt/Makefile      |   2 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c |   6 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c   |   3 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c  |  26 +-
 drivers/gpu/drm/i915/gvt/gtt.c         |  19 +-
 drivers/gpu/drm/i915/gvt/gvt.c         |   1 +
 drivers/gpu/drm/i915/gvt/gvt.h         |  41 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c       |  65 ++-
 drivers/gpu/drm/i915/gvt/migrate.c     | 715 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/migrate.h     |  82 ++++
 drivers/gpu/drm/i915/gvt/mmio.c        |  14 +
 drivers/gpu/drm/i915/gvt/mmio.h        |   1 +
 drivers/gpu/drm/i915/gvt/vgpu.c        |   8 +-
 include/uapi/linux/vfio.h              |  33 +-
 14 files changed, 984 insertions(+), 32 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/migrate.c
 create mode 100644 drivers/gpu/drm/i915/gvt/migrate.h

-- 
2.7.4
