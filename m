Received: from eggs.gnu.org ([2001:4830:134:3::10]:43150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkp-00061U-G4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETko-0007JF-G9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:13 +1000
Message-Id: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] ppc-for-2.13 queue 20180504
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 59255887e6cafeff747250d2613003a41d1d9d=
ff:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into =
staging (2018-05-03 11:25:14 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.13-20180504

for you to fetch changes up to 0550b1206a91d66051a21441a02c4ff126b531fe:

  spapr: don't advertise radix GTSE if max-compat-cpu < power9 (2018-05-0=
4 15:00:37 +1000)

----------------------------------------------------------------
ppc patch queue 2018-05-04

Second patch of patches for qemu-2.13 (or whatever the version ends up
being called).  Highlights are:
  * Preliminary patches for POWER9 hash MMU support for powernv
  * A number of cleanups fo pseries startup and LPCR handling
  * Remove support for explicitly allocated RMAs (which require kernel
    support that's been gone for 3+ years)
  * Some mac_newworld cleanups
  * A few bugfixes

----------------------------------------------------------------
C=C3=A9dric Le Goater (2):
      target/ppc: return a nil HPT base address on sPAPR machines
      target/ppc: add basic support for PTCR on POWER9

David Gibson (9):
      spapr: Remove support for explicitly allocated RMAs
      target/ppc: Add ppc_store_lpcr() helper
      spapr: Clean up rtas_start_cpu() & rtas_stop_self()
      spapr: Remove unhelpful helpers from rtas_start_cpu()
      spapr: Make a helper to set up cpu entry point state
      spapr: Clean up LPCR updates from hypercalls
      target/ppc: Delay initialization of LPCR_UPRT for secondary cpus
      spapr: Move PAPR mode cpu setup fully to spapr code
      spapr: Clean up handling of LPCR power-saving exit bits

Greg Kurz (3):
      target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack
      spapr: don't migrate "spapr_option_vector_ov5_cas" to pre 2.8 machi=
nes
      spapr: don't advertise radix GTSE if max-compat-cpu < power9

Mark Cave-Ayland (3):
      uninorth: create new uninorth device
      mac_newworld: remove pics IRQ array and wire up macio to OpenPIC di=
rectly
      mac_newworld: move wiring of macio IRQs to macio_newworld_realize()

 hw/misc/macio/macio.c           |  39 +++++++++------
 hw/pci-host/trace-events        |   2 +
 hw/pci-host/uninorth.c          |  58 +++++++++++++++++++++
 hw/ppc/mac.h                    |   9 ++++
 hw/ppc/mac_newworld.c           |  56 +++------------------
 hw/ppc/spapr.c                  |  84 ++++++++++++-------------------
 hw/ppc/spapr_cpu_core.c         |  47 ++++++++++++++---
 hw/ppc/spapr_hcall.c            |  50 ++++++++-----------
 hw/ppc/spapr_rtas.c             | 108 ++++++++++++++++++++--------------=
------
 hw/ppc/trace-events             |   4 --
 include/hw/misc/macio/macio.h   |   1 -
 include/hw/pci-host/uninorth.h  |  11 ++++
 include/hw/ppc/spapr_cpu_core.h |   3 ++
 target/ppc/cpu.h                |   4 +-
 target/ppc/helper.h             |   1 +
 target/ppc/kvm.c                |  46 ++---------------
 target/ppc/kvm_ppc.h            |   6 ---
 target/ppc/machine.c            |   5 ++
 target/ppc/misc_helper.c        |  12 +++++
 target/ppc/mmu-book3s-v3.h      |   6 +++
 target/ppc/mmu-hash64.c         |  15 ++++--
 target/ppc/mmu-hash64.h         |   6 ++-
 target/ppc/mmu_helper.c         |  29 +++++++++++
 target/ppc/translate.c          |   3 ++
 target/ppc/translate_init.c     |  80 +++++++----------------------
 25 files changed, 355 insertions(+), 330 deletions(-)
