Received: from eggs.gnu.org ([2001:4830:134:3::10]:35347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNv-0003CL-NS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNr-0006Rx-Lb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  8 Jan 2018 16:53:36 +1100
Message-Id: <20180108055348.20444-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: surajjs@au1.ibm.com, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651=
b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-re=
quest' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180108

for you to fetch changes up to 9f173585d3f35345b2facce50620ce2cdda05f2f:

  spapr: Correct compatibility mode setting for hotplugged CPUs (2018-01-=
08 13:33:17 +1100)

----------------------------------------------------------------
ppc patch queue 2018-01-08

This pull requests supersedes both ppc-for-2.12-20180103 and
ppc-for-2.12-20171219.  We've discovered that some substantial
extensions to the proposed capabilities infrastructure will be
valuable, amongst other things for managing/advertising workarounds
for the dreaded Meltdown/Spectre bugs.

Although that could be done as follow on changes, since the caps
infrastructure hasn't been merged yet, we might as well pull it out
while we rework, and just merge the unrelated bugfixes.

The last two pull requests apparently had problems on some arm32
systems.  I haven't been able to reproduce those, so I have no idea
which patch is causing them.  If we get lucky and it was one of the
patches I've removed from this series, this may also serve to unjam
the other fixes.

Higlights from this series:
  * SLOF update
  * Significant TCG speedup from Paolo
  * Several new devices for embedded platforms
  * Fix to correctly set compatiblity mode for hotplugged CPUs
  * dtc compile fix for older MacOS versions

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

David Gibson (1):
      spapr: Correct compatibility mode setting for hotplugged CPUs

Greg Kurz (1):
      spapr_pci: use warn_report()

John Arbuckle (1):
      Update dtc to fix compilation problem on Mac OS 10.6

Thomas Huth (1):
      hw/ppc: Remove the deprecated spapr-pci-vfio-host-bridge device

pbonzini@redhat.com (1):
      target-ppc: optimize cmp translation

 MAINTAINERS                        |   6 +
 default-configs/ppcemb-softmmu.mak |   1 +
 dtc                                |   2 +-
 hw/display/sm501.c                 |  30 +++
 hw/i2c/ppc4xx_i2c.c                | 198 +++++++++++++++++---
 hw/ide/Makefile.objs               |   1 +
 hw/ide/sii3112.c                   | 368 +++++++++++++++++++++++++++++++=
++++++
 hw/ide/trace-events                |   5 +
 hw/ppc/pnv.c                       |  94 +++++-----
 hw/ppc/pnv_bmc.c                   |   2 +-
 hw/ppc/pnv_core.c                  |   8 +-
 hw/ppc/pnv_lpc.c                   |  16 +-
 hw/ppc/pnv_psi.c                   |   4 +-
 hw/ppc/pnv_xscom.c                 |  10 +-
 hw/ppc/spapr.c                     |   2 +-
 hw/ppc/spapr_pci.c                 |   6 +-
 hw/ppc/spapr_pci_vfio.c            |  47 -----
 hw/ppc/spapr_rtas.c                |   9 +
 include/hw/i2c/ppc4xx_i2c.h        |   3 +
 include/hw/ppc/pnv.h               |  10 +-
 include/hw/ppc/pnv_xscom.h         |   4 +-
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 905200 -> 913880 bytes
 qemu-doc.texi                      |   5 -
 roms/SLOF                          |   2 +-
 scripts/device-crash-test          |   1 -
 target/ppc/cpu.h                   |  56 +++---
 target/ppc/int_helper.c            |   2 +-
 target/ppc/translate.c             |  29 ++-
 29 files changed, 717 insertions(+), 206 deletions(-)
 create mode 100644 hw/ide/sii3112.c
