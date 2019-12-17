Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720722072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Sejz2c9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720722072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5oF-0006JX-MP
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kt-0003VX-SD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ks-0001KB-GZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35953 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ks-0000F6-5x; Mon, 16 Dec 2019 23:46:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWm0zKgz9sRc; Tue, 17 Dec 2019 15:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557828;
 bh=jJaUvC3L1J19szq6Xx2t4DAcLfJF1KIsBpr7HLRkc1Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sejz2c9OpmwdASBQpfvQUZzBPFIIfXcZsD5g4r4E7SXFbnG53Eq5hrNPjBLekwKdB
 nUVKXqYulIVsuOmGUVG6A9mDqyML1IUGNTUYpSO8h+T0Xt4E1OdA/sN++YWAlTk3t+
 nTFfpixPtZaSUivunTFU/iMN1xGA5EDe0aVN2i8M=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 86/88] ppc/pnv: Introduce PnvChipClass::xscom_pcba() method
Date: Tue, 17 Dec 2019 15:43:20 +1100
Message-Id: <20191217044322.351838-87-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XSCOM bus is implemented with a QOM interface, which is mostly
generic from a CPU type standpoint, except for the computation of
addresses on the Pervasive Connect Bus (PCB) network. This is handled
by the pnv_xscom_pcba() function with a switch statement based on
the chip_type class level attribute of the CPU chip.

This can be achieved using QOM. Also the address argument is masked with
PNV_XSCOM_SIZE - 1, which is for POWER8 only. Addresses may have differen=
t
sizes with other CPU types. Have each CPU chip type handle the appropriat=
e
computation with a QOM xscom_pcba() method.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623843543.360005.13996472463887521794.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 23 +++++++++++++++++++++++
 hw/ppc/pnv_xscom.c   | 14 +-------------
 include/hw/ppc/pnv.h |  1 +
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b3388038c6..41e5d762df 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1120,6 +1120,12 @@ static void pnv_chip_power8_realize(DeviceState *d=
ev, Error **errp)
                                 &chip8->homer.regs);
 }
=20
+static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &=3D (PNV_XSCOM_SIZE - 1);
+    return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
+}
+
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -1137,6 +1143,7 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1160,6 +1167,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER8";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1183,6 +1191,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1339,6 +1348,12 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
                                 &chip9->homer.regs);
 }
=20
+static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &=3D (PNV9_XSCOM_SIZE - 1);
+    return addr >> 3;
+}
+
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -1356,6 +1371,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
     k->xscom_core_base =3D pnv_chip_power9_xscom_core_base;
+    k->xscom_pcba =3D pnv_chip_power9_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER9";
=20
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1421,6 +1437,12 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
                                             (uint64_t) PNV10_LPCM_BASE(c=
hip));
 }
=20
+static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr=
)
+{
+    addr &=3D (PNV10_XSCOM_SIZE - 1);
+    return addr >> 3;
+}
+
 static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -1438,6 +1460,7 @@ static void pnv_chip_power10_class_init(ObjectClass=
 *klass, void *data)
     k->dt_populate =3D pnv_chip_power10_dt_populate;
     k->pic_print_info =3D pnv_chip_power10_pic_print_info;
     k->xscom_core_base =3D pnv_chip_power10_xscom_core_base;
+    k->xscom_pcba =3D pnv_chip_power10_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER10";
=20
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 5ae9dfbb88..b681c72575 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -57,19 +57,7 @@ static void xscom_complete(CPUState *cs, uint64_t hmer=
_bits)
=20
 static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 {
-    addr &=3D (PNV_XSCOM_SIZE - 1);
-
-    switch (PNV_CHIP_GET_CLASS(chip)->chip_type) {
-    case PNV_CHIP_POWER8E:
-    case PNV_CHIP_POWER8:
-    case PNV_CHIP_POWER8NVL:
-        return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
-    case PNV_CHIP_POWER9:
-    case PNV_CHIP_POWER10:
-        return addr >> 3;
-    default:
-        g_assert_not_reached();
-    }
+    return PNV_CHIP_GET_CLASS(chip)->xscom_pcba(chip, addr);
 }
=20
 static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7a134a15d3..4972e93c26 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -138,6 +138,7 @@ typedef struct PnvChipClass {
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
     uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
+    uint32_t (*xscom_pcba)(PnvChip *chip, uint64_t addr);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
--=20
2.23.0


