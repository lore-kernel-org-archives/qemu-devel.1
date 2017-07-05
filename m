Received: from eggs.gnu.org ([2001:4830:134:3::10]:41130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsh-0003Mb-N5
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsd-0002lM-G1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:27 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnsd-0002kd-6X
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:23 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D290AFCBEC
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:21 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:17 +0200
Message-Id: <1499274819-15607-5-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton for
 the XIVE interrupt controller model
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

Let's provide an empty shell for the XIVE controller model with a
couple of attributes for the IRQ number allocator. The latter is
largely inspired by OPAL which allocates IPI IRQ numbers from the
bottom of the IRQ number space and allocates the HW IRQ numbers from
the top.

The number of IPIs is simply deduced from the max number of CPUs the
guest supports and we provision a arbitrary number of HW irqs.

The XIVE object is kept private because it will hold internal tables
which do not need to be exposed to sPAPR.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |  1 +
 hw/intc/Makefile.objs             |  1 +
 hw/intc/xive-internal.h           | 28 ++++++++++++
 hw/intc/xive.c                    | 94 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/xive.h             | 27 +++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 hw/intc/xive-internal.h
 create mode 100644 hw/intc/xive.c
 create mode 100644 include/hw/ppc/xive.h

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 46c95993217d..1179c07e6e9f 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
 CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
+CONFIG_XIVE=3D$(CONFIG_PSERIES)
 # For PReP
 CONFIG_SERIAL_ISA=3Dy
 CONFIG_MC146818RTC=3Dy
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 78426a7dafcd..28b83456bfcc 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
 obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
+obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
new file mode 100644
index 000000000000..155c2dcd6066
--- /dev/null
+++ b/hw/intc/xive-internal.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2016,2017 IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _INTC_XIVE_INTERNAL_H
+#define _INTC_XIVE_INTERNAL_H
+
+#include <hw/sysbus.h>
+
+struct XIVE {
+    SysBusDevice parent;
+
+    /* Properties */
+    uint32_t     nr_targets;
+
+    /* IRQ number allocator */
+    uint32_t     int_count;     /* Number of interrupts: nr_targets + HW=
 IRQs */
+    uint32_t     int_base;      /* Min index */
+    uint32_t     int_max;       /* Max index */
+    uint32_t     int_hw_bot;    /* Bottom index of HW IRQ allocator */
+    uint32_t     int_ipi_top;   /* Highest IPI index handed out so far +=
 1 */
+};
+
+#endif /* _INTC_XIVE_INTERNAL_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
new file mode 100644
index 000000000000..5b4ea915d87c
--- /dev/null
+++ b/hw/intc/xive.c
@@ -0,0 +1,94 @@
+/*
+ * QEMU PowerPC XIVE model
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
+#include "hw/ppc/xive.h"
+
+#include "xive-internal.h"
+
+/*
+ * Main XIVE object
+ */
+
+/* Let's provision some HW IRQ numbers. We could use a XIVE property
+ * also but it does not seem necessary for the moment.
+ */
+#define MAX_HW_IRQS_ENTRIES (8 * 1024)
+
+static void xive_init(Object *obj)
+{
+    ;
+}
+
+static void xive_realize(DeviceState *dev, Error **errp)
+{
+    XIVE *x =3D XIVE(dev);
+
+    if (!x->nr_targets) {
+        error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
+        return;
+    }
+
+    /* Initialize IRQ number allocator. Let's use a base number if we
+     * need to introduce a notion of blocks one day.
+     */
+    x->int_base =3D 0;
+    x->int_count =3D x->nr_targets + MAX_HW_IRQS_ENTRIES;
+    x->int_max =3D x->int_base + x->int_count;
+    x->int_hw_bot =3D x->int_max;
+    x->int_ipi_top =3D x->int_base;
+
+    /* Reserve some numbers as OPAL does ? */
+    if (x->int_ipi_top < 0x10) {
+        x->int_ipi_top =3D 0x10;
+    }
+}
+
+static Property xive_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-targets", XIVE, nr_targets, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D xive_realize;
+    dc->props =3D xive_properties;
+    dc->desc =3D "XIVE";
+}
+
+static const TypeInfo xive_info =3D {
+    .name =3D TYPE_XIVE,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_init =3D xive_init,
+    .instance_size =3D sizeof(XIVE),
+    .class_init =3D xive_class_init,
+};
+
+static void xive_register_types(void)
+{
+    type_register_static(&xive_info);
+}
+
+type_init(xive_register_types)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
new file mode 100644
index 000000000000..863f5a9c6b5f
--- /dev/null
+++ b/include/hw/ppc/xive.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU PowerPC XIVE model
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
+#ifndef PPC_XIVE_H
+#define PPC_XIVE_H
+
+typedef struct XIVE XIVE;
+
+#define TYPE_XIVE "xive"
+#define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
+
+#endif /* PPC_XIVE_H */
--=20
2.7.5
