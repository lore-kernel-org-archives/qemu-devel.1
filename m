Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuO-0004uy-8u
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuK-0004Dk-8H
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:12 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:50555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuK-0004DM-1v
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:08 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id C76E8FCDC3
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:06 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:34 +0200
Message-Id: <1499274819-15607-22-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 21/26] ppc/xive: introduce routines to
 allocate IRQ numbers
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

The IRQ number allocator is inspired by OPAL which allocates IPI IRQ
numbers from the bottom of the IRQ number space and allocates the HW
IRQ numbers from the top.

So, this might be slightly overkill for our need. Needs to be
discussed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/xive.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index bec123649ebd..42eefbe7fd65 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -748,6 +748,59 @@ void xive_ics_create(XiveICSState *xs, XIVE *x, uint=
32_t offset,
 }
=20
 /*
+ * IRQ number allocators
+ */
+uint32_t xive_alloc_hw_irqs(XIVE *x, uint32_t count, uint32_t align)
+{
+    uint32_t base;
+    int i;
+
+    base =3D x->int_hw_bot - count;
+    base &=3D ~(align - 1);
+    if (base < x->int_ipi_top) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: HW alloc request for %d interrupts "
+                      "aligned to %d failed\n",
+                      count, align);
+        return -1;
+    }
+
+    x->int_hw_bot =3D base;
+
+    for (i =3D 0; i < count; i++) {
+        XiveIVE *ive =3D xive_get_ive(x, base + i);
+
+        ive->w =3D IVE_VALID | IVE_MASKED;
+    }
+    return base;
+}
+
+static uint32_t xive_alloc_ipi_irqs(XIVE *x, uint32_t count, uint32_t al=
ign)
+{
+    uint32_t base;
+    int i;
+
+    base =3D x->int_ipi_top + (align - 1);
+    base &=3D ~(align - 1);
+    if (base >=3D x->int_hw_bot) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IPI alloc request for %d interrupts aligned to %d=
 "
+                      "failed\n",
+                      count, align);
+                return -1;
+    }
+
+    x->int_ipi_top =3D base + count;
+
+    for (i =3D 0; i < count; i++) {
+        XiveIVE *ive =3D xive_get_ive(x, base + i);
+
+        ive->w =3D IVE_VALID | IVE_MASKED;
+    }
+    return base;
+}
+
+/*
  * Main XIVE object
  */
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a1c7797658ba..3c1cd96ea4d0 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -69,6 +69,7 @@ void xive_spapr_init(sPAPRMachineState *spapr);
 void xive_spapr_populate(XIVE *x, void *fdt);
=20
 void xive_mmio_map(XIVE *x);
+uint32_t xive_alloc_hw_irqs(XIVE *x, uint32_t count, uint32_t align);
=20
 void xive_ics_create(XiveICSState *xs, XIVE *x, uint32_t offset,
                      uint32_t nr_irqs, uint32_t shift, uint32_t flags,
--=20
2.7.5
