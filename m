Received: from eggs.gnu.org ([2001:4830:134:3::10]:43509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtsz-00014n-Gd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtsx-00025l-Ne
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:03 +1000
Message-Id: <20170714061521.28300-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d=
4f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12'=
 into staging (2017-07-13 16:56:06 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170714

for you to fetch changes up to e11134d2ac7744569d7c387102368c507d340c30:

  pseries: Allow HPT resizing with KVM (2017-07-14 09:28:30 +1000)

----------------------------------------------------------------
ppc patch queue 2017-07-14

Two major batches in this set, rather than the usual collection of
assorted fixes.

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

Daniel Henrique Barboza (1):
      spapr: migrate pending_events of spapr state

David Gibson (14):
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

Greg Kurz (1):
      spapr: fix potential memory leak in spapr_core_plug()

Laurent Vivier (1):
      spapr: Treat devices added before inbound migration as coldplugged

 hw/ppc/spapr.c              | 235 ++++++++++++++++--------
 hw/ppc/spapr_drc.c          | 401 ++++++++++++++++++++++----------------=
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
 13 files changed, 1056 insertions(+), 346 deletions(-)
