Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE71C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47EDB2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ni2znKjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EDB2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5J7-0002vh-5h
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kf-00038a-Se
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ke-0000a4-Ht
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:29 -0500
Received: from ozlabs.org ([203.11.71.1]:37773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ke-0008Jk-5u; Mon, 16 Dec 2019 23:46:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWk50zcz9sTh; Tue, 17 Dec 2019 15:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557826;
 bh=6Nu5aL34GOYK0IMDawQWJzLfK3WQGy47SluL54q3xhg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ni2znKjVFrqnfj4OlHb9kDl1zg0cYeK8EMsiMjzotGYwRCEuSN2WXPKupQ7djnQXW
 8AgDCkMVwrsNH4mgkc3lmLxYvDAUJHMZGhPgQAGE4jmc6ySUZCxDVv9lpGv1m7wx6Y
 YvgiqXSobvh4z79sJPVCjxtKVOiUrC/SzHqcDNf4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 84/88] ppc/pnv: Pass content of the "compatible" property to
 pnv_dt_xscom()
Date: Tue, 17 Dec 2019 15:43:18 +1100
Message-Id: <20191217044322.351838-85-david@gibson.dropbear.id.au>
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

From: Greg Kurz <groug@kaod.org>

Since pnv_dt_xscom() is called from chip specific dt_populate() hooks,
it shouldn't have to guess the chip type in order to populate the
"compatible" property. Just pass the compat string and its size as
arguments.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623842430.360005.9513965612524265862.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 12 +++++++++---
 hw/ppc/pnv_xscom.c         | 20 +++-----------------
 include/hw/ppc/pnv_xscom.h |  3 ++-
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0a5703b74..b3388038c6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -280,11 +280,13 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, ui=
nt32_t pir,
=20
 static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] =3D "ibm,power8-xscom\0ibm,xscom";
     int i;
=20
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV_XSCOM_SIZE));
+                 cpu_to_be64(PNV_XSCOM_SIZE),
+                 compat, sizeof(compat));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
@@ -302,11 +304,13 @@ static void pnv_chip_power8_dt_populate(PnvChip *ch=
ip, void *fdt)
=20
 static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] =3D "ibm,power9-xscom\0ibm,xscom";
     int i;
=20
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV9_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV9_XSCOM_SIZE));
+                 cpu_to_be64(PNV9_XSCOM_SIZE),
+                 compat, sizeof(compat));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
@@ -323,11 +327,13 @@ static void pnv_chip_power9_dt_populate(PnvChip *ch=
ip, void *fdt)
=20
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] =3D "ibm,power10-xscom\0ibm,xscom";
     int i;
=20
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV10_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV10_XSCOM_SIZE));
+                 cpu_to_be64(PNV10_XSCOM_SIZE),
+                 compat, sizeof(compat));
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D chip->cores[i];
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 8189767eb0..5ae9dfbb88 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -282,12 +282,9 @@ static int xscom_dt_child(Object *child, void *opaqu=
e)
     return 0;
 }
=20
-static const char compat_p8[] =3D "ibm,power8-xscom\0ibm,xscom";
-static const char compat_p9[] =3D "ibm,power9-xscom\0ibm,xscom";
-static const char compat_p10[] =3D "ibm,power10-xscom\0ibm,xscom";
-
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
-                 uint64_t xscom_base, uint64_t xscom_size)
+                 uint64_t xscom_base, uint64_t xscom_size,
+                 const char *compat, int compat_size)
 {
     uint64_t reg[] =3D { xscom_base, xscom_size };
     int xscom_offset;
@@ -302,18 +299,7 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_=
offset,
     _FDT((fdt_setprop_cell(fdt, xscom_offset, "#address-cells", 1)));
     _FDT((fdt_setprop_cell(fdt, xscom_offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, xscom_offset, "reg", reg, sizeof(reg))));
-
-    if (pnv_chip_is_power10(chip)) {
-        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p10,
-                          sizeof(compat_p10))));
-    } else if (pnv_chip_is_power9(chip)) {
-        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p9,
-                          sizeof(compat_p9))));
-    } else {
-        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p8,
-                          sizeof(compat_p8))));
-    }
-
+    _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat, compat_si=
ze)));
     _FDT((fdt_setprop(fdt, xscom_offset, "scom-controller", NULL, 0)));
=20
     args.fdt =3D fdt;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index ad53f788b4..f74c81a980 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -115,7 +115,8 @@ typedef struct PnvXScomInterfaceClass {
=20
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
-                 uint64_t xscom_base, uint64_t xscom_size);
+                 uint64_t xscom_base, uint64_t xscom_size,
+                 const char *compat, int compat_size);
=20
 void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
                              MemoryRegion *mr);
--=20
2.23.0


