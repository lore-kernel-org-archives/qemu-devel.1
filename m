Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV0-0002ww-45
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQUx-0007pH-4P
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:05 +1100
Message-Id: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/43] ppc-for-2.9 queue 20170222
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96=
ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170222

for you to fetch changes up to fb6971c110387cf597b58c411658e3d15cc6c6fb:

  hw/ppc/ppc405_uc.c: Avoid integer overflows (2017-02-22 14:28:53 +1100)

NOTE: This pull request hasn't passed the full set of tests I usually
run, because there seem to be problems with those on current master
anyway: some of "make check" seems to wedge, and a number of travis
builds timed out.  AFAICT this series doesn't cause any failures that
aren't already present in upstream.

----------------------------------------------------------------
ppc patch queue for 2017-02-22

This pull request has:
   * Yet more POWER9 instruction implementations
   * Some extensions to the softfloat code which are necesssary for
     some of those instructions
   * Some preliminary patches in preparation for POWER9 softmmu
     implementation
   * Igor Mammedov's cleanups to unify hotplug cpu handling across
     architectures
   * Assorted bugfixes

The softfloat and cpu hotplug changes aren't entirely ppc specific (in
fact the hotplug stuff contains some pc specific patches).  However
they're included here because ppc is one of the main beneficiaries,
and the series depend on some ppc specific patches.

----------------------------------------------------------------
Alex Zuepke (1):
      target-ppc: fix Book-E TLB matching

Balamuruhan S (2):
      target-ppc: implement load atomic instruction
      target-ppc: implement store atomic instruction

Bharata B Rao (7):
      target-ppc: Add xsmaxcdp and xsmincdp instructions
      target-ppc: Add xsmaxjdp and xsminjdp instructions
      softfloat: Add round-to-odd rounding mode
      softfloat: Add float128_to_uint64_round_to_zero()
      softfloat: Add float128_to_uint32_round_to_zero()
      target-ppc: Implement round to odd variants of quad FP instructions
      target-ppc: Add xscvqpudz and xscvqpuwz instructions

Igor Mammedov (11):
      spapr: cpu core: separate child threads destruction from machine st=
ate operations
      spapr: move spapr_core_[foo]plug() callbacks close to machine code =
in spapr.c
      spapr: make cpu core unplug follow expected hotunplug call flow
      machine: move possible_cpus to MachineState
      pc: move pcms->possible_cpus init out of pc_cpus_init()
      pc: calculate topology only once when possible_cpus is initialised
      pc: pass apic_id to pc_find_cpu_slot() directly so lookup could be =
done without CPU object
      change CPUArchId.cpu type to Object*
      spapr: reuse machine->possible_cpus instead of cores[]
      machine: unify [pc_|spapr_]query_hotpluggable_cpus() callbacks
      machine: replace query_hotpluggable_cpus() callback with has_hotplu=
ggable_cpus flag

Jose Ricardo Ziviani (4):
      ppc: implement xsrqpi[x] instruction
      ppc: implement xsrqpxp instruction
      ppc: implement xssqrtqp instruction
      ppc: implement xssubqp instruction

Laurent Vivier (3):
      mac99: replace debug printf with trace points
      ppc4xx: replace debug printf with trace points
      spapr: replace debug printf with trace points

Nikunj A Dadhania (4):
      target-ppc: generate exception for copy/paste
      target-ppc: add slbieg instruction
      target-ppc: add slbsync implementation
      target-ppc: add wait instruction

Peter Maydell (1):
      hw/ppc/ppc405_uc.c: Avoid integer overflows

Sam Bobroff (3):
      spapr: fix off-by-one error in spapr_ovec_populate_dt()
      target-ppc, tcg: fix usermode segfault with pthread_create()
      hw/net/spapr_llan: 6 byte mac address device tree entry

Suraj Jitindar Singh (4):
      target/ppc: Fix LPCR DPFD mask define
      target/ppc/POWER9: Add ISAv3.00 MMU definition
      target/ppc/POWER9: Adapt LPCR handling for POWER9
      target/ppc/POWER9: Direct all instr and data storage interrupts to =
the hypv

Thomas Huth (3):
      hw/ppc/pnv: Remove superfluous "qemu" prefix from error strings
      hw/pci-host/prep: Do not use hw_error() in realize function
      hw/ppc/spapr: Check for valid page size when hot plugging memory

 fpu/softfloat.c                     | 108 ++++++++++++-
 hw/acpi/cpu.c                       |   2 +-
 hw/core/machine.c                   |  31 ++++
 hw/i386/pc.c                        | 126 +++++++--------
 hw/net/spapr_llan.c                 |  18 ++-
 hw/pci-host/prep.c                  |  11 +-
 hw/ppc/mac_newworld.c               |  15 +-
 hw/ppc/pnv.c                        |   6 +-
 hw/ppc/ppc405_uc.c                  |   6 +-
 hw/ppc/ppc4xx_pci.c                 |  13 +-
 hw/ppc/spapr.c                      | 255 ++++++++++++++++++++++++-----
 hw/ppc/spapr_cpu_core.c             | 137 +---------------
 hw/ppc/spapr_ovec.c                 |  19 +--
 hw/ppc/trace-events                 |  12 ++
 include/fpu/softfloat.h             |   5 +
 include/hw/boards.h                 |  16 +-
 include/hw/i386/pc.h                |   1 -
 include/hw/ppc/spapr.h              |   1 -
 include/hw/ppc/spapr_cpu_core.h     |   6 -
 linux-user/main.c                   |   3 +-
 monitor.c                           |   4 +-
 target/ppc/cpu-qom.h                |   5 +-
 target/ppc/cpu.h                    |  20 ++-
 target/ppc/fpu_helper.c             | 312 ++++++++++++++++++++++++++++++=
++++--
 target/ppc/helper.h                 |  11 ++
 target/ppc/internal.h               |   3 +
 target/ppc/kvm.c                    |  32 +++-
 target/ppc/kvm_ppc.h                |   7 +
 target/ppc/mmu-hash64.c             |  44 ++++-
 target/ppc/mmu_helper.c             |   4 +-
 target/ppc/translate.c              | 153 ++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c |  11 ++
 target/ppc/translate/vsx-ops.inc.c  |  21 +++
 target/ppc/translate_init.c         |  27 +++-
 vl.c                                |   2 +-
 35 files changed, 1093 insertions(+), 354 deletions(-)
