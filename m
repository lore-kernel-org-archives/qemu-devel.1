Received: from eggs.gnu.org ([209.51.188.92]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W2-0005h9-3S
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W0-00044p-SU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3W0-00036O-GJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9i5lw074178
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:04 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9vhk7ayh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:03 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:47:01 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:24 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-19-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/19] ppc/xive: Make XIVE generate the proper
 interrupt types
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It should be generic Hypervisor Virtualization interrupts for HV
directed rings and traditional External Interrupts for the OS directed
ring.

Don't generate anything for the user ring as it isn't actually
supported.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  3 ++-
 hw/intc/xive.c        | 22 +++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2bad8526221b..82e9aef677c5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -316,7 +316,8 @@ typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
     CPUState    *cs;
-    qemu_irq    output;
+    qemu_irq    hv_output;
+    qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
     uint32_t    hw_cam;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 119bb02d345d..14b854181ab7 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -61,13 +61,28 @@ static uint8_t exception_mask(uint8_t ring)
     }
 }
=20
+static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
+{
+        switch (ring) {
+        case TM_QW0_USER:
+                return 0; /* Not supported */
+        case TM_QW1_OS:
+                return tctx->os_output;
+        case TM_QW2_HV_POOL:
+        case TM_QW3_HV_PHYS:
+                return tctx->hv_output;
+        default:
+                return 0;
+        }
+}
+
 static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs =3D &tctx->regs[ring];
     uint8_t nsr =3D regs[TM_NSR];
     uint8_t mask =3D exception_mask(ring);
=20
-    qemu_irq_lower(tctx->output);
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
=20
     if (regs[TM_NSR] & mask) {
         uint8_t cppr =3D regs[TM_PIPR];
@@ -100,7 +115,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t =
ring)
         default:
             g_assert_not_reached();
         }
-        qemu_irq_raise(tctx->output);
+        qemu_irq_raise(xive_tctx_output(tctx, ring));
     }
 }
=20
@@ -554,7 +569,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
-        tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
+        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
+        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
=20
     default:
--=20
2.20.1
