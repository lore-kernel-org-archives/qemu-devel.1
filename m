Received: from eggs.gnu.org ([209.51.188.92]:46268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gu1lI-0003Bu-SP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gu1lI-0003Eh-0x
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42522
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gu1lH-0003E9-Py
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DL02TZ058955
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 16:08:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmsv7aphe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 16:08:05 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 13 Feb 2019 21:08:04 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 13 Feb 2019 22:07:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190213210756.27032-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] spapr/irq: remove the XICS offset
 adjustment for the dual machine
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

When using the 'dual' interrupt mode, the source numbers of both sPAPR
IRQ backends are aligned to share a common IRQ number space and to use
a similar mapping of the machine qemu_irq array which is indexed by
the source number.

The XICS IRQ number range initially being [ 0x1000 - 0x2000 ], this
requires to change the XICS ICSState offset to 0 and to provision for
an extra 4K of source numbers and qemu_irqs which will never be used
by the machine when running under the XICS interrupt mode. This is not
an optimal solution.

Moreover, the KVM support for the 'dual' interrupt mode will require
some adjustments. The XICS KVM device considers that the IRQ numbers
start at XICS_IRQ_BASE (0x1000) and we have no way to inform KVM of
the offset change. We will need to ignore the lower 4K numbers when
capturing or restoring the source states from the XICS KVM device.

The first patch allocates an IRQ number space of the expected size for
the XICS sPAPR IRQ backend. The overall IRQ number space size and the
qemu_irq array size is still the one required by the 'dual' sPAPR IRQ
backend, that is, in sync with XIVE. The second patch removes the
ICSState offset adjustment. This last change adds some benefits as it
simplifies greatly the qirq() method of the 'dual' sPAPR IRQ backend.

C.

C=C3=A9dric Le Goater (2):
  spapr/irq: add an 'nr_irq' parameter to initialize the backend.
  spapr/irq: remove the XICS offset adjustment

 include/hw/ppc/spapr_irq.h |  2 +-
 hw/ppc/spapr_irq.c         | 45 ++++++++++----------------------------
 2 files changed, 12 insertions(+), 35 deletions(-)

--=20
2.20.1
