Received: from eggs.gnu.org ([2001:4830:134:3::10]:46622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQrb8-0006Ys-Oa
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQrb7-0001nc-S7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:20:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Dec 2017 20:20:18 +1100
Message-Id: <20171218092024.21645-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/6] spapr: Add optional capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: surajjs@au1.ibm.com, groug@kaod.org, lvivier@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This series is a first draft to add the notion of optional
capabilities to the "pseries" machine type.  A default set of
capabilities is selected based on the machine type version and
selected cpu model, but this can be overridden with machine
parameters.

The purpose of this is to get rid of a number of places where we
implicitly decide what features to advertise to the guest based on
capabilities of the host.  This is bad, because it means it's
difficult to be certain if machines started at different ends of a
migration really match from the guest's point of view.

By giving the user explicit control of these optional features, then
validating that the chosen ones can be supplied on the host we make
behaviour more predictable.

The more specific motivation for this is that POWER9 has bugs in its
hardware transactional memory (HTM) implementation making it unsafe to
migrate POWER8 guests to POWER9 if they use HTM.

Changes since RFC:
 - Two preliminary patches not really related split off and already
   merged.
 - Assorted minor fixes based on review notes
 - Change defaults to disable HTM on pseries-2.12 machine type

David Gibson (6):
  spapr: Capabilities infrastructure
  spapr: Treat Hardware Transactional Memory (HTM) as an optional
    capability
  spapr: Validate capabilities on migration
  target/ppc: Clean up probing of VMX, VSX and DFP availability on KVM
  spapr: Handle VMX/VSX presence as an spapr capability flag
  spapr: Handle Decimal Floating Point (DFP) as an optional capability

 hw/ppc/Makefile.objs   |   2 +-
 hw/ppc/spapr.c         |  47 +++++--
 hw/ppc/spapr_caps.c    | 342 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  46 +++++++
 target/ppc/kvm.c       |  27 +---
 target/ppc/kvm_ppc.h   |   2 -
 6 files changed, 429 insertions(+), 37 deletions(-)
 create mode 100644 hw/ppc/spapr_caps.c

-- 
2.14.3
