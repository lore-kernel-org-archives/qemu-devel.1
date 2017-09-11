Received: from eggs.gnu.org ([2001:4830:134:3::10]:34740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGx-0000UK-61
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGs-0003qB-M7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:23 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:40367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSGs-0003pu-FY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:18 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 879B7AACCD
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:18 +0200
Message-Id: <20170911171235.29331-5-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 04/21] ppc/xive: provide a link to the
 sPAPR ICS object under XIVE
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

The sPAPR machine first starts with a XICS interrupt model and
depending on the guest capabilities, the XIVE exploitation mode is
negotiated during CAS. A reset should then be performed to rebuild the
device tree but the same IRQ numbers which were allocated by the
devices prior to reset, when the XICS model was operating, are still
in use.

For this purpose, we need a common IRQ number allocator for both the
interrupt models: XICS legacy or XIVE exploitation. This is what the
ICSIRQState array of the XICS interrupt source is used for. It also
contains the LSI/MSI flag of an interrupt which will we need later on.

So, let's provide a link to the sPAPR ICS object under XIVE to make
use of it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 12 ++++++++++++
 include/hw/ppc/spapr_xive.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 6d98528fae68..1681affb0848 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -56,6 +56,8 @@ void spapr_xive_reset(void *dev)
 static void spapr_xive_realize(DeviceState *dev, Error **errp)
 {
     sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    Object *obj;
+    Error *err =3D NULL;
=20
     if (!xive->nr_targets) {
         error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
@@ -68,6 +70,16 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
+    /* Retrieve SPAPR ICS source to share the IRQ number allocator */
+    obj =3D object_property_get_link(OBJECT(dev), "ics", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'ics' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    xive->ics =3D ICS_BASE(obj);
+
     /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
     xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
     xive->sbe =3D g_malloc0(xive->sbe_size);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index b17dd4f17b0b..29112589b37f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -24,6 +24,7 @@
 typedef struct sPAPRXive sPAPRXive;
 typedef struct XiveIVE XiveIVE;
 typedef struct XiveEQ XiveEQ;
+typedef struct ICSState ICSState;
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
@@ -35,6 +36,9 @@ struct sPAPRXive {
     uint32_t     nr_targets;
     uint32_t     nr_irqs;
=20
+    /* IRQ */
+    ICSState     *ics;  /* XICS source inherited from the SPAPR machine =
*/
+
     /* XIVE internal tables */
     uint8_t      *sbe;
     uint32_t     sbe_size;
--=20
2.13.5
