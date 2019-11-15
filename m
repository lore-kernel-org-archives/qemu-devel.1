Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93424C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6781F20732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6781F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVe72-0000XV-76
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdx5-0005MR-3s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdx2-0003fi-67
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21278
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdx2-0003fX-1E
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFgXQo116538
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtw3ju4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:59 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:55:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:55:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFFttf256688840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:55:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10D85A4057;
 Fri, 15 Nov 2019 15:55:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6A47A4055;
 Fri, 15 Nov 2019 15:55:54 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:55:54 +0000 (GMT)
Subject: [PATCH v2 for-5.0 6/8] ppc/pnv: Link "chip" property to
 PnvHomer::chip pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:55:54 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0012-0000-0000-00000363FEC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0013-0000-0000-0000219F7D34
Message-Id: <157383335451.165747.32301068645427993.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1034 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=939
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The homer object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c       |    8 ++++----
 hw/ppc/pnv_homer.c |   20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 96c5a23cd1eb..232c817452c0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -904,8 +904,6 @@ static void pnv_chip_power8_instance_init(Object *obj)
 
     object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->homer),
                             TYPE_PNV8_HOMER, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->homer), "chip", obj,
-                                   &error_abort);
 }
 
 static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
@@ -1009,6 +1007,8 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                                 &chip8->occ.sram_regs);
 
     /* HOMER */
+    object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip8->homer), true, "realized",
                              &local_err);
     if (local_err) {
@@ -1104,8 +1104,6 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->homer),
                             TYPE_PNV9_HOMER, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->homer), "chip", obj,
-                                   &error_abort);
 }
 
 static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
@@ -1222,6 +1220,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                                 &chip9->occ.sram_regs);
 
     /* HOMER */
+    object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->homer), true, "realized",
                              &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index cc881a3b3289..994a378108da 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -22,6 +22,7 @@
 #include "exec/memory.h"
 #include "sysemu/cpus.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_homer.h"
 
@@ -229,28 +230,27 @@ static void pnv_homer_realize(DeviceState *dev, Error **errp)
 {
     PnvHomer *homer = PNV_HOMER(dev);
     PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
-    Object *obj;
-    Error *local_err = NULL;
-
-    obj = object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'chip' not found: ");
-        return;
-    }
-    homer->chip = PNV_CHIP(obj);
+
+    assert(homer->chip);
+
     /* homer region */
     memory_region_init_io(&homer->regs, OBJECT(dev),
                           hmrc->homer_ops, homer, "homer-main-memory",
                           hmrc->homer_size);
 }
 
+static Property pnv_homer_properties[] = {
+    DEFINE_PROP_LINK("chip", PnvHomer, chip, TYPE_PNV_CHIP, PnvChip *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_homer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pnv_homer_realize;
     dc->desc = "PowerNV HOMER Memory";
+    dc->props = pnv_homer_properties;
 }
 
 static const TypeInfo pnv_homer_type_info = {


