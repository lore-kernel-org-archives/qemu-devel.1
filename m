Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49784C2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C560E24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C560E24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjsP-0001TG-L0
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjcZ-0007yC-7w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjcX-0004zz-Jk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10922
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjcX-0004yY-Be
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:33 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBuuw4115718
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wusv0utvp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:32 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:30 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBDC0Pjr36045302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:00:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C80C6A4055;
 Fri, 13 Dec 2019 12:00:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A31E5A4051;
 Fri, 13 Dec 2019 12:00:24 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:00:24 +0000 (GMT)
Subject: [PATCH 10/13] ppc/pnv: Pass content of the "compatible" property to
 pnv_dt_xscom()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:24 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0012-0000-0000-000003747166
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0013-0000-0000-000021B050E5
Message-Id: <157623842430.360005.9513965612524265862.stgit@bahia.lan>
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

Since pnv_dt_xscom() is called from chip specific dt_populate() hooks,
it shouldn't have to guess the chip type in order to populate the
"compatible" property. Just pass the compat string and its size as
arguments.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c               |   12 +++++++++---
 hw/ppc/pnv_xscom.c         |   20 +++-----------------
 include/hw/ppc/pnv_xscom.h |    3 ++-
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c532e98e752a..0447b534b8c5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -280,11 +280,13 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
 
 static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] = "ibm,power8-xscom\0ibm,xscom";
     int i;
 
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV_XSCOM_SIZE));
+                 cpu_to_be64(PNV_XSCOM_SIZE),
+                 compat, sizeof(compat));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
@@ -302,11 +304,13 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 
 static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] = "ibm,power9-xscom\0ibm,xscom";
     int i;
 
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV9_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV9_XSCOM_SIZE));
+                 cpu_to_be64(PNV9_XSCOM_SIZE),
+                 compat, sizeof(compat));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
@@ -323,11 +327,13 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
+    static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
     int i;
 
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV10_XSCOM_BASE(chip)),
-                 cpu_to_be64(PNV10_XSCOM_SIZE));
+                 cpu_to_be64(PNV10_XSCOM_SIZE),
+                 compat, sizeof(compat));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 8189767eb0bb..5ae9dfbb88ad 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -282,12 +282,9 @@ static int xscom_dt_child(Object *child, void *opaque)
     return 0;
 }
 
-static const char compat_p8[] = "ibm,power8-xscom\0ibm,xscom";
-static const char compat_p9[] = "ibm,power9-xscom\0ibm,xscom";
-static const char compat_p10[] = "ibm,power10-xscom\0ibm,xscom";
-
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
-                 uint64_t xscom_base, uint64_t xscom_size)
+                 uint64_t xscom_base, uint64_t xscom_size,
+                 const char *compat, int compat_size)
 {
     uint64_t reg[] = { xscom_base, xscom_size };
     int xscom_offset;
@@ -302,18 +299,7 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
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
+    _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat, compat_size)));
     _FDT((fdt_setprop(fdt, xscom_offset, "scom-controller", NULL, 0)));
 
     args.fdt = fdt;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index ad53f788b44c..f74c81a980f3 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -115,7 +115,8 @@ typedef struct PnvXScomInterfaceClass {
 
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
-                 uint64_t xscom_base, uint64_t xscom_size);
+                 uint64_t xscom_base, uint64_t xscom_size,
+                 const char *compat, int compat_size);
 
 void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
                              MemoryRegion *mr);


