Received: from eggs.gnu.org ([2001:4830:134:3::10]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbm-0001dU-4T
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbg-0001wN-5b
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:02 -0500
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:59483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrbf-0001uT-W4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:56 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id F27F2175ADC
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:31:54 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:41 +0100
Message-Id: <20171123132955.1261-12-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE interrupt sources can have different characteristics depending
on their nature and the HW level in use. The sPAPR specs provide a set of
flags to describe them :

 - XIVE_SRC_H_INT_ESB  the Event State Buffers are controlled with a
                       specific hcall H_INT_ESB and not with MMIO
 - XIVE_SRC_LSI        LSI or MSI source (ICSIRQState level)
 - XIVE_SRC_TRIGGER    the full function page supports trigger
 - XIVE_SRC_STORE_EOI  EOI can be done with a store.

Our QEMU emulation of XIVE for the sPAPR machine gathers all sources unde=
r
a same model and provides a common source with the XIVE_SRC_TRIGGER type.
So, the above list is mostly informative apart from the XIVE_SRC_LSI flag
which will be deduced from the XIVE_STATUS_LSI flag.

The OS retrieves this information on the source with the
H_INT_GET_SOURCE_INFO hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 4 ++++
 include/hw/ppc/spapr_xive.h | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index f45f50fd017e..b1e3f8710cff 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -368,6 +368,10 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
     /* Allocate the IVT (Interrupt Virtualization Table) */
     xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
=20
+    /* All sources are emulated under the XIVE object and share the
+     * same characteristic */
+    xive->flags =3D XIVE_SRC_TRIGGER;
+
     /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
     xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
     xive->sbe =3D g_malloc0(xive->sbe_size);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 84c910e62e56..7a308fb4db2b 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -40,6 +40,13 @@ struct sPAPRXive {
 #define XIVE_STATUS_SENT               0x4
     uint8_t      *status;
=20
+    /* Interrupt source flags */
+#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
+#define XIVE_SRC_LSI           (1ull << (63 - 61))
+#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
+#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
+    uint32_t     flags;
+
     /* XIVE internal tables */
     XiveIVE      *ivt;
     uint8_t      *sbe;
--=20
2.13.6
