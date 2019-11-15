Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A47C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36603206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36603206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVe0q-0001Ng-QP
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdxA-0005Pv-3n
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdx8-0003lN-W7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62216
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdx8-0003kw-LM
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFhQg2102833
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:56:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9qmjsdbt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:56:04 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:56:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:56:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFFu02c37421164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:56:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D66D4204F;
 Fri, 15 Nov 2019 15:56:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BE8842042;
 Fri, 15 Nov 2019 15:56:00 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:56:00 +0000 (GMT)
Subject: [PATCH v2 for-5.0 7/8] ppc/pnv: Link "chip" property to
 PnvCore::chip pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:56:00 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0020-0000-0000-000003868A73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0021-0000-0000-000021DCA824
Message-Id: <157383336007.165747.1524120147081367440.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=706 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150142
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The core object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c      |    4 ++--
 hw/ppc/pnv_core.c |   10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 232c817452c0..8851875bcfd7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1326,8 +1326,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
-        object_property_add_const_link(OBJECT(pnv_core), "chip",
-                                       OBJECT(chip), &error_fatal);
+        object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
+                                 &error_abort);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 61b3d3ce2250..5ab75bde6cc5 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -217,15 +217,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
     char name[32];
-    Object *chip;
 
-    chip = object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!chip) {
-        error_propagate_prepend(errp, local_err,
-                                "required link 'chip' not found: ");
-        return;
-    }
-    pc->chip = PNV_CHIP(chip);
+    assert(pc->chip);
 
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
@@ -297,6 +290,7 @@ static void pnv_core_unrealize(DeviceState *dev, Error **errp)
 
 static Property pnv_core_properties[] = {
     DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
+    DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
 


