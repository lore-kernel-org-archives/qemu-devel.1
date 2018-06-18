Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEW-0005IZ-KW
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlET-0003vf-Gx
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:52:56 +1000
Message-Id: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/28] ppc-for-3.0 queue 20180618
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180618

for you to fetch changes up to 844afc54ae229515a37f63519855661ad2d01d19:

  spapr: fix xics_system_init() error path (2018-06-18 09:43:19 +1000)

----------------------------------------------------------------
ppc patch queue 2018-06-18

Next batch of ppc and spapr related patches for the 3.0 release.
    * Improved handling of Spectre/Meltdown mitigations for POWER8
    * Numerous Mac machine type cleanups and improvements
    * Cleanup to cpu realize/unrealize path for spapr
    * Create a place for machine-specific per-cpu information, and
      start moving some things to it
    * Assorted bugfixes

----------------------------------------------------------------
BALATON Zoltan (1):
      sm501: Do not clear read only bits when writing registers

C=C3=A9dric Le Goater (2):
      xics_kvm: fix a build break
      ppc/pnv: introduce a pnv_chip_core_realize() routine

David Gibson (6):
      spapr: Clean up cpu realize/unrealize paths
      pnv: Fix some error handling cpu realize()
      pnv_core: Allocate cpu thread objects individually
      pnv: Clean up cpu realize path
      pnv: Add cpu unrealize path
      target/ppc, spapr: Move VPA information to machine_data

Greg Kurz (7):
      target/ppc: drop empty #if/#endif block
      spapr: fix leak in h_client_architecture_support()
      spapr_cpu_core: convert last snprintf() to g_strdup_printf()
      spapr_cpu_core: fix potential leak in spapr_cpu_core_realize()
      spapr_cpu_core: add missing rollback on realization path
      spapr_cpu_core: introduce spapr_create_vcpu()
      spapr: fix xics_system_init() error path

Mark Cave-Ayland (10):
      ppc: introduce Core99MachinesState for the mac99 machine
      mac_newworld: add via machine option to control mac99 VIA/ADB confi=
guration
      mac_newworld: add gpios to macio devices with PMU enabled
      mac_newworld: wire up programmer switch to NMI handler
      adb: fix read reg 3 byte ordering
      adb: add property to disable direct reg 3 writes
      mac_newworld: add PMU device
      mos6522: only clear the shift register interrupt upon write
      mos6522: remove additional interrupt flag filter from mos6522_updat=
e_irq()
      mos6522: expose mos6522_update_irq() through MOS6522DeviceClass

Suraj Jitindar Singh (2):
      target/ppc: Don't require private l1d cache on POWER8 for cap_ppc_s=
afe_cache
      ppc/spapr_caps: Don't disable cap_cfpc on POWER8 by default

 default-configs/ppc-softmmu.mak |   2 +
 hw/display/sm501.c              |  15 +-
 hw/input/adb-kbd.c              |  29 +-
 hw/input/adb-mouse.c            |  41 +-
 hw/input/adb.c                  |   7 +
 hw/intc/xics_kvm.c              |  10 +-
 hw/misc/macio/Makefile.objs     |   2 +
 hw/misc/macio/gpio.c            | 231 +++++++++++
 hw/misc/macio/macio.c           |  89 +++-
 hw/misc/macio/pmu.c             | 871 ++++++++++++++++++++++++++++++++++=
++++++
 hw/misc/macio/trace-events      |  28 ++
 hw/misc/mos6522.c               |   5 +-
 hw/ppc/mac.h                    |  20 +
 hw/ppc/mac_newworld.c           |  84 +++-
 hw/ppc/pnv.c                    |  36 +-
 hw/ppc/pnv_core.c               |  93 ++---
 hw/ppc/spapr.c                  |  22 +-
 hw/ppc/spapr_caps.c             |   6 +-
 hw/ppc/spapr_cpu_core.c         | 163 ++++----
 hw/ppc/spapr_hcall.c            |  78 ++--
 include/hw/input/adb.h          |   1 +
 include/hw/misc/macio/gpio.h    |  47 +++
 include/hw/misc/macio/macio.h   |   7 +
 include/hw/misc/macio/pmu.h     | 237 +++++++++++
 include/hw/misc/mos6522.h       |   1 +
 include/hw/ppc/pnv_core.h       |   2 +-
 include/hw/ppc/ppc.h            |   1 +
 include/hw/ppc/spapr_cpu_core.h |  11 +
 target/ppc/cpu.h                |   9 +-
 target/ppc/kvm.c                |  58 ++-
 target/ppc/translate_init.inc.c |   8 -
 31 files changed, 1930 insertions(+), 284 deletions(-)
 create mode 100644 hw/misc/macio/gpio.c
 create mode 100644 hw/misc/macio/pmu.c
 create mode 100644 include/hw/misc/macio/gpio.h
 create mode 100644 include/hw/misc/macio/pmu.h
