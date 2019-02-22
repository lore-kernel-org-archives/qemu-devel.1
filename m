Received: from eggs.gnu.org ([209.51.188.92]:40595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApP-0000qc-4I
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeU-0004Oq-Vv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58942
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeT-0003zI-OU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDCPO1133585
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:43 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtf438c74-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:41 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:36 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:16 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-8-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/13] spapr/xive: fix migration of the
 XiveTCTX under TCG
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

When the thread interrupt management state is retrieved from the KVM
VCPU, word2 is saved under the QEMU XIVE thread context to print out
the OS CAM line under the QEMU monitor.

This breaks the migration of a TCG guest (and with KVM when
kernel_irqchip=3Doff) because the matching algorithm of the presenter
relies on the OS CAM value. Fix with an extra reset of the thread
contexts to restore the expected value.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 12ecca6264f3..3176098b9f7c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -356,7 +356,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMach=
ineState *spapr,
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
 {
-    return spapr_xive_post_load(spapr->xive, version_id);
+    CPUState *cs;
+    int ret;
+
+    ret =3D spapr_xive_post_load(spapr->xive, version_id);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * When the states are collected from the KVM XIVE device, word2
+     * of the XiveTCTX is set to print out the OS CAM line under the
+     * QEMU monitor.
+     *
+     * This breaks the migration on a TCG guest (or on KVM with
+     * kernel_irqchip=3Doff) because the matching algorithm of the
+     * presenter relies on the OS CAM value. Fix with an extra reset
+     * of the thread contexts to restore the expected value.
+     */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        /* (TCG) Set the OS CAM line of the thread interrupt context. */
+        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
+    }
+    return 0;
 }
=20
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
--=20
2.20.1
