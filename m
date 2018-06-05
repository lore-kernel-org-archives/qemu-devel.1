Received: from eggs.gnu.org ([2001:4830:134:3::10]:51946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQ5tc-0005AF-JU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQ5tZ-0002dP-Gb
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:56:44 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:34539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQ5tZ-0002cf-A4
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:56:41 -0400
Received: from player746.ha.ovh.net (unknown [10.109.105.10])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A495217E8DE
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 08:56:39 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue,  5 Jun 2018 08:56:26 +0200
Message-Id: <20180605065626.4304-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr/vio: deprecate the "irq" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

VIO devices have an "irq" property that can be used by the sPAPR IRQ
allocator as an IRQ number hint. But it is not set in QEMU nor in
libvirt. It brings unnecessary complexity to the underlying layers
managing the IRQ number space and it is in full opposition with the
new static IRQ allocator we want to introduce in sPAPR.

Let's deprecate it to simplify the spapr_irq_alloc routine in the
future.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 qemu-doc.texi      | 12 ++++++++++--
 hw/ppc/spapr_vio.c | 19 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index f00706b9996c..fd25ddf7a06a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2970,13 +2970,21 @@ support page sizes < 4096 any longer.
 The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' mach=
ine.
 The ``xlnx-zcu102'' machine has the same features and capabilites in QEM=
U.
=20
-@section Block device options
+@section Device options
=20
-@subsection "backing": "" (since 2.12.0)
+@subsection Block device options
+
+@subsubsection "backing": "" (since 2.12.0)
=20
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
=20
+@subsection vio-spapr-device device options
+
+@subsubsection "irq": "" (since 3.0.0)
+
+The ``irq'' property is obsoleted.
+
 @node Supported build platforms
 @appendix Supported build platforms
=20
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 472dd6f33a96..28bb3b849b9b 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
@@ -41,8 +42,24 @@
=20
 #include <libfdt.h>
=20
+static void spapr_vio_getset_irq(Object *obj, Visitor *v, const char *na=
me,
+                              void *opaque, Error **errp)
+{
+    Property *prop =3D opaque;
+    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
+
+    warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated", na=
me);
+    visit_type_uint32(v, name, ptr, errp);
+}
+
+static const PropertyInfo spapr_vio_irq_propinfo =3D {
+    .name =3D "irq",
+    .get =3D spapr_vio_getset_irq,
+    .set =3D spapr_vio_getset_irq,
+};
+
 static Property spapr_vio_props[] =3D {
-    DEFINE_PROP_UINT32("irq", VIOsPAPRDevice, irq, 0), \
+    DEFINE_PROP("irq", VIOsPAPRDevice, irq, spapr_vio_irq_propinfo, uint=
32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.13.6
