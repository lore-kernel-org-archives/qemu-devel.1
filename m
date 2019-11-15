Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82309206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82309206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdyc-0006d3-1O
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdwc-0004o2-VQ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdwb-0003XQ-Oe
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdwb-0003Wy-Fd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFgmSR011203
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nuhcx8t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:32 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:55:30 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:55:28 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAFFtRki35455278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:55:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 422FB11C05E;
 Fri, 15 Nov 2019 15:55:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1167511C064;
 Fri, 15 Nov 2019 15:55:27 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:55:26 +0000 (GMT)
Subject: [PATCH v2 for-5.0 1/8] xive: Link "cpu" property to XiveTCTX::cs
 pointer
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:55:26 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0016-0000-0000-000002C40281
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0017-0000-0000-00003325AAFF
Message-Id: <157383332669.165747.2484056603605646820.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1034 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=880 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911150142
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

The TCTX object has both a pointer and a "cpu" property pointing to the
vCPU object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 75dce82fb205..9376e84aff75 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -580,19 +580,11 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
     XiveTCTX *tctx = XIVE_TCTX(dev);
     PowerPCCPU *cpu;
     CPUPPCState *env;
-    Object *obj;
     Error *local_err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "cpu", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'cpu' not found: ");
-        return;
-    }
-
-    cpu = POWERPC_CPU(obj);
-    tctx->cs = CPU(obj);
+    assert(tctx->cs);
 
+    cpu = POWERPC_CPU(tctx->cs);
     env = &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
@@ -662,6 +654,11 @@ static const VMStateDescription vmstate_xive_tctx = {
     },
 };
 
+static Property xive_tctx_properties[] = {
+    DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xive_tctx_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -669,6 +666,7 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
     dc->desc = "XIVE Interrupt Thread Context";
     dc->realize = xive_tctx_realize;
     dc->vmsd = &vmstate_xive_tctx;
+    dc->props = xive_tctx_properties;
     /*
      * Reason: part of XIVE interrupt controller, needs to be wired up
      * by xive_tctx_create().
@@ -691,8 +689,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
     obj = object_new(TYPE_XIVE_TCTX);
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
-    object_ref(cpu);
-    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_link(obj, cpu, "cpu", &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
@@ -710,7 +707,6 @@ void xive_tctx_destroy(XiveTCTX *tctx)
 {
     Object *obj = OBJECT(tctx);
 
-    object_unref(object_property_get_link(obj, "cpu", &error_abort));
     object_unparent(obj);
 }
 


