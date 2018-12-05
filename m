Received: from eggs.gnu.org ([2001:4830:134:3::10]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYB-0007wu-TM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY7-0004GC-5K
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:51 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:49320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY6-0004B1-KM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:46 -0500
Received: from player714.ha.ovh.net (unknown [10.109.146.82])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0EA69105853
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:35 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:42 +0100
Message-Id: <20181205232251.10446-29-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 28/37] spapr/xive: fix migration of the
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When the thread interrupt management state is retrieved from the KVM
VCPU, word2 is saved under the QEMU XIVE thread context to print out
the OS CAM line under the QEMU monitor.

This breaks the migration on a TCG guest (or on KVM with
kernel_irqchip=3Doff) because the matching algorithm of the presenter
relies on the OS CAM value. Fix with an extra reset of the thread
contexts to restore the expected value.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 7b401dc1d47c..951d4ff1350a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -326,7 +326,25 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
 {
-    return spapr_xive_post_load(spapr->xive, version_id);
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
+    spapr_xive_reset_tctx(spapr->xive);
+    return 0;
 }
=20
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
--=20
2.17.2
