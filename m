Received: from eggs.gnu.org ([2001:4830:134:3::10]:38941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkU8-0004wx-Dc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkU7-0004E6-Ep
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:36:52 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  5 Jul 2017 21:36:29 +0800
Message-Id: <20170705133635.11850-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] block: Add VFIO based driver for NVMe
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

v3: Rebase, small tweaks/fixes and add locks to provide basic thread safety
    (basic because it is not really tested).

v2:
    - Implement "split vfio addr space" appraoch. [Paolo]
    - Add back 'device reset' in nvme_close(). [Paolo]
    - Better variable namings. [Stefan]
    - "Reuse" macro definitions from NVMe emulation code.
    - Rebase onto current master which has polling by default and update
      performance results accordingly.
    - Update MAINTAINERS.
    - Specify namespace in URI.
    - The sporadical I/O error from v1 "disappeared" in this version.
    - Tests one: qemu-img bench, fio, bonnie++ and installation of
      ubuntu/fedora/rhel on QEMU emulated nvme and a Intel P3700 card.

Fam Zheng (6):
  stubs: Add stubs for ram block API
  block: Add VFIO based NVMe driver
  block: Introduce bdrv_dma_map and bdrv_dma_unmap
  block/nvme: Implement .bdrv_dma_map and .bdrv_dma_unmap
  qemu-img: Map bench buffer
  block: Move NVMe spec definitions to a separate header

 MAINTAINERS                    |    6 +
 block/Makefile.objs            |    1 +
 block/block-backend.c          |   10 +
 block/io.c                     |   24 +
 block/nvme-vfio.c              |  703 +++++++++++++++++++++++++
 block/nvme-vfio.h              |   30 ++
 block/nvme.c                   | 1103 ++++++++++++++++++++++++++++++++++++++++
 block/nvme.h                   |  700 +++++++++++++++++++++++++
 block/trace-events             |   32 ++
 hw/block/nvme.h                |  698 +------------------------
 include/block/block.h          |    2 +
 include/block/block_int.h      |    4 +
 include/sysemu/block-backend.h |    3 +
 qemu-img.c                     |    9 +-
 stubs/Makefile.objs            |    1 +
 stubs/ram-block.c              |   16 +
 16 files changed, 2644 insertions(+), 698 deletions(-)
 create mode 100644 block/nvme-vfio.c
 create mode 100644 block/nvme-vfio.h
 create mode 100644 block/nvme.c
 create mode 100644 block/nvme.h
 create mode 100644 stubs/ram-block.c

-- 
2.9.4
