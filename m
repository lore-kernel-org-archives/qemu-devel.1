Received: from eggs.gnu.org ([209.51.188.92]:34197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dD-0007SS-HZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d4-00035W-Tz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cy-000243-6d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MMaOB042909
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r3a1ynth6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:04 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:02 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:43 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-11-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/15] ppc/pnv: extend XSCOM core support
 for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Provide a new class attribute to define XSCOM operations per CPU
family and add a couple of XSCOM addresses controlling the power
management states of the core on POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes in v2 :

 - new class attribute to define XSCOM operations per CPU family

 include/hw/ppc/pnv_core.h |   2 +
 hw/ppc/pnv_core.c         | 100 +++++++++++++++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 6874bb847a01..cbe9ad36f32c 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -42,6 +42,8 @@ typedef struct PnvCore {
=20
 typedef struct PnvCoreClass {
     DeviceClass parent_class;
+
+    const MemoryRegionOps *xscom_ops;
 } PnvCoreClass;
=20
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 38179cdc53dc..171474e0805c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -60,8 +60,8 @@ static void pnv_cpu_reset(void *opaque)
 #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
 #define PNV_XSCOM_EX_DTS_RESULT1     0x50001
=20
-static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
-                                    unsigned int width)
+static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
 {
     uint32_t offset =3D addr >> 3;
     uint64_t val =3D 0;
@@ -82,16 +82,74 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwa=
ddr addr,
     return val;
 }
=20
-static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t val=
,
-                                 unsigned int width)
+static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint6=
4_t val,
+                                        unsigned int width)
 {
     qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_PRIx=
 "\n",
                   addr);
 }
=20
-static const MemoryRegionOps pnv_core_xscom_ops =3D {
-    .read =3D pnv_core_xscom_read,
-    .write =3D pnv_core_xscom_write,
+static const MemoryRegionOps pnv_core_power8_xscom_ops =3D {
+    .read =3D pnv_core_power8_xscom_read,
+    .write =3D pnv_core_power8_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+
+/*
+ * POWER9 core controls
+ */
+#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
+#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
+
+static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
+{
+    uint32_t offset =3D addr >> 3;
+    uint64_t val =3D 0;
+
+    /* The result should be 38 C */
+    switch (offset) {
+    case PNV_XSCOM_EX_DTS_RESULT0:
+        val =3D 0x26f024f023f0000ull;
+        break;
+    case PNV_XSCOM_EX_DTS_RESULT1:
+        val =3D 0x24f000000000000ull;
+        break;
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
+        val =3D 0x0;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_PRI=
x "\n",
+                  addr);
+    }
+
+    return val;
+}
+
+static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint6=
4_t val,
+                                        unsigned int width)
+{
+    uint32_t offset =3D addr >> 3;
+
+    switch (offset) {
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_=
PRIx "\n",
+                      addr);
+    }
+}
+
+static const MemoryRegionOps pnv_core_power9_xscom_ops =3D {
+    .read =3D pnv_core_power9_xscom_read,
+    .write =3D pnv_core_power9_xscom_write,
     .valid.min_access_size =3D 8,
     .valid.max_access_size =3D 8,
     .impl.min_access_size =3D 8,
@@ -138,6 +196,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip=
 *chip, Error **errp)
 static void pnv_core_realize(DeviceState *dev, Error **errp)
 {
     PnvCore *pc =3D PNV_CORE(OBJECT(dev));
+    PnvCoreClass *pcc =3D PNV_CORE_GET_CLASS(pc);
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
     const char *typename =3D pnv_core_cpu_typename(pc);
     Error *local_err =3D NULL;
@@ -180,7 +239,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
-    pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), &pnv_core_xscom_=
ops,
+    pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
                           pc, name, PNV_XSCOM_EX_SIZE);
     return;
=20
@@ -222,6 +281,20 @@ static Property pnv_core_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
+{
+    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
+
+    pcc->xscom_ops =3D &pnv_core_power8_xscom_ops;
+}
+
+static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
+{
+    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
+
+    pcc->xscom_ops =3D &pnv_core_power9_xscom_ops;
+}
+
 static void pnv_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -231,10 +304,11 @@ static void pnv_core_class_init(ObjectClass *oc, vo=
id *data)
     dc->props =3D pnv_core_properties;
 }
=20
-#define DEFINE_PNV_CORE_TYPE(cpu_model)         \
+#define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
     {                                           \
         .parent =3D TYPE_PNV_CORE,                \
         .name =3D PNV_CORE_TYPE_NAME(cpu_model),  \
+        .class_init =3D pnv_core_##family##_class_init, \
     }
=20
 static const TypeInfo pnv_core_infos[] =3D {
@@ -246,10 +320,10 @@ static const TypeInfo pnv_core_infos[] =3D {
         .class_init =3D pnv_core_class_init,
         .abstract       =3D true,
     },
-    DEFINE_PNV_CORE_TYPE("power8e_v2.1"),
-    DEFINE_PNV_CORE_TYPE("power8_v2.0"),
-    DEFINE_PNV_CORE_TYPE("power8nvl_v1.0"),
-    DEFINE_PNV_CORE_TYPE("power9_v2.0"),
+    DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
+    DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
+    DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
+    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.0"),
 };
=20
 DEFINE_TYPES(pnv_core_infos)
--=20
2.20.1
