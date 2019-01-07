Received: from eggs.gnu.org ([209.51.188.92]:43650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpO-0002mB-V2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpN-0002v0-PL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:46 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:35273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZpN-0002sW-IK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:45 -0500
Received: from player687.ha.ovh.net (unknown [10.109.160.54])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1CCC71087A4
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:40:44 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:39 +0100
Message-Id: <20190107183946.7230-7-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] spapr/xive: fix migration of the
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
index 233c97c5ecd9..ba27d9d8e972 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -363,7 +363,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMach=
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
+        spapr_xive_set_tctx_os_cam(cpu->tctx);
+    }
+    return 0;
 }
=20
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
--=20
2.20.1
