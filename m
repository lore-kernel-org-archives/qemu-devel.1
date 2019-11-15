Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D70C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124EB206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124EB206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41207 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVe4z-00065Z-JF
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdxF-0005Yh-Bz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdxE-0003qx-4g
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35658
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdxD-0003qO-V0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:56:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFgeBa009664
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:56:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsmnsma-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:56:11 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:56:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:56:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFFu6aw53739524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:56:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 350D911C05E;
 Fri, 15 Nov 2019 15:56:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0365D11C052;
 Fri, 15 Nov 2019 15:56:06 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:56:05 +0000 (GMT)
Subject: [PATCH v2 for-5.0 8/8] ppc/pnv: Link "chip" property to
 PnvXive::chip pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:56:05 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0016-0000-0000-000002C402F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0017-0000-0000-00003325AB70
Message-Id: <157383336564.165747.10250365296928442882.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=509 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The XIVE object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/pnv_xive.c |   13 +++----------
 hw/ppc/pnv.c       |    4 ++--
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 6aa7aeed6f83..4e56c2e4689c 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1675,17 +1675,8 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
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
@@ -1800,6 +1791,8 @@ static Property pnv_xive_properties[] = {
     DEFINE_PROP_UINT64("vc-bar", PnvXive, vc_base, 0),
     DEFINE_PROP_UINT64("pc-bar", PnvXive, pc_base, 0),
     DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
+    /* The PnvChip id identifies the XIVE interrupt controller. */
+    DEFINE_PROP_LINK("chip", PnvXive, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
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


