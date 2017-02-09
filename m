Received: from eggs.gnu.org ([2001:4830:134:3::10]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDz-0002bh-7F
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0007QI-Bc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:23 -0500
From: Alexander Graf <agraf@suse.de>
Date: Thu,  9 Feb 2017 13:53:26 +0100
Message-Id: <1486644810-33181-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2 0/4] target-arm: Add some omitted dma cache
 coherency flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

ARM is amazing when it comes to cache coherency and VMs. While any sane
architecture allows the host to override the guest's caching attributes,
that's very hard to do on ARM.

That means that the guest may directly access guest memory bypassing the
cache while QEMU happily writes to / reads from cache. The end result is
very nasty, because both sides see very different views of the world.
 
That means that we need to be very cautious to tell guests that devices
that QEMU emulates are going to use data in the cache rather than directly
on memory.

We added this to PCI a while back for DT (5d636e21 "hw/arm/virt: mark the PCIe
host controller as DMA coherent in the DT") and ACPI (bc64b96 "hw/arm/virt-
acpi-build: _CCA attribute is compulsory") but never updated virtio-mmio or
fw-cfg in DT or ACPI tables.

This patch set adds the respective cache coherency flags for them in both DT and
ACPI.

Fortunately, no guests except for Linux 4.9.7 and 4.9.8 are broken because of
this. Upstream realized quickly enough that every user of virtio-mmio out there
describes its cache coherency incorrectly and reverted the patch that would
require said dma coherency flag. But we should be safe for the future and "do
the right thing".

Alexander Graf (4):
  target-arm: Declare virtio-mmio as dma-coherent in dt
  hw/arm/virt: Declare virtio-mmio as dma cache coherent in ACPI
  hw/arm/virt: Declare fwcfg as dma cache coherent in ACPI
  hw/arm/virt: Declare fwcfg as dma cache coherent in dt

 hw/arm/vexpress.c        | 1 +
 hw/arm/virt-acpi-build.c | 2 ++
 hw/arm/virt.c            | 2 ++
 3 files changed, 5 insertions(+)

-- 
2.10.0
