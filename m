Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazp-0003QT-RJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazm-00081R-Nm
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqazm-00080x-Ix
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:22 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:52:02 +0100
Message-Id: <20180227085209.19151-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

This series adds support for a vgpu display to the qemu vfio code.

v5:
 - rebase to latest master
 - drop DeviceState->hotpluggable patch, use separate vfio-pci-display
   device instead so we can use DeviceClass->hotpluggable.
 - add vfio dma-buf patch.  Right now this can be tested with '-display
   egl-headless' only.  gtk and spice support is almost ready for merge
   and should follow soon.

cheers,
  Gerd

Gerd Hoffmann (7):
  linux-headers: update to 4.16-rc1
  standard-headers: add drm/drm_fourcc.h
  ui/pixman: add qemu_drm_format_to_pixman()
  vfio/common: cleanup in vfio_region_finalize
  vfio/display: core & wireup
  vfio/display: adding region support
  vfio/display: adding dmabuf support

 hw/vfio/pci.h                                      |   4 +
 include/hw/vfio/vfio-common.h                      |  22 ++
 include/standard-headers/drm/drm_fourcc.h          | 411 +++++++++++++++++++++
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/input.h             |  11 +
 include/standard-headers/linux/pci_regs.h          |  30 +-
 include/standard-headers/linux/virtio_net.h        |  13 +
 include/ui/qemu-pixman.h                           |   5 +
 linux-headers/asm-powerpc/kvm.h                    |   2 +
 linux-headers/asm-powerpc/unistd.h                 |   3 +
 linux-headers/asm-s390/unistd.h                    | 401 +-------------------
 linux-headers/asm-s390/unistd_32.h                 | 364 ++++++++++++++++++
 linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
 linux-headers/asm-x86/kvm_para.h                   |   4 +
 linux-headers/linux/kvm.h                          |  90 +++++
 linux-headers/linux/psci.h                         |   3 +
 linux-headers/linux/vfio.h                         |  72 ++++
 hw/vfio/common.c                                   |   7 +
 hw/vfio/display.c                                  | 286 ++++++++++++++
 hw/vfio/pci.c                                      |  30 ++
 ui/qemu-pixman.c                                   |  22 ++
 hw/vfio/Makefile.objs                              |   2 +-
 scripts/update-linux-headers.sh                    |   7 +
 23 files changed, 1710 insertions(+), 411 deletions(-)
 create mode 100644 include/standard-headers/drm/drm_fourcc.h
 create mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 100644 linux-headers/asm-s390/unistd_64.h
 create mode 100644 hw/vfio/display.c

-- 
2.9.3
