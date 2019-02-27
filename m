Received: from eggs.gnu.org ([209.51.188.92]:36298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gyuwe-00044X-Dv
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gyuwc-0004B5-MN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:52:04 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 27 Feb 2019 19:51:43 +1100
Message-Id: <20190227085149.38596-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 0/6] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


This is for passing through NVIDIA V100 GPUs on POWER9 systems.

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU.

1/6 went via PCI tree, here for the reference only.

Since 6/6 moves GPU RAM to much higher addresses than before,
I added 4/6 to mitigate RCU stall warnings in the guest.

Here is the kernel driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci?h=v5.0-rc6&id=7f92891778dff62303c070ac81de7b7d80de331a

SLOF changes already went in.

This is based on dwg/ppc-for-4.0 sha1
a12da2e Murilo Opsfelder Araujo "ppc/pnv: use IEC binary prefixes to represent sizes".

Please comment. Thanks.



Alexey Kardashevskiy (6):
  pci: Move NVIDIA vendor id to the rest of ids
  vfio/spapr: Fix indirect levels calculation
  vfio/spapr: Rename local systempagesize variable
  spapr_iommu: Do not replay mappings from just created DMA window
  vfio: Make vfio_get_region_info_cap public
  spapr: Support NVIDIA V100 GPU with NVLink2

 hw/ppc/Makefile.objs          |   2 +-
 hw/vfio/pci.h                 |   2 +
 include/hw/pci-host/spapr.h   |  41 ++++
 include/hw/pci/pci_ids.h      |   2 +
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/vfio/vfio-common.h |   2 +
 hw/ppc/spapr.c                |  29 ++-
 hw/ppc/spapr_iommu.c          |  31 +++
 hw/ppc/spapr_pci.c            |   8 +
 hw/ppc/spapr_pci_nvlink2.c    | 419 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas_ddw.c       |   7 +
 hw/vfio/common.c              |   2 +-
 hw/vfio/pci-quirks.c          | 122 +++++++++-
 hw/vfio/pci.c                 |  14 ++
 hw/vfio/spapr.c               |  49 ++--
 hw/vfio/trace-events          |   6 +-
 16 files changed, 718 insertions(+), 22 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_nvlink2.c

-- 
2.17.1
