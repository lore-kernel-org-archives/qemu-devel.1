Received: from eggs.gnu.org ([209.51.188.92]:40383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2DvV-00084q-0E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2DvT-0005Ba-2S
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:44:31 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 8 Mar 2019 11:42:07 +0000
Message-ID: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 00/11] ARM virt: ACPI memory hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

This series is an attempt to provide device memory hotplug support 
on ARM virt platform. This is based on Eric's recent works here[1]
and carries some of the pc-dimm related patches dropped from his
series.

The kernel support for arm64 memory hot add was added recently by
Robin and hence the guest kernel should be => 5.0-rc1.

NVDIM support is not included currently as we still have an unresolved
issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
can be included, but not done for now, for keeping it simple.

This makes use of GED device to sent hotplug ACPI events to the
Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
Sebastien to add the hardware-reduced support to Nemu using GED
device[3]. (Please shout if I got the author/signed-off wrong for
those patches or missed any names).

This series can be applied on top of Eric's branch here[4].

This is sanity tested on a HiSilicon ARM64 platform and appreciate
any further testing.

Thanks,
Shameer

[1] https://patchwork.kernel.org/cover/10837565/
[2] https://patchwork.kernel.org/cover/10783589/
[3] https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/ged.c
[4] https://github.com/eauger/qemu/tree/v3.1.0-extended-memmap-v12


RFC --> v2

-Use GED device instead of GPIO for ACPI hotplug events.
-Removed NVDIMM support for now.
-Includes dropped patches from Eric's v9 series.


Eric Auger (1):
  hw/arm/virt: Add memory hotplug framework

Samuel Ortiz (3):
  hw/acpi: Do not create memory hotplug method when handler is not
    defined
  hw/arm/virt: Add virtual ACPI device
  hw/acpi: Add ACPI Generic Event Device Support

Sebastien Boeuf (1):
  hw/acpi: Move constant definitions to header files

Shameer Kolothum (6):
  hw/acpi: Make ACPI IO address space configurable
  hw/arm/virt: Add ACPI support for device memory cold-plug
  hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
  hw/arm/boot: Expose the PC-DIMM nodes in the DT
  hw/arm/virt: Add GED device configuration and build aml
  hw/arm/virt: Add GED irq routing and Enable memory hotplug

 default-configs/arm-softmmu.mak  |   4 +
 hw/acpi/Makefile.objs            |   1 +
 hw/acpi/ged.c                    | 198 +++++++++++++++++++++++++++++++++++++++
 hw/acpi/memory_hotplug.c         |  58 ++++--------
 hw/arm/Makefile.objs             |   2 +-
 hw/arm/boot.c                    |  42 +++++++++
 hw/arm/virt-acpi-build.c         |  31 ++++++
 hw/arm/virt-acpi.c               | 161 +++++++++++++++++++++++++++++++
 hw/arm/virt.c                    |  93 +++++++++++++++++-
 hw/i386/acpi-build.c             |   3 +-
 include/hw/acpi/ged.h            |  61 ++++++++++++
 include/hw/acpi/memory_hotplug.h |  31 +++++-
 include/hw/arm/virt.h            |   8 ++
 13 files changed, 649 insertions(+), 44 deletions(-)
 create mode 100644 hw/acpi/ged.c
 create mode 100644 hw/arm/virt-acpi.c
 create mode 100644 include/hw/acpi/ged.h

-- 
2.7.4
