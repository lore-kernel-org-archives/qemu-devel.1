Received: from eggs.gnu.org ([2001:4830:134:3::10]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMUGu-000341-5g
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMU6w-0006XL-MD
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:31:53 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 13 Nov 2018 19:30:57 +1100
Message-Id: <20181113083104.2692-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu RFC 0/7] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


This is for passing through NVIDIA V100 GPUs on POWER9 systems.
22/22 has the details of hardware setup.

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU. This also implements
required platform support for both powernv (host) and pseries (guest)
platforms.

This is pushed on github:
https://github.com/aik/linux/tree/nv2-stage4

QEMU bits are here (will post separately):
https://github.com/aik/qemu/tree/nv2-stage4

Skiboot bits are here (will post separately as well):
https://github.com/aik/skiboot/tree/nv2-stage4


Please comment. Thanks.



Alexey Kardashevskiy (7):
  vfio/spapr: Fix indirect levels calculation
  linux-header: Update for new capabilities
  pci: Move NVIDIA vendor id to the rest of ids
  vfio/nvidia-v100: Disable VBIOS update
  spapr-iommu: Always advertise the maximum possible DMA window size
  vfio: Make vfio_get_region_info_cap public
  spapr: Add NVLink2 pass through support

 hw/vfio/pci.h                                 |   3 +
 include/hw/pci-host/spapr.h                   |  28 ++
 include/hw/pci/pci_ids.h                      |   3 +
 include/hw/ppc/spapr.h                        |   3 +-
 include/hw/vfio/vfio-common.h                 |   2 +
 include/standard-headers/drm/drm_fourcc.h     |  48 ++++
 include/standard-headers/linux/ethtool.h      |  15 +-
 .../linux/input-event-codes.h                 |  18 ++
 include/standard-headers/linux/pci_regs.h     |   1 +
 linux-headers/asm-arm/unistd-common.h         |   1 +
 linux-headers/asm-arm64/unistd.h              |   1 +
 linux-headers/asm-generic/unistd.h            |   2 +
 linux-headers/linux/kvm.h                     |  10 +
 linux-headers/linux/vfio.h                    |  76 ++++++
 hw/ppc/spapr.c                                |  14 +-
 hw/ppc/spapr_pci.c                            | 256 +++++++++++++++++-
 hw/ppc/spapr_rtas_ddw.c                       |  19 +-
 hw/vfio/common.c                              |   2 +-
 hw/vfio/pci-quirks.c                          | 121 ++++++++-
 hw/vfio/pci.c                                 |  16 ++
 hw/vfio/spapr.c                               |   3 +-
 hw/vfio/trace-events                          |   6 +-
 22 files changed, 610 insertions(+), 38 deletions(-)

-- 
2.17.1
