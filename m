Received: from eggs.gnu.org ([2001:4830:134:3::10]:38531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIYa7-00030G-Ea
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIYa4-00012n-4u
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIYa0-0000p3-2h
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:29:36 -0400
Date: Fri, 2 Nov 2018 13:29:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181102132925.365e1881@redhat.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/23] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org

On Thu,  1 Nov 2018 11:22:40 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

Thanks for looking at ACPI mess we have in QEMU and trying to make it better,
this series look a bit hackish probably because it was written to suit new
virt board, so it needs some more clean up to be done.

> This patch set provides an ACPI code reorganization in preparation for
> adding hardware-reduced support to QEMU.
QEMU already has hw reduced implementation, specifically in arm/virt board

> The changes are coming from the NEMU [1] project where we're defining
> a new x86 machine type: i386/virt. This is an EFI only, ACPI
> hardware-reduced platform and as such we had to implement support
> for the latter.
> 
> As a preliminary for adding hardware-reduced support to QEMU, we did
s:support to QEMU:support for new i386/virt machine:

> some ACPI code reorganization with the following goals:
> 
> * Share as much as possible of the current ACPI build APIs between
>   legacy and hardware-reduced ACPI.
> * Share the ACPI build code across machine types and architectures and
>   remove the typical PC machine type dependency.
>   Eventually we hope to see arm/virt also re-use much of that code.
it probably should be other way around, generalize and reuse as much of
arm/virt acpi code, instead of adding new duplicated code without
an actual user and then swapping/dropping old arm version in favor of the
new one. It's hard to review when it done in this order and easy to miss
issues that would be easier to spot if you reused arm versions (where
applicable) as starting point for generalization.

Here are some generic suggestions/nits that apply to whole series:
  * s/Factorize/Factor out/
  * try to restructure series in following way
     1. put bug fixes at the beginning of series.
        'make V=1 check' should produce tables diffs to account for
        changes made in the tables.
        After error fixing, add an extra patch to update reference
        ACPI tables to simplify testing for reviewing and so for
        self-check when you'll be doing refactoring to make sure
        there aren't any changes during generalization/refactoring
        later.

     2. instead of adding 'new' implementations try to generalize
        existing ones so that a user for new code will always exist.
        It's also makes patches easier to review/test.
        
     3. Since you are touching/moving around existing fixed tables
        that are using legacy 'struct' based approach to construct
        them, it's a good as opportunity to switch to a newer approach
        and use build_append_int_noprefix() API to construct tables.
        Use build_amd_iommu() as example. And it's doubly true if/when
        you are adding new fixed tables (i.e. only build_append_int_noprefix()
        based ones are acceptable).

     4. for patches during #2 and #3 stages, 'make V=1 check'
        should pass without any warnings, that will speed up review
        process.

     5. add i386/virt board and related hardware reduced ACPI code
        that's specific to it.

I'll try to review series during next week and will do per patch
suggestions how to structure it or do other way.

Hopefully after doing refactoring we would end up with
simpler/smaller and cleaner ACPI code to the benefit of everyone.

PS:
if you need a quick advice wrt APCI parts, feel free to ping me on IRC
(Paris timezone).

