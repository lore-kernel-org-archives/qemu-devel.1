Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuH-0004rL-T6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuD-0004B9-Tt
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:05 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuD-0004AP-N9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:01 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9C550FCD73
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:33 +0200
Message-Id: <1499274819-15607-21-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 20/26] ppc/xive: introduce a helper to
 create XIVE interrupt source objects
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 21 +++++++++++++++++++++
 include/hw/ppc/xive.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 895dd2b2f61b..bec123649ebd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -726,6 +726,27 @@ static const TypeInfo xive_ics_info =3D {
     .class_init =3D xive_ics_class_init,
 };
=20
+void xive_ics_create(XiveICSState *xs, XIVE *x, uint32_t offset,
+                     uint32_t nr_irqs, uint32_t shift,
+                     uint32_t flags, Error **errp)
+{
+    Error *error =3D NULL;
+
+    object_property_add_const_link(OBJECT(xs), "xive", OBJECT(x),
+                                   &error_fatal);
+    object_property_add_const_link(OBJECT(xs), "xics",
+                                   OBJECT(qdev_get_machine()), &error_fa=
tal);
+    object_property_set_int(OBJECT(xs), shift, "shift", &error_fatal);
+    object_property_set_int(OBJECT(xs), flags, "flags", &error_fatal);
+    object_property_set_int(OBJECT(xs), offset, "irq-base", &error_fatal=
);
+    object_property_set_int(OBJECT(xs), nr_irqs, "nr-irqs", &error_fatal=
);
+    object_property_set_bool(OBJECT(xs), true, "realized", &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+}
+
 /*
  * Main XIVE object
  */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 560f6ab66f73..a1c7797658ba 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -70,4 +70,8 @@ void xive_spapr_populate(XIVE *x, void *fdt);
=20
 void xive_mmio_map(XIVE *x);
=20
+void xive_ics_create(XiveICSState *xs, XIVE *x, uint32_t offset,
+                     uint32_t nr_irqs, uint32_t shift, uint32_t flags,
+                     Error **errp);
+
 #endif /* PPC_XIVE_H */
--=20
2.7.5
