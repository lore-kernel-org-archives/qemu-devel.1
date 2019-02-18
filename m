Received: from eggs.gnu.org ([209.51.188.92]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwu-0005ZK-1v
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwk-0002aa-U8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:06 +1100
Message-Id: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/43] ppc-for-4.0 queue 20190219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469=
af:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190=
215' into staging (2019-02-15 11:12:14 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190219

for you to fetch changes up to 73e14c6a9cdefb94c01ea488f04e7fba7ac0dc5b:

  target/ppc: convert vmin* and vmax* to vector operations (2019-02-18 11=
:00:44 +1100)

----------------------------------------------------------------
ppc patch queue 2019-02-19

Here's the next batch of ppc and spapr patches.  Higlights are:

 * A bunch of improvements to TCG handling of vector instructions from
   Richard Henderson and Marc Cave-Ayland

 * Cleanup to the XICS interrupt controller from Greg Kurz, removing
   the special KVM subclasses which were a bad idea

 * Some refinements to the XIVE interrupt controller from C=C3=A9dric Le
   Goater

 * Fix from Fabiano Rosas for a really dumb buffer overflow in the
   device tree code for memory hotplug

 * Code for allowing access to SPRs from the gdb stub from Fabiano
   Rosas

 * Assorted minor fixes and cleanups

----------------------------------------------------------------
BALATON Zoltan (1):
      target/ppc: Fix msync to do what hardware does

Benjamin Herrenschmidt (2):
      target/ppc: Remove some #if 0'ed code
      target/ppc: Disable ISA 2.06 PM instructions on POWER9

C=C3=A9dric Le Goater (2):
      spapr/irq: add an 'nr_irq' parameter to initialize the backend.
      spapr/irq: remove the XICS offset adjustment

Fabiano Rosas (2):
      target/ppc: Enable reporting of SPRs to GDB
      spapr: fix out of bounds write in spapr_populate_drmem_v2

Greg Kurz (14):
      spapr: Rename xics to intc in interrupt controller agnostic code
      spapr_pci: Fix interrupt leak in rtas_ibm_change_msi() error path
      spapr: Disallow unsupported kernel-irqchip settings
      xive: Only set source type for LSIs
      xics: Explicitely call KVM ICP methods from the common code
      xics: Handle KVM ICP reset from the common code
      xics: Handle KVM ICP realize from the common code
      spapr/irq: Use the base ICP class for KVM
      xics: Drop the KVM ICP class
      xics: Explicitely call KVM ICS methods from the common code
      xics: Handle KVM ICS reset from the "simple" ICS code
      xics: Handle KVM interrupt presentation from "simple" ICS code
      spapr/irq: Use the "simple" ICS class for KVM
      xics: Drop the KVM ICS class

Mark Cave-Ayland (4):
      cuda: decrease time delay before raising VIA SR interrupt and remov=
e fast path
      mac_newworld: change default NIC to sungem for mac99 machine
      target/ppc: convert VMX logical instructions to use vector operatio=
ns
      target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use v=
ector operations

Michael Roth (1):
      qdev: pass an Object * to qbus_set_hotplug_handler()

Philippe Mathieu-Daud=C3=A9 (1):
      hw/ppc/prep: Drop useless inclusion of "hw/i386/pc.h"

Richard Henderson (15):
      target/ppc: convert vspltis[bhw] to use vector operations
      target/ppc: convert vsplt[bhw] to use vector operations
      target/ppc: convert VSX logical operations to vector operations
      target/ppc: convert xxspltib to vector operations
      target/ppc: convert xxspltw to vector operations
      target/ppc: convert xxsel to vector operations
      target/ppc: Pass integer to helper_mtvscr
      target/ppc: Use helper_mtvscr for reset and gdb
      target/ppc: Remove vscr_nj and vscr_sat
      target/ppc: Add helper_mfvscr
      target/ppc: Use mtvscr/mfvscr for vmstate
      target/ppc: Add set_vscr_sat
      target/ppc: Split out VSCR_SAT to a vector field
      target/ppc: convert vadd*s and vsub*s to vector operations
      target/ppc: convert vmin* and vmax* to vector operations

Roman Kapl (1):
      ppc: fix crash during branch stepping

 hw/acpi/pcihp.c                     |   2 +-
 hw/acpi/piix4.c                     |   2 +-
 hw/char/virtio-serial-bus.c         |   2 +-
 hw/core/bus.c                       |  11 +-
 hw/intc/spapr_xive.c                |   7 +-
 hw/intc/xics.c                      |  76 ++++++-----
 hw/intc/xics_kvm.c                  | 120 ++---------------
 hw/misc/macio/cuda.c                |  11 +-
 hw/pci/pcie.c                       |   2 +-
 hw/pci/shpc.c                       |   2 +-
 hw/ppc/mac_newworld.c               |   2 +-
 hw/ppc/prep.c                       |   1 -
 hw/ppc/spapr.c                      |  10 +-
 hw/ppc/spapr_events.c               |   2 +-
 hw/ppc/spapr_irq.c                  |  86 +++++-------
 hw/ppc/spapr_pci.c                  |  14 +-
 hw/ppc/spapr_vio.c                  |   2 +-
 hw/s390x/css-bridge.c               |   2 +-
 hw/s390x/s390-pci-bus.c             |   6 +-
 hw/scsi/virtio-scsi.c               |   2 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/usb/dev-smartcard-reader.c       |   2 +-
 include/hw/pci-host/spapr.h         |   2 +-
 include/hw/ppc/spapr.h              |   3 +-
 include/hw/ppc/spapr_irq.h          |   2 +-
 include/hw/ppc/xics.h               |  26 ++--
 include/hw/ppc/xive.h               |   7 +-
 include/hw/qdev-core.h              |   3 +-
 target/ppc/arch_dump.c              |   3 +-
 target/ppc/cpu-qom.h                |   4 +
 target/ppc/cpu.h                    |  11 +-
 target/ppc/excp_helper.c            |  12 --
 target/ppc/gdbstub.c                |  61 +++++++++
 target/ppc/helper.h                 |  57 ++------
 target/ppc/int_helper.c             | 129 +++++-------------
 target/ppc/machine.c                |  44 ++++++-
 target/ppc/mmu_helper.c             |  12 --
 target/ppc/translate.c              |  49 ++++---
 target/ppc/translate/vmx-impl.inc.c | 251 +++++++++++++++++++-----------=
------
 target/ppc/translate/vsx-impl.inc.c | 147 +++++++++------------
 target/ppc/translate_init.inc.c     |  71 +++++++++-
 41 files changed, 581 insertions(+), 679 deletions(-)
