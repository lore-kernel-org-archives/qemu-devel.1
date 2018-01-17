Received: from eggs.gnu.org ([2001:4830:134:3::10]:45498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQH-0007pk-12
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQF-0001GZ-4D
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:03 +1100
Message-Id: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] ppc-for-2.12 queue 20180117
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada=
7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into =
staging (2018-01-16 17:36:39 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180117

for you to fetch changes up to 2e569845bd314fc1dde83d65dc9b87e71b4d29b4:

  target-ppc: Fix booke206 tlbwe TLB instruction (2018-01-17 09:35:24 +11=
00)

This pull request hasn't been through a Travis build, unfortunately,
since Travis seems to have a gigantic backlog today.  I've run all the
rest of my usual tests, and I did get a Travis build of this branch
before the latest minor rebase, so it's unlikely there's a problem
there.


----------------------------------------------------------------
ppc patch queue 2017-01-17

Another pull request for ppc related patches.  The most interesting
thing here is the new capabilities framework for the pseries machine
type.  This gives us better handling of several existing
incompatibilities between TCG, PR and HV KVM, as well as new ones that
arise with POWER9.  Further, it will allow reasonable handling of the
advertisement of features necessary to mitigate the recent CVEs
(Spectre and Meltdown).

In addition there's:
     * Improvide handling of different "vsmt" modes
     * Significant enhancements to the "pnv" machine type
     * Assorted other bugfixes

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      target/ppc: Yet another fix for KVM-HV HPTE accessors

C=C3=A9dric Le Goater (8):
      ppc/pnv: Update skiboot firmware image
      tests/boot-serial-test: fix powernv support
      ppc/pnv: use POWER9 DD2 processor
      ppc/pnv: change core mask for POWER9
      ppc/pnv: introduce pnv*_is_power9() helpers
      ppc/pnv: fix XSCOM core addressing on POWER9
      ppc/pnv: change initrd address
      target/ppc: add support for POWER9 HILE

David Gibson (10):
      spapr: Capabilities infrastructure
      spapr: Treat Hardware Transactional Memory (HTM) as an optional cap=
ability
      spapr: Validate capabilities on migration
      target/ppc: Clean up probing of VMX, VSX and DFP availability on KV=
M
      spapr: Handle VMX/VSX presence as an spapr capability flag
      spapr: Handle Decimal Floating Point (DFP) as an optional capabilit=
y
      spapr: Remove unnecessary 'options' field from sPAPRCapabilityInfo
      target/ppc: Clarify compat mode max_threads value
      spapr: Allow some cases where we can't set VSMT mode in the kernel
      spapr: Adjust default VSMT value for better migration compatibility

Jose Ricardo Ziviani (1):
      ppc: Change Power9 compat table to support at most 8 threads/core

Luc MICHEL (1):
      target-ppc: Fix booke206 tlbwe TLB instruction

Suraj Jitindar Singh (1):
      hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal represen=
tation

 hw/ppc/Makefile.objs       |   2 +-
 hw/ppc/pnv.c               |  23 +--
 hw/ppc/pnv_core.c          |   2 +-
 hw/ppc/pnv_xscom.c         |   8 +-
 hw/ppc/spapr.c             | 115 +++++++++++----
 hw/ppc/spapr_caps.c        | 345 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h       |  11 +-
 include/hw/ppc/pnv_xscom.h |  13 +-
 include/hw/ppc/spapr.h     |  49 +++++++
 pc-bios/skiboot.lid        | Bin 983893 -> 1302336 bytes
 roms/skiboot               |   2 +-
 target/ppc/compat.c        |  32 +++--
 target/ppc/cpu.h           |   3 +-
 target/ppc/excp_helper.c   |   2 +-
 target/ppc/kvm.c           |  38 ++---
 target/ppc/kvm_ppc.h       |   2 -
 target/ppc/mmu_helper.c    |  32 ++++-
 tests/boot-serial-test.c   |   2 +-
 tests/pnv-xscom-test.c     |  31 ++--
 19 files changed, 610 insertions(+), 102 deletions(-)
 create mode 100644 hw/ppc/spapr_caps.c
