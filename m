Received: from eggs.gnu.org ([2001:4830:134:3::10]:58700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3i-0002eg-PO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3h-0001na-Ko
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:40 +1000
Message-Id: <20180612064503.14282-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/33] spapr/vio: deprecate the "irq" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

VIO devices have an "irq" property that can be used by the sPAPR IRQ
allocator as an IRQ number hint. But it is not set in QEMU nor in
libvirt. It brings unnecessary complexity to the underlying layers
managing the IRQ number space and it is in full opposition with the
new static IRQ allocator we want to introduce in sPAPR.

Let's deprecate it to simplify the spapr_irq_alloc routine in the
future.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Check qtest_enabled() to suppress bogus warnings from make check]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c | 22 +++++++++++++++++++++-
 qemu-doc.texi      | 12 ++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 472dd6f33a..4555c648a8 100644
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
@@ -32,6 +33,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/device_tree.h"
 #include "kvm_ppc.h"
+#include "sysemu/qtest.h"
=20
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -41,8 +43,26 @@
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
+    if (!qtest_enabled()) {
+        warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated"=
, name);
+    }
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
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 9aff6b4ea9..cd05760cac 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2958,13 +2958,21 @@ support page sizes < 4096 any longer.
=20
 @section System emulator machines
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
--=20
2.17.1
