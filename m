Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C5EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FF524125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FF524125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjiH-0004fo-2m
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjcQ-0007m5-I5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjcP-0004iA-0g
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjcO-0004gA-Mw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBw6Mp026965
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuq3xamr5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDC0EDS51249306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:00:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7A2352069;
 Fri, 13 Dec 2019 12:00:13 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6F6B35207E;
 Fri, 13 Dec 2019 12:00:13 +0000 (GMT)
Subject: [PATCH 08/13] ppc/pnv: Introduce PnvChipClass::xscom_core_base()
 method
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:13 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0020-0000-0000-00000397C4CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0021-0000-0000-000021EED23C
Message-Id: <157623841311.360005.4705705734873339545.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1034
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130097
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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

The pnv_chip_core_realize() function configures the XSCOM MMIO subregion
for each core of a single chip. The base address of the subregion depends
on the CPU type. Its computation is currently open-code using the
pnv_chip_is_powerXX() helpers. This can be achieved with QOM. Introduce
a method for this in the base chip class and implement it in child classes.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c         |   31 ++++++++++++++++++++++++-------
 include/hw/ppc/pnv.h |    1 +
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2a53e99bda2e..88efa755e611 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -616,6 +616,24 @@ static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
     pnv_psi_pic_print_info(&chip9->psi, mon);
 }
 
+static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
+                                                uint32_t core_id)
+{
+    return PNV_XSCOM_EX_BASE(core_id);
+}
+
+static uint64_t pnv_chip_power9_xscom_core_base(PnvChip *chip,
+                                                uint32_t core_id)
+{
+    return PNV9_XSCOM_EC_BASE(core_id);
+}
+
+static uint64_t pnv_chip_power10_xscom_core_base(PnvChip *chip,
+                                                 uint32_t core_id)
+{
+    return PNV10_XSCOM_EC_BASE(core_id);
+}
+
 static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
 {
     PowerPCCPUClass *ppc_default =
@@ -1107,6 +1125,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
+    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
     dc->desc = "PowerNV Chip POWER8E";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1129,6 +1148,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
+    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
     dc->desc = "PowerNV Chip POWER8";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1151,6 +1171,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->isa_create = pnv_chip_power8nvl_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
+    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
     dc->desc = "PowerNV Chip POWER8NVL";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1323,6 +1344,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     k->isa_create = pnv_chip_power9_isa_create;
     k->dt_populate = pnv_chip_power9_dt_populate;
     k->pic_print_info = pnv_chip_power9_pic_print_info;
+    k->xscom_core_base = pnv_chip_power9_xscom_core_base;
     dc->desc = "PowerNV Chip POWER9";
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1404,6 +1426,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->isa_create = pnv_chip_power10_isa_create;
     k->dt_populate = pnv_chip_power10_dt_populate;
     k->pic_print_info = pnv_chip_power10_pic_print_info;
+    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
     dc->desc = "PowerNV Chip POWER10";
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
@@ -1491,13 +1514,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                  &error_fatal);
 
         /* Each core has an XSCOM MMIO region */
-        if (pnv_chip_is_power10(chip)) {
-            xscom_core_base = PNV10_XSCOM_EC_BASE(core_hwid);
-        } else if (pnv_chip_is_power9(chip)) {
-            xscom_core_base = PNV9_XSCOM_EC_BASE(core_hwid);
-        } else {
-            xscom_core_base = PNV_XSCOM_EX_BASE(core_hwid);
-        }
+        xscom_core_base = pcc->xscom_core_base(chip, core_hwid);
 
         pnv_xscom_add_subregion(chip, xscom_core_base,
                                 &pnv_core->xscom_regs);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7d2402784d4b..17ca9a14ac8f 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -137,6 +137,7 @@ typedef struct PnvChipClass {
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
+    uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
 } PnvChipClass;
 
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP


