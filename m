Received: from eggs.gnu.org ([2001:4830:134:3::10]:42491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcn-0002QB-GK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcj-0007lu-JK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:00:53 +1000
Message-Id: <20170510070115.13063-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] ppc-for-2.10 queue 20170510
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:

  Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170510

for you to fetch changes up to ca1de9d144f11e52f0e67c8d78b4206b2849eff0:

  pnv: Fix build failures on some host platforms (2017-05-10 16:46:01 +10=
00)

----------------------------------------------------------------
ppc patch queue for 2017-05-10

Highlights of this set:
  * Some fixes for POWER9
  * TCG support for POWER9 radix MMU
  * VGA rom for Mac machine types
  * Fixes for the XICS interrupt controller
  * MTTCG support for ppc targets

As suggested by Paolo, I've tried to add the Docker tests to my
standard pre-pull-request tests.  I haven't wholly suceeded; this has
been tested with some of the Docker images, but others I haven't
managed due to problems that as best I can tell are not due to
problems in this patch series.  I'll continue working on this for
future pull requests.

----------------------------------------------------------------
Bharata B Rao (1):
      cpus: Fix CPU unplug for MTTCG

C=C3=A9dric Le Goater (1):
      ppc/pnv: restrict BMC object to the BMC simulator

David Gibson (3):
      spapr: Don't accidentally advertise HTM support on POWER9
      target/ppc: Allow workarounds for POWER9 DD1
      pnv: Fix build failures on some host platforms

Mark Cave-Ayland (4):
      Add QemuMacDrivers as submodule
      Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a built as submodul=
e
      ppc: add qemu_vga.ndrv ROM to fw_cfg interface for OldWorld Macs
      ppc: add qemu_vga.ndrv ROM to fw_cfg interface for NewWorld Macs

Nikunj A Dadhania (5):
      target/ppc: Emulate LL/SC using cmpxchg helpers
      cputlb: handle first atomic write to the page
      target/ppc: Generate fence operations
      tcg: enable MTTCG by default for PPC64 on x86
      target/ppc: do not reset reserve_addr in exec_enter

Paolo Bonzini (1):
      ppc: xics: fix compilation with CentOS 6

Sam Bobroff (2):
      ppc/xics: Fix stale irq->status bits after get
      ppc/xics: preserve P and Q bits for KVM IRQs

Suraj Jitindar Singh (5):
      target/ppc: Set UPRT and GTSE on all cpus in H_REGISTER_PROCESS_TAB=
LE
      target/ppc: Update tlbie to check privilege level based on GTSE
      target/ppc: Change tlbie invalid fields for POWER9 support
      target/ppc: Implement ISA V3.00 radix page fault handler
      target/ppc: Enable RADIX mmu mode for pseries TCG guest

 .gitmodules                 |   3 +
 Makefile                    |   3 +-
 configure                   |   2 +
 cpus.c                      |   6 +
 cputlb.c                    |   8 +-
 hw/intc/xics_kvm.c          |  13 +++
 hw/ppc/mac_newworld.c       |  18 ++-
 hw/ppc/mac_oldworld.c       |  18 ++-
 hw/ppc/pnv.c                |   2 +-
 hw/ppc/spapr.c              |  17 ++-
 hw/ppc/spapr_hcall.c        |  18 ++-
 include/hw/ppc/pnv.h        |   3 +-
 include/hw/ppc/pnv_lpc.h    |   4 +-
 include/hw/ppc/pnv_occ.h    |   4 +-
 include/hw/ppc/xics.h       |   4 +-
 pc-bios/README              |   3 +
 pc-bios/qemu_vga.ndrv       | Bin 0 -> 14752 bytes
 roms/QemuMacDrivers         |   1 +
 target/ppc/Makefile.objs    |   1 +
 target/ppc/cpu-models.h     |   1 +
 target/ppc/cpu.h            |   4 +
 target/ppc/excp_helper.c    |   3 +
 target/ppc/kvm.c            |  11 ++
 target/ppc/mmu-book3s-v3.c  |   6 +-
 target/ppc/mmu-book3s-v3.h  |   5 +
 target/ppc/mmu-radix64.c    | 259 ++++++++++++++++++++++++++++++++++++++=
++++++
 target/ppc/mmu-radix64.h    |  71 ++++++++++++
 target/ppc/translate.c      |  48 ++++++--
 target/ppc/translate_init.c |  11 +-
 29 files changed, 498 insertions(+), 49 deletions(-)
 create mode 100644 pc-bios/qemu_vga.ndrv
 create mode 160000 roms/QemuMacDrivers
 create mode 100644 target/ppc/mmu-radix64.c
 create mode 100644 target/ppc/mmu-radix64.h
