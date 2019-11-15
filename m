Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0826C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9787B2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9787B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaMK-0004nt-9T
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVaB8-000269-DF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVaB7-0006hV-0T
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48738
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVaB6-0006h7-RO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:54:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFBpmQ2186314
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:54:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9nsfmwy4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:54:16 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 11:54:14 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 11:54:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAFBrXaC43516330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:53:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76B40A4062;
 Fri, 15 Nov 2019 11:54:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06B2FA405C;
 Fri, 15 Nov 2019 11:54:10 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 11:54:09 +0000 (GMT)
Subject: [PATCH for-5.0 8/8] ppc/pnv: Link "chip" property to PnvXive::chip
 pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 12:54:09 +0100
In-Reply-To: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111511-4275-0000-0000-0000037DFA42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111511-4276-0000-0000-0000389163B2
Message-Id: <157381884958.136087.2386559512465741955.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1034
 malwarescore=0 mlxlogscore=395 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150112
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

The XIVE object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

While here, rename pnv_xive_init() to pnv_xive_instance_init() for
clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/pnv_xive.c   |   21 +++++++++------------
 hw/ppc/pnv.c         |    4 ++--
 include/hw/ppc/pnv.h |    2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 6aa7aeed6f83..158d16b328e3 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1651,7 +1651,7 @@ static void pnv_xive_reset(void *dev)
     }
 }
 
-static void pnv_xive_init(Object *obj)
+static void pnv_xive_instance_init(Object *obj)
 {
     PnvXive *xive = PNV_XIVE(obj);
 
@@ -1661,6 +1661,12 @@ static void pnv_xive_init(Object *obj)
     object_initialize_child(obj, "end_source", &xive->end_source,
                             sizeof(xive->end_source), TYPE_XIVE_END_SOURCE,
                             &error_abort, NULL);
+
+    /* The PnvChip id identifies the XIVE interrupt controller. */
+    object_property_add_link(obj, "chip", TYPE_PNV_CHIP,
+                             (Object **) &PNV_XIVE(obj)->chip,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
 }
 
 /*
@@ -1675,17 +1681,8 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
     XiveSource *xsrc = &xive->ipi_source;
     XiveENDSource *end_xsrc = &xive->end_source;
     Error *local_err = NULL;
-    Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'chip' not found: ");
-        return;
-    }
-
-    /* The PnvChip id identifies the XIVE interrupt controller. */
-    xive->chip = PNV_CHIP(obj);
+    assert(xive->chip);
 
     /*
      * The XiveSource and XiveENDSource objects are realized with the
@@ -1829,7 +1826,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pnv_xive_info = {
     .name          = TYPE_PNV_XIVE,
     .parent        = TYPE_XIVE_ROUTER,
-    .instance_init = pnv_xive_init,
+    .instance_init = pnv_xive_instance_init,
     .instance_size = sizeof(PnvXive),
     .class_init    = pnv_xive_class_init,
     .interfaces    = (InterfaceInfo[]) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8851875bcfd7..d7130c3304f0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1088,8 +1088,6 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xive),
                             TYPE_PNV_XIVE, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->xive), "chip", obj,
-                                   &error_abort);
 
     object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi),
                             TYPE_PNV9_PSI, &error_abort, NULL);
@@ -1171,6 +1169,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             "pc-bar", &error_fatal);
     object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_TM_BASE(chip),
                             "tm-bar", &error_fatal);
+    object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->xive), true, "realized",
                              &local_err);
     if (local_err) {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 5ecd3ba6ed24..d82484ecf669 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -87,9 +87,9 @@ typedef struct Pnv8Chip {
 typedef struct Pnv9Chip {
     /*< private >*/
     PnvChip      parent_obj;
+    PnvXive      xive;
 
     /*< public >*/
-    PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
     PnvOCC       occ;


