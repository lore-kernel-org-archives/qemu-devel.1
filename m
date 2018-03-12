Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSHI-00077k-0r
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSHE-0004pv-RU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:34:32 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSHE-0004pf-IH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:34:28 -0400
Received: by mail-pl0-x233.google.com with SMTP id m22-v6so9833576pls.5
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:34:28 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:33:45 +1000
Message-Id: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 00/30] Xen Q35 Bringup patches + support
 for PCIe Extended Capabilities for passed through devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org

This patch series introduces support of Q35 emulation for Xen HVM guests
(via QEMU). This feature is present in other virtualization products and
Xen can greatly benefit from this feature as well.

The main goal for implementing Q35 emulation for Xen was extending PCI/GPU
passthrough capabilities. It's the main advantage of Q35 emulation
- availability of extra features for PCIe device passthrough. The most
important PCIe-specific passthrough feature Q35 provides is a support for
PCIe config space ECAM (aka MMCONFIG) to allow accesses to extended PCIe
config space (>256), which is MMIO-based.  Lots of PCIe devices and their
drivers make use of PCIe Extended Capabilities, whose can be accessed only
using ECAM and offsets above 0x100 in PCI config space. Supporting ECAM
is a mandatory feature for PCIe passthrough. Not only this allows
passthrough PCIe devices to function properly, but opens a road to extend
Xen PCIe passthrough features further -- eg. providing support for AER. One
of possible directions is providing support for PCIe Resizable BARs --
a feature which likely to become common for modern GPUs as video memory
sizes increase.

Q35 emulation may also be useful for other purposes. In fact, the emulation
of a more recent chipset partially closes a huge gap between a set of
required platform features and the actual emulated platform capabilities
- lot of required functionality is actually missing in a real i440 chipset.
One can look at IGD passthru support patches from Intel for example:
according to code comments, they had to create a dummy PCI-ISA bridge
at BDF 0:1F.0 in order to make the old i440 system look more modern, just
to make it compatible with IGD driver. Using Q35 emulation with its own
emulated LPC bridge allows to avoid workarounds like this. i440 on its own
is a fairly outdated system and doesn't really support lot of things, like
MMIO hole above 4Gb (although it is actually emulated). Also, due to the
i440 chipset's age the only fact of its usage may be used as a reliable
method to detect a virtualized environment by some malicious software
especially considering the fact that i440 emulation is shared among
multiple virtualization products.

On top of this series I've also implemented a solution which solves
existing Xen puzzle with HVM memory layout -- handling of VRAM, RMRRs and
MMIO hole in general. This "puzzle" (memory layout inconsistency between
libxl/libxc, hvmloader and QEMU) is a sort of fundamental problem which
plagues Xen for years and among few other issues prevents Xen to become a
decent GPU/PCIe passthrough platform (which it should be). This solution
also allows to later resolve current PCI passthrough incompatibility
issues, eg. with Populate-on-Demand. In fact, i440 support has been added
as well, but it's a bit hacky as it uses NB registers which are not present
in a real i440 (well, one more non-existing i440 feature won't harm anyway
as there are plenty of them already). I'm planning to send RFC patches of
this solution right after current patches will be reviewed and related code
settle, to rebase patches on top of it. Also, a good description is
required as the change is rather radical.

The good thing is that providing Q35 support for Xen at this stage neither
break any existing functionality nor affect the legacy i440 emulation
in any way - Q35 emulation can be enabled on demand only, using a new
domain config option. Also, only existing interfaces are used, no new
hypecalls were introduced, no API changes, etc. Although in the future
we'll have to change some hypercall/QMP/etc interfaces to remove
limitations and extend the Q35/PCIe passthru support further.

Current features and limitations:
- All basic functionality works normally - MP, networking, storage (AHCI),
  powering down VMs via ACPI soft off, etc
- Xen Platform Device and PV devices are supported -- PV drivers for vbd,
  vif, etc may be installed and used
- PCIe ECAM fully supported, with allocating space for PCIEXBAR in MMIO
  hole, ACPI MCFG generation, etc.
- Xen is limited to max 4 PIRQs in multiple places, while Q35 have support
  of 8 PIRQs / PCI router links. This was workarounded by describing only
  4 usable IRQ link entries in ACPI tables and disabling PIRQE..PIRQH -- like
  we're on a real system which has only some of 8 available PIRQs physically
  connected on the chipset. Extending the number of PCI links supported
  is trivial, but this step will change the save/migration stream format
  a bit... although as it seems there was actually some place for this
  extension being left -- eg. field uint8_t route[4] followed by uint8_t
  pad0[4] in hvm_hw_pci_link structure. Anyway, there is no problem actually
  as we normally deal with APIC mode (or MSIs) for IRQ delivery, while PIC
  mode with PCI routing needed only for legacy compatibility
- PCI hotplug currently implemented via ACPI hotplug, in a way similar
  to i440. In future, this might be changed to native PCIe hotplug facilities
  (if there will be a benefit).
- For PCIe passthrough to work on Windows 7 and above, a specific
  workaround was implemented, which allows to use PCIe device passthrough
  on those guest OSes normally. In future, this should be changed to a new
  emulated PCI architecture for Xen -- providing support for simple PCI
  hierarchies, nested MMIO spaces, etc. Basically, we need at least
  to provide support for PCI-PCI bridges (PCIe Root Ports in our case).
  Currently Xen limited to bus 0 in many places, even in hypercall
  parameters. A detailed description of the issue can be found in the patch
  named "xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
  check".
- VM migration was not tested as the feature primarily targets the PCIe
  passthrough which doesn't compatible with migration anyway.

