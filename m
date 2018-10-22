Received: from eggs.gnu.org ([2001:4830:134:3::10]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf5G-0007wx-CH
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf5C-0003ry-9l
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:37:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:11303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf5B-0003qC-VS
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:37:42 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:30 +0200
Message-Id: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>

This patch set implements support for the ACPI hardware-reduced
specification.

The changes are coming from the NEMU [1] project where we're defining
a new x86 machine type: i386/virt. This is an EFI only, ACPI
hardware-reduced platform and as such we had to implement support
for the latter.

As a preliminary for adding hardware-reduced support to QEMU, we did
some ACPI code reorganization with the following goals:

* Share as much as possible of the current ACPI build APIs between
  legacy and hardware-reduced ACPI.
* Share the ACPI build code across machine types and architectures and
  remove the typical PC machine type dependency.
  Eventually we hope to see arm/virt also re-use much of that code.

The rest of the patchset adds the hardware-reduced support on top of
this code reorganization. Here again, the implementation is machine
type, platform and architecture independent.

[1] https://github.com/intel/nemu


The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)

are available in the Git repository at:

  git@github.com:intel/nemu topic/upstream/acpi

for you to fetch changes up to 4133ebe0d638d0a3d583bd89aa2360ef35ba746b:

  hw: acpi: reduced: Add PCI hotplug support (2018-10-22 20:32:23 +0200)

----------------------------------------------------------------
Jing Liu (2):
      hw: acpi: reduced: Add shutdown support
      hw: acpi: reduced: Add reboot support

Samuel Ortiz (10):
      hw: i386: Decouple the ACPI build from the PC machine type
      hw: acpi: Export ACPI build alignment API
      hw: acpi: Export the RSDP build API
      hw: arm: Switch to the AML build RSDP building routine
      hw: acpi: Do not create hotplug method when handler is not defined
      hw: i386: Make the hotpluggable memory size property more generic
      hw: fw-build: Add firmware build methods and state
      hw: i386: Convert PC machine type to firmware build methods
      hw: acpi: Initial hardware-reduced support
      hw: acpi: reduced: Generic Event Device support

Sebastien Boeuf (4):
      hw: acpi: Export the PCI hotplug API
      hw: acpi: Retrieve the PCI bus from AcpiPciHpState
      hw: acpi: reduced: Add NFIT support
      hw: acpi: reduced: Add PCI hotplug support

Yang Zhong (10):
      hw: acpi: Generalize AML build routines
      hw: acpi: Factorize _OSC AML across architectures
      hw: i386: Refactor PCI host getter
      hw: acpi: Export and generalize the PCI host AML API
      hw: acpi: Export the MCFG getter
      hw: acpi: Export the SRAT AML build API
      hw: acpi: Fix memory hotplug AML generation error
      hw: acpi: reduced: Add MCFG support
      hw: acpi: reduced: Add memory hotplug support
      hw: acpi: reduced: Add SRAT table

 default-configs/i386-softmmu.mak |    1 +
 hw/acpi/Makefile.objs            |    1 +
 hw/acpi/aml-build.c              | 1139 +++++++++++++++++++++++++++++++++++-
 hw/acpi/cpu.c                    |    8 +-
 hw/acpi/cpu_hotplug.c            |    9 +-
 hw/acpi/memory_hotplug.c         |   21 +-
 hw/acpi/pcihp.c                  |   10 +-
 hw/acpi/reduced.c                |  472 +++++++++++++++
 hw/arm/virt-acpi-build.c         |   86 +--
 hw/i386/acpi-build.c             | 1172 +++-----------------------------------
 hw/i386/acpi-build.h             |    4 +-
 hw/i386/pc.c                     |  188 +++---
 hw/i386/pc_piix.c                |   21 +-
 hw/i386/pc_q35.c                 |   21 +-
 hw/pci-host/piix.c               |    8 -
 include/hw/acpi/acpi-defs.h      |   15 +
 include/hw/acpi/acpi.h           |   47 ++
 include/hw/acpi/aml-build.h      |   48 ++
 include/hw/acpi/reduced.h        |   46 ++
 include/hw/boards.h              |    5 +
 include/hw/fw-build.h            |   57 ++
 include/hw/i386/acpi.h           |   27 +
 include/hw/i386/pc.h             |   21 +-
 include/hw/mem/memory-device.h   |    2 +
 stubs/Makefile.objs              |    1 -
 stubs/pci-host-piix.c            |    6 -
 26 files changed, 2107 insertions(+), 1329 deletions(-)
 create mode 100644 hw/acpi/reduced.c
 create mode 100644 include/hw/acpi/reduced.h
 create mode 100644 include/hw/fw-build.h
 create mode 100644 include/hw/i386/acpi.h
 delete mode 100644 stubs/pci-host-piix.c

-- 
2.17.2
