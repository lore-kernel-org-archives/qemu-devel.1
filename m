Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C642CC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9957C222C2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957C222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzpK-0001T1-Cw
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFznG-0008Bm-QM
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFznB-0007CI-KW
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23768
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFznB-0007Bm-GC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93Bvns8045930
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:01:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vddd9x3kq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:01:04 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:01:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:00:58 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C0vu122675624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:00:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 077534C05A;
 Thu,  3 Oct 2019 12:00:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C88394C040;
 Thu,  3 Oct 2019 12:00:56 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:00:56 +0000 (GMT)
Subject: [PATCH 1/7] spapr,
 xics: Get number of servers with a XICSFabricClass method
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:00:56 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0020-0000-0000-00000374A8C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0021-0000-0000-000021CAB256
Message-Id: <157010405465.246126.7760334967989385566.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
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

The number of servers, ie. upper bound of the highest VCPU id, is
currently only needed to generate the "interrupt-controller" node
in the DT. Soon it will be needed to inform the XICS-on-XIVE KVM
device that it can allocates less resources in the XIVE HW.

Add a method to XICSFabricClass for this purpose. Implement it
for sPAPR and use it to generate the "interrupt-controller" node.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |    7 +++++++
 hw/intc/xics_spapr.c  |    3 ++-
 hw/ppc/spapr.c        |    8 ++++++++
 include/hw/ppc/xics.h |    2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index dfe7dbd254ab..f82072935266 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -716,6 +716,13 @@ ICPState *xics_icp_get(XICSFabric *xi, int server)
     return xic->icp_get(xi, server);
 }
 
+uint32_t xics_nr_servers(XICSFabric *xi)
+{
+    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
+
+    return xic->nr_servers(xi);
+}
+
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
 {
     assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 6e5eb24b3cca..aa568ed0dc0d 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -311,8 +311,9 @@ static void ics_spapr_realize(DeviceState *dev, Error **errp)
 void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle)
 {
+    ICSState *ics = spapr->ics;
     uint32_t interrupt_server_ranges_prop[] = {
-        0, cpu_to_be32(nr_servers),
+        0, cpu_to_be32(xics_nr_servers(ics->xics)),
     };
     int node;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 514a17ae74d6..b8b9796c88e4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4266,6 +4266,13 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
     return cpu ? spapr_cpu_state(cpu)->icp : NULL;
 }
 
+static uint32_t spapr_nr_servers(XICSFabric *xi)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(xi);
+
+    return spapr_max_server_number(spapr);
+}
+
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
@@ -4423,6 +4430,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
+    xic->nr_servers = spapr_nr_servers;
     ispc->print_info = spapr_pic_print_info;
     /* Force NUMA node memory size to be a multiple of
      * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1e6a9300eb2b..e6bb1239e8f8 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -151,9 +151,11 @@ typedef struct XICSFabricClass {
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
     ICPState *(*icp_get)(XICSFabric *xi, int server);
+    uint32_t (*nr_servers)(XICSFabric *xi);
 } XICSFabricClass;
 
 ICPState *xics_icp_get(XICSFabric *xi, int server);
+uint32_t xics_nr_servers(XICSFabric *xi);
 
 /* Internal XICS interfaces */
 void icp_set_cppr(ICPState *icp, uint8_t cppr);