How to use the Q35 feature:

A new domain config option was implemented: device_model_machine. It's
a string which has following possible values:
- "i440" -- i440 emulation (default)
- "q35"  -- emulate a Q35 machine. By default, the storage interface is
  AHCI.

Note that omitting device_model_machine parameter means i440 system
by default, so the default behavior doesn't change for old domain config
files.

So, in order to enable Q35 emulation one need to specify the following
option in the domain config file:
device_model_machine="q35"

It is recommended to install the guest OS from scratch to avoid issues due
to the emulated platform change.

One extra note - if you're going to backport this series to some older QEMU
version, make sure you have this patch for AHCI DMA bug applied: [1].
Otherwise you will encounter  random Q35 guest hangups with "Bad RAM
offset" message logged in /var/log/xen. Recent QEMU versions have this
patch commited already.

Also, a commit [2] is required to be applied (for xen-pt.c) -- it is
available in the upstream QEMU currently, but not present in qemu-xen.

This is my first (somewhat) large contribution to Xen, so some mistakes
are to be expected. Most testing was done using previous version of patches
and Xen 4.8.x.

I plan to support and extend this series further, for now I expect some
comments/suggestions/testing results/bugreports.

[1]: https://lists.xen.org/archives/html/xen-devel/2017-07/msg01077.html
[2]: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03572.html

Xen changes:
Alexey Gerasimenko (12):
  libacpi: new DSDT ACPI table for Q35
  Makefile: build and use new DSDT table for Q35
  hvmloader: add function to query an emulated machine type (i440/Q35)
  hvmloader: add ACPI enabling for Q35
  hvmloader: add Q35 DSDT table loading
  hvmloader: add basic Q35 support
  hvmloader: allocate MMCONFIG area in the MMIO hole + minor code
    refactoring
  libxl: Q35 support (new option device_model_machine)
  libxl: Xen Platform device support for Q35
  libacpi: build ACPI MCFG table if requested
  hvmloader: use libacpi to build MCFG table
  docs: provide description for device_model_machine option

 docs/man/xl.cfg.pod.5.in             |  27 ++
 tools/firmware/hvmloader/Makefile    |   2 +-
 tools/firmware/hvmloader/config.h    |   5 +
 tools/firmware/hvmloader/hvmloader.c |  11 +-
 tools/firmware/hvmloader/pci.c       | 289 ++++++++++++------
 tools/firmware/hvmloader/pci_regs.h  |   7 +
 tools/firmware/hvmloader/util.c      | 130 ++++++++-
 tools/firmware/hvmloader/util.h      |  10 +
 tools/libacpi/Makefile               |   9 +-
 tools/libacpi/acpi2_0.h              |  21 ++
 tools/libacpi/build.c                |  42 +++
 tools/libacpi/dsdt_q35.asl           | 551 +++++++++++++++++++++++++++++++++++
 tools/libacpi/libacpi.h              |   4 +
 tools/libxl/libxl_dm.c               |  20 +-
 tools/libxl/libxl_types.idl          |   7 +
 tools/xl/xl_parse.c                  |  14 +
 16 files changed, 1051 insertions(+), 98 deletions(-)
 create mode 100644 tools/libacpi/dsdt_q35.asl

QEMU changes:
Alexey Gerasimenko (18):
  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
  pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug
  q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35
  q35/xen: Add Xen platform device support for Q35
  q35: Fix incorrect values for PCIEXBAR masks
  xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities and
    PCIe Extended Capabilities enumeration
  xen/pt: avoid reading PCIe device type and cap version multiple times
  xen/pt: determine the legacy/PCIe mode for a passed through device
  xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
    check
  xen/pt: add support for PCIe Extended Capabilities and larger config
    space
  xen/pt: handle PCIe Extended Capabilities Next register
  xen/pt: allow to hide PCIe Extended Capabilities
  xen/pt: add Vendor-specific PCIe Extended Capability descriptor and
    sizing
  xen/pt: add fixed-size PCIe Extended Capabilities descriptors
  xen/pt: add AER PCIe Extended Capability descriptor and sizing
  xen/pt: add descriptors and size calculation for
    RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
  xen/pt: add Resizable BAR PCIe Extended Capability descriptor and
    sizing
  xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors and
    sizing

 hw/acpi/ich9.c               |   24 +
 hw/acpi/pcihp.c              |    8 +-
 hw/core/machine.c            |   21 +
 hw/i386/pc_q35.c             |   27 +-
 hw/i386/xen/xen-hvm.c        |   32 +-
 hw/isa/lpc_ich9.c            |    4 +
 hw/pci-host/piix.c           |    2 +-
 hw/pci-host/q35.c            |   14 +-
 hw/xen/xen-host-pci-device.c |  110 ++++-
 hw/xen/xen-host-pci-device.h |    6 +-
 hw/xen/xen_pt.c              |   53 +-
 hw/xen/xen_pt.h              |   19 +-
 hw/xen/xen_pt_config_init.c  | 1109 +++++++++++++++++++++++++++++++++++++++---
 include/hw/acpi/ich9.h       |    2 +
 include/hw/acpi/pcihp.h      |    2 +
 include/hw/boards.h          |    1 +
 include/hw/i386/ich9.h       |    1 +
 include/hw/i386/pc.h         |    3 +
 include/hw/pci-host/q35.h    |    4 +-
 include/hw/xen/xen.h         |    5 +-
 qemu-options.hx              |    1 +
 stubs/xen-hvm.c              |    8 +-
 22 files changed, 1333 insertions(+), 123 deletions(-)

-- 
2.11.0
