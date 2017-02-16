Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4u-0002LC-6D
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4q-0007R6-Rv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:36 -0500
Received: from greensocs.com ([193.104.36.180]:53082)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4q-0007NU-IW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:32 -0500
From: fred.konrad@greensocs.com
Date: Thu, 16 Feb 2017 15:30:06 +0100
Message-Id: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V1 0/7] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This series allows to execute code from mmio areas.
The main goal of this is to be able to run code for example from an SPI device.

The three first patch fixes the way get_page_addr_code fills the TLB.

The fourth patch implements the mmio execution helpers: the device must
implement the request_ptr callback of the MemoryRegion and will be notified when
the guest wants to execute code from it.

The fifth patch introduces mmio_interface device which allows to dynamically
map a host pointer somewhere into the memory.

The sixth patch implements the execution from the SPI memories in the
xilinx_spips model.

Thanks,
Fred

RFC -> V1:
  * Use an interface (mmio-interface) to fix any reference leak issue.

KONRAD Frederic (7):
  cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
  cputlb: move get_page_addr_code
  cputlb: fix the way get_page_addr_code fills the tlb
  exec: allow to get a pointer for some mmio memory region
  qdev: add MemoryRegion property
  introduce mmio_interface
  xilinx_spips: allow mmio execution

 cputlb.c                         |  81 ++++++++++++++-----------
 hw/misc/Makefile.objs            |   1 +
 hw/misc/mmio_interface.c         | 128 +++++++++++++++++++++++++++++++++++++++
 hw/ssi/xilinx_spips.c            |  74 ++++++++++++++++------
 include/exec/memory.h            |  35 +++++++++++
 include/hw/misc/mmio_interface.h |  49 +++++++++++++++
 include/hw/qdev-properties.h     |   2 +
 memory.c                         |  57 +++++++++++++++++
 8 files changed, 372 insertions(+), 55 deletions(-)
 create mode 100644 hw/misc/mmio_interface.c
 create mode 100644 include/hw/misc/mmio_interface.h

-- 
1.8.3.1
