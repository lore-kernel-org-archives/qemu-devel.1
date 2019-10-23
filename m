Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F065BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CC621872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CC621872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNID2-0002ZY-4C
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNHzm-0000oo-Pm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNHzl-000463-3u
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53614
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNHzk-00045Z-Vp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9NEj7dp128863
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vtqg6ccum-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:16 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 23 Oct 2019 15:52:14 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 15:52:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9NEpcm829229436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 14:51:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2744FAE053;
 Wed, 23 Oct 2019 14:52:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2B1BAE05A;
 Wed, 23 Oct 2019 14:52:10 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2019 14:52:10 +0000 (GMT)
Subject: [PATCH 3/6] ppc: Reparent presenter objects to the interrupt
 controller object
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Oct 2019 16:52:10 +0200
In-Reply-To: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102314-0016-0000-0000-000002BC2A79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102314-0017-0000-0000-0000331D6B04
Message-Id: <157184233056.3053790.13073641279894392321.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230148
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each VCPU is associated to a presenter object within the interrupt
controller, ie. TCTX for XIVE and ICP for XICS, but our current
models put these objects below the VCPU, and we rely on CPU_FOREACH()
to do anything that involves presenters.

This recently bit us with the CAM line matching logic in XIVE because
CPU_FOREACH() can race with CPU hotplug and we ended up considering a
VCPU that wasn't associated to a TCTX object yet. Other users of
CPU_FOREACH() are 'info pic' for both XICS and XIVE. It is again very
easy to crash QEMU with concurrent VCPU hotplug/unplug and 'info pic'.

Reparent the presenter objects to the corresponding interrupt controller
object, ie. XIVE router or ICS, to make it clear they are not some extra
data hanging from the CPU but internal XIVE or XICS entities. The CPU
object now needs to explicitely take a reference on the presenter to
ensure its pointer remains valid until unrealize time.

This will allow to get rid of CPU_FOREACH() and ease further improvements
to the XIVE model.

This change doesn't impact section ids and is thus transparent to
migration.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c  |    6 +++++-
 hw/intc/xics.c        |    7 +++++--
 hw/intc/xics_spapr.c  |    8 ++++++--
 hw/intc/xive.c        |    4 +++-
 hw/ppc/pnv.c          |   17 +++++++++++++----
 include/hw/ppc/xics.h |    2 +-
 6 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b09cc48bcb61..d74ee71e76b4 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -526,6 +526,7 @@ static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
         return -1;
     }
 
+    object_ref(obj);
     spapr_cpu->tctx = XIVE_TCTX(obj);
     return 0;
 }
@@ -558,7 +559,10 @@ static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
 static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
                                         PowerPCCPU *cpu)
 {
-    xive_tctx_destroy(spapr_cpu_state(cpu)->tctx);
+    XiveTCTX *tctx = spapr_cpu_state(cpu)->tctx;
+
+    object_unref(OBJECT(tctx));
+    xive_tctx_destroy(tctx);
 }
 
 static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 5f746079be46..d5e4db668a4b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -380,13 +380,16 @@ static const TypeInfo icp_info = {
     .class_size = sizeof(ICPStateClass),
 };
 
-Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
+Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSFabric *xi,
+                   Error **errp)
 {
     Error *local_err = NULL;
+    g_autofree char *name = NULL;
     Object *obj;
 
     obj = object_new(type);
-    object_property_add_child(cpu, type, obj, &error_abort);
+    name = g_strdup_printf("%s[%d]", type, CPU(cpu)->cpu_index);
+    object_property_add_child(OBJECT(ics), name, obj, &error_abort);
     object_unref(obj);
     object_ref(OBJECT(xi));
     object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 5977d1bdb73f..080ed73aad64 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -337,11 +337,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterruptController *intc,
     Object *obj;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
-    obj = icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
+    obj = icp_create(OBJECT(cpu), TYPE_ICP, ics, ics->xics, errp);
     if (!obj) {
         return -1;
     }
 
+    object_ref(obj);
     spapr_cpu->icp = ICP(obj);
     return 0;
 }
@@ -355,7 +356,10 @@ static void xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
 static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
                                         PowerPCCPU *cpu)
 {
-    icp_destroy(spapr_cpu_state(cpu)->icp);
+    ICPState *icp = spapr_cpu_state(cpu)->icp;
+
+    object_unref(OBJECT(icp));
+    icp_destroy(icp);
 }
 
 static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 952a461d5329..8d2da4a11163 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -677,10 +677,12 @@ static const TypeInfo xive_tctx_info = {
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
 {
     Error *local_err = NULL;
+    g_autofree char *name = NULL;
     Object *obj;
 
     obj = object_new(TYPE_XIVE_TCTX);
-    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
+    name = g_strdup_printf(TYPE_XIVE_TCTX "[%d]", CPU(cpu)->cpu_index);
+    object_property_add_child(OBJECT(xrtr), name, obj, &error_abort);
     object_unref(obj);
     object_ref(cpu);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bd17c3536dd5..cbeabf98bff6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -767,14 +767,16 @@ static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
     Error *local_err = NULL;
     Object *obj;
     PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+    Pnv8Chip *chip8 = PNV8_CHIP(chip);
 
-    obj = icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_machine()),
-                     &local_err);
+    obj = icp_create(OBJECT(cpu), TYPE_PNV_ICP, &chip8->psi.ics,
+                     XICS_FABRIC(qdev_get_machine()), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
+    object_ref(obj);
     pnv_cpu->intc = obj;
 }
 
@@ -788,7 +790,10 @@ static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
 
 static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 {
-    icp_destroy(ICP(pnv_cpu_state(cpu)->intc));
+    Object *intc = pnv_cpu_state(cpu)->intc;
+
+    object_unref(intc);
+    icp_destroy(ICP(intc));
 }
 
 /*
@@ -825,6 +830,7 @@ static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
         return;
     }
 
+    object_ref(obj);
     pnv_cpu->intc = obj;
 }
 
@@ -837,7 +843,10 @@ static void pnv_chip_power9_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
 
 static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 {
-    xive_tctx_destroy(XIVE_TCTX(pnv_cpu_state(cpu)->intc));
+    Object *intc = pnv_cpu_state(cpu)->intc;
+
+    object_unref(intc);
+    xive_tctx_destroy(XIVE_TCTX(intc));
 }
 
 /*
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 48a75aa4ab75..f4827e748fd8 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -179,7 +179,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon);
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
 
-Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
+Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSFabric *xi,
                    Error **errp);
 void icp_destroy(ICPState *icp);
 


