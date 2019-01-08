Received: from eggs.gnu.org ([209.51.188.92]:57688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08Y-0005dQ-Nt
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08U-0006XX-C4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:31 +1100
Message-Id: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] ppc-for-4.0 queue 20190109
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22=
f0:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-req=
uest' into staging (2019-01-08 16:07:32 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190109

for you to fetch changes up to 3a8eb78e6c135422017888380db091793039b6dd:

  spapr: enable XIVE MMIOs at reset (2019-01-09 09:28:14 +1100)

----------------------------------------------------------------
ppc patch queue 2019-01-09

Second main pull request for qemu-4.0.  Highlights are:
 * Final parts of XIVE support for pseries (without KVM)
 * Preliminary work for PHB hotplug
 * Starting to use TCG vector operations

This includes some changes in the PCI core, which Michael Tsirkin
requested come through this tree, since they're primarily of interest
for ppc.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      ppc/spapr: Receive and store device tree blob from SLOF

BALATON Zoltan (2):
      ppc4xx: Disable debug logging by default
      MAINTAINERS: Add more files to sam460ex

C=C3=A9dric Le Goater (11):
      spapr/xive: simplify the sPAPR IRQ qirq method for XIVE
      spapr: modify the prototype of the cpu_intc_create() method
      ppc/xive: introduce a XiveTCTX pointer under PowerPCCPU
      ppc: replace the 'Object *intc' by a 'ICPState *icp' pointer under =
the CPU
      spapr: return from post_load method when RTC import fails
      ppc: export the XICS and XIVE set_irq handlers
      pnv/psi: move the ICSState qemu_irq array under the PSI device mode=
l
      spapr: move the qemu_irq array under the machine
      ppc/xics: allow ICSState to have an offset 0
      spapr: introduce a new sPAPR IRQ backend supporting XIVE and XICS
      spapr: enable XIVE MMIOs at reset

Greg Kurz (2):
      spapr: move spapr_create_phb() to core machine code
      spapr_pci: Define SPAPR_MAX_PHBS in hw/pci-host/spapr.h

Laurent Vivier (1):
      spapr: Add H-Call H_HOME_NODE_ASSOCIATIVITY

Mark Cave-Ayland (10):
      target/ppc: fix typo in SIMM5 extraction helper
      target/ppc: switch EXTRACT_HELPER macros over to use sextract32/ext=
ract32
      target/ppc: introduce get_fpr() and set_fpr() helpers for FP regist=
er access
      target/ppc: introduce get_avr64() and set_avr64() helpers for VMX r=
egister access
      target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}() hel=
pers for VSR register access
      target/ppc: switch FPR, VMX and VSX helpers to access data directly=
 from cpu_env
      target/ppc: merge ppc_vsr_t and ppc_avr_t union types
      target/ppc: move FP and VMX registers into aligned vsr register arr=
ay
      target/ppc: replace AVR* macros with Vsr* macros
      MAINTAINERS: add qemu_vga.ndrv file entry for Mac machines

Michael Roth (1):
      pci: allow cleanup/unregistration of PCI root buses

Thomas Huth (1):
      MAINTAINERS: Add some missing ppc-related files

 MAINTAINERS                         |  17 +-
 configure                           |   2 +-
 hw/intc/spapr_xive.c                |  23 +-
 hw/intc/xics.c                      |   4 +-
 hw/intc/xics_kvm.c                  |   3 +-
 hw/intc/xics_spapr.c                |  10 +-
 hw/intc/xive.c                      |  11 +-
 hw/pci/pci.c                        |  33 ++
 hw/ppc/pnv.c                        |  27 +-
 hw/ppc/pnv_core.c                   |   4 +-
 hw/ppc/pnv_psi.c                    |   7 +-
 hw/ppc/ppc4xx_devs.c                |   3 +-
 hw/ppc/spapr.c                      |  80 +++-
 hw/ppc/spapr_cpu_core.c             |   9 +-
 hw/ppc/spapr_hcall.c                |  93 ++++
 hw/ppc/spapr_irq.c                  | 270 ++++++++++-
 hw/ppc/spapr_pci.c                  |  11 -
 hw/ppc/trace-events                 |   3 +
 include/hw/pci-host/spapr.h         |   8 +-
 include/hw/pci/pci.h                |   3 +
 include/hw/ppc/pnv.h                |   2 +-
 include/hw/ppc/pnv_psi.h            |   1 +
 include/hw/ppc/spapr.h              |   9 +-
 include/hw/ppc/spapr_irq.h          |   6 +-
 include/hw/ppc/spapr_xive.h         |   2 +-
 include/hw/ppc/xics.h               |   6 +-
 include/hw/ppc/xive.h               |   9 +-
 linux-user/ppc/signal.c             |  28 +-
 target/ppc/arch_dump.c              |  15 +-
 target/ppc/cpu.h                    |  47 +-
 target/ppc/gdbstub.c                |   8 +-
 target/ppc/int_helper.c             |  86 ++--
 target/ppc/internal.h               |  39 +-
 target/ppc/kvm.c                    |  24 +-
 target/ppc/machine.c                |  72 ++-
 target/ppc/monitor.c                |   4 +-
 target/ppc/translate.c              |  73 ++-
 target/ppc/translate/dfp-impl.inc.c |   2 +-
 target/ppc/translate/fp-impl.inc.c  | 486 +++++++++++++++-----
 target/ppc/translate/vmx-impl.inc.c | 154 +++++--
 target/ppc/translate/vsx-impl.inc.c | 862 ++++++++++++++++++++++++++----=
------
 target/ppc/translate_init.inc.c     |  26 +-
 42 files changed, 1927 insertions(+), 655 deletions(-)
