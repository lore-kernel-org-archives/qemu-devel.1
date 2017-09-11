Received: from eggs.gnu.org ([2001:4830:134:3::10]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIg-0002D7-3N
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIc-0004v3-TQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:10 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:37131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSIc-0004uh-N3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:06 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id AAC4CAB2B3
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:15:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:33 +0200
Message-Id: <20170911171235.29331-20-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 19/21] ppc/xive: introduce a helper to
 map the XIVE memory regions
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

It will be used when the guest chooses the XIVE exploitation mode in CAS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 12 ++++++++++++
 include/hw/ppc/spapr_xive.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ad3f03e37401..adcbbc6ec245 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -807,3 +807,15 @@ bool spapr_xive_eq_for_target(sPAPRXive *xive, uint3=
2_t target,
=20
     return true;
 }
+
+void spapr_xive_mmio_map(sPAPRXive *xive)
+{
+    /* ESBs */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
+
+    /* Thread Management Interrupt Areas */
+    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
+     * region needs some rework in the handlers */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1,
+                    xive->tm_base + (1 << xive->tm_shift));
+}
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0a156f2d8591..13cf10f365d8 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -70,5 +70,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle);
+void spapr_xive_mmio_map(sPAPRXive *xive);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.5
