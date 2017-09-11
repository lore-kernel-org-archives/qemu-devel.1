Received: from eggs.gnu.org ([2001:4830:134:3::10]:34584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGc-00006f-1S
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGX-0003jA-Rr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:02 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSGX-0003ib-IB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:12:57 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id EDECEA4C3C
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:12:55 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:15 +0200
Message-Id: <20170911171235.29331-2-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a skeleton
 for the sPAPR XIVE interrupt controller
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

Start with a couple of attributes for the XIVE sPAPR controller
model. The number of provisionned IRQ is necessary to size the
different internal XIVE tables, the number of CPUs is also.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |  1 +
 hw/intc/Makefile.objs             |  1 +
 hw/intc/spapr_xive.c              | 76 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr_xive.h       | 37 +++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 include/hw/ppc/spapr_xive.h

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 46c95993217d..8294df31c0f5 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
 CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
+CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
 # For PReP
 CONFIG_SERIAL_ISA=3Dy
 CONFIG_MC146818RTC=3Dy
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 78426a7dafcd..2dae80bdf611 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
 obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
+obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
new file mode 100644
index 000000000000..c83796519586
--- /dev/null
+++ b/hw/intc/spapr_xive.c
@@ -0,0 +1,76 @@
+/*
+ * QEMU PowerPC sPAPR XIVE model
+ *
+ * Copyright (c) 2017, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "target/ppc/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/dma.h"
+#include "monitor/monitor.h"
+#include "hw/ppc/xics.h"
+#include "hw/ppc/spapr_xive.h"
+
+
+/*
+ * Main XIVE object
+ */
+
+static void spapr_xive_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+
+    if (!xive->nr_targets) {
+        error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
+        return;
+    }
+
+    /* We need to be able to allocate at least the IPIs */
+    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
+        error_setg(errp, "Number of interrupts too small");
+        return;
+    }
+}
+
+static Property spapr_xive_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
+    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void spapr_xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D spapr_xive_realize;
+    dc->props =3D spapr_xive_properties;
+    dc->desc =3D "sPAPR XIVE interrupt controller";
+}
+
+static const TypeInfo spapr_xive_info =3D {
+    .name =3D TYPE_SPAPR_XIVE,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(sPAPRXive),
+    .class_init =3D spapr_xive_class_init,
+};
+
+static void spapr_xive_register_types(void)
+{
+    type_register_static(&spapr_xive_info);
+}
+
+type_init(spapr_xive_register_types)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
new file mode 100644
index 000000000000..5b99f7fc2b81
--- /dev/null
+++ b/include/hw/ppc/spapr_xive.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU PowerPC sPAPR XIVE model
+ *
+ * Copyright (c) 2017, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef PPC_SPAPR_XIVE_H
+#define PPC_SPAPR_XIVE_H
+
+#include <hw/sysbus.h>
+
+typedef struct sPAPRXive sPAPRXive;
+
+#define TYPE_SPAPR_XIVE "spapr-xive"
+#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
+
+struct sPAPRXive {
+    SysBusDevice parent;
+
+    /* Properties */
+    uint32_t     nr_targets;
+    uint32_t     nr_irqs;
+};
+
+#endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.5
