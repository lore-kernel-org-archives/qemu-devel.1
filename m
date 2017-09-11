Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHQ-0000zG-Is
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHL-00048K-Kr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:52 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:38889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHL-00047l-Ez
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:47 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 835E3AB087
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:46 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:22 +0200
Message-Id: <20170911171235.29331-9-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 08/21] ppc/xive: describe the XIVE
 interrupt source flags
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

The XIVE interrupt sources can have different characteristics
depending on their nature and the HW level in use. The PAPR specs
provide a set of flags to describe them : :

 - XIVE_SRC_H_INT_ESB  the Event State Buffers are controlled with a
                       specific hcall H_INT_ESB and not with MMIO
 - XIVE_SRC_LSI        LSI or MSI source (ICSIRQState level)
 - XIVE_SRC_TRIGGER    the full function page supports trigger
 - XIVE_SRC_STORE_EOI  EOI can be done with a store.

Our QEMU emulation of XIVE for the sPAPR machine gathers all sources
under a same model and provides a common source with the
XIVE_SRC_TRIGGER type. So, the above list is mostly informative apart
from the XIVE_SRC_LSI flag which will be deduced from the
XICS_FLAGS_IRQ_LSI flag of the ICSIRQState array when needed.

The OS retrieves this information on the source with the
H_INT_GET_SOURCE_INFO hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 4 ++++
 include/hw/ppc/spapr_xive.h | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 8a85d64efc4c..a1ce993d2afa 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -371,6 +371,10 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
         ics_set_irq_type(xive->ics, i, false);
     }
=20
+    /* All sources are emulated under the XIVE object and share the
+     * same characteristic */
+    xive->flags =3D XIVE_SRC_TRIGGER;
+
     /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
     xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
     xive->sbe =3D g_malloc0(xive->sbe_size);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0f516534d76a..b46e59319236 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -40,6 +40,13 @@ struct sPAPRXive {
     ICSState     *ics;  /* XICS source inherited from the SPAPR machine =
*/
     qemu_irq     *qirqs;
=20
+    /* Interrupt source flags */
+#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
+#define XIVE_SRC_LSI           (1ull << (63 - 61))
+#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
+#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
+    uint32_t     flags;
+
     /* XIVE internal tables */
     uint8_t      *sbe;
     uint32_t     sbe_size;
--=20
2.13.5
