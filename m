Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4ABCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F130E21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F130E21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNI8r-0007A2-MD
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNI0B-0000qt-0W
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNI08-0004Nx-C9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNI06-0004Eb-QK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9NEjsn5055204
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vtr77a4m8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:28 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 23 Oct 2019 15:52:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 15:52:23 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9NEqMBW62521360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 14:52:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D0A25204F;
 Wed, 23 Oct 2019 14:52:22 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1583C5204E;
 Wed, 23 Oct 2019 14:52:22 +0000 (GMT)
Subject: [PATCH 5/6] spapr: Don't use CPU_FOREACH() in 'info pic'
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Oct 2019 16:52:21 +0200
In-Reply-To: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102314-0020-0000-0000-0000037D2E47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102314-0021-0000-0000-000021D37080
Message-Id: <157184234176.3053790.8577967462603127139.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=400 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230148
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that presenter objects are parented to the interrupt controller, stop
relying on CPU_FOREACH() which can race with CPU hotplug and crash QEMU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c  |    8 +-------
 hw/intc/xics.c        |   12 ++++++++++++
 hw/intc/xics_spapr.c  |    8 +-------
 hw/intc/xive.c        |   12 ++++++++++++
 include/hw/ppc/xics.h |    1 +
 include/hw/ppc/xive.h |    2 ++
 6 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d74ee71e76b4..05763a58cf5d 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -579,14 +579,8 @@ static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
 static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
-    }
 
+    xive_presenter_print_info(XIVE_ROUTER(intc), mon);
     spapr_xive_pic_print_info(xive, mon);
 }
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d5e4db668a4b..6e820c4851f3 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -88,6 +88,18 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
     }
 }
 
+static int do_ics_pic_print_icp_infos(Object *child, void *opaque)
+{
+    icp_pic_print_info(ICP(child), opaque);
+    return 0;
+}
+
+void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monitor *mon)
+{
+    object_child_foreach_type(OBJECT(ics), type, do_ics_pic_print_icp_infos,
+                              mon);
+}
+
 /*
  * ICP: Presentation layer
  */
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 080ed73aad64..7624d693c8da 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -400,14 +400,8 @@ static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, int val)
 static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
 {
     ICSState *ics = ICS_SPAPR(intc);
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
-    }
 
+    ics_pic_print_icp_infos(ics, TYPE_ICP, mon);
     ics_pic_print_info(ics, mon);
 }
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8d2da4a11163..40ce43152456 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -547,6 +547,18 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
     }
 }
 
+static int do_xive_presenter_print_info(Object *child, void *opaque)
+{
+    xive_tctx_pic_print_info(XIVE_TCTX(child), opaque);
+    return 0;
+}
+
+void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon)
+{
+    object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
+                              do_xive_presenter_print_info, mon);
+}
+
 void xive_tctx_reset(XiveTCTX *tctx)
 {
     memset(tctx->regs, 0, sizeof(tctx->regs));
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index f4827e748fd8..4de1f421c997 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -175,6 +175,7 @@ static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
+void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monitor *mon);
 
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8fd439ec9bba..14690428a0aa 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -367,6 +367,8 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
 XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
 
+void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon);
+
 /*
  * XIVE END ESBs
  */


