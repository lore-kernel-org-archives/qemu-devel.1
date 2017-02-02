Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jZ-00071m-DV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jX-0003PB-P3
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:12:58 +1100
Message-Id: <20170202051445.5735-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 000/107] ppc-for-2.9 queue 20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d8=
47:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170202

for you to fetch changes up to 7c6e8797337c24520b48d8b50a900a747e50f974:

  hw/ppc/pnv: Use error_report instead of hw_error if a ROM file can't be=
 found (2017-02-02 09:30:07 +1100)

----------------------------------------------------------------
ppc patch queue 2017-02-02

This obsoletes ppc-for-2.9-20170112, which had a MacOS build bug.

This is a long overdue ppc pull request for qemu-2.9.  It's been a
long time coming due to some holidays and inconveniently timed
problems with testing.  So, there's a lot in here:

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
    * A number of bugfixes and cleanups
    * Stop the guest timebase when the guest is stopped under KVM.
      This makes the guest system clock also stop when paused, which
      matches the x86 behaviour.
    * Some preliminary cleanups leading towards implementation of the
      POWER9 MMU.

There are also some changes not strictly related to ppc code, but for
its benefit:

    * Limit the pxi-expander-bridge (PXB) device to x86 guests only
      (it's essentially a hack to work around historical x86
      limitations)
    * Some additions to the 128-bit math in host_utils, necessary for
      some of the new instructions.
    * Revise a number of qtests and enable them for ppc

----------------------------------------------------------------
Avinesh Kumar (1):
      target-ppc: add vextu[bhw][lr]x instructions

Bharata B Rao (19):
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
      softfloat: Fix the default qNAN for target-ppc
      target-ppc: Add xscvqps[d,w]z instructions
      target-ppc: Use ppc_vsr_t.f128 in xscmp[o,u,exp]qp
      target-ppc: Add xscvsdqp and xscvudqp instructions
      target-ppc: Add xsdivqp instruction
      target-ppc: Add xsmulqp instruction

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

Herv=C3=A9 Poussineau (5):
      prep: do not use global variable to access nvram
      prep: add PReP System I/O
      prep: add IBM RS/6000 7020 (40p) memory controller
      prep: add IBM RS/6000 7020 (40p) machine emulation
      ppc/prep: update MAINTAINERS file

Jose Ricardo Ziviani (13):
      target-ppc: Implement bcdcfsq. instruction
      target-ppc: Implement bcdctsq. instruction
      target-ppc: Implement bcdcpsgn. instruction
      target-ppc: Implement bcdsetsgn. instruction
      target-ppc: Implement bcd_is_valid function
      ppc: Fix a warning in bcdcfz code and improve BCD_DIG_BYTE macro
      host-utils: Move 128-bit guard macro to .c file
      host-utils: Implement unsigned quadword left/right shift and unit t=
ests
      ppc: Implement bcds. instruction
      ppc: Implement bcdus. instruction
      ppc: Implement bcdsr. instruction
      ppc: Implement bcdtrunc. instruction
      ppc: Implement bcdutrunc. instruction

Laurent Vivier (6):
      qtest: add netfilter tests for ppc64
      qtest: add display-vga-test to ppc64
      libqos: fix spapr qpci_map()
      qtest: convert ivshmem-test to use libqos
      qtest: add ivshmem-test for ppc64
      spapr: clock should count only if vm is running

Michael S. Tsirkin (1):
      ppc: switch to constants within BUILD_BUG_ON

Nicholas Piggin (1):
      ppc/spapr: implement H_SIGNAL_SYS_RESET

Nikunj A Dadhania (30):
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
      target-ppc: xscvqpdp zero VSR
      target-ppc: Add xsiexpdp instruction
      target-ppc: Add xsiexpqp instruction
      target-ppc: Add xviexpsp instruction
      target-ppc: Add xviexpdp instruction
      target-ppc: Add xvxexpsp instruction
      target-ppc: Add xvxexpdp instruction
      target-ppc: Add xvxsigsp instruction
      target-ppc: Add xvxsigdp instruction
      target-ppc: Add xvcv[hpsp, sphp] instructions
      target-ppc: Add xvtstdc[sp,dp] instructions
      target-ppc: Add xststdc[sp, dp, qp] instructions

Roman Kapl (1):
      ppc: Prevent inifnite loop in decrementer auto-reload.

Stefan Weil (1):
      disas/ppc: Fix indefinite articles in comments

Suraj Jitindar Singh (6):
      powerpc/cpu-models: rename ISAv3.00 logical PVR definition
      target/ppc: Add pcr_supported to POWER9 cpu class definition
      target/ppc/debug: Print LPCR register value if register exists
      tcg/POWER9: NOOP the cp_abort instruction
      target/ppc/mmu_hash64: Fix printing unsigned as signed int
      target/ppc/mmu_hash64: Fix incorrect shift value in amr calculation

