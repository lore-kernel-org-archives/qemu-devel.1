Received: from eggs.gnu.org ([2001:4830:134:3::10]:46642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTtf-0005zV-TM
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTta-0000nY-U8
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:41:43 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:23 +0100
Message-Id: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/24] ACPI reorganization for
 hardware-reduced API addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

This patch set provides an ACPI code reorganization in preparation for
adding a shared hardware-reduced ACPI API to QEMU.

The changes are coming from the NEMU [1] project where we're defining
a new x86 machine type: i386/virt. This is an EFI only, ACPI
hardware-reduced platform that is built on top of a generic
hardware-reduced ACPI API [2]. This API was initially based off the
generic parts of the arm/virt-acpi-build.c implementation, and the goal
is for both i386/virt and arm/virt to duplicate as little code as
possible by using this new, shared API.

As a preliminary for adding this hardware-reduced ACPI API to QEMU, we did
some ACPI code reorganization with the following goals:

* Share as much as possible of the current ACPI build APIs between
  legacy and hardware-reduced ACPI.
* Share the ACPI build code across machine types and architectures and
  remove the typical PC machine type dependency.

The patches are also available in their own git branch [3].

[1] https://github.com/intel/nemu
[2] https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/reduced.c
[3] https://github.com/intel/nemu/tree/topic/upstream/acpi

v1 -> v2:
   * Drop the hardware-reduced implementation for now. Our next patch
   * set
     will add hardware-reduced and convert arm/virt to it.
   * Implement the ACPI build methods as a QOM Interface Class and
   * convert
     the PC machine type to it.
   * acpi_conf_pc_init() uses a PCMachineState pointer and not a
     MachineState one as its argument.

v2 -> v3:
   * Cc all relevant maintainers, no functional changes.

v3 -> v4:
   * Renamed all AcpiConfiguration pointers from conf to acpi_conf.
   * Removed the ACPI_BUILD_ALIGN_SIZE export.
   * Temporarily updated the arm virt build_rsdp() prototype for
     bisectability purposes.
   * Removed unneeded pci headers from acpi-build.c.
   * Refactor the acpi PCI host getter so that it truly is architecture
     agnostic, by carrying the PCI host pointer through the
     AcpiConfiguration structure.
   * Splitted the PCI host AML builder API export patch from the PCI
     host and holes getter one.
   * Reduced the build_srat() export scope to hw/i386 instead of the
     broader hw/acpi. SRAT builders are truly architecture specific
     and can hardly be generalized.
   * Completed the ACPI builder documentation.

v4 -> v5:
   * Reorganize the ACPI RSDP export and XSDT implementation into 3
     patches.
   * Fix the hw/i386/acpi header inclusions.

Samuel Ortiz (16):
  hw: i386: Decouple the ACPI build from the PC machine type
  hw: acpi: Export ACPI build alignment API
  hw: acpi: The RSDP build API can return void
  hw: acpi: Export the RSDP build API
  hw: acpi: Implement XSDT support for RSDP
  hw: acpi: Factorize the RSDP build API implementation
  hw: i386: Move PCI host definitions to pci_host.h
  hw: acpi: Export the PCI host and holes getters
  hw: acpi: Do not create hotplug method when handler is not defined
  hw: i386: Make the hotpluggable memory size property more generic
  hw: i386: Export the i386 ACPI SRAT build method
  hw: i386: Export the MADT build method
  hw: acpi: Define ACPI tables builder interface
  hw: i386: Implement the ACPI builder interface for PC
  hw: pci-host: piix: Return PCI host pointer instead of PCI bus
  hw: i386: Set ACPI configuration PCI host pointer

Sebastien Boeuf (2):
  hw: acpi: Export the PCI hotplug API
  hw: acpi: Retrieve the PCI bus from AcpiPciHpState

Yang Zhong (6):
  hw: acpi: Generalize AML build routines
  hw: acpi: Factorize _OSC AML across architectures
  hw: acpi: Export and generalize the PCI host AML API
  hw: acpi: Export the MCFG getter
  hw: acpi: Fix memory hotplug AML generation error
  hw: i386: Refactor PCI host getter

 hw/i386/acpi-build.h           |    9 +-
 include/hw/acpi/acpi-defs.h    |   14 +
 include/hw/acpi/acpi.h         |   44 ++
 include/hw/acpi/aml-build.h    |   47 ++
 include/hw/acpi/builder.h      |  100 +++
 include/hw/i386/acpi.h         |   28 +
 include/hw/i386/pc.h           |   49 +-
 include/hw/mem/memory-device.h |    2 +
 include/hw/pci/pci_host.h      |    6 +
 hw/acpi/aml-build.c            |  981 +++++++++++++++++++++++++++++
 hw/acpi/builder.c              |   97 +++
 hw/acpi/cpu.c                  |    8 +-
 hw/acpi/cpu_hotplug.c          |    9 +-
 hw/acpi/memory_hotplug.c       |   21 +-
 hw/acpi/pcihp.c                |   10 +-
 hw/arm/virt-acpi-build.c       |   93 +--
 hw/i386/acpi-build.c           | 1072 +++-----------------------------
 hw/i386/pc.c                   |  198 +++---
 hw/i386/pc_piix.c              |   36 +-
 hw/i386/pc_q35.c               |   22 +-
 hw/i386/xen/xen-hvm.c          |   19 +-
 hw/pci-host/piix.c             |   32 +-
 stubs/pci-host-piix.c          |    6 -
 hw/acpi/Makefile.objs          |    1 +
 stubs/Makefile.objs            |    1 -
 25 files changed, 1644 insertions(+), 1261 deletions(-)
 create mode 100644 include/hw/acpi/builder.h
 create mode 100644 include/hw/i386/acpi.h
 create mode 100644 hw/acpi/builder.c
 delete mode 100644 stubs/pci-host-piix.c

-- 
2.19.1
