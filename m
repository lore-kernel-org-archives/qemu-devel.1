Received: from eggs.gnu.org ([2001:4830:134:3::10]:38704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjtW-0000cf-29
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjtS-0006gE-FM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:29 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ebjtS-0006f9-3X
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:26 -0500
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 33BC585EB0
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 10:20:22 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 17 Jan 2018 10:20:14 +0100
Message-ID: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] spapr: fix CPU device tree nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When a compatibility mode is requested on the command line,
only the boot CPU core is correctly advertised in the device
tree. Any other CPU core, either hot-plugged or cold-plugged,
appears to be in raw mode with the host PVR.

Guest started on a POWER8 host with:
     -smp cores=2 -machine pseries,max-cpu-compat=compat7

# dtc -f -I fs -O dts /proc/device-tree | egrep 'cpu-version|pa-features'
                        ibm,pa-features = [18 00 f6 3f c7 c0 80 f0 80 00
 00 00 00 00 00 00 00 00 80 00 80 00 80 00 00 00];
                        cpu-version = <0x4d0200>;

                               ^^^
                        second CPU core

                        ibm,pa-features = <0x600f63f 0xc70080c0>;
                        cpu-version = <0xf000003>;

                               ^^^
                          boot CPU core

This happens because the compatibility mode for any CPU but
the boot one is set after the device tree was populated, and
exposed to the guest.

This series fixes the issue by setting the compatibility mode
during CPU reset. This is done in the last patch.

The first two patches are preliminary cleanup of the CPU reset
and CPU hotplug paths. They are not strictly needed, but I
think they are valuable anyway.

--
Greg

---

Greg Kurz (3):
      spapr: drop duplicate variable in spapr_core_plug()
      spapr_cpu_core: don't reset CPUs during realization
      spapr: fix device tree properties when using compatibility mode


 hw/ppc/spapr.c                  |   30 ++++++++++++++++++------------
 hw/ppc/spapr_cpu_core.c         |   15 +++++++++++++--
 hw/ppc/spapr_rtas.c             |    9 ---------
 include/hw/ppc/spapr_cpu_core.h |    2 ++
 4 files changed, 33 insertions(+), 23 deletions(-)
