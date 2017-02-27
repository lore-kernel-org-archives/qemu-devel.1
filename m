Received: from eggs.gnu.org ([2001:4830:134:3::10]:37541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJF-0000MY-D8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJB-000733-Dg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:29:53 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJB-000726-6q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:29:49 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 839A2B3A5A
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:29:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:07 +0100
Message-Id: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/26] ppc/xics: simplify ICS and ICP
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>


Hello,

The goal behind this series is to simplify the XICS interface by
moving back in the machine the way the ICS and ICP objects interact
together. It's up to the machine to implement this "fabric" logic by
providing a set of handlers of a QOM interface. These handlers are
used to grab an ICS or an ICP object and also do irq resends. The idea
was suggested by David Gibson.


The patchset is organised as follow. It starts with a preliminary
cleanup to get rid of the set_nr_irqs() and set_nr_servers()
handlers. It also moves the creation of the ICS and ICP objects from
the XICS object to the sPAPR machine. This simplifies the code
significantly and prepares ground for future changes.

As the sPAPR machine only makes use of a single ICS, we can store it
at the machine level. This lets us remove dependencies on the list of
ICS of the XICS object and simplify even more the code for the
following changes.

The QOM interface to interact with the ICS and ICP objects is then
introduced. These are moved under the machine and cleanups are done
accordingly.

Finally, the XICSState classes are removed as they have been
deprecated by the QOM interface.


After the initial cleanups, which are rather big, each patch are small
and simple. The make target 'check-qtest-ppc64' runs succesfully for
each of them and so does migration of HV and TCG guests.

The tree is available here :

	   https://github.com/legoater/qemu/tree/ppc-2.9

Thanks,

C.



Caveats:

 - The kernel ICP file descriptor 'kernel_xics_fd' was made static to
   ease changes but that could be an issue. We could move it under the
   sPAPR machine if needed.

Changes since v3:

 - reintroduced 'xics' backlinks to remove useless calls to
   qdev_get_machine()
 - moved InterruptStatsProvider to the sPAPR machine for a better
   output
 - moved move ics-simple post_load under the machine and removed the
   icp_resend() XICSFabric handler
=20
Changes since v2:

 - renamed QOM Interface to XICSFabric

C=C3=A9dric Le Goater (25):
  ppc/xics: fix ICP and ICS reset
  ppc/xics: remove set_nr_irqs() handler from XICSStateClass
  ppc/xics: remove set_nr_servers() handler from XICSStateClass
  ppc/xics: store the ICS object under the sPAPR machine
  ppc/xics: add an InterruptStatsProvider interface to ICS and ICP
    objects
  ppc/xics: introduce a XICSFabric QOM interface to handle ICSs
  ppc/xics: use the QOM interface under the sPAPR machine
  ppc/xics: use the QOM interface to get irqs
  ppc/xics: use the QOM interface to resend irqs
  ppc/xics: remove xics_find_source()
  ppc/xics: register the reset handler of ICS objects
  ppc/xics: remove the XICS list of ICS
  ppc/xics: extend the QOM interface to handle ICPs
  ppc/xics: move kernel_xics_fd out of KVMXICSState
  ppc/xics: simplify the cpu_setup() handler
  ppc/xics: move the cpu_setup() handler under the ICPState class
  ppc/xics: use the QOM interface to grab an ICP
  ppc/xics: simplify spapr_dt_xics() interface
  ppc/xics: register the reset handler of ICP objects
  ppc/xics: move the ICP array under the sPAPR machine
  ppc/xics: export the XICS init routines
  ppc/xics: remove the XICSState classes
  ppc/xics: move ics-simple post_load under the machine
  ppc/xics: move InterruptStatsProvider to the sPAPR machine
  ppc/xics: rename 'ICPState *' variables to 'icp'

David Gibson (1):
  xics: XICS should not be a SysBusDevice

 hw/intc/xics.c              | 461 +++++++++++++++++---------------------=
------
 hw/intc/xics_kvm.c          | 184 +++++-------------
 hw/intc/xics_spapr.c        | 128 +++---------
 hw/ppc/spapr.c              | 134 ++++++++++---
 hw/ppc/spapr_cpu_core.c     |   4 +-
 hw/ppc/spapr_events.c       |  10 +-
 hw/ppc/spapr_pci.c          |  10 +-
 hw/ppc/spapr_vio.c          |   2 +-
 include/hw/pci-host/spapr.h |   2 +-
 include/hw/ppc/spapr.h      |   5 +-
 include/hw/ppc/spapr_vio.h  |   2 +-
 include/hw/ppc/xics.h       |  97 ++++------
 12 files changed, 424 insertions(+), 615 deletions(-)

--=20
2.7.4
