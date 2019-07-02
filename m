Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7050C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B3721841
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="frpIoVu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B3721841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiC61-00020V-Qz
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByd-0004iT-IX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByc-0002o3-7q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:15 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44041 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByb-0002k0-Ij; Tue, 02 Jul 2019 02:09:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg2sxjz9sPG; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=S50G9zcN5W0terqyxreSlcCaApbINZ0R7OPFquHstlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=frpIoVu9cU8nsU7gcsWmWS4s+f0H5xJPO1pswLvB989eRvUffnQcWsvcUu1oIJrHQ
 tCrA2WtB+MdBReqoalzrIvNslHjgDOc8mnh3jXW5gaDcjJ/qoXllpj0evgXa8v6aDQ
 EGOx5OTrdYvmGwCYC7ntbEoSJHW5/Zr9LQkB2qxg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:12 +1000
Message-Id: <20190702060857.3926-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 04/49] ppc/pnv: fix XSCOM MMIO base address for
 P9 machines with multiple chips
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The PNV_XSCOM_BASE and PNV_XSCOM_SIZE macros are specific to POWER8
and they are used when the device tree is populated and the MMIO
region created, even for POWER9 chips. This is not too much of a
problem today because we don't have important devices on the second
chip, but we might have oneday (PHBs).

Fix by using the appropriate macros in case of P9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190612174345.9799-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 24 ++++++++++++++++--------
 hw/ppc/pnv_xscom.c         | 17 ++++++++++++-----
 include/hw/ppc/pnv.h       |  3 +++
 include/hw/ppc/pnv_xscom.h |  2 +-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9db43916ac..0d98a281f6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -860,6 +860,14 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
     Pnv8Psi *psi8 =3D &chip8->psi;
     Error *local_err =3D NULL;
=20
+    /* XSCOM bridge is first */
+    pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
+
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1024,6 +1032,14 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
     Pnv9Psi *psi9 =3D &chip9->psi;
     Error *local_err =3D NULL;
=20
+    /* XSCOM bridge is first */
+    pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
+
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1206,14 +1222,6 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
     PnvChip *chip =3D PNV_CHIP(dev);
     Error *error =3D NULL;
=20
-    /* XSCOM bridge */
-    pnv_xscom_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
-
     /* Cores */
     pnv_chip_core_realize(chip, &error);
     if (error) {
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 4e52885c9e..2b81c75f56 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -213,17 +213,17 @@ const MemoryRegionOps pnv_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-void pnv_xscom_realize(PnvChip *chip, Error **errp)
+void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
     char *name;
=20
     name =3D g_strdup_printf("xscom-%x", chip->chip_id);
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_op=
s,
-                          chip, name, PNV_XSCOM_SIZE);
+                          chip, name, size);
     sysbus_init_mmio(sbd, &chip->xscom_mmio);
=20
-    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE)=
;
+    memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
     g_free(name);
 }
@@ -265,12 +265,19 @@ static const char compat_p9[] =3D "ibm,power9-xscom=
\0ibm,xscom";
=20
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
 {
-    uint64_t reg[] =3D { cpu_to_be64(PNV_XSCOM_BASE(chip)),
-                       cpu_to_be64(PNV_XSCOM_SIZE) };
+    uint64_t reg[2];
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
=20
+    if (pnv_chip_is_power9(chip)) {
+        reg[0] =3D cpu_to_be64(PNV9_XSCOM_BASE(chip));
+        reg[1] =3D cpu_to_be64(PNV9_XSCOM_SIZE);
+    } else {
+        reg[0] =3D cpu_to_be64(PNV_XSCOM_BASE(chip));
+        reg[1] =3D cpu_to_be64(PNV_XSCOM_SIZE);
+    }
+
     name =3D g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset =3D fdt_add_subnode(fdt, root_offset, name);
     _FDT(xscom_offset);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fc4678f757..01ac9e7996 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -256,4 +256,7 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
 #define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x00060302031c=
0000ull)
=20
+#define PNV9_XSCOM_SIZE              0x0000000400000000ull
+#define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc00000=
000ull)
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index c842d950d2..67641ed278 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -87,7 +87,7 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_XIVE_BASE      0x5013000
 #define PNV9_XSCOM_XIVE_SIZE      0x300
=20
-extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
+extern void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp=
);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
 extern void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
--=20
2.21.0


