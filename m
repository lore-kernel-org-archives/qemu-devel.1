Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B3BC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C70421655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C70421655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjpt-0006sR-BX
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjcT-0007po-T2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjcS-0004or-Eq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjcS-0004nI-3u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBvJDE049877
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuspgvb9n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:27 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDC0L8R15335494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:00:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4040F4C06E;
 Fri, 13 Dec 2019 12:00:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17C084C07E;
 Fri, 13 Dec 2019 12:00:19 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:00:19 +0000 (GMT)
Subject: [PATCH 09/13] ppc/pnv: Pass XSCOM base address and address size to
 pnv_dt_xscom()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:18 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0016-0000-0000-000002D47158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0017-0000-0000-000033369CC0
Message-Id: <157623841868.360005.17577624823547136435.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1034
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Since pnv_dt_xscom() is called from chip specific dt_populate() hooks,
it shouldn't have to guess the chip type in order to populate the "reg"
property. Just pass the base address and address size as arguments.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c               |   12 +++++++++---
 hw/ppc/pnv_xscom.c         |   16 +++-------------
 include/hw/ppc/pnv_xscom.h |    3 ++-
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 88efa755e611..c532e98e752a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -282,7 +282,9 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
     int i;
 
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV_XSCOM_SIZE));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
@@ -302,7 +304,9 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
     int i;
 
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV9_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV9_XSCOM_SIZE));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
@@ -321,7 +325,9 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
     int i;
 
-    pnv_dt_xscom(chip, fdt, 0);
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV10_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV10_XSCOM_SIZE));
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index df926003f2ba..8189767eb0bb 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -286,24 +286,14 @@ static const char compat_p8[] = "ibm,power8-xscom\0ibm,xscom";
 static const char compat_p9[] = "ibm,power9-xscom\0ibm,xscom";
 static const char compat_p10[] = "ibm,power10-xscom\0ibm,xscom";
 
-int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
+int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
+                 uint64_t xscom_base, uint64_t xscom_size)
 {
-    uint64_t reg[2];
+    uint64_t reg[] = { xscom_base, xscom_size };
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
 
-    if (pnv_chip_is_power10(chip)) {
-        reg[0] = cpu_to_be64(PNV10_XSCOM_BASE(chip));
-        reg[1] = cpu_to_be64(PNV10_XSCOM_SIZE);
-    } else if (pnv_chip_is_power9(chip)) {
-        reg[0] = cpu_to_be64(PNV9_XSCOM_BASE(chip));
-        reg[1] = cpu_to_be64(PNV9_XSCOM_SIZE);
-    } else {
-        reg[0] = cpu_to_be64(PNV_XSCOM_BASE(chip));
-        reg[1] = cpu_to_be64(PNV_XSCOM_SIZE);
-    }
-
     name = g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset = fdt_add_subnode(fdt, root_offset, name);
     _FDT(xscom_offset);
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 2bdb7ae84fd3..ad53f788b44c 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -114,7 +114,8 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
 
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
-int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
+int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
+                 uint64_t xscom_base, uint64_t xscom_size);
 
 void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
                              MemoryRegion *mr);


