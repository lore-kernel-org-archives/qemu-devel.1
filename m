Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIF-0001bi-Ig
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TID-0003Sl-Bh
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:01 +1000
Message-Id: <20170424015927.8933-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/47] ppc/pnv: add a PnvICPState object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This provides a new ICPState object for the PowerNV machine (POWER8).
Access to the Interrupt Management area is done though a memory
region. It contains the registers of the Interrupt Control Presenters
of each thread which are used to accept, return, forward interrupts in
the system.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/Makefile.objs |   1 +
 hw/intc/xics_pnv.c    | 192 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/xics.h |  12 ++++
 3 files changed, 205 insertions(+)
 create mode 100644 hw/intc/xics_pnv.c

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index adedd0d..78426a7 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
 obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
+obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
 obj-$(CONFIG_S390_FLIC_KVM) +=3D s390_flic_kvm.o
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
new file mode 100644
index 0000000..12ae605
--- /dev/null
+++ b/hw/intc/xics_pnv.c
@@ -0,0 +1,192 @@
+/*
+ * QEMU PowerPC PowerNV Interrupt Control Presenter (ICP) model
+ *
+ * Copyright (c) 2017, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/ppc/xics.h"
+
+#define ICP_XIRR_POLL    0 /* 1 byte (CPRR) or 4 bytes */
+#define ICP_XIRR         4 /* 1 byte (CPRR) or 4 bytes */
+#define ICP_MFRR        12 /* 1 byte access only */
+
+#define ICP_LINKA       16 /* unused */
+#define ICP_LINKB       20 /* unused */
+#define ICP_LINKC       24 /* unused */
+
+static uint64_t pnv_icp_read(void *opaque, hwaddr addr, unsigned width)
+{
+    ICPState *icp =3D ICP(opaque);
+    PnvICPState *picp =3D PNV_ICP(opaque);
+    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
+    uint64_t val =3D 0xffffffff;
+
+    switch (addr & 0xffc) {
+    case ICP_XIRR_POLL:
+        val =3D icp_ipoll(icp, NULL);
+        if (byte0) {
+            val >>=3D 24;
+        } else if (width !=3D 4) {
+            goto bad_access;
+        }
+        break;
+    case ICP_XIRR:
+        if (byte0) {
+            val =3D icp_ipoll(icp, NULL) >> 24;
+        } else if (width =3D=3D 4) {
+            val =3D icp_accept(icp);
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_MFRR:
+        if (byte0) {
+            val =3D icp->mfrr;
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKA:
+        if (width =3D=3D 4) {
+            val =3D picp->links[0];
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKB:
+        if (width =3D=3D 4) {
+            val =3D picp->links[1];
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKC:
+        if (width =3D=3D 4) {
+            val =3D picp->links[2];
+        } else {
+            goto bad_access;
+        }
+        break;
+    default:
+bad_access:
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
+                      HWADDR_PRIx"/%d\n", addr, width);
+    }
+
+    return val;
+}
+
+static void pnv_icp_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned width)
+{
+    ICPState *icp =3D ICP(opaque);
+    PnvICPState *picp =3D PNV_ICP(opaque);
+    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
+
+    switch (addr & 0xffc) {
+    case ICP_XIRR:
+        if (byte0) {
+            icp_set_cppr(icp, val);
+        } else if (width =3D=3D 4) {
+            icp_eoi(icp, val);
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_MFRR:
+        if (byte0) {
+            icp_set_mfrr(icp, val);
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKA:
+        if (width =3D=3D 4) {
+            picp->links[0] =3D val;
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKB:
+        if (width =3D=3D 4) {
+            picp->links[1] =3D val;
+        } else {
+            goto bad_access;
+        }
+        break;
+    case ICP_LINKC:
+        if (width =3D=3D 4) {
+            picp->links[2] =3D val;
+        } else {
+            goto bad_access;
+        }
+        break;
+    default:
+bad_access:
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
+                      HWADDR_PRIx"/%d\n", addr, width);
+    }
+}
+
+static const MemoryRegionOps pnv_icp_ops =3D {
+    .read =3D pnv_icp_read,
+    .write =3D pnv_icp_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+};
+
+static void pnv_icp_realize(DeviceState *dev, Error **errp)
+{
+    PnvICPState *icp =3D PNV_ICP(dev);
+
+    memory_region_init_io(&icp->mmio, OBJECT(dev), &pnv_icp_ops,
+                          icp, "icp-thread", 0x1000);
+}
+
+static void pnv_icp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ICPStateClass *icpc =3D ICP_CLASS(klass);
+
+    icpc->realize =3D pnv_icp_realize;
+    dc->desc =3D "PowerNV ICP";
+}
+
+static const TypeInfo pnv_icp_info =3D {
+    .name          =3D TYPE_PNV_ICP,
+    .parent        =3D TYPE_ICP,
+    .instance_size =3D sizeof(PnvICPState),
+    .class_init    =3D pnv_icp_class_init,
+    .class_size    =3D sizeof(ICPStateClass),
+};
+
+static void pnv_icp_register_types(void)
+{
+    type_register_static(&pnv_icp_info);
+}
+
+type_init(pnv_icp_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 731e177..c215dc7 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -41,10 +41,12 @@
  */
 typedef struct ICPStateClass ICPStateClass;
 typedef struct ICPState ICPState;
+typedef struct PnvICPState PnvICPState;
 typedef struct ICSStateClass ICSStateClass;
 typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
 typedef struct XICSFabric XICSFabric;
+typedef struct PowerPCCPU PowerPCCPU;
=20
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
@@ -52,6 +54,9 @@ typedef struct XICSFabric XICSFabric;
 #define TYPE_KVM_ICP "icp-kvm"
 #define KVM_ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_KVM_ICP)
=20
+#define TYPE_PNV_ICP "pnv-icp"
+#define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
+
 #define ICP_CLASS(klass) \
      OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP)
 #define ICP_GET_CLASS(obj) \
@@ -81,6 +86,13 @@ struct ICPState {
     XICSFabric *xics;
 };
=20
+struct PnvICPState {
+    ICPState parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t links[3];
+};
+
 #define TYPE_ICS_BASE "ics-base"
 #define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
=20
--=20
2.9.3
