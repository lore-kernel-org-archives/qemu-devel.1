Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHX-00016I-Gz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHT-0004EK-0B
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:59 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHS-0004DT-Pf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:54 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B5090AB1DC
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:23 +0200
Message-Id: <20170911171235.29331-10-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 09/21] ppc/xive: extend the interrupt
 presenter model for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE interrupt presenter exposes a set of Thread Interrupt
Management Areas, also called rings, one per different level of
privilege (four in all). This area is used to handle priority
management and interrupt acknowledgment among other things.

We extend the ICPState object with a cache of the register data for
XIVE. The integration with the sPAPR machine is much easier and we
need a common framework to switch from one controller model to
another: XICS <-> XIVE.

The next patch will introduce the MMIO handlers to interact with the
TIMA, OS only, which is required for the sPAPR support.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 4 ++++
 include/hw/ppc/xics.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a84ba51ad8ff..927d4fec966a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -274,6 +274,7 @@ static const VMStateDescription vmstate_icp_server =3D=
 {
         VMSTATE_UINT32(xirr, ICPState),
         VMSTATE_UINT8(pending_priority, ICPState),
         VMSTATE_UINT8(mfrr, ICPState),
+        VMSTATE_UINT8_ARRAY(tima, ICPState, 0x40),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -293,6 +294,7 @@ static void icp_reset(void *dev)
     if (icpc->reset) {
         icpc->reset(icp);
     }
+    memset(icp->tima, 0, sizeof(icp->tima));
 }
=20
 static void icp_realize(DeviceState *dev, Error **errp)
@@ -343,6 +345,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
         icpc->realize(icp, errp);
     }
=20
+    icp->tima_os =3D &icp->tima[0x10];
+
     qemu_register_reset(icp_reset, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp)=
;
 }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 28d248abad61..c835997303c4 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -83,6 +83,12 @@ struct ICPState {
     qemu_irq output;
=20
     XICSFabric *xics;
+
+    /* XIVE section */
+#define XIVE_TM_RING_COUNT 4
+
+    uint8_t tima[XIVE_TM_RING_COUNT * 0x10];
+    uint8_t *tima_os;
 };
=20
 #define ICP_PROP_XICS "xics"
--=20
2.13.5
