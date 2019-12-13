Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79523C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F7924679
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F7924679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifji4-0004Iy-Hq
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjbn-000793-ND
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjbm-0003lZ-3o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55872
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjbl-0003kP-TX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBuvS3115779
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wusv0usmw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:45 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 11:59:43 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 11:59:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBDBxegZ39387514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 11:59:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AEE84C058;
 Fri, 13 Dec 2019 11:59:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AA0B4C04E;
 Fri, 13 Dec 2019 11:59:40 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 11:59:40 +0000 (GMT)
Subject: [PATCH 02/13] ppc/pnv: Introduce PnvPsiClass::compat
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 12:59:39 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121311-4275-0000-0000-0000038E93CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121311-4276-0000-0000-000038A250A8
Message-Id: <157623837974.360005.14706607446188964477.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1034 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130097
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Processor Service Interface (PSI) model has a chip_type class level
attribute, which is used to generate the content of the "compatible" DT
property according to the CPU type.

Since the PSI model already has specialized classes for each supported
CPU type, it seems cleaner to achieve this with QOM. Provide the content
of the "compatible" property with a new class level attribute.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_psi.c         |   25 +++++++++++--------------
 include/hw/ppc/pnv_psi.h |    2 ++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 572924388b3c..98a82b25e01f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -536,10 +536,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(pnv_psi_reset, dev);
 }
 
-static const char compat_p8[] = "ibm,power8-psihb-x\0ibm,psihb-x";
-static const char compat_p9[] = "ibm,power9-psihb-x\0ibm,psihb-x";
-static const char compat_p10[] = "ibm,power10-psihb-x\0ibm,psihb-x";
-
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom_offset)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(dev);
@@ -558,16 +554,8 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom_offset)
     _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
     _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
-    if (ppc->chip_type == PNV_CHIP_POWER10) {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p10,
-                         sizeof(compat_p10)));
-    } else if (ppc->chip_type == PNV_CHIP_POWER9) {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
-                         sizeof(compat_p9)));
-    } else {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
-                         sizeof(compat_p8)));
-    }
+    _FDT(fdt_setprop(fdt, offset, "compatible", ppc->compat,
+                     ppc->compat_size));
     return 0;
 }
 
@@ -581,6 +569,7 @@ static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
+    static const char compat[] = "ibm,power8-psihb-x\0ibm,psihb-x";
 
     dc->desc    = "PowerNV PSI Controller POWER8";
     dc->realize = pnv_psi_power8_realize;
@@ -590,6 +579,8 @@ static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
     ppc->xscom_size = PNV_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   = PSIHB_BAR_MASK;
     ppc->irq_set    = pnv_psi_power8_irq_set;
+    ppc->compat     = compat;
+    ppc->compat_size = sizeof(compat);
 }
 
 static const TypeInfo pnv_psi_power8_info = {
@@ -888,6 +879,7 @@ static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
     XiveNotifierClass *xfc = XIVE_NOTIFIER_CLASS(klass);
+    static const char compat[] = "ibm,power9-psihb-x\0ibm,psihb-x";
 
     dc->desc    = "PowerNV PSI Controller POWER9";
     dc->realize = pnv_psi_power9_realize;
@@ -897,6 +889,8 @@ static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
     ppc->xscom_size = PNV9_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   = PSIHB9_BAR_MASK;
     ppc->irq_set    = pnv_psi_power9_irq_set;
+    ppc->compat     = compat;
+    ppc->compat_size = sizeof(compat);
 
     xfc->notify      = pnv_psi_notify;
 }
@@ -917,12 +911,15 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
+    static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
 
     dc->desc    = "PowerNV PSI Controller POWER10";
 
     ppc->chip_type  = PNV_CHIP_POWER10;
     ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;
+    ppc->compat     = compat;
+    ppc->compat_size = sizeof(compat);
 }
 
 static const TypeInfo pnv_psi_power10_info = {
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index a044aab304ae..fc068c95e543 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -83,6 +83,8 @@ typedef struct PnvPsiClass {
     uint32_t xscom_pcba;
     uint32_t xscom_size;
     uint64_t bar_mask;
+    const char *compat;
+    int compat_size;
 
     void (*irq_set)(PnvPsi *psi, int, bool state);
 } PnvPsiClass;


