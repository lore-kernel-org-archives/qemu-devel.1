Received: from eggs.gnu.org ([2001:4830:134:3::10]:41562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntU-00047r-I8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntQ-0003Ek-Hd
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:16 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:42470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntQ-0003EG-Ag
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:12 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 411CCFCC3E
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:25 +0200
Message-Id: <1499274819-15607-13-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 12/26] ppc/xive: add a print_info() handler
 for the interrupt source
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

This is much like the default one but we expose the PQ bits also.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0db97fd33981..db808e0cbe3d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -290,6 +290,25 @@ static void xive_ics_set_irq(void *opaque, int srcno=
, int val)
     }
 }
=20
+static void xive_ics_print_info(ICSState *ics, Monitor *mon)
+{
+    XiveICSState *xs =3D ICS_XIVE(ics);
+    int i;
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        ICSIRQState *irq =3D ics->irqs + i;
+
+        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
+            continue;
+        }
+        monitor_printf(mon, "  %4x %s pq=3D%02x status=3D%02x\n",
+                       ics->offset + i,
+                       (irq->flags & XICS_FLAGS_IRQ_LSI) ? "LSI" : "MSI"=
,
+                       xive_pq_get(xs->xive, ics->offset + i),
+                       irq->status);
+    }
+}
+
 static void xive_ics_reset(void *dev)
 {
     ICSState *ics =3D ICS_BASE(dev);
@@ -364,6 +383,7 @@ static void xive_ics_class_init(ObjectClass *klass, v=
oid *data)
     ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
=20
     isc->realize =3D xive_ics_realize;
+    isc->print_info =3D xive_ics_print_info;
=20
     dc->props =3D xive_ics_properties;
 }
--=20
2.7.5
