Received: from eggs.gnu.org ([2001:4830:134:3::10]:54918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTK4t-0008Pi-6Q
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 00:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTK4s-00014f-7m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 00:41:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 14:41:22 +1000
Message-Id: <20180614044129.13606-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv3 0/7] Better handling of machine specific
 per-cpu information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

It's moderately common for a machine type to need to keep track of
information that is specific to the platform it implements, but
per-cpu.

While it could keep such information inside the MachineState, this
makes lookup from the CPUState awkward.  So, this series adds a
standard way to stash machine-specific per-cpu information using a
void pointer in the PowerPCCPU object.  The machine is responsible for
alloc()ing, free()ing and (if applicable) migrating this state.

The meat of the series is the last two patches.  The first 5 clean up
a number of minor uglies I encountered while implementing.

Chganges since v2:
  * Fix compile (and other) errors in KVM code.

Changes since v1:
  * Simplify the error handling cleanup in 2/7 to use &error_abort
    instead of more propagations

David Gibson (7):
  spapr: Clean up cpu realize/unrealize paths
  pnv: Fix some error handling cpu realize()
  pnv_core: Allocate cpu thread objects individually
  pnv: Clean up cpu realize path
  pnv: Add cpu unrealize path
  target/ppc: Replace intc pointer with a general machine_data pointer
  target/ppc, spapr: Move VPA information to machine_data

 hw/intc/xics.c                  |   5 +-
 hw/intc/xics_spapr.c            |  16 +++--
 hw/ppc/pnv.c                    |   8 +--
 hw/ppc/pnv_core.c               | 100 ++++++++++++++++++--------------
 hw/ppc/spapr.c                  |   8 +--
 hw/ppc/spapr_cpu_core.c         |  85 +++++++++++++--------------
 hw/ppc/spapr_hcall.c            |  77 +++++++++++++-----------
 include/hw/ppc/pnv_core.h       |  11 +++-
 include/hw/ppc/spapr_cpu_core.h |  13 +++++
 include/hw/ppc/xics.h           |   4 +-
 target/ppc/cpu.h                |   8 +--
 target/ppc/kvm.c                |  36 ++++++------
 target/ppc/translate_init.inc.c |   8 ---
 13 files changed, 203 insertions(+), 176 deletions(-)

--=20
2.17.1
