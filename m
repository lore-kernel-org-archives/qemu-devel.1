Received: from eggs.gnu.org ([2001:4830:134:3::10]:51383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpY9-0005Vp-Kh
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpY8-0003B5-SC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:18:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Feb 2017 17:18:39 +0800
Message-Id: <20170223091845.18523-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] block: Add VFIO based driver for NVMe
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is a refresh of the NVMe VFIO driver patches.

The first three patches add the driver, the others are to make qemu-img more
efficient with the new driver.

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
  nvme: Move NVMe definitions to a separate header
  stubs: Add stubs for ram block notifier API
  block: Add VFIO based NVMe driver
  block: Introduce bdrv_dma_map and bdrv_dma_unmap
  block/nvme: Implement .bdrv_dma_map and .bdrv_dma_unmap
  qemu-img: dma map buffers

 MAINTAINERS                    |    6 +
 block/Makefile.objs            |    1 +
 block/block-backend.c          |   10 +
 block/io.c                     |   24 +
 block/nvme-vfio.c              |  664 +++++++++++++++++++++++++
 block/nvme-vfio.h              |   31 ++
 block/nvme.c                   | 1073 ++++++++++++++++++++++++++++++++++++++++
 block/trace-events             |   27 +
 hw/block/nvme.h                |  629 +----------------------
 include/block/block.h          |    2 +
 include/block/block_int.h      |    4 +
 include/block/nvme.h           |  632 +++++++++++++++++++++++
 include/sysemu/block-backend.h |    3 +
 qemu-img.c                     |   15 +
 stubs/Makefile.objs            |    1 +
 stubs/ram-block-notifier.c     |   10 +
 16 files changed, 2504 insertions(+), 628 deletions(-)
 create mode 100644 block/nvme-vfio.c
 create mode 100644 block/nvme-vfio.h
 create mode 100644 block/nvme.c
 create mode 100644 include/block/nvme.h
 create mode 100644 stubs/ram-block-notifier.c

-- 
2.9.3
