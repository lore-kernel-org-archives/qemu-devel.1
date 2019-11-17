Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D7C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5527B2071E
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5527B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWTuK-0002kF-Ho
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 18:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWTqp-0006j2-6k
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWTqm-0007Ux-Un
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:21:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWTqm-0007Ua-D2
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:21:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAHNCRi6028978
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wayf4dgs7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:59 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sun, 17 Nov 2019 23:20:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Nov 2019 23:20:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAHNKrj429360226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Nov 2019 23:20:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28E3CAE053;
 Sun, 17 Nov 2019 23:20:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03E43AE051;
 Sun, 17 Nov 2019 23:20:53 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 17 Nov 2019 23:20:52 +0000 (GMT)
Subject: [PATCH for-5.0 4/4] spapr: Abort if XICS interrupt controller
 cannot be initialized
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Nov 2019 00:20:52 +0100
In-Reply-To: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111723-0012-0000-0000-000003662F5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111723-0013-0000-0000-000021A1B26D
Message-Id: <157403285265.409804.8683093665795248192.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_05:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1034
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=988 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Failing to set any of the ICS property should really never happen:
- object_property_add_child() always succeed unless the child object
  already has a parent, which isn't the case here obviously since the
  ICS has just been created with object_new()
- the ICS has an "nr-irqs" property than can be set as long as the ICS
  isn't realized

In both cases, an error indicates there is a bug in QEMU. Propagating the
error, ie. exiting QEMU since spapr_irq_init() is called with &error_fatal
doesn't make much sense. Abort instead. This is consistent with what is
done with XIVE : both qdev_create() and qdev_prop_set_uint32() abort QEMU
on error.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 487c8ceb35a3..37f65dac9ca8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -313,20 +313,11 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         Object *obj;
 
         obj = object_new(TYPE_ICS_SPAPR);
-        object_property_add_child(OBJECT(spapr), "ics", obj, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
 
+        object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
-        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
+        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abort);
         object_property_set_bool(obj, true, "realized", &local_err);
         if (local_err) {
             error_propagate(errp, local_err);


