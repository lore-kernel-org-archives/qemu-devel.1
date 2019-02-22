Received: from eggs.gnu.org ([209.51.188.92]:40818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApN-0000tn-2f
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeV-0004PV-6z
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeU-00042T-Dv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDBBxV141240
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtgndkr28-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:46 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:33 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/13] spapr: add KVM support to the XIVE
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This is the v2 of the QEMU/KVM patchset taking into account the
remarks on the interface with Linux/KVM.

The first patches introduce the XIVE KVM device, state synchronization
and migration support under KVM. The second part of the patchset
modifies the XICS and XIVE interrupt models to add KVM support to the
'dual' IRQ backend.

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

Change since v1:

 - Reworked most of the KVM interface
 - Reworked *All* hcalls which are now handled at the QEMU level,
   possibly extended with a KVM device ioctl when required.
 - TIMA and ESB special mapping done on the KVM device fd.
 - Tested on nested
 - Implemented the device fallback mode when a kernel_irqchip is not
   available and not required. Useful on nested to use XIVE.=20
 - Fix device hotplug when VM is stopped (Is this necessary ?)

C=C3=A9dric Le Goater (13):
  spapr/xive: add KVM support
  spapr/xive: add hcall support when under KVM
  spapr/xive: activate KVM support
  spapr/xive: add state synchronization with KVM
  spapr/xive: introduce a VM state change handler
  spapr/xive: add migration support for KVM
  spapr/xive: fix migration of the XiveTCTX under TCG
  spapr/rtas: modify spapr_rtas_register() to remove RTAS handlers
  sysbus: add a sysbus_mmio_unmap() helper
  spapr: introduce routines to delete the KVM IRQ device
  spapr: check for the activation of the KVM IRQ device
  spapr: add KVM support to the 'dual' machine
  spapr/xive: fix device hotplug when VM is stopped

 default-configs/ppc64-softmmu.mak |   1 +
 include/hw/ppc/spapr.h            |   4 +
 include/hw/ppc/spapr_xive.h       |  39 ++
 include/hw/ppc/xics_spapr.h       |   1 +
 include/hw/ppc/xive.h             |  15 +
 include/hw/sysbus.h               |   1 +
 target/ppc/kvm_ppc.h              |   6 +
 hw/core/sysbus.c                  |  10 +
 hw/intc/spapr_xive.c              | 193 ++++++-
 hw/intc/spapr_xive_kvm.c          | 807 ++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c                | 108 +++-
 hw/intc/xive.c                    |  44 +-
 hw/ppc/spapr_irq.c                | 136 +++--
 hw/ppc/spapr_rtas.c               |   2 +-
 target/ppc/kvm.c                  |   7 +
 hw/intc/Makefile.objs             |   1 +
 16 files changed, 1315 insertions(+), 60 deletions(-)
 create mode 100644 hw/intc/spapr_xive_kvm.c

--=20
2.20.1
