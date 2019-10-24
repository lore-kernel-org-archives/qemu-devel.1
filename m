Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9252F2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9252F2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfUA-0003zl-MX
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNe5T-0003Cw-CG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNe5P-0004hf-Ag
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20588
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNe5P-0004gB-5H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9OEOHbW003495
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vucbgm3b3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:33 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 24 Oct 2019 15:27:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 15:27:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9OERSVu53149886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 14:27:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 421C8AE051;
 Thu, 24 Oct 2019 14:27:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12EECAE053;
 Thu, 24 Oct 2019 14:27:28 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 14:27:28 +0000 (GMT)
Subject: [PATCH 2/3] xive, xics: Fix reference counting on CPU objects
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 24 Oct 2019 16:27:27 +0200
In-Reply-To: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
References: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102414-0028-0000-0000-000003AEDB3B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102414-0029-0000-0000-000024710E01
Message-Id: <157192724770.3146912.15400869269097231255.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240135
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a VCPU gets connected to the XIVE interrupt controller, we add a
const link targetting the CPU object to the TCTX object. Similar links
are added to the ICP object when using the XICS interrupt controller.

As explained in <qom/object.h>:

 * The caller must ensure that @target stays alive as long as
 * this property exists.  In the case @target is a child of @obj,
 * this will be the case.  Otherwise, the caller is responsible for
 * taking a reference.

We're in the latter case for both XICS and XIVE. Add the missing
calls to object_ref() and object_unref().

This doesn't fix any known issue because the life cycle of the TCTX or
ICP happens to be shorter than the one of the CPU or XICS fabric, but
better safe than sorry.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c |    8 +++++++-
 hw/intc/xive.c |    6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 935f325749cb..5f746079be46 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -388,8 +388,10 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     obj = object_new(type);
     object_property_add_child(cpu, type, obj, &error_abort);
     object_unref(obj);
+    object_ref(OBJECT(xi));
     object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
                                    &error_abort);
+    object_ref(cpu);
     object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
@@ -403,7 +405,11 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
 
 void icp_destroy(ICPState *icp)
 {
-    object_unparent(OBJECT(icp));
+    Object *obj = OBJECT(icp);
+
+    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abort));
+    object_unref(object_property_get_link(obj, ICP_PROP_XICS, &error_abort));
+    object_unparent(obj);
 }
 
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 38257aa02083..952a461d5329 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -682,6 +682,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
     obj = object_new(TYPE_XIVE_TCTX);
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
+    object_ref(cpu);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
@@ -698,7 +699,10 @@ error:
 
 void xive_tctx_destroy(XiveTCTX *tctx)
 {
-    object_unparent(OBJECT(tctx));
+    Object *obj = OBJECT(tctx);
+
+    object_unref(object_property_get_link(obj, "cpu", &error_abort));
+    object_unparent(obj);
 }
 
 /*


