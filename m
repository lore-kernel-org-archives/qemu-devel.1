Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7g-0007uB-G2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7d-0008Rg-Ja
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:15 +1100
Message-Id: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/50] ppc-for-2.9 queue 20170301
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbf=
ba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170301

for you to fetch changes up to 356bb70ed1a8a741413d55e3dbc5ccd02c53d794:

  Add PowerPC 32-bit guest memory dump support (2017-03-01 11:53:58 +1100=
)

----------------------------------------------------------------
ppc patch queue for 2017-03-01

I was hoping to get this pull request squeezed in before the soft
freeze, but I ran into some difficulties during testing.  Everything
here was at least posted before the soft freeze, so I'm hoping we can
still merge it for 2.9.

The biggest things here are:
    * Cleanups to handling of hashed page tables, that will make
      adding support for the POWER9 MMU easier
    * Cleanups to the XICS interrupt controller that will make
      implementing the powernv machine easier
    * TCG implementation of extended overflow and carry handling for
      POWER9

It also includes:
    * Increasing the CPU limit for pseries to 1024 vCPUs
    * Generating proper OF node names in qemu (making hotplug and
      coldplug logic closer together)

----------------------------------------------------------------
C=C3=A9dric Le Goater (24):
      ppc/xics: remove set_nr_irqs() handler from XICSStateClass
      ppc/xics: remove set_nr_servers() handler from XICSStateClass
      ppc/xics: store the ICS object under the sPAPR machine
      ppc/xics: add an InterruptStatsProvider interface to ICS and ICP ob=
jects
      ppc/xics: introduce a XICSFabric QOM interface to handle ICSs
      ppc/xics: use the QOM interface under the sPAPR machine
      ppc/xics: use the QOM interface to get irqs
      ppc/xics: use the QOM interface to resend irqs
      ppc/xics: remove xics_find_source()
      ppc/xics: register the reset handler of ICS objects
      ppc/xics: remove the XICS list of ICS
      ppc/xics: extend the QOM interface to handle ICPs
      ppc/xics: move kernel_xics_fd out of KVMXICSState
      ppc/xics: simplify the cpu_setup() handler
      ppc/xics: move the cpu_setup() handler under the ICPState class
      ppc/xics: use the QOM interface to grab an ICP
      ppc/xics: simplify spapr_dt_xics() interface
      ppc/xics: register the reset handler of ICP objects
      ppc/xics: move the ICP array under the sPAPR machine
      ppc/xics: export the XICS init routines
      ppc/xics: remove the XICSState classes
      ppc/xics: move ics-simple post_load under the machine
      ppc/xics: move InterruptStatsProvider to the sPAPR machine
      ppc/xics: rename 'ICPState *' variables to 'icp'

David Gibson (9):
      target/ppc: Fix KVM-HV HPTE accessors
      pseries: Minor cleanups to HPT management hypercalls
      target/ppc: Merge cpu_ppc_set_vhyp() with cpu_ppc_set_papr()
      target/ppc: SDR1 is a hypervisor resource
      target/ppc: Cleanup HPTE accessors for 64-bit hash MMU
      target/ppc: Eliminate htab_base and htab_mask variables
      target/ppc: Manage external HPT via virtual hypervisor
      target/ppc: Correct SDR1 masking
      xics: XICS should not be a SysBusDevice

Greg Kurz (2):
      sysemu: support up to 1024 vCPUs
      spapr/pci: populate PCI DT in reverse order

Laurent Vivier (2):
      PCI: add missing classes in pci_ids.h to build device tree
      spapr: generate DT node names

Mike Nawrocki (1):
      Add PowerPC 32-bit guest memory dump support

Nikunj A Dadhania (11):
      target/ppc: move cpu_[read, write]_xer to cpu.c
      target/ppc: optimize gen_write_xer()
      target/ppc: introduce helper_update_ov_legacy
      target/ppc: support for 32-bit carry and overflow
      target/ppc: update ca32 in arithmetic add
      target/ppc: update ca32 in arithmetic substract
      target/ppc: update overflow flags for add/sub
      target/ppc: use tcg ops for neg instruction
      target/ppc: add ov32 flag for multiply low insns
      target/ppc: add ov32 flag in divide operations
      target/ppc: add mcrxrx instruction

Suraj Jitindar Singh (1):
      target/ppc: Remove the function ppc_hash64_set_sdr1()

 hw/intc/xics.c              | 461 +++++++++++++++++---------------------=
------
 hw/intc/xics_kvm.c          | 184 +++++-------------
 hw/intc/xics_spapr.c        | 128 +++---------
 hw/pci/pci.c                |  28 +++
 hw/ppc/spapr.c              | 196 ++++++++++++++++---
 hw/ppc/spapr_cpu_core.c     |  24 ++-
 hw/ppc/spapr_events.c       |  10 +-
 hw/ppc/spapr_hcall.c        |  89 +++++----
 hw/ppc/spapr_pci.c          | 312 +++++++++++++++++++++++++++---
 hw/ppc/spapr_vio.c          |   2 +-
 include/hw/pci-host/spapr.h |   2 +-
 include/hw/pci/pci.h        |   4 +
 include/hw/pci/pci_ids.h    | 112 ++++++++++-
 include/hw/ppc/spapr.h      |   5 +-
 include/hw/ppc/spapr_vio.h  |   2 +-
 include/hw/ppc/xics.h       |  97 ++++------
 target/ppc/Makefile.objs    |   5 +-
 target/ppc/arch_dump.c      | 154 ++++++++-------
 target/ppc/cpu.c            |  47 +++++
 target/ppc/cpu.h            |  50 +++--
 target/ppc/int_helper.c     |  34 ++--
 target/ppc/kvm.c            | 128 ++++++------
 target/ppc/kvm_ppc.h        |  20 +-
 target/ppc/machine.c        |   5 +-
 target/ppc/misc_helper.c    |   8 +-
 target/ppc/mmu-hash32.c     |  14 +-
 target/ppc/mmu-hash32.h     |  34 ++--
 target/ppc/mmu-hash64.c     | 193 +++++++------------
 target/ppc/mmu-hash64.h     |  65 +++----
 target/ppc/mmu_helper.c     |  51 ++---
 target/ppc/translate.c      | 115 +++++++++--
 target/ppc/translate_init.c |  39 ++--
 32 files changed, 1486 insertions(+), 1132 deletions(-)
 create mode 100644 target/ppc/cpu.c
