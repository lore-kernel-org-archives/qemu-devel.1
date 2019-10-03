Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37818222C4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37818222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzpf-0001ov-VC
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFznX-0008V3-VN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFznW-0007g8-Jl
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54922
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFznW-0007ew-EG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93BvehE075758
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:01:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vdg8m0tdh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:01:28 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:01:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:01:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C1N4G40894658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:01:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6F8842047;
 Thu,  3 Oct 2019 12:01:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 866FD42049;
 Thu,  3 Oct 2019 12:01:23 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:01:23 +0000 (GMT)
Subject: [PATCH 3/7] spapr, xics,
 xive: Drop nr_servers argument in DT-related functions
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:01:23 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0012-0000-0000-00000353AB8E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0013-0000-0000-0000218EB25D
Message-Id: <157010407899.246126.7691819104525548257.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030113
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

Both XICS and XIVE backends can access nr_servers by other means. No
need to pass it around anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    3 +--
 hw/intc/xics_spapr.c        |    3 +--
 hw/ppc/spapr.c              |    3 +--
 hw/ppc/spapr_irq.c          |    5 ++---
 include/hw/ppc/spapr_irq.h  |    3 +--
 include/hw/ppc/spapr_xive.h |    3 +--
 include/hw/ppc/xics_spapr.h |    3 +--
 7 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 62888ddc68db..56d851169cf6 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1552,8 +1552,7 @@ void spapr_xive_hcall_init(SpaprMachineState *spapr)
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
 
-void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle)
+void spapr_dt_xive(SpaprMachineState *spapr, void *fdt, uint32_t phandle)
 {
     SpaprXive *xive = spapr->xive;
     int node;
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index aa568ed0dc0d..015753c19c5d 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -308,8 +308,7 @@ static void ics_spapr_realize(DeviceState *dev, Error **errp)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
 
-void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle)
+void spapr_dt_xics(SpaprMachineState *spapr, void *fdt, uint32_t phandle)
 {
     ICSState *ics = spapr->ics;
     uint32_t interrupt_server_ranges_prop[] = {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b8b9796c88e4..8f59f08c102e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1255,8 +1255,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
-                          PHANDLE_INTC);
+    spapr->irq->dt_populate(spapr, fdt, PHANDLE_INTC);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 025fd00143a2..02e1b5503b65 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -368,11 +368,10 @@ static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor *mon)
     spapr_irq_current(spapr)->print_info(spapr, mon);
 }
 
-static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
-                                       uint32_t nr_servers, void *fdt,
+static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr, void *fdt,
                                        uint32_t phandle)
 {
-    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandle);
+    spapr_irq_current(spapr)->dt_populate(spapr, fdt, phandle);
 }
 
 static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 69a37f608e01..1736e503a8e9 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -45,8 +45,7 @@ typedef struct SpaprIrq {
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
     void (*free)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
-    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
-                        void *fdt, uint32_t phandle);
+    void (*dt_populate)(SpaprMachineState *spapr, void *fdt, uint32_t phandle);
     void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                             Error **errp);
     int (*post_load)(SpaprMachineState *spapr, int version_id);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 4a4a6fc6be7f..fae075d51815 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -61,8 +61,7 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
 int spapr_xive_post_load(SpaprXive *xive, int version_id);
 
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
-void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle);
+void spapr_dt_xive(SpaprMachineState *spapr, void *fdt, uint32_t phandle);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 0b35e85c266a..ecb67c6c340a 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,8 +32,7 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
 
-void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle);
+void spapr_dt_xics(SpaprMachineState *spapr, void *fdt, uint32_t phandle);
 int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);


