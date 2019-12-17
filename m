Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C441C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4B02072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LCAA6eFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4B02072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Mw-0000UZ-VM
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jw-0002Is-6r
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ju-0007sk-Cm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:43 -0500
Received: from ozlabs.org ([203.11.71.1]:59281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ju-0007LS-0o; Mon, 16 Dec 2019 23:45:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWf1RW7z9sTd; Tue, 17 Dec 2019 15:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557822;
 bh=64a+yA1L+5XUCbPgZCq1xv2EeBj3e0aHAOWcvpUe778=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LCAA6eFIi8hB8GS355V+2svtMaYyJG9kPrvMuKOTop+jPUpnW+j3GSGVf5DcyUUNR
 6uPbpqORMxUzDwZ96TwixpjTtLAULN+bGadsbXz8yM6umLOCd/ZkLEbZyaLpajwrfJ
 G0m0dAmfgrDHiZ3qMGjKgt8sQUhOAqUIOXC6ZHuk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 65/88] ppc/pnv: add a LPC Controller model for POWER10
Date: Tue, 17 Dec 2019 15:42:59 +1100
Message-Id: <20191217044322.351838-66-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Same a POWER9, only the MMIO window changes.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191205184454.10722-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             | 25 ++++++++++++++++++++++---
 hw/ppc/pnv_lpc.c         | 30 ++++++++++++++++++++++--------
 include/hw/ppc/pnv.h     |  4 ++++
 include/hw/ppc/pnv_lpc.h |  6 +++++-
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09263ab747..67d0ad55b8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -314,7 +314,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip=
, void *fdt)
         pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
     }
=20
-    pnv_dt_lpc(chip, fdt, 0);
+    pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
 }
=20
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
@@ -332,6 +332,8 @@ static void pnv_chip_power10_dt_populate(PnvChip *chi=
p, void *fdt)
     if (chip->ram_size) {
         pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
     }
+
+    pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
 }
=20
 static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
@@ -601,8 +603,8 @@ static ISABus *pnv_chip_power9_isa_create(PnvChip *ch=
ip, Error **errp)
=20
 static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
 {
-    error_setg(errp, "No ISA bus!");
-    return NULL;
+    Pnv10Chip *chip10 =3D PNV10_CHIP(chip);
+    return pnv_lpc_isa_create(&chip10->lpc, false, errp);
 }
=20
 static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
@@ -1315,6 +1317,8 @@ static void pnv_chip_power10_instance_init(Object *=
obj)
=20
     object_initialize_child(obj, "psi",  &chip10->psi, sizeof(chip10->ps=
i),
                             TYPE_PNV10_PSI, &error_abort, NULL);
+    object_initialize_child(obj, "lpc",  &chip10->lpc, sizeof(chip10->lp=
c),
+                            TYPE_PNV10_LPC, &error_abort, NULL);
 }
=20
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
@@ -1349,6 +1353,21 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
     }
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_PSIHB_BASE,
                             &PNV_PSI(&chip10->psi)->xscom_regs);
+
+    /* LPC */
+    object_property_set_link(OBJECT(&chip10->lpc), OBJECT(&chip10->psi),=
 "psi",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&chip10->lpc), true, "realized",
+                             &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chi=
p),
+                                &chip10->lpc.xscom_regs);
+
+    chip->dt_isa_nodename =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc=
@0",
+                                            (uint64_t) PNV10_LPCM_BASE(c=
hip));
 }
=20
 static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index dd5374c838..18256d9ba3 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -122,26 +122,26 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev,=
 void *fdt, int xscom_offset)
 }
=20
 /* POWER9 only */
