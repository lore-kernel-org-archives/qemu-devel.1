Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKO-0002km-VF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKK-0006gd-Up
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:29 +1000
Message-Id: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/35] ppc-for-3.0 queue 20180703
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180703

for you to fetch changes up to 29f9cef39eb1ae55e82c6763eb22d7a1bdff7276:

  ppc: Include vga cirrus card into the compiling process (2018-07-03 11:=
23:09 +1000)

----------------------------------------------------------------
ppc patch queue 2018-07-03

Here's a last minue pull request before today's soft freeze.  Ideally
I would have sent this earlier, but I was waiting for a couple of
extra fixes I knew were close.  And the freeze crept up on me, like
always.

Most of the changes here are bugfixes in any case.  There are some
cleanups as well, which have been in my staging tree for a little
while.  There are a couple of truly new features (some extensions to
the sam460ex platform), but these are low risk, since they only affect
a new and not really stabilized machine type anyway.

Higlights are:
  * Mac platform improvements from Mark Cave-Ayland
  * Sam460ex improvements from BALATON Zoltan et al.
  * XICS interrupt handler cleanups from C=C3=A9dric Le Goater
  * TCG improvements for atomic loads and stores from Richard
    Henderson
  * Assorted other bugfixes

----------------------------------------------------------------
BALATON Zoltan (5):
      ppc4xx_i2c: Rewrite to model hardware more closely
      hw/timer: Add basic M41T80 emulation
      sam460ex: Add RTC device
      ppc440_uc: Basic emulation of PPC440 DMA controller
      target/ppc: Relax reserved bitmask of indexed store instructions

C=C3=A9dric Le Goater (7):
      ppc/xics: introduce ICP DeviceRealize and DeviceReset handlers
      ppc/xics: introduce a parent_realize in ICSStateClass
      ppc/xics: move the instance_init handler under the ics-base class
      ppx/xics: introduce a parent_reset in ICSStateClass
      ppc/xics: move the vmstate structures under the ics-base class
      ppc/xics: rework the ICS classes inheritance tree
      ppc/pnv: fix pnv_core_realize() error handling

David Gibson (1):
      hw/ppc: Give sam46ex its own config option

Emilio G. Cota (1):
      target/ppc: set is_jmp on ppc_tr_breakpoint_check

Greg Kurz (3):
      target/ppc/kvm: get rid of kvm_get_fallback_smmu_info()
      target/ppc/kvm: don't pass cpu to kvm_get_smmu_info()
      spapr: compute default value of "hpt-max-page-size" later

Guenter Roeck (1):
      sam460ex: Fix sam460ex device tree when booting the Linux kernel

John Arbuckle (1):
      fpu_helper.c: fix setting FPSCR[FI] bit

Mark Cave-Ayland (2):
      mac_dbdma: only dump commands for debug enabled channels
      mac_newworld: always enable disable_direct_reg3_writes for ADB mach=
ines

Richard Henderson (13):
      target/ppc: Add do_unaligned_access hook
      target/ppc: Use atomic load for LQ and LQARX
      target/ppc: Use atomic store for STQ
      target/ppc: Use atomic cmpxchg for STQCX
      target/ppc: Remove POWERPC_EXCP_STCX
      target/ppc: Tidy gen_conditional_store
      target/ppc: Split out gen_load_locked
      target/ppc: Split out gen_ld_atomic
      target/ppc: Split out gen_st_atomic
      target/ppc: Use MO_ALIGN for EXIWX and ECOWX
      target/ppc: Use atomic min/max helpers
      target/ppc: Implement the rest of gen_ld_atomic
      target/ppc: Implement the rest of gen_st_atomic

Sebastian Bauer (1):
      ppc: Include vga cirrus card into the compiling process

 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   3 +
 hw/i2c/ppc4xx_i2c.c             | 299 ++++++++++---------
 hw/intc/xics.c                  | 174 ++++++-----
 hw/intc/xics_kvm.c              |  80 +++--
 hw/intc/xics_pnv.c              |  15 +-
 hw/misc/macio/mac_dbdma.c       |  21 +-
 hw/ppc/Makefile.objs            |   3 +-
 hw/ppc/mac_newworld.c           |   4 +-
 hw/ppc/pnv_core.c               |   1 +
 hw/ppc/ppc440.h                 |   1 +
 hw/ppc/ppc440_uc.c              | 222 ++++++++++++++
 hw/ppc/sam460ex.c               |  32 ++
 hw/ppc/spapr.c                  |  16 +-
 hw/ppc/spapr_caps.c             |  13 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 ++++++++
 include/hw/i2c/ppc4xx_i2c.h     |   3 +-
 include/hw/ppc/xics.h           |   9 +-
 linux-user/ppc/cpu_loop.c       | 121 ++------
 target/ppc/cpu.h                |   8 +-
 target/ppc/excp_helper.c        |  18 +-
 target/ppc/fpu_helper.c         |   8 +
 target/ppc/helper.h             |  11 +
 target/ppc/internal.h           |   5 +
 target/ppc/kvm.c                | 118 ++------
 target/ppc/mem_helper.c         |  72 ++++-
 target/ppc/translate.c          | 641 +++++++++++++++++++++++++---------=
------
 target/ppc/translate_init.inc.c |   1 +
 29 files changed, 1299 insertions(+), 719 deletions(-)
 create mode 100644 hw/timer/m41t80.c
