Received: from eggs.gnu.org ([2001:4830:134:3::10]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaX-0000i0-7L
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaS-0004mS-Mm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 15:53:09 +1000
Message-Id: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 0/8] spapr: DRC cleanups (part VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, danielhb@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

This sixth set of DRC cleanup patches is a complete rework of DRC
state management.  We stop tracking some unnecessary things, and
change the basic state representation to a simpler and more robust
model.

Many of the patches in this set "break" migration from earlier git
snapshots, but not from any released qemu version.  The previous
migration stream format had multiple problems, so better to fix them
now, before 2.10 is out.

Although there are certainly more things that can be improved in the
DRC system, with this series we should have a solid foundation for
migrating DRCs - the state trasferred is about as minimal and well
defined as it's possible to be.

Changes since v1:
  * Rebased onto current tree
  * Added cleanup to unplug path
  * Added restriction of DR-indicator to physical DRCs
  * Included revised version of Laurent's patch to correctly handle
    things "hot" plugged before incoming migration

David Gibson (7):
  spapr: Remove 'awaiting_allocation' DRC flag
  spapr: Simplify unplug path
  spapr: Refactor spapr_drc_detach()
  spapr: Cleanups relating to DRC awaiting_release field
  spapr: Consolidate DRC state variables
  spapr: Remove sPAPRConfigureConnectorState sub-structure
  spapr: Implement DR-indicator for physical DRCs only

Laurent Vivier (1):
  spapr: Treat devices added before inbound migration as coldplugged

 hw/ppc/spapr.c             |  89 +++-------
 hw/ppc/spapr_drc.c         | 399 ++++++++++++++++++++++++---------------------
 hw/ppc/spapr_pci.c         |  17 +-
 hw/ppc/trace-events        |   3 +-
 include/hw/ppc/spapr_drc.h |  74 ++++++---
 5 files changed, 301 insertions(+), 281 deletions(-)

-- 
2.9.4
