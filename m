Received: from eggs.gnu.org ([209.51.188.92]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZok-00025W-Lw
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZoj-0001zj-LX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:06 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:45472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZoi-0001qE-DK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:04 -0500
Received: from player687.ha.ovh.net (unknown [10.109.159.90])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 574E51EF4A8
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:40:00 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:33 +0100
Message-Id: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] spapr: add KVM support to the XIVE
 interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Following the 'dual' IRQ backend, this series adds KVM support to the
XIVE interrupt mode.

The first patches introduce the XIVE KVM device, state synchronization
and migration support under KVM. The second part of the patchset
modifies the XICS and XIVE interrupt models to add KVM support to the
'dual' IRQ backend.

This is a first round to check that the interfaces with Linux/KVM are
well in place.=20

GitHub trees available here :
=20
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-next
 =20
Linux/KVM:

  https://github.com/legoater/linux/commits/xive-5.0

OPAL:

  https://github.com/legoater/skiboot/commits/xive

Thanks,

C.

C=C3=A9dric Le Goater (13):
  linux-headers: update to 5.0
  spapr/xive: add KVM support
  spapr/xive: add state synchronization with KVM
  spapr/xive: introduce a VM state change handler
  spapr/xive: add migration support for KVM
  spapr/xive: fix migration of the XiveTCTX under TCG
  ppc/xics: introduce a icp_kvm_connect() routine
  spapr/rtas: modify spapr_rtas_register() to remove RTAS handlers
  sysbus: add a sysbus_mmio_unmap() helper
  spapr: introduce routines to delete the KVM IRQ device
  spapr: check for the activation of the KVM IRQ device
  spapr/xics: ignore the lower 4K in the IRQ number space
  spapr: add KVM support to the 'dual' machine

 default-configs/ppc64-softmmu.mak |   1 +
 include/hw/ppc/spapr.h            |   4 +
 include/hw/ppc/spapr_xive.h       |  26 +
 include/hw/ppc/xics.h             |   1 +
 include/hw/ppc/xive.h             |  24 +
 include/hw/sysbus.h               |   1 +
 linux-headers/asm-powerpc/kvm.h   |  46 ++
 linux-headers/linux/kvm.h         |   9 +
 target/ppc/kvm_ppc.h              |   6 +
 hw/core/sysbus.c                  |  10 +
 hw/intc/spapr_xive.c              |  83 ++-
 hw/intc/spapr_xive_kvm.c          | 886 ++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c                | 154 +++++-
 hw/intc/xive.c                    |  45 +-
 hw/ppc/spapr_irq.c                | 114 +++-
 hw/ppc/spapr_rtas.c               |   2 +-
 target/ppc/kvm.c                  |   7 +
 hw/intc/Makefile.objs             |   1 +
 18 files changed, 1363 insertions(+), 57 deletions(-)
 create mode 100644 hw/intc/spapr_xive_kvm.c

--=20
2.20.1
