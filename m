Received: from eggs.gnu.org ([2001:4830:134:3::10]:41519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELV-0003rl-Pm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELR-00023Q-PY
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:25 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAELR-0001yj-JA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:21 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id EBF6C1FB35
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:39:11 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 15 May 2017 13:38:58 +0200
Message-ID: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/6] spapr/xics: fix migration of older machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Recent work on XICS broke migration of older machine types. The target
fails with:

qemu-system-ppc64: Unknown savevm section or instance 'icp/server' 1
qemu-system-ppc64: load of migration failed: Invalid argument

This happens because the current code no longer pre-allocates ICP objects
at machine init time.

This series restore the previous behavior for older machine types (patch 6).
Since the fix adds an error path to cover the case when realization of the
ICP objects fails, the series first does some cleanup on the way errors are
handled (patch 1-5).

I could successfully migrate older machines back and forth with QEMU 2.9:
- pseries-2.9
- pseries-2.9 with hotplugged CPUs
- pseries-2.6 (pre CPU hotplug support)

This series is based on:

https://github.com/dgibson/qemu.git ppc-for-2.10

--
Greg

---

Greg Kurz (6):
      ppc/xics: simplify prototype of xics_spapr_init()
      spapr: fix error path of required kernel-irqchip
      spapr: fix error reporting in xics_system_init()
      spapr: sanitize error handling in spapr_ics_create()
      spapr-cpu-core: release ICP object when realization fails
      spapr: fix migration of ICP objects from/to older QEMU


 hw/intc/xics_spapr.c    |    3 +-
 hw/ppc/spapr.c          |   75 ++++++++++++++++++++++++++++++++++++++---------
 hw/ppc/spapr_cpu_core.c |   40 ++++++++++++++++---------
 include/hw/ppc/spapr.h  |    2 +
 include/hw/ppc/xics.h   |    2 +
 5 files changed, 90 insertions(+), 32 deletions(-)