> The patches are also available in their own git branch [2].
> 
> [1] https://github.com/intel/nemu
> [2] https://github.com/intel/nemu/tree/topic/upstream/acpi
> 
> v1 -> v2:
>    * Drop the hardware-reduced implementation for now. Our next patch set
>      will add hardware-reduced and convert arm/virt to it.
>    * Implement the ACPI build methods as a QOM Interface Class and convert
>      the PC machine type to it.
>    * acpi_conf_pc_init() uses a PCMachineState pointer and not a
>      MachineState one as its argument.
> 
> v2 -> v3:
>    * Cc all relevant maintainers, no functional changes.
> 
> v3 -> v4:
>    * Renamed all AcpiConfiguration pointers from conf to acpi_conf.
>    * Removed the ACPI_BUILD_ALIGN_SIZE export.
>    * Temporarily updated the arm virt build_rsdp() prototype for
>      bisectability purposes.
>    * Removed unneeded pci headers from acpi-build.c.
>    * Refactor the acpi PCI host getter so that it truly is architecture
>      agnostic, by carrying the PCI host pointer through the
>      AcpiConfiguration structure.
>    * Splitted the PCI host AML builder API export patch from the PCI host
>      and holes getter one.
>    * Reduced the build_srat() export scope to hw/i386 instead of the broader
>      hw/acpi. SRAT builders are truly architecture specific and can hardly be
>      generalized.
>    * Completed the ACPI builder documentation.
> 
> Samuel Ortiz (15):
>   hw: i386: Decouple the ACPI build from the PC machine type
>   hw: acpi: Export ACPI build alignment API
>   hw: acpi: Export the RSDP build API
>   hw: acpi: Implement XSDT support for RSDP
>   hw: arm: Switch to the AML build RSDP building routine
>   hw: i386: Move PCI host definitions to pci_host.h
>   hw: acpi: Export the PCI host and holes getters
>   hw: acpi: Do not create hotplug method when handler is not defined
>   hw: i386: Make the hotpluggable memory size property more generic
>   hw: i386: Export the i386 ACPI SRAT build method
>   hw: i386: Export the MADT build method
>   hw: acpi: Define ACPI tables builder interface
>   hw: i386: Implement the ACPI builder interface for PC
>   hw: pci-host: piix: Return PCI host pointer instead of PCI bus
>   hw: i386: Set ACPI configuration PCI host pointer
> 
> Sebastien Boeuf (2):
>   hw: acpi: Export the PCI hotplug API
>   hw: acpi: Retrieve the PCI bus from AcpiPciHpState
> 
> Yang Zhong (6):
>   hw: acpi: Generalize AML build routines
>   hw: acpi: Factorize _OSC AML across architectures
>   hw: acpi: Export and generalize the PCI host AML API
>   hw: acpi: Export the MCFG getter
>   hw: acpi: Fix memory hotplug AML generation error
>   hw: i386: Refactor PCI host getter
> 
>  hw/acpi/Makefile.objs          |    1 +
>  hw/acpi/aml-build.c            |  985 +++++++++++++++++++++++++++++
>  hw/acpi/builder.c              |   97 +++
>  hw/acpi/cpu.c                  |    8 +-
>  hw/acpi/cpu_hotplug.c          |    9 +-
>  hw/acpi/memory_hotplug.c       |   21 +-
>  hw/acpi/pcihp.c                |   10 +-
>  hw/arm/virt-acpi-build.c       |   94 +--
>  hw/i386/acpi-build.c           | 1071 +++-----------------------------
>  hw/i386/acpi-build.h           |    9 +-
>  hw/i386/pc.c                   |  198 +++---
>  hw/i386/pc_piix.c              |   36 +-
>  hw/i386/pc_q35.c               |   22 +-
>  hw/i386/xen/xen-hvm.c          |   19 +-
>  hw/pci-host/piix.c             |   32 +-
>  include/hw/acpi/acpi-defs.h    |   14 +
>  include/hw/acpi/acpi.h         |   44 ++
>  include/hw/acpi/aml-build.h    |   47 ++
>  include/hw/acpi/builder.h      |  100 +++
>  include/hw/i386/acpi.h         |   27 +
>  include/hw/i386/pc.h           |   49 +-
>  include/hw/mem/memory-device.h |    2 +
>  include/hw/pci/pci_host.h      |    6 +
>  stubs/Makefile.objs            |    1 -
>  stubs/pci-host-piix.c          |    6 -
>  25 files changed, 1648 insertions(+), 1260 deletions(-)
>  create mode 100644 hw/acpi/builder.c
>  create mode 100644 include/hw/acpi/builder.h
>  create mode 100644 include/hw/i386/acpi.h
>  delete mode 100644 stubs/pci-host-piix.c
> 
