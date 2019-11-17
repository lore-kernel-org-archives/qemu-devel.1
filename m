Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20887C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90932071E
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90932071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWTsS-0008EU-BY
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 18:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWTqc-0006Vf-8c
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWTqb-0007Rg-4n
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWTqa-0007RM-Rh
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAHNCFU9132317
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:48 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2way2xwqtv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:47 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sun, 17 Nov 2019 23:20:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Nov 2019 23:20:43 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAHNKg5t61145118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Nov 2019 23:20:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 162D742041;
 Sun, 17 Nov 2019 23:20:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA0AF4203F;
 Sun, 17 Nov 2019 23:20:41 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 17 Nov 2019 23:20:41 +0000 (GMT)
Subject: [PATCH for-5.0 2/4] xics: Link ICP_PROP_XICS property to
 ICPState::xics pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Nov 2019 00:20:41 +0100
In-Reply-To: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111723-0016-0000-0000-000002C634C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111723-0017-0000-0000-00003327E25D
Message-Id: <157403284152.409804.17114564311521923733.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_05:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=638 priorityscore=1501
 clxscore=1034 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911170222
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

The ICP object has both a pointer and an ICP_PROP_XICS property pointing
to the XICS fabric. Confusing bugs could arise if these ever go out of
sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index f7a454808992..35dddb88670e 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -310,15 +310,7 @@ static void icp_realize(DeviceState *dev, Error **errp)
     Object *obj;
     Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), ICP_PROP_XICS, &err);
-    if (!obj) {
-        error_propagate_prepend(errp, err,
-                                "required link '" ICP_PROP_XICS
-                                "' not found: ");
-        return;
-    }
-
-    icp->xics = XICS_FABRIC(obj);
+    assert(icp->xics);
 
     obj = object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
     if (!obj) {
@@ -368,12 +360,19 @@ static void icp_unrealize(DeviceState *dev, Error **errp)
     vmstate_unregister(NULL, &vmstate_icp_server, icp);
 }
 
+static Property icp_properties[] = {
+    DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
+                     XICSFabric *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
+    dc->props = icp_properties;
     /*
      * Reason: part of XICS interrupt controller, needs to be wired up
      * by icp_create().
@@ -397,9 +396,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     obj = object_new(type);
     object_property_add_child(cpu, type, obj, &error_abort);
     object_unref(obj);
-    object_ref(OBJECT(xi));
-    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
-                                   &error_abort);
+    object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
     object_ref(cpu);
     object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
@@ -417,7 +414,6 @@ void icp_destroy(ICPState *icp)
     Object *obj = OBJECT(icp);
 
     object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abort));
-    object_unref(object_property_get_link(obj, ICP_PROP_XICS, &error_abort));
     object_unparent(obj);
 }
 


