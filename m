Received: from eggs.gnu.org ([2001:4830:134:3::10]:33274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabW-00017w-A4
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabV-0001rj-5o
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:04 +1100
Message-Id: <20180103042419.14520-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] ppc-for-2.12 queue 20180103
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>


Peter, the pull request this supersedes apparently failed your tests
on an arm32 host, so it's very likely this one does as well.  I've
been unable to reproduce the problem on a handful of arm32 machines I
was able to borrow access to, and I'm beginning to suspect the problem
is something specific to the library/distro versions on your test
machine rather than something inherent to arm32.

I'm afraid I'm going to need help from you to fix this: either
debugging on your part, borrowed access or many more details of the
error.  At this point I simply have nothing whatsoever to go on to
debug the problem.


The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651=
b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-re=
quest' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180103

for you to fetch changes up to 28af7a42a98dd8d8c13eb0abac496165a8e04634:

  target/ppc: more use of the PPC_*() macros (2018-01-03 10:40:57 +1100)



----------------------------------------------------------------
ppc patch queue 2018-01-03

This pull request supersedes my one from 2017-12-19.  It has been
rebased and retested and has one extra patch, but is otherwise
unchanged.

Here's a second batch of patches for qemu-2.12.  Highlights are:
  * Optional capabilities for the "pseries" machine.  This removes
    some places where we were changing guest visible properties based
    on host capabilities, which makes life very bad for migration.
  * SLOF update
  * Significant TCG speedup from Paolo
  * Several new devices for embedded platforms
  * Some minor cleanups

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image to qemu-slof-20171214

BALATON Zoltan (4):
      sm501: Add panel hardware cursor registers also to read function
      sm501: Add some more unimplemented registers
      ppc4xx_i2c: Implement basic I2C functions
      hw/ide: Emulate SiI3112 SATA controller

C=C3=A9dric Le Goater (2):
      ppc/pnv: change powernv_ prefix to pnv_ for overall naming consiste=
ncy
      target/ppc: more use of the PPC_*() macros

David Gibson (6):
      spapr: Capabilities infrastructure
      spapr: Treat Hardware Transactional Memory (HTM) as an optional cap=
ability
      spapr: Validate capabilities on migration
      target/ppc: Clean up probing of VMX, VSX and DFP availability on KV=
M
      spapr: Handle VMX/VSX presence as an spapr capability flag
      spapr: Handle Decimal Floating Point (DFP) as an optional capabilit=
y

Greg Kurz (1):
      spapr_pci: use warn_report()

pbonzini@redhat.com (1):
      target-ppc: optimize cmp translation

 MAINTAINERS                        |   6 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/display/sm501.c                 |  30 +++
 hw/i2c/ppc4xx_i2c.c                | 198 +++++++++++++++++---
 hw/ide/Makefile.objs               |   1 +
 hw/ide/sii3112.c                   | 368 +++++++++++++++++++++++++++++++=
++++++
 hw/ide/trace-events                |   5 +
 hw/ppc/Makefile.objs               |   2 +-
 hw/ppc/pnv.c                       |  94 +++++-----
 hw/ppc/pnv_bmc.c                   |   2 +-
 hw/ppc/pnv_core.c                  |   8 +-
 hw/ppc/pnv_lpc.c                   |  16 +-
 hw/ppc/pnv_psi.c                   |   4 +-
 hw/ppc/pnv_xscom.c                 |  10 +-
 hw/ppc/spapr.c                     |  47 +++--
 hw/ppc/spapr_caps.c                | 341 +++++++++++++++++++++++++++++++=
+++
 hw/ppc/spapr_pci.c                 |   6 +-
 hw/ppc/spapr_pci_vfio.c            |   2 +-
 include/hw/i2c/ppc4xx_i2c.h        |   3 +
 include/hw/ppc/pnv.h               |  10 +-
 include/hw/ppc/pnv_xscom.h         |   4 +-
 include/hw/ppc/spapr.h             |  46 +++++
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 905200 -> 913880 bytes
 roms/SLOF                          |   2 +-
 target/ppc/cpu.h                   |  56 +++---
 target/ppc/int_helper.c            |   2 +-
 target/ppc/kvm.c                   |  27 +--
 target/ppc/kvm_ppc.h               |   2 -
 target/ppc/translate.c             |  29 ++-
 30 files changed, 1135 insertions(+), 189 deletions(-)
 create mode 100644 hw/ide/sii3112.c
 create mode 100644 hw/ppc/spapr_caps.c
