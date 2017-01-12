Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjr-0002nw-DQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjq-0006MN-4f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:20 +1100
Message-Id: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/67] ppc-for-2.9 queue 20170112
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b44486dfb9447c88e4b216e730adcc78019085=
2c:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' i=
nto staging (2017-01-10 14:52:34 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170112

for you to fetch changes up to 229b5b6b56db9c3e6b8f44b4b55a62fa32979f47:

  ppc: Fix a warning in bcdcfz code and improve BCD_DIG_BYTE macro (2017-=
01-12 10:21:49 +1100)

----------------------------------------------------------------
ppc patch queue 2017-01-12

This is the first ppc pull request for qemu-2.9.  It's been a while
coming, partly due to dealing with some problems running my usual set
of tests.  So, there's quite a lot in here.

    * More POWER9 instruction implementations for TCG
    * The simpler parts of my CPU compatibility mode cleanup
        * This changes behaviour to prefer compatibility modes over
          "raW" mode for new machine type versions
    * New "40p" machine type which is essentially a modernized and
      cleaned up "prep".  The intention is that it will replace "prep"
      once it has some more testing and polish.
    * Add pseries-2.9 machine type
    * Implement H_SIGNAL_SYS_RESET hypercall
    * Consolidate the two alternate CPU init paths in pseries by
      making it always go through CPU core objects to initialize CPU
    * A handful of bugfixes and cleanups

There are also some changes not strictly related to ppc code, but for
its benefit:

    * Limit the pxi-expander-bridge (PXB) device to x86 guests only
      (it's essentially a hack to work around historical x86
      limitations)
    * Revise a number of qtests and enable them for ppc

----------------------------------------------------------------
Avinesh Kumar (1):
      target-ppc: add vextu[bhw][lr]x instructions

Bharata B Rao (13):
      target-ppc: Consolidate instruction decode helpers
      target-ppc: Fix xscmpodp and xscmpudp instructions
      target-ppc: Add xscmpexp[dp,qp] instructions
      target-ppc: Add xscmpoqp and xscmpuqp instructions
      target-ppc: Add xxperm and xxpermr instructions
      target-ppc: Use float64 arg in helper_compute_fprf()
      target-ppc: Replace isden by float64_is_zero_or_denormal
      target-ppc: Rename helper_compute_fprf to helper_compute_fprf_float=
64
      target-ppc: Add xscvdphp, xscvhpdp
      target-ppc: Use correct precision for FPRF setting
      target-ppc: Add xsaddqp instructions
      target-ppc: Add xscvdpqp instruction
      target-ppc: Add xscvqpdp instruction

David Gibson (12):
      pseries: Always use core objects for CPU construction
      pseries: Make cpu_update during CAS unconditional
      ppc: Clean up and QOMify hypercall emulation
      ppc: Rename cpu_version to compat_pvr
      target-ppc: implement xsabsqp/xsnabsqp instruction
      pseries: Add pseries-2.9 machine type
      ppc: Rewrite ppc_set_compat()
      ppc: Rewrite ppc_get_compat_smt_threads()
      ppc: Validate compatibility modes when setting
      pxb: Restrict to x86
      pseries: Rewrite CAS PVR compatibility logic
      ppc: Add ppc_set_compat_all()

Herv=C3=A9 Poussineau (4):
      prep: do not use global variable to access nvram
      prep: add PReP System I/O
      prep: add IBM RS/6000 7020 (40p) memory controller
      prep: add IBM RS/6000 7020 (40p) machine emulation

Jose Ricardo Ziviani (6):
      target-ppc: Implement bcdcfsq. instruction
      target-ppc: Implement bcdctsq. instruction
      target-ppc: Implement bcdcpsgn. instruction
      target-ppc: Implement bcdsetsgn. instruction
      target-ppc: Implement bcd_is_valid function
      ppc: Fix a warning in bcdcfz code and improve BCD_DIG_BYTE macro

Laurent Vivier (5):
      qtest: add netfilter tests for ppc64
      qtest: add display-vga-test to ppc64
      libqos: fix spapr qpci_map()
      qtest: convert ivshmem-test to use libqos
      qtest: add ivshmem-test for ppc64

Nicholas Piggin (1):
      ppc/spapr: implement H_SIGNAL_SYS_RESET

Nikunj A Dadhania (18):
      target-ppc: rename CRF_* defines as CRF_*_BIT
      target-ppc: implement lxsd and lxssp instructions
      target-ppc: implement stxsd and stxssp
      target-ppc: implement lxv/lxvx and stxv/stxvx
      target-ppc: move ppc_vsr_t to common header
      target-ppc: implement stop instruction
      target-ppc: implement xsnegqp instruction
      target-ppc: implement xscpsgnqp instruction
      target-ppc: implement lxvl instruction
      target-ppc: implement lxvll instruction
      target-ppc: implement stxvl instruction
      target-ppc: implement stxvll instructions
      target-ppc: Add xxextractuw instruction
      target-ppc: Add xxinsertw instruction
      target-ppc: Add xsxexpdp instruction
      target-ppc: Add xsxexpqp instruction
      target-ppc: Add xsxsigdp instruction
      target-ppc: Add xsxsigqp instructions

Roman Kapl (1):
      ppc: Prevent inifnite loop in decrementer auto-reload.

Stefan Weil (1):
      disas/ppc: Fix indefinite articles in comments

Thomas Huth (1):
      hw/ppc/spapr: Fix boot path of usb-host storage devices

xiaoqiang zhao (4):
      hw/gpio: QOM'ify mpc8xxx.c
      hw/ppc: QOM'ify e500.c
      hw/ppc: QOM'ify ppce500_spin.c
      hw/ppc: QOM'ify spapr_vio.c

 default-configs/i386-softmmu.mak    |   1 +
 default-configs/ppc-softmmu.mak     |   2 +
 default-configs/ppc64-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak  |   1 +
 disas/ppc.c                         |  12 +-
 hw/gpio/mpc8xxx.c                   |  20 +-
 hw/pci-bridge/Makefile.objs         |   2 +-
 hw/ppc/Makefile.objs                |   2 +
 hw/ppc/e500.c                       |  17 +-
 hw/ppc/ppc_booke.c                  |   8 +-
 hw/ppc/ppce500_spin.c               |  18 +-
 hw/ppc/prep.c                       | 234 ++++++++++++++++-
 hw/ppc/prep_systemio.c              | 303 ++++++++++++++++++++++
 hw/ppc/rs6000_mc.c                  | 232 +++++++++++++++++
 hw/ppc/spapr.c                      | 190 +++++++++-----
 hw/ppc/spapr_cpu_core.c             |  38 +--
 hw/ppc/spapr_hcall.c                | 160 +++++-------
 hw/ppc/spapr_vio.c                  |  10 -
 hw/ppc/trace-events                 |  13 +-
 hw/usb/host-libusb.c                |  29 +++
 hw/usb/host-stub.c                  |   5 +
 include/fpu/softfloat.h             |  20 ++
 include/hw/ppc/spapr.h              |   7 +-
 include/hw/usb.h                    |   1 +
 target/ppc/Makefile.objs            |   2 +-
 target/ppc/compat.c                 | 184 +++++++++++++
 target/ppc/cpu.h                    |  66 ++++-
 target/ppc/excp_helper.c            |  11 +-
 target/ppc/fpu_helper.c             | 505 ++++++++++++++++++++++++++----=
------
 target/ppc/helper.h                 |  31 ++-
 target/ppc/int_helper.c             | 256 ++++++++++++++++--
 target/ppc/internal.h               | 200 ++++++++++++++
 target/ppc/kvm.c                    |   4 +-
 target/ppc/kvm_ppc.h                |   4 +-
 target/ppc/mem_helper.c             |  66 +++++
 target/ppc/translate.c              | 236 ++++++-----------
 target/ppc/translate/fp-impl.inc.c  |  20 +-
 target/ppc/translate/fp-ops.inc.c   |   2 -
 target/ppc/translate/vmx-impl.inc.c |  48 ++++
 target/ppc/translate/vmx-ops.inc.c  |  10 +-
 target/ppc/translate/vsx-impl.inc.c | 301 +++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  45 ++++
 target/ppc/translate_init.c         |  73 +-----
 tests/Makefile.include              |   7 +-
 tests/display-vga-test.c            |   7 +-
 tests/ivshmem-test.c                |  46 ++--
 tests/libqos/pci-spapr.c            |   4 +-
 47 files changed, 2784 insertions(+), 670 deletions(-)
 create mode 100644 hw/ppc/prep_systemio.c
 create mode 100644 hw/ppc/rs6000_mc.c
 create mode 100644 target/ppc/compat.c
