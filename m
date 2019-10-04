Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95764C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605792133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FMzM3KUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605792133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKGR-0002w3-0j
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2H-0004sD-Jv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2F-00053u-GB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2F-0004zg-2v; Fri, 04 Oct 2019 05:38:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YG2KKBz9sR7; Fri,  4 Oct 2019 19:37:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181874;
 bh=MbYqP+P9al0i2R1KDwdyAZMKiFjKrDvTMY3tLqcY60U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FMzM3KUCjR/gm2uVjRw4/iNexgvm5RLxOam1uGhb438VXkbnMUQ5YcewCHcV+NXad
 RoghnoCQJQypbYFFH1rPDPxQYMcYHz6ROOhFfa8GOO0AuGxOtp3cU6jX5L7E6ZW+73
 FS5ANk5nLza4i8YIV3g0xZZ/lYlzbdRcYm0daboU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/53] hw/ppc/pnv_occ: add sram device model for occ common area
Date: Fri,  4 Oct 2019 19:37:01 +1000
Message-Id: <20191004093747.31350-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Balamuruhan S <bala24@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Balamuruhan S <bala24@linux.ibm.com>

emulate occ common area region with occ sram device model which
occ and skiboot uses it to communicate regarding sensors, slw
and HWMON in PowerNV emulated host.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
Message-Id: <20190912093056.4516-3-bala24@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             |  8 +++++
 hw/ppc/pnv_occ.c         | 78 ++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_occ.h |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 13126d675e..09d2d7c026 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -953,6 +953,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
(chip),
+                                &chip8->occ.sram_regs);
 }
=20
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
@@ -1141,6 +1145,10 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A(chip),
+                                &chip9->occ.sram_regs);
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 8bead2c930..785653bb67 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -30,6 +30,24 @@
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
=20
+/* OCC sensors */
+#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x580000
+#define OCC_SENSOR_DATA_VALID                 0x580001
+#define OCC_SENSOR_DATA_VERSION               0x580002
+#define OCC_SENSOR_DATA_READING_VERSION       0x580004
+#define OCC_SENSOR_DATA_NR_SENSORS            0x580008
+#define OCC_SENSOR_DATA_NAMES_OFFSET          0x580010
+#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x580014
+#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x58000c
+#define OCC_SENSOR_DATA_NAME_LENGTH           0x58000d
+#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x580023
+#define OCC_SENSOR_LOC_CORE                   0x580022
+#define OCC_SENSOR_LOC_GPU                    0x580020
+#define OCC_SENSOR_TYPE_POWER                 0x580003
+#define OCC_SENSOR_NAME                       0x580005
+#define HWMON_SENSORS_MASK                    0x58001e
+#define SLW_IMAGE_BASE                        0x0
+
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
     bool irq_state;
@@ -82,6 +100,48 @@ static void pnv_occ_power8_xscom_write(void *opaque, =
hwaddr addr,
     }
 }
=20
+static uint64_t pnv_occ_common_area_read(void *opaque, hwaddr addr,
+                                         unsigned width)
+{
+    switch (addr) {
+    /*
+     * occ-sensor sanity check that asserts the sensor
+     * header block
+     */
+    case OCC_SENSOR_DATA_BLOCK_OFFSET:
+    case OCC_SENSOR_DATA_VALID:
+    case OCC_SENSOR_DATA_VERSION:
+    case OCC_SENSOR_DATA_READING_VERSION:
+    case OCC_SENSOR_DATA_NR_SENSORS:
+    case OCC_SENSOR_DATA_NAMES_OFFSET:
+    case OCC_SENSOR_DATA_READING_PING_OFFSET:
+    case OCC_SENSOR_DATA_READING_PONG_OFFSET:
+    case OCC_SENSOR_NAME_STRUCTURE_TYPE:
+        return 1;
+    case OCC_SENSOR_DATA_NAME_LENGTH:
+        return 0x30;
+    case OCC_SENSOR_LOC_CORE:
+        return 0x0040;
+    case OCC_SENSOR_TYPE_POWER:
+        return 0x0080;
+    case OCC_SENSOR_NAME:
+        return 0x1000;
+    case HWMON_SENSORS_MASK:
+    case OCC_SENSOR_LOC_GPU:
+        return 0x8e00;
+    case SLW_IMAGE_BASE:
+        return 0x1000000000000000;
+    }
+    return 0;
+}
+
+static void pnv_occ_common_area_write(void *opaque, hwaddr addr,
+                                             uint64_t val, unsigned widt=
h)
+{
+    /* callback function defined to occ common area write */
+    return;
+}
+
 static const MemoryRegionOps pnv_occ_power8_xscom_ops =3D {
     .read =3D pnv_occ_power8_xscom_read,
     .write =3D pnv_occ_power8_xscom_write,
@@ -92,12 +152,24 @@ static const MemoryRegionOps pnv_occ_power8_xscom_op=
s =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+const MemoryRegionOps pnv_occ_sram_ops =3D {
+    .read =3D pnv_occ_common_area_read,
+    .write =3D pnv_occ_common_area_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
+    poc->sram_size =3D PNV_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
+    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB_IRQ_OCC;
 }
=20
@@ -168,7 +240,9 @@ static void pnv_occ_power9_class_init(ObjectClass *kl=
ass, void *data)
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
+    poc->sram_size =3D PNV9_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
+    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB9_IRQ_OCC;
 }
=20
@@ -199,6 +273,10 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
     /* XScom region for OCC registers */
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
                           occ, "xscom-occ", poc->xscom_size);
+
+    /* XScom region for OCC SRAM registers */
+    pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_ops,
+                          occ, "occ-common-area", poc->sram_size);
 }
=20
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index ed0709bfc0..66b0989be6 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -38,6 +38,7 @@ typedef struct PnvOCC {
     PnvPsi *psi;
=20
     MemoryRegion xscom_regs;
+    MemoryRegion sram_regs;
 } PnvOCC;
=20
 #define PNV_OCC_CLASS(klass) \
@@ -49,7 +50,9 @@ typedef struct PnvOCCClass {
     DeviceClass parent_class;
=20
     int xscom_size;
+    int sram_size;
     const MemoryRegionOps *xscom_ops;
+    const MemoryRegionOps *sram_ops;
     int psi_irq;
 } PnvOCCClass;
=20
--=20
2.21.0


