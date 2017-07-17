Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxK-0002aA-4j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxG-0001WY-5V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:00 +1000
Message-Id: <20170717065621.4688-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] ppc-for-2.10 queue 20170717
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170717

for you to fetch changes up to 346ebfc6fbf1a0c07cbdfc52beef0f0b9b5180d4:

  target/ppc: fix CPU hotplug when radix is enabled (TCG) (2017-07-17 15:=
07:05 +1000)

----------------------------------------------------------------
ppc patch queue 2017-07-17

This pull requests supersedes the one from 2017-07-14.  That one had a
couple of subtle regressions: there was a build error for mingw32, and
an instance_size which was theoretically wrong everywhere, but only
actually bit on the Travis OSX build.

There are two major batches in this set, rather than the usual
collection of assorted fixes.

    * More DRC cleanup.  This gets the state management into a state
      which should fix many of the hotplug+migration problems we've
      had.  Plus it gets the migration stream format into something
      well defined and pretty minimal which we can reasonably support
      into the future.

    * Hashed Page Table resizing.  It's been a while since this was
      posted, but it's been through several previous rounds of review.
      The kernel parts (both guest and host) are merged in 4.11, so
      this is the only remaining piece left to allow resizing of the
      HPT in a running guest.

There are also a handful of unrelated fixes.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      ppc/pnv: Remove unused XICSState reference

C=C3=A9dric Le Goater (1):
      target/ppc: fix CPU hotplug when radix is enabled (TCG)

Daniel Henrique Barboza (1):
      spapr: migrate pending_events of spapr state

David Gibson (15):
      spapr: Remove unnecessary instance_size specifications from DRC sub=
types
      spapr: Minor cleanups to events handling
      spapr: Remove 'awaiting_allocation' DRC flag
      spapr: Simplify unplug path
      spapr: Abort on delete failure in spapr_drc_release()
      spapr: Refactor spapr_drc_detach()
      spapr: Cleanups relating to DRC awaiting_release field
      spapr: Consolidate DRC state variables
      spapr: Remove sPAPRConfigureConnectorState sub-structure
      spapr: Implement DR-indicator for physical DRCs only
      pseries: Stubs for HPT resizing
      pseries: Implement HPT resizing
      pseries: Enable HPT resizing for 2.10
      pseries: Use smaller default hash page tables when guest can resize
      pseries: Allow HPT resizing with KVM

Greg Kurz (2):
      spapr: fix potential memory leak in spapr_core_plug()
      spapr: fix memory leak in spapr_core_pre_plug()

Laurent Vivier (1):
      spapr: Treat devices added before inbound migration as coldplugged

 hw/ppc/spapr.c              | 239 ++++++++++++++++--------
 hw/ppc/spapr_drc.c          | 405 +++++++++++++++++++++-----------------=
--
 hw/ppc/spapr_events.c       |  98 +++++-----
 hw/ppc/spapr_hcall.c        | 439 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_pci.c          |  17 +-
 hw/ppc/trace-events         |   5 +-
 include/hw/ppc/pnv_psi.h    |   2 -
 include/hw/ppc/spapr.h      |  24 ++-
 include/hw/ppc/spapr_drc.h  |  74 +++++---
 include/hw/ppc/spapr_ovec.h |   1 +
 target/ppc/kvm.c            |  76 ++++++++
 target/ppc/kvm_ppc.h        |  26 +++
 target/ppc/mmu-hash64.h     |   4 +
 target/ppc/translate_init.c |  10 +-
 14 files changed, 1067 insertions(+), 353 deletions(-)
