Received: from eggs.gnu.org ([2001:4830:134:3::10]:38406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnU-0000e3-PO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnT-0003vm-PE
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:00 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:26 +1100
Message-Id: <20180302060350.24330-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/24] ppc-for-2.12 queue 20180302
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, surajjs@au1.ibm.com, mark.cave-ayland@ilande.co.uk, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c=
67:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' in=
to staging (2018-03-01 17:08:16 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180302

for you to fetch changes up to 57ae75b2e401f1d04f37a8cd26212eb3134c51a6:

  hw/ppc/spapr,e500: Use new property "stdout-path" for boot console (201=
8-03-02 12:24:44 +1100)

----------------------------------------------------------------
ppc patch queue 2018-03-02

Here's the next batch of accumulated spapr and ppc patches.
Highlights are:
    * New Sam460ex machine type
    * Yet more fixes related to vcpu id allocation for spapr
    * Numerous macio cleanupsr
    * Some enhancements to the Spectre/Meltdown fixes for pseries,
      allowing use of a better mitigation for indirect branch based
      exploits
    * New pseries machine types with Spectre/Meltdown mitigations
      enabled (stop gap until libvirt and management understands the
      machine options)
    * A handful of other fixes

----------------------------------------------------------------
BALATON Zoltan (2):
      ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
      ppc: Add aCube Sam460ex board

Greg Kurz (3):
      spapr: fix missing CPU core nodes in DT when running with TCG
      spapr: register dummy ICPs later
      spapr: harden code that depends on VSMT

Mark Cave-Ayland (12):
      macio: embed DBDMA device directly within macio
      macio: move ESCC device within the macio device
      heathrow: QOMify heathrow PIC
      heathrow: convert to trace-events
      heathrow: change heathrow_pic_init() to return the heathrow device
      macio: move macio related structures and defines into separate maci=
o.h file
      mac_oldworld: use object link to pass heathrow PIC object to macio
      openpic: move KVM-specific declarations into separate openpic_kvm.h=
 file
      openpic: move OpenPIC state and related definitions to openpic.h
      mac_newworld: use object link to pass OpenPIC object to macio
      macio: move setting of CUDA timebase frequency to macio_common_real=
ize()
      macio: remove macio_init() function

Nikunj A Dadhania (1):
      hw/ppc/spapr,e500: Use new property "stdout-path" for boot console

Suraj Jitindar Singh (6):
      target/ppc: Check mask when setting cap_ppc_safe_indirect_branch
      ppc/spapr-caps: Add support for custom spapr_capabilities
      ppc/spapr-caps: Convert cap-cfpc to custom spapr-cap
      ppc/spapr-caps: Convert cap-sbbc to custom spapr-cap
      ppc/spapr-caps: Convert cap-ibs to custom spapr-cap
      ppc/spapr-caps: Define the pseries-2.12-sxxm machine type

 Makefile                           |   2 +-
 default-configs/ppc-softmmu.mak    |   2 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/intc/heathrow_pic.c             | 166 +++++-----
 hw/intc/openpic.c                  | 157 ----------
 hw/intc/openpic_kvm.c              |   1 +
 hw/intc/trace-events               |   5 +
 hw/misc/macio/macio.c              | 150 +++++----
 hw/ppc/Makefile.objs               |   3 +-
 hw/ppc/e500.c                      |   8 +
 hw/ppc/mac.h                       |  10 +-
 hw/ppc/mac_newworld.c              |  56 ++--
 hw/ppc/mac_oldworld.c              |  50 ++-
 hw/ppc/ppc440_pcix.c               | 528 +++++++++++++++++++++++++++++++=
+
 hw/ppc/sam460ex.c                  | 603 +++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c                     | 176 ++++++-----
 hw/ppc/spapr_caps.c                | 132 +++++---
 hw/ppc/spapr_hcall.c               |   5 +-
 hw/ppc/trace-events                |   8 +
 include/hw/intc/heathrow_pic.h     |  49 +++
 include/hw/misc/macio/macio.h      |  79 +++++
 include/hw/ppc/openpic.h           | 160 +++++++++-
 include/hw/ppc/openpic_kvm.h       |   7 +
 include/hw/ppc/spapr.h             |   5 +-
 pc-bios/canyonlands.dtb            | Bin 0 -> 9779 bytes
 pc-bios/canyonlands.dts            | 566 +++++++++++++++++++++++++++++++=
+++
 target/ppc/kvm-stub.c              |   2 +-
 target/ppc/kvm.c                   |   6 +-
 tests/qom-test.c                   |   7 +
 tests/test-hmp.c                   |   3 +-
 30 files changed, 2423 insertions(+), 524 deletions(-)
 create mode 100644 hw/ppc/ppc440_pcix.c
 create mode 100644 hw/ppc/sam460ex.c
 create mode 100644 include/hw/intc/heathrow_pic.h
 create mode 100644 include/hw/misc/macio/macio.h
 create mode 100644 include/hw/ppc/openpic_kvm.h
 create mode 100644 pc-bios/canyonlands.dtb
 create mode 100644 pc-bios/canyonlands.dts
