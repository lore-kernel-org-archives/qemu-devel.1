Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAwJ-0001Xr-QD
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAwF-0003qs-SP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:02:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:25841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAwA-0003ee-9X
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:02:49 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 18:01:40 +0100
Message-Id: <20181029170159.3801-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 00/19] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch set provides an ACPI code reorganization in preparation for
adding hardware-reduced support to QEMU.

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

The patches are also available in their own git branch [2].

[1] https://github.com/intel/nemu
[2] https://github.com/intel/nemu/tree/topic/upstream/acpi

v1 -> v2:
   * Drop the hardware-reduced implementation for now. Our next patch set
     will add hardware-reduced and convert arm/virt to it.
   * Implement the ACPI build methods as a QOM Interface Class and convert
     the PC machine type to it.
   * acpi_conf_pc_init() uses a PCMachineState pointer and not a
     MachineState one as its argument.

v2 -> v3:
   * Cc all relevant maintainers, no functional changes.

Samuel Ortiz (10):
  hw: i386: Decouple the ACPI build from the PC machine type
  hw: acpi: Export ACPI build alignment API
  hw: acpi: Export the RSDP build API
  hw: acpi: Implement XSDT support for RSDP
  hw: arm: Switch to the AML build RSDP building routine
  hw: acpi: Do not create hotplug method when handler is not defined
  hw: i386: Make the hotpluggable memory size property more generic
  hw: acpi: Define ACPI tables builder interface
  hw: i386: Export the MADT build method
  hw: i386: Implement the ACPI builder interface for PC

Sebastien Boeuf (2):
  hw: acpi: Export the PCI hotplug API
  hw: acpi: Retrieve the PCI bus from AcpiPciHpState

Yang Zhong (7):
  hw: acpi: Generalize AML build routines
  hw: acpi: Factorize _OSC AML across architectures
  hw: i386: Refactor PCI host getter
  hw: acpi: Export and generalize the PCI host AML API
  hw: acpi: Export the MCFG getter
  hw: acpi: Export the SRAT AML build API
  hw: acpi: Fix memory hotplug AML generation error

 hw/acpi/Makefile.objs          |    1 +
 hw/acpi/aml-build.c            | 1129 ++++++++++++++++++++++++++++++
 hw/acpi/builder.c              |   97 +++
 hw/acpi/cpu.c                  |    8 +-
 hw/acpi/cpu_hotplug.c          |    9 +-
 hw/acpi/memory_hotplug.c       |   21 +-
 hw/acpi/pcihp.c                |   10 +-
 hw/arm/virt-acpi-build.c       |   98 +--
 hw/i386/acpi-build.c           | 1174 ++------------------------------
 hw/i386/acpi-build.h           |    4 +-
 hw/i386/pc.c                   |  197 ++++--
 hw/i386/pc_piix.c              |   21 +-
 hw/i386/pc_q35.c               |   21 +-
 hw/i386/xen/xen-hvm.c          |   19 +-
 hw/pci-host/piix.c             |    8 -
 include/hw/acpi/acpi-defs.h    |   14 +
 include/hw/acpi/acpi.h         |   43 ++
 include/hw/acpi/aml-build.h    |   50 ++
 include/hw/acpi/builder.h      |   97 +++
 include/hw/i386/acpi.h         |   27 +
 include/hw/i386/pc.h           |   21 +-
 include/hw/mem/memory-device.h |    2 +
 stubs/Makefile.objs            |    1 -
 stubs/pci-host-piix.c          |    6 -
 24 files changed, 1734 insertions(+), 1344 deletions(-)
 create mode 100644 hw/acpi/builder.c
 create mode 100644 include/hw/acpi/builder.h
 create mode 100644 include/hw/i386/acpi.h
 delete mode 100644 stubs/pci-host-piix.c

-- 
2.17.2
