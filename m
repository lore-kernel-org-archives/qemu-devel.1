Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A449920733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fYnBEn3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A449920733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Xi-0008MU-Kq
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kV-0002qf-3X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kT-00009a-QO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:18 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48477 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kT-00082o-Fp; Mon, 16 Dec 2019 23:46:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWj5gTRz9sTs; Tue, 17 Dec 2019 15:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557825;
 bh=ljmL1lYaXFyfFF9azN9Hfb8Gm1J0BuKOdNiP9RTy5kU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fYnBEn3Q97fzOecWLnZ4a4awkx9f7ReJymTAUJRx2FNwmNtuA3kr8QV0KDHNGwPXy
 LCbRnR/SFseP+DwKhoXif2sKMaLqB2Zj34MGSCtpFrKFbQF2uj+VdoBcPo5vsn49hl
 ShZurNJ+boqCSISIWtaWqDauyWSpCLPppECqxnCM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 83/88] ppc/pnv: Pass XSCOM base address and address size to
 pnv_dt_xscom()
Date: Tue, 17 Dec 2019 15:43:17 +1100
Message-Id: <20191217044322.351838-84-david@gibson.dropbear.id.au>
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

Since pnv_dt_xscom() is called from chip specific dt_populate() hooks,
it shouldn't have to guess the chip type in order to populate the "reg"
property. Just pass the base address and address size as arguments.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623841868.360005.17577624823547136435.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 12 +++++++++---
 hw/ppc/pnv_xscom.c         | 16 +++-------------
 include/hw/ppc/pnv_xscom.h |  3 ++-
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 16f4e407ee..c0a5703b74 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -282,7 +282,9 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip=
, void *fdt)
 {
     int i;
=20
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV_XSCOM_SIZE));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
@@ -302,7 +304,9 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip=
, void *fdt)
 {
     int i;
=20
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV9_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV9_XSCOM_SIZE));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
@@ -321,7 +325,9 @@ static void pnv_chip_power10_dt_populate(PnvChip *chi=
p, void *fdt)
 {
     int i;
=20
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV10_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV10_XSCOM_SIZE));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index df926003f2..8189767eb0 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -286,24 +286,14 @@ static const char compat_p8[] =3D "ibm,power8-xscom=
\0ibm,xscom";
 static const char compat_p9[] =3D "ibm,power9-xscom\0ibm,xscom";
 static const char compat_p10[] =3D "ibm,power10-xscom\0ibm,xscom";
=20
-int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
+int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
+                 uint64_t xscom_base, uint64_t xscom_size)
 {
-    uint64_t reg[2];
+    uint64_t reg[] =3D { xscom_base, xscom_size };
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
=20
-    if (pnv_chip_is_power10(chip)) {
-        reg[0] =3D cpu_to_be64(PNV10_XSCOM_BASE(chip));
-        reg[1] =3D cpu_to_be64(PNV10_XSCOM_SIZE);
-    } else if (pnv_chip_is_power9(chip)) {
-        reg[0] =3D cpu_to_be64(PNV9_XSCOM_BASE(chip));
-        reg[1] =3D cpu_to_be64(PNV9_XSCOM_SIZE);
-    } else {
-        reg[0] =3D cpu_to_be64(PNV_XSCOM_BASE(chip));
-        reg[1] =3D cpu_to_be64(PNV_XSCOM_SIZE);
-    }
-
     name =3D g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset =3D fdt_add_subnode(fdt, root_offset, name);
     _FDT(xscom_offset);
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 2bdb7ae84f..ad53f788b4 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -114,7 +114,8 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
=20
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
-int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
+int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
+                 uint64_t xscom_base, uint64_t xscom_size);
=20
 void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
                              MemoryRegion *mr);
--=20
2.23.0


