Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BE62231A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BE62231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7gn-00080C-Uw
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7fB-00063N-1k
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7f9-0005Ef-QD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iX7f9-0005EP-IQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJHmr0n004479
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf592pkp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:38 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 19 Nov 2019 17:51:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Nov 2019 17:51:34 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJHpXHD54198398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 17:51:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F13CD4C04E;
 Tue, 19 Nov 2019 17:51:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A10414C044;
 Tue, 19 Nov 2019 17:51:31 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.84.11])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 17:51:31 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
Date: Tue, 19 Nov 2019 23:20:56 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191119175056.32518-1-bala24@linux.ibm.com>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111917-0012-0000-0000-000003689BD2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111917-0013-0000-0000-000021A426F8
Message-Id: <20191119175056.32518-6-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 mlxlogscore=907 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911190152
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
Cc: Balamuruhan S <bala24@linux.ibm.com>, david@gibson.dropbear.id.au,
 qemu-ppc@nongnu.org, clg@kaod.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

slw base and size mask are accessed during boot in homer_init_chip(),
so include BAR2 and BARMASK2 for Power8.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c   | 10 ++++++++--
 include/hw/ppc/pnv.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index f797a5ec7d..828a2e2a5a 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -38,8 +38,10 @@
 
 /* PBA BARs */
 #define P8_PBA_BAR0                     0x2013f00
+#define P8_PBA_BAR2                     0x2013f02
 #define P8_PBA_BAR3                     0x2013f03
 #define P8_PBA_BARMASK0                 0x2013f04
+#define P8_PBA_BARMASK2                 0x2013f06
 #define P8_PBA_BARMASK3                 0x2013f07
 #define P9_PBA_BAR0                     0x5012b00
 #define P9_PBA_BAR2                     0x5012b02
@@ -49,6 +51,7 @@
 /* Mask to calculate Homer/Occ size */
 #define HOMER_SIZE_MASK                 0x0000000000300000ull
 #define OCC_SIZE_MASK                   0x0000000000700000ull
+#define SLW_SIZE_MASK                   0x0
 
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
@@ -115,6 +118,11 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
         }
         return 0;
 
+    case P8_PBA_BAR2: /* P8 slw image */
+        return PNV_SLW_IMAGE_BASE(chip);
+    case P8_PBA_BARMASK2: /* P8 slw image size is 1MB and mask is zero*/
+        return SLW_SIZE_MASK;
+
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
 
@@ -135,9 +143,7 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
     case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
     case 0x2013f01:     /* PBA stuff */
-    case 0x2013f02:     /* PBA stuff */
     case 0x2013f05:     /* PBA stuff */
-    case 0x2013f06:     /* PBA stuff */
         return 0;
     case 0x2013028:     /* CAPP stuff */
     case 0x201302a:     /* CAPP stuff */
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index e9ed8b928a..bd22dbf8a9 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -212,6 +212,10 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV_HOMER_BASE(chip)                                            \
     (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SIZE)
 
+#define PNV_SLW_SIZE                0x0000000000100000ull
+#define PNV_SLW_IMAGE_BASE(chip)                                        \
+    (0x2ffda00000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_SLW_SIZE)
+
 
 /*
  * XSCOM 0x20109CA defines the ICP BAR:
-- 
2.14.5