-int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset)
+int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_=
addr,
+               uint64_t lpcm_size)
 {
     const char compat[] =3D "ibm,power9-lpcm-opb\0simple-bus";
     const char lpc_compat[] =3D "ibm,power9-lpc\0ibm,lpc";
     char *name;
     int offset, lpcm_offset;
-    uint64_t lpcm_addr =3D PNV9_LPCM_BASE(chip);
     uint32_t opb_ranges[8] =3D { 0,
                                cpu_to_be32(lpcm_addr >> 32),
                                cpu_to_be32((uint32_t)lpcm_addr),
-                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
-                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
+                               cpu_to_be32(lpcm_size / 2),
+                               cpu_to_be32(lpcm_size / 2),
                                cpu_to_be32(lpcm_addr >> 32),
-                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
-                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
+                               cpu_to_be32(lpcm_size / 2),
+                               cpu_to_be32(lpcm_size / 2),
     };
     uint32_t opb_reg[4] =3D { cpu_to_be32(lpcm_addr >> 32),
                             cpu_to_be32((uint32_t)lpcm_addr),
-                            cpu_to_be32(PNV9_LPCM_SIZE >> 32),
-                            cpu_to_be32((uint32_t)PNV9_LPCM_SIZE),
+                            cpu_to_be32(lpcm_size >> 32),
+                            cpu_to_be32((uint32_t)lpcm_size),
     };
     uint32_t lpc_ranges[12] =3D { 0, 0,
                                 cpu_to_be32(LPC_MEM_OPB_ADDR),
@@ -691,6 +691,19 @@ static const TypeInfo pnv_lpc_power9_info =3D {
     .class_init    =3D pnv_lpc_power9_class_init,
 };
=20
+static void pnv_lpc_power10_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc =3D "PowerNV LPC Controller POWER10";
+}
+
+static const TypeInfo pnv_lpc_power10_info =3D {
+    .name          =3D TYPE_PNV10_LPC,
+    .parent        =3D TYPE_PNV9_LPC,
+    .class_init    =3D pnv_lpc_power10_class_init,
+};
+
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc =3D PNV_LPC(dev);
@@ -764,6 +777,7 @@ static void pnv_lpc_register_types(void)
     type_register_static(&pnv_lpc_info);
     type_register_static(&pnv_lpc_power8_info);
     type_register_static(&pnv_lpc_power9_info);
+    type_register_static(&pnv_lpc_power10_info);
 }
=20
 type_init(pnv_lpc_register_types)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 47b7370b27..56d1161515 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -115,6 +115,7 @@ typedef struct Pnv10Chip {
=20
     /*< public >*/
     Pnv9Psi      psi;
+    PnvLpcController lpc;
 } Pnv10Chip;
=20
 typedef struct PnvChipClass {
@@ -329,6 +330,9 @@ IPMIBmc *pnv_bmc_create(void);
 #define PNV10_XSCOM_SIZE             0x0000000400000000ull
 #define PNV10_XSCOM_BASE(chip)       PNV10_CHIP_BASE(chip, 0x00603fc0000=
0000ull)
=20
+#define PNV10_LPCM_SIZE             0x0000000100000000ull
+#define PNV10_LPCM_BASE(chip)       PNV10_CHIP_BASE(chip, 0x000603000000=
0000ull)
+
 #define PNV10_PSIHB_ESB_SIZE        0x0000000000100000ull
 #define PNV10_PSIHB_ESB_BASE(chip)  PNV10_CHIP_BASE(chip, 0x000603020200=
0000ull)
=20
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index f659410716..c1ec85d5e2 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -31,6 +31,9 @@
 #define TYPE_PNV9_LPC TYPE_PNV_LPC "-POWER9"
 #define PNV9_LPC(obj) OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV9_LP=
C)
=20
+#define TYPE_PNV10_LPC TYPE_PNV_LPC "-POWER10"
+#define PNV10_LPC(obj) OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV10_=
LPC)
+
 typedef struct PnvLpcController {
     DeviceState parent;
=20
@@ -97,6 +100,7 @@ typedef struct PnvLpcClass {
 struct PnvChip;
=20
 ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
-int pnv_dt_lpc(struct PnvChip *chip, void *fdt, int root_offset);
+int pnv_dt_lpc(struct PnvChip *chip, void *fdt, int root_offset,
+               uint64_t lpcm_addr, uint64_t lpcm_size);
=20
 #endif /* PPC_PNV_LPC_H */
--=20
2.23.0


