Received: from eggs.gnu.org ([2001:4830:134:3::10]:57233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0006UW-Qp
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoL-0007S4-OW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:14 +1000
Message-Id: <20170525035132.24268-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170525

for you to fetch changes up to 62f94fc94f98095173146e753a1f03d7c2cc7ba3:

  xics: add unrealize handler (2017-05-25 11:31:33 +1000)

----------------------------------------------------------------
ppc patch queue 2017-05-25

Assorted accumulated patches.  These are nearly all bugfixes at one
level or another - some for longstanding problems, others for some
regressions caused by more recent cleanups.

This includes preliminary patches towards fixing migration for Radix
Page Table guests under POWER9 and also fixing some migration
regressions due to the re-organization of the interrupt controller
code.  Not all the pieces are there yet, so those still won't quite
work, but the preliminary changes make sense on their own.

----------------------------------------------------------------
Bharata B Rao (1):
      spapr: Consolidate HPT freeing code into a routine

Daniel Henrique Barboza (4):
      hw/ppc/spapr_events.c: removing 'exception' from sPAPREventLogEntry
      hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
      hw/ppc: migrating the DRC state of hotplugged devices
      hw/ppc/spapr.c: recover pending LMB unplug info in spapr_lmb_releas=
e

David Gibson (3):
      pseries: Split CAS PVR negotiation out into a separate function
      pseries: Restore support for total vcpus not a multiple of threads-=
per-core for old machine types
      hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState

Greg Kurz (8):
      ppc/xics: simplify prototype of xics_spapr_init()
      spapr: sanitize error handling in spapr_ics_create()
      spapr-cpu-core: release ICP object when realization fails
      xics_kvm: cache already enabled vCPU ids
      spapr: ensure core_slot isn't NULL in spapr_core_unplug()
      spapr_cpu_core: drop reference on ICP object during CPU realization
      spapr: fix error reporting in xics_system_init()
      xics: add unrealize handler

Laurent Vivier (1):
      spapr: add pre_plug function for memory

Nikunj A Dadhania (1):
      target/ppc: reset reservation in do_rfi()

 hw/intc/xics.c              |   5 +
 hw/intc/xics_kvm.c          |  33 ++++--
 hw/intc/xics_spapr.c        |   3 +-
 hw/ppc/spapr.c              | 239 +++++++++++++++++++++++++++++++-------=
------
 hw/ppc/spapr_cpu_core.c     |  19 ++--
 hw/ppc/spapr_drc.c          |  92 ++++++++++++++---
 hw/ppc/spapr_events.c       |  52 ++--------
 hw/ppc/spapr_hcall.c        |  54 ++++++----
 hw/ppc/spapr_pci.c          |   5 +-
 include/hw/pci-host/spapr.h |   3 +
 include/hw/ppc/spapr.h      |  12 ++-
 include/hw/ppc/spapr_drc.h  |   8 +-
 include/hw/ppc/xics.h       |   3 +-
 target/ppc/excp_helper.c    |   3 +
 14 files changed, 349 insertions(+), 182 deletions(-)
