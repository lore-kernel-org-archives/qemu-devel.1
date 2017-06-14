Received: from eggs.gnu.org ([2001:4830:134:3::10]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8M1-0005n4-Ns
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8Lx-00042Q-OB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:29:01 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:57560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dL8Lx-000420-H8
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:28:57 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B46D01052D7
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 15:28:55 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Jun 2017 15:28:43 +0200
Message-ID: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 0/3] spapr/xics: fix migration of older
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Cc'ing Laurent because I needed to incorporate the "spapr: manage hotplugged
devices while the VM is not started" patch in this series to be able to
verify that the "CPU core unplug" part of patch 3 behaves as expected.

With this series, I could successfully do the following on POWER8 host with
full cores:

1) start a pseries-2.9 machine with QEMU 2.9:
        -smp cores=1,threads=2,maxcpus=8

2) hotplug a core:
    device_add host-spapr-cpu-core,core-id=4,id=core4

3) migrate to QEMU 2.10 with core4 added (ie, started with same -smp as in
   step 1 and same device_add as step 2):

4) hotplug another core:
    device_add host-spapr-cpu-core,core-id=2,id=core2

5) migrate back to QEMU 2.9 with core4 and core2 added

6) hotplug the core in the last available slot:
    device_add host-spapr-cpu-core,core-id=6,id=core6

7) migrate to QEMU 2.10 with core4, core2 and core6 added

The following step requires Laurent's patch, otherwise the guest complains
about the non-existing DRC and fails to unplug the cores.

8) unplug some cores:
    device_del core4
    device_del core2

9) migrate back to QEMU 2.9 with core6 added

v5: - some patches from v4 got merged
    - rebased and added Laurent's change to manage hotplugging of CPU
      on the destination host (patch 1)
    - see individual changelog for patches 2 and 3

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

Cheers.

--
Greg

---

Greg Kurz (2):
      xics: directly register ICPState objects to vmstate
      spapr: fix migration of ICPState objects from/to older QEMU

Laurent Vivier (1):
      spapr: manage hotplugged devices while the VM is not started


 hw/intc/xics.c         |    5 ++
 hw/ppc/spapr.c         |  107 ++++++++++++++++++++++++++++++++++++++++++++----
 include/hw/ppc/spapr.h |    1 
 3 files changed, 104 insertions(+), 9 deletions(-)
