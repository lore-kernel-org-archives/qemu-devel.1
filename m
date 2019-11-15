Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D472C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03000206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03000206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdyj-0006oh-GB
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdwi-0004wx-GG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdwh-0003Yi-9B
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdwh-0003YV-26
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFgZc0038586
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9jtthc17-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:38 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:55:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:55:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFFtWJ448496660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:55:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C450CAE057;
 Fri, 15 Nov 2019 15:55:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE85AE059;
 Fri, 15 Nov 2019 15:55:32 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:55:32 +0000 (GMT)
Subject: [PATCH v2 for-5.0 2/8] xive: Link "xive" property to
 XiveSource::xive pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:55:32 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0028-0000-0000-000003B74000
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0029-0000-0000-0000247A523C
Message-Id: <157383333227.165747.12901571295951957951.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 mlxlogscore=625 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 clxscore=1034 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150142
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

The source object has both a pointer and a "xive" property pointing to the
notifier object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/pnv_xive.c   |    4 ++--
 hw/intc/spapr_xive.c |    4 ++--
 hw/intc/xive.c       |   13 +++----------
 hw/ppc/pnv_psi.c     |    3 +--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 348f2fdd263d..9e23dc705dc3 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1695,8 +1695,8 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
      */
     object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9cb8d38a3bab..10890aeeeb5b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -276,8 +276,8 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
      */
     object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9376e84aff75..2eac15efa675 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1060,17 +1060,8 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc = XIVE_SOURCE(dev);
-    Object *obj;
-    Error *local_err = NULL;
-
-    obj = object_property_get_link(OBJECT(dev), "xive", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'xive' not found: ");
-        return;
-    }
 
-    xsrc->xive = XIVE_NOTIFIER(obj);
+    assert(xsrc->xive);
 
     if (!xsrc->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater than 0");
@@ -1116,6 +1107,8 @@ static Property xive_source_properties[] = {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
+    DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
+                     XiveNotifier *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 68d0dfacfe2b..a360515a86f8 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -851,8 +851,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(psi),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);


