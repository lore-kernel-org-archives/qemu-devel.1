Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB72C43215
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E252071E
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E252071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWTsY-0008PD-QC
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 18:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWTqg-0006c5-KF
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWTqf-0007St-Fh
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64126
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWTqf-0007Sl-AH
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:20:53 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAHNCJlf100875
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wayen5841-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 18:20:52 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sun, 17 Nov 2019 23:20:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Nov 2019 23:20:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAHNKlMP29360220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Nov 2019 23:20:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F24A11C050;
 Sun, 17 Nov 2019 23:20:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EAC411C04C;
 Sun, 17 Nov 2019 23:20:47 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 17 Nov 2019 23:20:47 +0000 (GMT)
Subject: [PATCH for-5.0 3/4] xics: Link ICP_PROP_CPU property to
 ICPState::cs pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Nov 2019 00:20:47 +0100
In-Reply-To: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111723-0020-0000-0000-00000388BC4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111723-0021-0000-0000-000021DEDF4D
Message-Id: <157403284709.409804.16142099083325945141.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_05:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=775 clxscore=1034
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911170222
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

The ICP object has both a pointer and an ICP_PROP_CPU property pointing
to the cpu. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 35dddb88670e..0b259a09c545 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -305,25 +305,13 @@ void icp_reset(ICPState *icp)
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp = ICP(dev);
-    PowerPCCPU *cpu;
     CPUPPCState *env;
-    Object *obj;
     Error *err = NULL;
 
     assert(icp->xics);
+    assert(icp->cs);
 
-    obj = object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
-    if (!obj) {
-        error_propagate_prepend(errp, err,
-                                "required link '" ICP_PROP_CPU
-                                "' not found: ");
-        return;
-    }
-
-    cpu = POWERPC_CPU(obj);
-    icp->cs = CPU(obj);
-
-    env = &cpu->env;
+    env = &POWERPC_CPU(icp->cs)->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
         icp->output = env->irq_inputs[POWER7_INPUT_INT];
@@ -363,6 +351,7 @@ static void icp_unrealize(DeviceState *dev, Error **errp)
 static Property icp_properties[] = {
     DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
+    DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -397,8 +386,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     object_property_add_child(cpu, type, obj, &error_abort);
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
-    object_ref(cpu);
-    object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort);
+    object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         object_unparent(obj);
@@ -413,7 +401,6 @@ void icp_destroy(ICPState *icp)
 {
     Object *obj = OBJECT(icp);
 
-    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abort));
     object_unparent(obj);
 }
 


