Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF12C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4542A2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaJz-0001v3-BS
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVaAf-0001Yc-K3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVaAe-0006DP-D7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58112
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVaAe-0006Cr-8K
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:53:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFBq77I068915
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:53:46 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9qmjgef2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:53:46 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 11:53:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 11:53:43 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFBrgDc55902346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:53:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E1AF4C04A;
 Fri, 15 Nov 2019 11:53:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BA224C040;
 Fri, 15 Nov 2019 11:53:42 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 11:53:42 +0000 (GMT)
Subject: [PATCH for-5.0 3/8] xive: Link "xive" property to
 XiveEndSource::xrtr pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 12:53:41 +0100
In-Reply-To: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111511-4275-0000-0000-0000037DFA3A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111511-4276-0000-0000-0000389163AA
Message-Id: <157381882171.136087.11902736379070146922.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=638 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
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

The END source object has both a pointer and a "xive" property pointing to
the router object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/pnv_xive.c   |    4 ++--
 hw/intc/spapr_xive.c |    4 ++--
 hw/intc/xive.c       |   20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9e23dc705dc3..6aa7aeed6f83 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1705,8 +1705,8 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(end_xsrc), PNV_XIVE_NR_ENDS, "nr-ends",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 10890aeeeb5b..729246e906c9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -290,8 +290,8 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
      */
     object_property_set_int(OBJECT(end_xsrc), xive->nr_irqs, "nr-ends",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b69bceb4d255..a32ce0d5bfc6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1824,17 +1824,8 @@ static const MemoryRegionOps xive_end_source_ops = {
 static void xive_end_source_realize(DeviceState *dev, Error **errp)
 {
     XiveENDSource *xsrc = XIVE_END_SOURCE(dev);
-    Object *obj;
-    Error *local_err = NULL;
-
-    obj = object_property_get_link(OBJECT(dev), "xive", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'xive' not found: ");
-        return;
-    }
 
-    xsrc->xrtr = XIVE_ROUTER(obj);
+    assert(xsrc->xrtr);
 
     if (!xsrc->nr_ends) {
         error_setg(errp, "Number of interrupt needs to be greater than 0");
@@ -1863,6 +1854,14 @@ static Property xive_end_source_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void xive_end_source_instance_init(Object *obj)
+{
+    object_property_add_link(obj, "xive", TYPE_XIVE_ROUTER,
+                             (Object **) &XIVE_END_SOURCE(obj)->xrtr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+}
+
 static void xive_end_source_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1881,6 +1880,7 @@ static const TypeInfo xive_end_source_info = {
     .name          = TYPE_XIVE_END_SOURCE,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XiveENDSource),
+    .instance_init    = xive_end_source_instance_init,
     .class_init    = xive_end_source_class_init,
 };
 


