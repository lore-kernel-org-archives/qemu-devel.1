Received: from eggs.gnu.org ([2001:4830:134:3::10]:44517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEDs2-0006cY-1v
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEDrx-0000kz-Qc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:29:46 -0500
From: <zhuyijun@huawei.com>
Date: Mon, 13 Nov 2017 20:29:00 +0800
Message-ID: <1510576145-23084-1-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 0/5] arm: Exclude reserved memory regions of
 iommu to avoid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com
Cc: peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

From: Zhu Yijun <zhuyijun@huawei.com>

With kernel 4.11, iommu/smmu will populate the MSI IOVA reserved window and
PCI reserved window which has to be excluded from Guest iova allocations.

And on certain HiSilicon platforms (hip06/hip07), the GIC ITS and PCIe RC 
deviates from the standard implementation will reserve the hw msi regions in
the smmu-v3 driver which means these address regions will not be translated.

https://www.spinics.net/lists/linux-pci/msg65125.html

On such platforms, reserved memory regions will export like this:

root:~# cat /sys/kernel/iommu_groups/7/reserved_regions
0x00000000a8800000 0x00000000affeffff reserved
0x00000000c6000000 0x00000000c601ffff msi

However, it falls within the Qemu default virtual memory address space.

Take a look at hw/arm/virt.c:

[VIRT_MEM] =             { 0x40000000, RAMLIMIT_BYTES },
    . . .

    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                                     machine->ram_size);
memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);

So suppose we allocate 4GB mem to a VM, there is a chance that the reserved
regions will get allocated for a Guest VF DMA iova and it will fail.

This patchset create holes in the Qemu RAM address space which exclude
the sysfs exported regions.


Zhu Yijun (5):
  hw/vfio: Add function for getting reserved_region of device iommu
    group
  hw/arm/virt: Enable dynamic generation of guest RAM memory regions
  hw/arm: add scattered RAM memory region support
  hw/arm/boot: set fdt size cell of memory node from mem_list
  hw/arm/virt-acpi-build: Build srat table according to mem_list

 hw/arm/boot.c                 | 155 +++++++++++++++++++++++++++++++-----------
 hw/arm/virt-acpi-build.c      |  40 +++++++++--
 hw/arm/virt.c                 | 120 ++++++++++++++++++++++++++++++--
 hw/vfio/common.c              |  67 ++++++++++++++++++
 hw/vfio/pci.c                 |   2 +
 hw/vfio/platform.c            |   2 +
 include/exec/memory.h         |   7 ++
 include/hw/arm/arm.h          |   1 +
 include/hw/arm/virt.h         |   1 +
 include/hw/vfio/vfio-common.h |   3 +
 10 files changed, 347 insertions(+), 51 deletions(-)

-- 
1.8.3.1
