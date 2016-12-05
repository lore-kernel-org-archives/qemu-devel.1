Received: from eggs.gnu.org ([2001:4830:134:3::10]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16W-0006Uv-NX
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16V-0002Br-Il
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:20 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:34 +0100
Message-Id: <1480974406-29345-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 03/15] arm/arm64: ITS skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

At the moment we just detect the presence of ITS as part of the
GICv3 init routine and initialize its base address.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/Makefile.common        |  1 +
 lib/arm/asm/gic-v3-its.h   | 22 ++++++++++++++++++++++
 lib/arm/asm/gic.h          |  1 +
 lib/arm/gic-v3-its.c       |  9 +++++++++
 lib/arm/gic.c              | 30 +++++++++++++++++++++++++-----
 lib/arm64/asm/gic-v3-its.h |  1 +
 6 files changed, 59 insertions(+), 5 deletions(-)
 create mode 100644 lib/arm/asm/gic-v3-its.h
 create mode 100644 lib/arm/gic-v3-its.c
 create mode 100644 lib/arm64/asm/gic-v3-its.h

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 6c0898f..070f349 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -47,6 +47,7 @@ cflatobjs += lib/arm/bitops.o
 cflatobjs += lib/arm/psci.o
 cflatobjs += lib/arm/smp.o
 cflatobjs += lib/arm/gic.o lib/arm/gic-v2.o lib/arm/gic-v3.o
+cflatobjs += lib/arm/gic-v3-its.o
 
 libeabi = lib/arm/libeabi.a
 eabiobjs = lib/arm/eabi_compat.o
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
new file mode 100644
index 0000000..2044565
--- /dev/null
+++ b/lib/arm/asm/gic-v3-its.h
@@ -0,0 +1,22 @@
+/*
+ * All ITS* defines are lifted from include/linux/irqchip/arm-gic-v3.h
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#ifndef _ASMARM_GIC_V3_ITS_H_
+#define _ASMARM_GIC_V3_ITS_H_
+
+#ifndef __ASSEMBLY__
+
+struct its_data {
+	void *base;
+};
+
+extern struct its_data its_data;
+
+#define gicv3_its_base()		(its_data.base)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASMARM_GIC_V3_ITS_H_ */
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index ea5fde9..73d4502 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -30,6 +30,7 @@
 
 #include <asm/gic-v2.h>
 #include <asm/gic-v3.h>
+#include <asm/gic-v3-its.h>
 
 #ifndef __ASSEMBLY__
 #include <asm/cpumask.h>
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
new file mode 100644
index 0000000..e382b80
--- /dev/null
+++ b/lib/arm/gic-v3-its.c
@@ -0,0 +1,9 @@
+/*
+ * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <asm/gic.h>
+
+struct its_data its_data;
+
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 957a146..e551abd 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -6,6 +6,7 @@
 #include <devicetree.h>
 #include <asm/gic.h>
 #include <asm/io.h>
+#include <asm/gic-v3-its.h>
 
 struct gic_common_ops *gic_common_ops;
 
@@ -17,12 +18,14 @@ struct gicv3_data gicv3_data;
  * Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
  */
 static bool
-gic_get_dt_bases(const char *compatible, void **base1, void **base2)
+gic_get_dt_bases(const char *compatible, void **base1, void **base2,
+		 void **base3)
 {
 	struct dt_pbus_reg reg;
-	struct dt_device gic;
+	struct dt_device gic, its;
 	struct dt_bus bus;
-	int node, ret;
+	int node, subnode, ret, len;
+	const void *fdt = dt_fdt();
 
 	dt_bus_init_defaults(&bus);
 	dt_device_init(&gic, &bus, NULL);
@@ -43,19 +46,36 @@ gic_get_dt_bases(const char *compatible, void **base1, void **base2)
 	assert(ret == 0);
 	*base2 = ioremap(reg.addr, reg.size);
 
+	if (base3 && !strcmp(compatible, "arm,gic-v3")) {
+		dt_for_each_subnode(node, subnode) {
+			const struct fdt_property *prop;
+
+			prop = fdt_get_property(fdt, subnode,
+						"compatible", &len);
+			if (!strcmp((char *)prop->data, "arm,gic-v3-its")) {
+				dt_device_bind_node(&its, subnode);
+				ret = dt_pbus_translate(&its, 0, &reg);
+				assert(ret == 0);
+				*base3 = ioremap(reg.addr, reg.size);
+				break;
+			}
+		}
+
+	}
+
 	return true;
 }
 
 int gicv2_init(void)
 {
 	return gic_get_dt_bases("arm,cortex-a15-gic",
-			&gicv2_data.dist_base, &gicv2_data.cpu_base);
+			&gicv2_data.dist_base, &gicv2_data.cpu_base, NULL);
 }
 
 int gicv3_init(void)
 {
 	return gic_get_dt_bases("arm,gic-v3", &gicv3_data.dist_base,
-			&gicv3_data.redist_base[0]);
+			&gicv3_data.redist_base[0], &its_data.base);
 }
 
 int gic_init(void)
diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
new file mode 100644
index 0000000..083cba4
--- /dev/null
+++ b/lib/arm64/asm/gic-v3-its.h
@@ -0,0 +1 @@
+#include "../../arm/asm/gic-v3-its.h"
-- 
2.5.5
