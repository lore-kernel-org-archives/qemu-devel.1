Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908CC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAAC2071E
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAAC2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWTsY-0008MI-9y
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 18:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWTqX-0006Qu-Jk
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWTqW-0007Q6-Gg
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWTqW-0007Pi-8h
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAHNCN5P145373
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2way8kdf1e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:42 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sun, 17 Nov 2019 23:20:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Nov 2019 23:20:37 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAHNKaPu56426640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Nov 2019 23:20:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FAADA4040;
 Sun, 17 Nov 2019 23:20:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50E0CA404D;
 Sun, 17 Nov 2019 23:20:36 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 17 Nov 2019 23:20:36 +0000 (GMT)
Subject: [PATCH for-5.0 1/4] xics: Link ICS_PROP_XICS property to
 ICSState::xics pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Nov 2019 00:20:36 +0100
In-Reply-To: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111723-0028-0000-0000-000003B970AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111723-0029-0000-0000-0000247C86E6
Message-Id: <157403283596.409804.17347207690271971987.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_05:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1034 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxlogscore=519 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The ICS object has both a pointer and an ICS_PROP_XICS property pointing
to the XICS fabric. Confusing bugs could arise if these ever go out of
sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c     |   13 +++----------
 hw/ppc/pnv_psi.c   |    3 +--
 hw/ppc/spapr_irq.c |    9 ++-------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e7ac9ba618fa..f7a454808992 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -609,17 +609,8 @@ static void ics_reset_handler(void *dev)
 static void ics_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics = ICS(dev);
-    Error *local_err = NULL;
-    Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &local_err);
-    if (!obj) {
-        error_propagate_prepend(errp, local_err,
-                                "required link '" ICS_PROP_XICS
-                                "' not found: ");
-        return;
-    }
-    ics->xics = XICS_FABRIC(obj);
+    assert(ics->xics);
 
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
@@ -699,6 +690,8 @@ static const VMStateDescription vmstate_ics = {
 
 static Property ics_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
+    DEFINE_PROP_LINK(ICS_PROP_XICS, ICSState, xics, TYPE_XICS_FABRIC,
+                     XICSFabric *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index a360515a86f8..7e725aaf2bd5 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -497,8 +497,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
     }
 
     /* Create PSI interrupt control source */
-    object_property_add_const_link(OBJECT(ics), ICS_PROP_XICS, obj,
-                                   &error_abort);
+    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abort);
     object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 168044be853a..487c8ceb35a3 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -319,13 +319,8 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
             return;
         }
 
-        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
-                                       &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
+        object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
+                                 &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_err);
         if (local_err) {
             error_propagate(errp, local_err);


