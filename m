Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA14E2465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA14E2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjks-00008I-Lq
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjci-00085Q-W1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjch-0005Fj-B8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26324
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjch-0005FJ-4c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBv6an061012
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxsc4uv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:42 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:40 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBDBxrJL50462988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 11:59:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0742111C05E;
 Fri, 13 Dec 2019 12:00:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9AA911C06F;
 Fri, 13 Dec 2019 12:00:35 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:00:35 +0000 (GMT)
Subject: [PATCH 12/13] ppc/pnv: Introduce PnvChipClass::xscom_pcba() method
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:35 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0028-0000-0000-000003C82A54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0029-0000-0000-0000248B6796
Message-Id: <157623843543.360005.13996472463887521794.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=884 impostorscore=0 priorityscore=1501
 clxscore=1034 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The XSCOM bus is implemented with a QOM interface, which is mostly
generic from a CPU type standpoint, except for the computation of
addresses on the Pervasize Connect Bus (PCB) network. This is handled
by the pnv_xscom_pcba() function with a switch statement based on
the chip_type class level attribute of the CPU chip.

This can be achieved using QOM. Also the address argument is masked with
PNV_XSCOM_SIZE - 1, which is for POWER8 only. Addresses may have different
sizes with other CPU types. Have each CPU chip type handle the appropriate
computation with a QOM xscom_pcba() method.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c         |   23 +++++++++++++++++++++++
 hw/ppc/pnv_xscom.c   |   14 +-------------
 include/hw/ppc/pnv.h |    1 +
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0447b534b8c5..cc40b90e9cd2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1121,6 +1121,12 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                                 &chip8->homer.regs);
 }
 
+static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &= (PNV_XSCOM_SIZE - 1);
+    return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
+}
+
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1138,6 +1144,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
     k->xscom_core_base = pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
     dc->desc = "PowerNV Chip POWER8E";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1161,6 +1168,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
     k->xscom_core_base = pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
     dc->desc = "PowerNV Chip POWER8";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1184,6 +1192,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
     k->xscom_core_base = pnv_chip_power8_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
     dc->desc = "PowerNV Chip POWER8NVL";
 
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1340,6 +1349,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                                 &chip9->homer.regs);
 }
 
+static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &= (PNV9_XSCOM_SIZE - 1);
+    return addr >> 3;
+}
+
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1357,6 +1372,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     k->dt_populate = pnv_chip_power9_dt_populate;
     k->pic_print_info = pnv_chip_power9_pic_print_info;
     k->xscom_core_base = pnv_chip_power9_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power9_xscom_pcba;
     dc->desc = "PowerNV Chip POWER9";
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1422,6 +1438,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                                             (uint64_t) PNV10_LPCM_BASE(chip));
 }
 
+static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &= (PNV10_XSCOM_SIZE - 1);
+    return addr >> 3;
+}
+
 static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1439,6 +1461,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->dt_populate = pnv_chip_power10_dt_populate;
     k->pic_print_info = pnv_chip_power10_pic_print_info;
     k->xscom_core_base = pnv_chip_power10_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
     dc->desc = "PowerNV Chip POWER10";
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 5ae9dfbb88ad..b681c72575b2 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -57,19 +57,7 @@ static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 
 static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 {
-    addr &= (PNV_XSCOM_SIZE - 1);
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
 
 static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7a134a15d3b5..4972e93c2619 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -138,6 +138,7 @@ typedef struct PnvChipClass {
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
     uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
+    uint32_t (*xscom_pcba)(PnvChip *chip, uint64_t addr);
 } PnvChipClass;
 
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP


