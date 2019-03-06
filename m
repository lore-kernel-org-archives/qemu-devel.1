Received: from eggs.gnu.org ([209.51.188.92]:55086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGo-0006Cx-Rm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGj-0001iJ-UD
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42310
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGg-0001F6-R7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mTlc048846
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r29v7v1w1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:52 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:51 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:15 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-11-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/27] ppc/xive: Make XIVE generate the proper
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
index c4f27742ca09..6b89dc7679f9 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -313,7 +313,8 @@ typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
     CPUState    *cs;
-    qemu_irq    output;
+    qemu_irq    hv_output;
+    qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
 } XiveTCTX;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a0b87001da25..237e7b256dc0 100644
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
@@ -546,7 +561,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
-        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
+        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
+        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
=20
     default:
--=20
2.20.1
