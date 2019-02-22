Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApG-0000qd-Ki
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAee-0004j6-4w
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49582
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAec-0003t6-IX
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:15 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDBBWo105014
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:36 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtgca4gy2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:36 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:34 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:12 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-4-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/13] spapr/xive: activate KVM support
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

All is in place for KVM now. State synchronization and migration will
come next.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 6e1c36dc62ca..1ad57582a403 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -263,19 +263,10 @@ sPAPRIrq spapr_irq_xics =3D {
 static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
-    MachineState *machine =3D MACHINE(spapr);
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
     DeviceState *dev;
     int i;
=20
-    /* KVM XIVE device not yet available */
-    if (kvm_enabled()) {
-        if (machine_kernel_irqchip_required(machine)) {
-            error_setg(errp, "kernel_irqchip requested. no KVM XIVE supp=
ort");
-            return;
-        }
-    }
-
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
     qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
     /*
--=20
2.20.1
