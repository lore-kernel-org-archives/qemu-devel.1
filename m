Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05625C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E032073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E032073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaML-0004qf-Qr
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVaB2-0001w6-AC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVaB0-0006bI-Sc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVaB0-0006aw-Kg
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFBqUPN034856
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:54:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nuxbs7w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:54:09 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 11:54:07 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 11:54:05 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAFBrRH227197736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:53:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849B8AE057;
 Fri, 15 Nov 2019 11:54:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FA89AE053;
 Fri, 15 Nov 2019 11:54:04 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 11:54:04 +0000 (GMT)
Subject: [PATCH for-5.0 7/8] ppc/pnv: Link "chip" property to PnvCore::chip
 pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 12:54:04 +0100
In-Reply-To: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111511-0016-0000-0000-000002C3E4A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111511-0017-0000-0000-000033258BA6
Message-Id: <157381884403.136087.1106071650789146002.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxlogscore=737 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150112
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The core object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c              |    4 ++--
 hw/ppc/pnv_core.c         |   18 ++++++++++--------
 include/hw/ppc/pnv_core.h |    2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

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
index 61b3d3ce2250..56d185f6290d 100644
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
@@ -323,6 +316,14 @@ static void pnv_core_class_init(ObjectClass *oc, void *data)
     dc->props = pnv_core_properties;
 }
 
+static void pnv_core_instance_init(Object *obj)
+{
+    object_property_add_link(obj, "chip", TYPE_PNV_CHIP,
+                             (Object **) &PNV_CORE(obj)->chip,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+}
+
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
     {                                           \
         .parent = TYPE_PNV_CORE,                \
@@ -335,6 +336,7 @@ static const TypeInfo pnv_core_infos[] = {
         .name           = TYPE_PNV_CORE,
         .parent         = TYPE_CPU_CORE,
         .instance_size  = sizeof(PnvCore),
+        .instance_init  = pnv_core_instance_init,
         .class_size     = sizeof(PnvCoreClass),
         .class_init = pnv_core_class_init,
         .abstract       = true,
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 55eee95104da..fce6d8d9b31b 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -36,11 +36,11 @@ typedef struct PnvChip PnvChip;
 typedef struct PnvCore {
     /*< private >*/
     CPUCore parent_obj;
+    PnvChip *chip;
 
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
-    PnvChip *chip;
 
     MemoryRegion xscom_regs;
 } PnvCore;


