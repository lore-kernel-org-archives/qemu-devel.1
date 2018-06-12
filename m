Received: from eggs.gnu.org ([2001:4830:134:3::10]:58635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3g-0002cc-QG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3d-0001fn-7j
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:30 +1000
Message-Id: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c7=
4a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-=
11' into staging (2018-06-11 15:31:20 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180612

for you to fetch changes up to 30f79dc13f116a79ff45d37ad0f5c035012064a7:

  spapr_pci: Remove unhelpful pagesize warning (2018-06-12 10:44:36 +1000=
)

----------------------------------------------------------------
ppc patch queue 2018-06-12

Here's another batch of ppc patches towards the 3.0 release.  There's
a fair bit here, because I've been working through my mail backlog
after a holiday.  There's not much of a central theme, amongst other
things we have:
    * ppc440 / sam460ex improvements
    * logging and error cleanups
    * 40p (PReP) bugfixes
    * Macintosh fixes and cleanups
    * Add emulation of the new POWER9 store-forwarding barrier
      instruction variant
    * Hotplug cleanups

----------------------------------------------------------------
BALATON Zoltan (2):
      ppc440_pcix: Fix a typo in setting a register (Coverity CID1390577)
      ppc4xx_i2c: Clean up and improve error logging

C=C3=A9dric Le Goater (4):
      spapr/vio: deprecate the "irq" property
      target/ppc: extend eieio for POWER9
      ppc/pnv: fix LPC HC firmware address space
      xics_kvm: use KVM helpers

David Gibson (1):
      spapr_pci: Remove unhelpful pagesize warning

David Hildenbrand (6):
      spapr: no need to verify the node
      spapr: move lookup of the node into spapr_memory_plug()
      spapr: move memory hotplug support check into spapr_memory_pre_plug=
()
      spapr: introduce machine unplug handler
      spapr: handle pc-dimm unplug via hotplug handler chain
      spapr: handle cpu core unplug via hotplug handler chain

Joel Stanley (1):
      target/ppc: Allow privileged access to SPR_PCR

Mark Cave-Ayland (11):
      macio: add trace-events to timer device
      uninorth: remove token register from uninorth device
      40p: remove pci_allow_0_address =3D true from 40p machine class
      prep: fix keyboard for the 40p machine
      ppc: remove obsolete pci_pmac_init() definitions from mac.h
      ppc: remove obsolete macio_init() definition from mac.h
      ppc: add missing FW_CFG_PPC_NVRAM_FLAT definition
      mos6522: fix vmstate_mos6522_timer version in vmstate_mos6522
      cuda: embed mos6522_cuda device directly rather than using QOM obje=
ct link
      mos6522: move timer frequency initialisation to mos6522_reset
      mos6522: convert VMSTATE_TIMER_PTR_TEST to VMSTATE_TIMER_PTR

Nicholas Piggin (1):
      osdep: powerpc64 align memory to allow 2MB radix THP page tables

Philippe Mathieu-Daud=C3=A9 (4):
      hw/ppc/spapr_drc: Replace error_setg(&error_abort) by error_report(=
) + abort()
      MAINTAINERS: Add an entry for the MacIO device headers
      MAINTAINERS: Add entries for the MOS6522 VIA device
      hw/misc/mos6522: Add trailing '\n' to qemu_log() calls

Suraj Jitindar Singh (1):
      target/ppc: Factor out the parsing in kvmppc_get_cpu_characteristic=
s()

Thomas Huth (1):
      target/ppc: Use proper logging function for possible guest errors

luporl (1):
      target/ppc: Allow PIR read in privileged mode

 MAINTAINERS                     |  5 ++-
 hw/i2c/ppc4xx_i2c.c             | 94 ++++++++++++++++++++++-------------=
------
 hw/intc/xics_kvm.c              | 52 ++++++-----------------
 hw/misc/macio/cuda.c            | 50 +++++++++-------------
 hw/misc/macio/macio.c           |  3 ++
 hw/misc/macio/trace-events      |  4 ++
 hw/misc/mos6522.c               | 30 ++++---------
 hw/pci-host/uninorth.c          | 11 +++--
 hw/ppc/mac.h                    |  9 ----
 hw/ppc/pnv_lpc.c                |  4 +-
 hw/ppc/ppc440_pcix.c            |  2 +-
 hw/ppc/prep.c                   |  2 -
 hw/ppc/spapr.c                  | 67 ++++++++++++++++++-----------
 hw/ppc/spapr_drc.c              |  3 +-
 hw/ppc/spapr_pci.c              |  7 ---
 hw/ppc/spapr_vio.c              | 22 +++++++++-
 include/hw/misc/macio/cuda.h    | 27 ++++++------
 include/hw/misc/mos6522.h       |  4 +-
 include/hw/pci-host/uninorth.h  |  4 +-
 include/hw/ppc/pnv_lpc.h        |  1 +
 include/hw/ppc/ppc.h            |  1 +
 include/qemu/osdep.h            |  3 +-
 qemu-doc.texi                   | 12 +++++-
 target/ppc/helper.h             |  1 +
 target/ppc/kvm.c                | 59 +++++++++++++++++---------
 target/ppc/misc_helper.c        |  9 ++++
 target/ppc/translate.c          | 62 +++++++++++++++------------
 target/ppc/translate_init.inc.c | 11 +++--
 28 files changed, 304 insertions(+), 255 deletions(-)
