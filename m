Received: from eggs.gnu.org ([2001:4830:134:3::10]:56614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwc-0005Cx-Hf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3GwW-0007vC-Bl
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:00:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 16:59:46 +1000
Message-Id: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/48] ppc-for-2.10 queue 20170426
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit fe491fa85c4634453b340b18046aae2eaf8147=
db:

  Merge remote-tracking branch 'remotes/agraf/tags/signed-s390-for-upstre=
am' into staging (2017-04-25 14:48:55 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170426

for you to fetch changes up to df02d2ca8b23ba1fff137090a65731c68cf1393d:

  MAINTAINERS: Remove myself from e500 (2017-04-26 12:41:56 +1000)

----------------------------------------------------------------
ppc patch queue 2017-04-26

Here's a respind of my first pull request for qemu-2.10, consisting of
assorted patches which have accumulated while qemu-2.9 stabilized.
Highlights are:
    * Rework / cleanup of the XICS interrupt controller
    * Substantial improvement to the 'powernv' machine type
        - Includes an MMIO XICS version
    * POWER9 support improvements
        - POWER9 guests with KVM
        - Partial support for POWER9 guests with TCG
    * IOMMU and VFIO improvements
    * Assorted minor changes

There are several IPMI patches here that aren't usually in my area of
maintenance, but there isn't a regular maintainer and these patches
are for the benefit of the powernv machine type.

This pull request supersedes my 2017-04-26 pull request.  This new set
fixes a bug in one of the aforementioned IPMI patches which caused
clang sanitizer failures (and may have crashed on some libc / host
versions).

----------------------------------------------------------------
Alexey Kardashevskiy (4):
      target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64
      target-ppc/kvm: Enable in-kernel TCE acceleration for multi-tce
      spapr_pci: Warn when RAM page size is not enabled in IOMMU page mas=
k
      spapr_pci: Removed unused include

Anton Blanchard (1):
      target/ppc: Fix size of struct PPCElfPrstatus

Benjamin Herrenschmidt (2):
      ppc/pnv: Add OCC model stub with interrupt support
      ppc/pnv: Add support for POWER8+ LPC Controller

Bernhard Kaindl (1):
      e500,book3s: mfspr 259: Register mapped/aliased SPRG3 user read

Bharata B Rao (1):
      spapr-cpu-core: Release ICPState object during CPU unrealization

C=C3=A9dric Le Goater (25):
      ppc/spapr: QOM'ify sPAPRRTCState
      ppc/xics: introduce an 'intc' backlink under PowerPCCPU
      spapr: move the IRQ server number mapping under the machine
      spapr: allocate the ICPState object from under sPAPRCPUCore
      ppc/xics: add a realize() handler to ICPStateClass
      ppc/pnv: add a PnvICPState object
      ppc/pnv: extend the machine with a XICSFabric interface
      ppc/pnv: extend the machine with a InterruptStatsProvider interface
      ppc/pnv: create the ICP object under PnvCore
      ppc/pnv: add a helper to calculate MMIO addresses registers
      ppc/pnv: add memory regions for the ICP registers
      ppc/pnv: Add cut down PSI bridge model and hookup external interrup=
t
      ppc: add IPMI support
      ipmi: use a file to load SDRs
      ipmi: provide support for FRUs
      ipmi: introduce an ipmi_bmc_sdr_find() API
      ipmi: introduce an ipmi_bmc_gen_event() API
      spapr: remove the 'nr_servers' field from the machine
      ppc/pnv: enable only one LPC bus
      ppc/pnv: scan ISA bus to populate device tree
      ppc/pnv: populate device tree for RTC devices
      ppc/pnv: populate device tree for serial devices
      ppc/pnv: populate device tree for IPMI BT devices
      ppc/pnv: add initial IPMI sensors for the BMC simulator
      ppc/pnv: generate an OEM SEL event on shutdown

David Gibson (2):
      pseries: Add pseries-2.10 machine type
      target/ppc: Style fixes

Sam Bobroff (6):
      target/ppc: Improve accuracy of guest HTM availability on P8s
      spapr: Add ibm,processor-radix-AP-encodings to the device tree
      target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
      spapr: move spapr_populate_pa_features()
      spapr: Enable ISA 3.0 MMU mode selection via CAS
      spapr: Workaround for broken radix guests

Scott Wood (1):
      MAINTAINERS: Remove myself from e500

Suraj Jitindar Singh (4):
      target/ppc: Add new H-CALL shells for in memory table translation
      target/ppc: Implement H_REGISTER_PROCESS_TABLE H_CALL
      target/ppc: Add ibm,processor-radix-AP-encodings for TCG
      target/ppc: Flush TLB on write to PIDR

Thomas Huth (1):
      hw/ppc/pnv: Classify the "PowerNV Chip" devices as CPU devices

 MAINTAINERS                       |   3 -
 default-configs/ppc64-softmmu.mak |   4 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/xics.c                    |  22 +-
 hw/intc/xics_pnv.c                | 192 +++++++++++++
 hw/intc/xics_spapr.c              |  25 +-
 hw/ipmi/ipmi_bmc_sim.c            | 196 ++++++++++++-
 hw/ppc/Makefile.objs              |   2 +-
 hw/ppc/pnv.c                      | 411 ++++++++++++++++++++++++---
 hw/ppc/pnv_bmc.c                  | 122 ++++++++
 hw/ppc/pnv_core.c                 |  27 +-
 hw/ppc/pnv_lpc.c                  | 106 ++++++-
 hw/ppc/pnv_occ.c                  | 136 +++++++++
 hw/ppc/pnv_psi.c                  | 571 ++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c                    | 371 +++++++++++++++----------
 hw/ppc/spapr_cpu_core.c           |  17 +-
 hw/ppc/spapr_events.c             |   2 +-
 hw/ppc/spapr_hcall.c              | 174 +++++++++++-
 hw/ppc/spapr_iommu.c              |   8 +-
 hw/ppc/spapr_pci.c                |   8 +-
 hw/ppc/spapr_rtc.c                |  41 +--
 include/hw/ipmi/ipmi.h            |   4 +
 include/hw/ppc/pnv.h              |  57 +++-
 include/hw/ppc/pnv_lpc.h          |   8 +
 include/hw/ppc/pnv_occ.h          |  38 +++
 include/hw/ppc/pnv_psi.h          |  67 +++++
 include/hw/ppc/pnv_xscom.h        |   6 +
 include/hw/ppc/spapr.h            |  30 +-
 include/hw/ppc/spapr_ovec.h       |   8 +
 include/hw/ppc/xics.h             |  19 +-
 include/sysemu/kvm.h              |   1 +
 qemu-options.hx                   |  15 +-
 target/ppc/arch_dump.c            |   2 +-
 target/ppc/cpu-qom.h              |   1 +
 target/ppc/cpu.h                  |   5 +
 target/ppc/helper.h               |   1 +
 target/ppc/kvm.c                  | 144 +++++++++-
 target/ppc/kvm_ppc.h              |  40 ++-
 target/ppc/misc_helper.c          |   8 +
 target/ppc/translate_init.c       | 410 ++++++++++++++-------------
 40 files changed, 2808 insertions(+), 495 deletions(-)
 create mode 100644 hw/intc/xics_pnv.c
 create mode 100644 hw/ppc/pnv_bmc.c
 create mode 100644 hw/ppc/pnv_occ.c
 create mode 100644 hw/ppc/pnv_psi.c
 create mode 100644 include/hw/ppc/pnv_occ.h
 create mode 100644 include/hw/ppc/pnv_psi.h
