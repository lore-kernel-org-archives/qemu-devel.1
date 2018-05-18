Received: from eggs.gnu.org ([2001:4830:134:3::10]:56651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUV-0004g4-U7
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUS-00083S-R6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:27 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:60437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fJiUS-0007rZ-Kr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:24 -0400
Received: from player774.ha.ovh.net (unknown [10.109.122.15])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 30463C2027
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:44:15 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 18 May 2018 18:44:01 +0200
Message-Id: <20180518164405.11804-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] spapr: generic IRQ frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This proposal moves all the related IRQ routines of the sPAPR machine
behind a class interface to prepare for future changes in the IRQ
controller model. First of which is a reorganization of the IRQ number
space layout and a second, coming later, will be to integrate the
support for the new POWER9 XIVE IRQ controller.

The new interface defines a set of fixed IRQ number ranges, for each
IRQ type, in which devices allocate the IRQ numbers they need
depending on a unique device index. Here is the layout :

   RANGES             DEVICES

   0x0000 - 0x0FFF    Reserved for future use (IPI =3D 2)
   0x1000 - 0x1000    1 EPOW
   0x1001 - 0x1001    1 HOTPLUG
   0x1002 - 0x10FF    unused
   0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
   0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
   0x1284 - 0x13FF    unused
   0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
   0x1800 - 0x1BFF    PCI MSI device 1
   0x1c00 - 0x1FFF    PCI MSI device 2
  =20
   0x2000    ....     not allocated. Need to increase NR_IRQS

Each device model is modified to take the new interface into account
using the IRQ range/type definitions and a device index. A part from
the VIO devices, lacking an id, the changes are relatively simple.

The MSI range is a bit more complex to handle as the IRQS are dynamically
allocated by the guest OS. In consequence, we use a bitmap allocator
under the machine for these.

The XICS IRQ number space is increased to 4K, which gives three MSI
ranges of 1K for the PHBs. The XICS source IRQ numbers still have the
4K offset.

Thanks,

C.

C=C3=A9dric Le Goater (4):
  spapr: remove irq_hint parameter from spapr_irq_alloc()
  sparp_pci: simplify how the PCI LSIs are allocated
  spapr: introduce a generic IRQ frontend to the machine
  spapr: introduce a new IRQ backend using fixed IRQ number ranges

 include/hw/ppc/spapr.h     |  13 +-
 include/hw/ppc/spapr_irq.h |  58 ++++++
 hw/ppc/spapr.c             | 208 +++------------------
 hw/ppc/spapr_events.c      |   8 +-
 hw/ppc/spapr_irq.c         | 451 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_pci.c         |  40 ++--
 hw/ppc/spapr_vio.c         |   5 +-
 hw/ppc/Makefile.objs       |   2 +-
 8 files changed, 571 insertions(+), 214 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.13.6
