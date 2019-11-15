Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ABC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E283F2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E283F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaDo-00049q-Km
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 06:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVaAm-0001jE-6G
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVaAk-0006LN-OX
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVaAk-0006IL-FN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:54 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFBpc54173842
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:53:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9ntbbcrt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:53:53 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 11:53:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 11:53:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFBrlH843712580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:53:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7D57A4051;
 Fri, 15 Nov 2019 11:53:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A81FDA404D;
 Fri, 15 Nov 2019 11:53:47 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 11:53:47 +0000 (GMT)
Subject: [PATCH for-5.0 4/8] ppc/pnv: Link "psi" property to PnvLpc::psi
 pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 12:53:47 +0100
In-Reply-To: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111511-4275-0000-0000-0000037DFA3B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111511-4276-0000-0000-0000389163AB
Message-Id: <157381882732.136087.1518730413761195138.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=514 clxscore=1034
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911150112
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

The LPC object has both a pointer and a "psi" property pointing to the
PSI object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c     |    8 ++++----
 hw/ppc/pnv_lpc.c |   23 ++++++++++++-----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d0c1d4227784..286901746f50 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -898,8 +898,6 @@ static void pnv_chip_power8_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
                             TYPE_PNV8_LPC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
-                                   OBJECT(&chip8->psi), &error_abort);
 
     object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
                             TYPE_PNV8_OCC, &error_abort, NULL);
@@ -978,6 +976,8 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             &PNV_PSI(psi8)->xscom_regs);
 
     /* Create LPC controller */
+    object_property_set_link(OBJECT(&chip8->lpc), OBJECT(&chip8->psi), "psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_regs);
@@ -1098,8 +1098,6 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc),
                             TYPE_PNV9_LPC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
-                                   OBJECT(&chip9->psi), &error_abort);
 
     object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ),
                             TYPE_PNV9_OCC, &error_abort, NULL);
@@ -1198,6 +1196,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             &PNV_PSI(psi9)->xscom_regs);
 
     /* LPC */
+    object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->lpc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9466d4a1be3b..f0040a26cfd0 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -24,7 +24,7 @@
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
-
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
@@ -682,17 +682,8 @@ static const TypeInfo pnv_lpc_power9_info = {
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc = PNV_LPC(dev);
-    Object *obj;
-    Error *local_err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "psi", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'psi' not found: ");
-        return;
-    }
-    /* The LPC controller needs PSI to generate interrupts  */
-    lpc->psi = PNV_PSI(obj);
+    assert(lpc->psi);
 
     /* Reg inits */
     lpc->lpc_hc_fw_rd_acc_size = LPC_HC_FW_RD_4B;
@@ -734,6 +725,15 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
                                 &lpc->lpc_hc_regs);
 }
 
+static void pnv_lpc_instance_init(Object *obj)
+{
+    /* The LPC controller needs PSI to generate interrupts  */
+    object_property_add_link(obj, "psi", TYPE_PNV_PSI,
+                             (Object **) &PNV_LPC(obj)->psi,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+}
+
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -745,6 +745,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pnv_lpc_info = {
     .name          = TYPE_PNV_LPC,
     .parent        = TYPE_DEVICE,
+    .instance_init = pnv_lpc_instance_init,
     .class_init    = pnv_lpc_class_init,
     .class_size    = sizeof(PnvLpcClass),
     .abstract      = true,


