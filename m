Received: from eggs.gnu.org ([2001:4830:134:3::10]:48063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxhy-0005Ky-1p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxhu-0006wQ-UW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:42 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIxhu-0006wE-NF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:38 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D9B4B3EADA
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:42:36 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 08 Jun 2017 15:42:32 +0200
Message-ID: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

I've provided answers for all comments from the v3 review that I deliberately
don't address in v4.

v4: - some patches from v3 got merged
    - added some more preparatory cleanup in xics (patches 1,2)
    - merge cpu_setup() handler into realize() (patch 4)
    - see individual changelog for patches 3 and 6

v3: - preparatory cleanup in pnv (patch 1)
    - rework ICPState realization and vmstate registration (patches 2,3,4)
    - fix migration using dummy icp/server entries (patch 5)

v2: - some patches from v1 are already merged in ppc-for-2.10
    - added a new fix to a potential memory leak (patch 1)
    - consolidate dt_id computation (patch 3)
    - see individual changelogs for patch 2 and 4

I could successfully do the following on POWER8 host with full cores (SMT8):

1) start a pseries-2.9 machine with QEMU 2.9:
        -smp cores=1,threads=2,maxcpus=8
2) hotplug a core:
        device_add host-spapr-cpu-core,core-id=4
3) migrate to QEMU 2.10 configured with core-id 0,4
4) hotplug another core:
        device_add host-spapr-cpu-core,core-id=2
5) migrate back to QEMU 2.9 configured with core-id 0,4,2
6) hotplug the core in the last available slot:
        device_add host-spapr-cpu-core,core-id=6
7) migrate to QEMU 2.10 configured with core-id 0,4,2,6

I could check that the guest is functional after each migration.

--
Greg

---

Greg Kurz (6):
      xics: introduce macros for ICP/ICS link properties
      xics: pass appropriate types to realize() handlers.
      xics: setup cpu at realize time
      xics: drop ICPStateClass::cpu_setup() handler
      xics: directly register ICPState objects to vmstate
      spapr: fix migration of ICPState objects from/to older QEMU


 hw/intc/xics.c          |   95 ++++++++++++++++++++---------------------------
 hw/intc/xics_kvm.c      |   18 ++++-----
 hw/intc/xics_pnv.c      |    6 +--
 hw/ppc/pnv_core.c       |   17 ++++----
 hw/ppc/pnv_psi.c        |    3 +
 hw/ppc/spapr.c          |   89 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_cpu_core.c |   22 +++++------
 include/hw/ppc/spapr.h  |    2 +
 include/hw/ppc/xics.h   |   16 ++++----
 9 files changed, 168 insertions(+), 100 deletions(-)
