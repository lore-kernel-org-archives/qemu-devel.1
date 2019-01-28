Received: from eggs.gnu.org ([209.51.188.92]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4km-0003fk-4X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4ki-00044P-HH
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:06:58 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 28 Jan 2019 11:05:42 +0000
Message-ID: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 0/4] ARM virt: ACPI memory hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: xuwei5@huawei.com, linuxarm@huawei.com

This series is an attempt to provide hotplug support to both
pc-dimm and nvdimm device memory on ARM virt platform. This is
based on Eric's recent works to support PCDIMM/NVDIMM device memory[1].
The kernel support for arm64 memory hot add was added only
recently by Robin[2] and hence the guest kernel should be => 5.0-rc1.

This makes use of PL061 GPIO controller to sent related ACPI events
to the Guest. The only reference I could find with respect to the GPIO
pins usage is here[3] which says, "use PIN 3 for system_powerdown,
reserving PIN 0, 1, 2 for PCI hotplug, CPU hotplug and memory hotplug".
Hence Pin 2 is used for PCDIMM and pin 4 for NVDIMM.

This is sanity tested on a HiSilicon ARM64 platform and appreciate
any further testing.

This series can be applied on top of Eric's branch here[4]

Test:
------
Please use a Guest kernel image >5.0-rc1 with all the mem/nvdimm
hotplug related CONFIGs enabled.

./qemu-system-aarch64 \
-machine virt,gic-version=3,nvdimm \
-m 1G,maxmem=4G,slots=4 \
-cpu host \
-kernel Image \
-initrd rootfs-iperf.cpio \
-bios QEMU_EFI.fd \
-numa node,nodeid=0 \
-net none \
-nographic -enable-kvm \
-append "console=ttyAMA0 acpi=force earlycon=pl011,0x9000000"

Enter Qemu monitor,
Add pc-dimm:
object_add memory-backend-ram,id=mem1,size=1G
device_add pc-dimm,id=dimm1,memdev=mem1

Add nvdimm:
object_add memory-backend-ram,id=mem2,size=1G
device_add nvdimm,id=dimm2,memdev=mem2

Known Issue:

It is observed that hot adding nvdimm will results in guest reboot
failure. EDK2 fails to build the ACPI tables on reboot. Please find
below EDK2 log on Guest reboot after nvdimm hot-add,

ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"
OnRootBridgesConnected: InstallAcpiTables: Protocol Error

The root cause seems to be EDK2 ACPI table checksum failure
as NFIT table is getting updated on hot-add. This needs further
investigation.

Thanks,
Shameer

[1]https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05740.html
[2]https://patchwork.kernel.org/patch/10724455/
[3]https://lists.gnu.org/archive/html/qemu-arm/2015-12/msg00095.html
[4]https://github.com/eauger/qemu/tree/v3.1.0-dimm-v5

Shameer Kolothum (4):
  hw:acpi: Make ACPI IO address space configurable
  hw/arm/virt: Add GPIO based pcdimm hotplug ACPI event support
  hw/arm/virt: Enable pc-dimm hotplug support
  hw/arm/virt: Add nvdimm hotplug support

 default-configs/arm-softmmu.mak  |   1 +
 hw/acpi/memory_hotplug.c         |  13 +++--
 hw/arm/virt-acpi-build.c         |  45 +++++++++++++++--
 hw/arm/virt.c                    | 105 ++++++++++++++++++++++++++++++++++++---
 hw/i386/acpi-build.c             |   3 +-
 include/hw/acpi/memory_hotplug.h |   6 ++-
 include/hw/arm/virt.h            |  15 ++++++
 7 files changed, 168 insertions(+), 20 deletions(-)

-- 
2.7.4
