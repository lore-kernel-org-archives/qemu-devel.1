Received: from eggs.gnu.org ([2001:4830:134:3::10]:41016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsQ-0003BV-P1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsL-0002eQ-Pi
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:10 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:55495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnsL-0002aN-Ga
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:05 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D8279FCADA
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:13:56 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:13 +0200
Message-Id: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 00/26] guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with an
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode, the newer POWER9 interrupt model. This
patchset is a first proposal to add XIVE support in the sPAPR machine.

The first patches introduce the XIVE exploitation mode in CAS.

Follow models for the XIVE interrupt controller, source and presenter.
We try to reuse the ICS and ICP models of XICS because the sPAPR
machine is tied to the XICSFabric interface and should be using a
common framework to be able to switch from one controller model to
another. To be discussed of course.

Then comes support for the Hypervisor's call which are used to
configure the interrupt sources and the event/notification queues of
the guest.

Finally, the last patches try to integrate the XIVE interrupt model in
the sPAPR machine and this not without a couple of serious hacks to
have something to test. See 'Caveats' below for more details.

This is a first draft and I expect a lot of rewrite before it reaches
mainline QEMU. Nevertheless, it compiles, boots and can be used for
some testing.

Code is here:

  https://github.com/legoater/qemu/commits/xive
  https://github.com/legoater/linux/commits/xive

Pre-compiled kernel (4.12) and initrd images can be found :

  http://kaod.org/qemu/ppc-xive/
      =20
Caveats :

 - Unnecessary complexity=20

   I started working on XIVE looking at OPAL because I had the
   ambition to provide a common framework for the PowerNV and sPAPR
   machines. This is still the goal but the XIVE support for the
   PowerNV machine will be *much *more complex and we could use
   something simpler for sPAPR probably. This is why there are some
   clumsiness with the IRQ allocator and at the end of the patchset
   with the IPI interrupt source.

 - Switching interrupt model after CAS.=20

   We now need a way to configure the guest with the interrupt model
   negotiated in CAS.

   But, currently, the sPAPR machine make uses of the controller very
   early in the initialization sequence. The interrupt source is used
   to allocate IRQ numbers and populate the device tree and the
   interrupt presenter objects are created along with the CPU.

   One approach would be to support the reset of the ICP and the ICS
   objects of the guest. We could be use a bitmap to allocate the IRQ
   numbers needed to populate the device tree and then instantiate the
   correct ICS with the bitmap as a parameter. The ICPs could be
   allocated later in the boot process. May be on demand, when a CPU
   is first notified.

 - Migration not addressed

 - Hotplug not addressed

 - KVM support

   The guest needs to be run with kernel_irqchip=3Doff on a POWER9
   system.

 - LSI

   lightly tested.
  =20
Thanks,

C.=20

C=C3=A9dric Le Goater (26):
  spapr: introduce the XIVE_EXPLOIT option in CAS
  spapr: populate device tree depending on XIVE_EXPLOIT option
  target/ppc/POWER9: add POWERPC_EXCP_POWER9
  ppc/xive: introduce a skeleton for the XIVE interrupt controller model
  ppc/xive: define XIVE internal tables
  ppc/xive: introduce a XIVE interrupt source model
  ppc/xive: add MMIO handlers to the XIVE interrupt source
  ppc/xive: add flags to the XIVE interrupt source
  ppc/xive: add an overall memory region for the ESBs
  ppc/xive: record interrupt source MMIO address for hcalls
  ppc/xics: introduce a print_info() handler to the ICS and ICP objects
  ppc/xive: add a print_info() handler for the interrupt source
  ppc/xive: introduce a XIVE interrupt presenter model
  ppc/xive: add MMIO handlers to the XIVE interrupt presenter model
  ppc/xive: push EQ data in OS event queues
  ppc/xive: notify CPU when interrupt priority is more privileged
  ppc/xive: add hcalls support
  ppc/xive: add device tree support
  ppc/xive: introduce a helper to map the XIVE memory regions
  ppc/xive: introduce a helper to create XIVE interrupt source objects
  ppc/xive: introduce routines to allocate IRQ numbers
  ppc/xive: create an XIVE interrupt source to handle IPIs
  spapr: add a XIVE object to the sPAPR machine
  spapr: include the XIVE interrupt source for IPIs
  spapr: print the XIVE interrupt source for IPIs in the monitor
  spapr: force XIVE exploitation mode for POWER9 (HACK)

 default-configs/ppc64-softmmu.mak |    2 +
 hw/intc/Makefile.objs             |    2 +
 hw/intc/xics.c                    |   36 +-
 hw/intc/xive-internal.h           |  218 ++++++++
 hw/intc/xive.c                    | 1024 +++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive_spapr.c              |  796 ++++++++++++++++++++++++++++
 hw/ppc/spapr.c                    |  141 ++++-
 include/hw/ppc/spapr.h            |   17 +-
 include/hw/ppc/spapr_ovec.h       |    1 +
 include/hw/ppc/xics.h             |    2 +
 include/hw/ppc/xive.h             |   80 +++
 target/ppc/cpu-qom.h              |    2 +
 target/ppc/excp_helper.c          |    9 +-
 target/ppc/translate.c            |    3 +-
 target/ppc/translate_init.c       |    2 +-
 15 files changed, 2306 insertions(+), 29 deletions(-)
 create mode 100644 hw/intc/xive-internal.h
 create mode 100644 hw/intc/xive.c
 create mode 100644 hw/intc/xive_spapr.c
 create mode 100644 include/hw/ppc/xive.h

--=20
2.7.5
