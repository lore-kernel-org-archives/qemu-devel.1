Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuB-0004kt-SS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnu7-00045w-SS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:59 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:33889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnu7-00044q-LE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:55 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 74150FCD3B
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:32 +0200
Message-Id: <1499274819-15607-20-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 19/26] ppc/xive: introduce a helper to map
 the XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will be used when the guest chooses the XIVE exploitation mode in
CAS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 11 +++++++++++
 include/hw/ppc/xive.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index cda1fa18e44d..895dd2b2f61b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -915,3 +915,14 @@ bool xive_eq_for_target(XIVE *x, uint32_t target, ui=
nt8_t priority,
=20
     return true;
 }
+
+void xive_mmio_map(XIVE *x)
+{
+    /* ESBs */
+    sysbus_mmio_map(SYS_BUS_DEVICE(x), 0, x->vc_base);
+
+    /* Thread Management Interrupt Areas */
+    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
+     * region needs some rework in the handlers */
+    sysbus_mmio_map(SYS_BUS_DEVICE(x), 1, x->tm_base + (1 << x->tm_shift=
));
+}
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 288116aeb8f4..560f6ab66f73 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -68,4 +68,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void xive_spapr_init(sPAPRMachineState *spapr);
 void xive_spapr_populate(XIVE *x, void *fdt);
=20
+void xive_mmio_map(XIVE *x);
+
 #endif /* PPC_XIVE_H */
--=20
2.7.5