Thomas Huth (6):
      hw/ppc/spapr: Fix boot path of usb-host storage devices
      ppc: Remove unused function cpu_ppc601_rtc_init()
      target/ppc: Remove unused POWERPC_FAMILY(POWER)
      target/ppc/cpu-models: Fix/remove bad CPU aliases
      ppc/kvm: Handle the "family" CPU via alias instead of registering n=
ew types
      hw/ppc/pnv: Use error_report instead of hw_error if a ROM file can'=
t be found

Valentin Plotkin (1):
      target-ppc: Add MMU model check for booke machines

xiaoqiang zhao (4):
      hw/gpio: QOM'ify mpc8xxx.c
      hw/ppc: QOM'ify e500.c
      hw/ppc: QOM'ify ppce500_spin.c
      hw/ppc: QOM'ify spapr_vio.c

 MAINTAINERS                         |   5 +-
 default-configs/i386-softmmu.mak    |   1 +
 default-configs/ppc-softmmu.mak     |   2 +
 default-configs/ppc64-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak  |   1 +
 disas/ppc.c                         |  12 +-
 fpu/softfloat-specialize.h          |   2 +-
 hw/gpio/mpc8xxx.c                   |  20 +-
 hw/pci-bridge/Makefile.objs         |   2 +-
 hw/ppc/Makefile.objs                |   2 +
 hw/ppc/e500.c                       |  23 +-
 hw/ppc/pnv.c                        |   6 +-
 hw/ppc/ppc.c                        |  73 ++--
 hw/ppc/ppc440_bamboo.c              |   6 +
 hw/ppc/ppc_booke.c                  |   8 +-
 hw/ppc/ppce500_spin.c               |  18 +-
 hw/ppc/prep.c                       | 234 ++++++++++-
 hw/ppc/prep_systemio.c              | 303 +++++++++++++++
 hw/ppc/rs6000_mc.c                  | 232 +++++++++++
 hw/ppc/spapr.c                      | 214 ++++++----
 hw/ppc/spapr_cpu_core.c             |  38 +-
 hw/ppc/spapr_hcall.c                | 160 ++++----
 hw/ppc/spapr_vio.c                  |  10 -
 hw/ppc/trace-events                 |  13 +-
 hw/ppc/virtex_ml507.c               |   7 +
 hw/usb/host-libusb.c                |  29 ++
 hw/usb/host-stub.c                  |   5 +
 include/fpu/softfloat.h             |  20 +
 include/hw/ppc/spapr.h              |   7 +-
 include/hw/usb.h                    |   1 +
 include/qemu/host-utils.h           |  27 ++
 target/ppc/Makefile.objs            |   2 +-
 target/ppc/compat.c                 | 185 +++++++++
 target/ppc/cpu-models.c             |  22 +-
 target/ppc/cpu-models.h             |   2 +-
 target/ppc/cpu-qom.h                |   3 +
 target/ppc/cpu.h                    |  67 +++-
 target/ppc/excp_helper.c            |  11 +-
 target/ppc/fpu_helper.c             | 756 +++++++++++++++++++++++++++++-=
------
 target/ppc/helper.h                 |  50 ++-
 target/ppc/int_helper.c             | 473 +++++++++++++++++++++-
 target/ppc/internal.h               | 202 ++++++++++
 target/ppc/kvm.c                    |  40 +-
 target/ppc/kvm_ppc.h                |   4 +-
 target/ppc/mem_helper.c             |  66 ++++
 target/ppc/mmu-hash64.c             |   4 +-
 target/ppc/mmu-hash64.h             |   2 +-
 target/ppc/translate.c              | 244 ++++--------
 target/ppc/translate/fp-impl.inc.c  |  20 +-
 target/ppc/translate/fp-ops.inc.c   |   2 -
 target/ppc/translate/vmx-impl.inc.c |  64 +++
 target/ppc/translate/vmx-ops.inc.c  |  23 +-
 target/ppc/translate/vsx-impl.inc.c | 484 +++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  74 ++++
 target/ppc/translate_init.c         |  97 +----
 tests/.gitignore                    |   1 +
 tests/Makefile.include              |  12 +-
 tests/display-vga-test.c            |   7 +-
 tests/ivshmem-test.c                |  46 ++-
 tests/libqos/pci-spapr.c            |   4 +-
 tests/test-shift128.c               | 139 +++++++
 util/Makefile.objs                  |   2 +-
 util/host-utils.c                   |  66 ++++
 63 files changed, 3877 insertions(+), 779 deletions(-)
 create mode 100644 hw/ppc/prep_systemio.c
 create mode 100644 hw/ppc/rs6000_mc.c
 create mode 100644 target/ppc/compat.c
 create mode 100644 tests/test-shift128.c
