Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F83C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753A720700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753A720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzsE-0004x1-5O
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFznO-0008Ns-1v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFznM-0007PT-4I
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18958
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFznL-0007P6-VN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93BvFQ3020314
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:01:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vdfe1a91y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:01:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:01:17 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:01:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C1EBD43188412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:01:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBA85A406E;
 Thu,  3 Oct 2019 12:01:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C150FA4069;
 Thu,  3 Oct 2019 12:01:13 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:01:13 +0000 (GMT)
Subject: [PATCH 2/7] spapr,
 xive: Turn "nr-ends" property into "nr-servers" property
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:01:13 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-4275-0000-0000-0000036DAAC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-4276-0000-0000-00003880B0D6
Message-Id: <157010406203.246126.13381271918474281392.stgit@bahia.lan>
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

The sPAPR XIVE object has an nr_ends field which happens to be a
multiple of spapr_max_server_number(). It is currently set with
the help of "nr-ends" property. This is a bit unfortunate since
it exposes to the sPAPR irq frontend what should remain an
implemantation detail within the XIVE backend.

It will be possible soon to inform the XIVE KVM device about the
range of VCPU ids that may be used in the VM, as returned by the
spapr_max_server_number() function. This will allow the device
to substantially reduce the consumption of scarce resources
in the XIVE HW.

For both reasons, replace the "nr-ends" property with an "nr-servers"
one. The existing nr_ends field must be kept though since it tells how
many ENDs are migrated, it is derived from "nr-servers" at realize time
for simplicity. Convert spapr_dt_xive() to use it as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |   21 ++++++++++++++++-----
 hw/ppc/spapr_irq.c          |    2 +-
 include/hw/ppc/spapr_xive.h |    1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 04879abf2e7a..62888ddc68db 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -99,6 +99,15 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
     return 0;
 }
 
+static uint32_t spapr_xive_vcpu_id_to_end_idx(uint32_t vcpu_id)
+{
+    /*
+     * 8 XIVE END structures per CPU. One for each available
+     * priority
+     */
+    return vcpu_id << 3;
+}
+
 static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
                                   uint8_t *out_end_blk, uint32_t *out_end_idx)
 {
@@ -109,7 +118,7 @@ static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
     }
 
     if (out_end_idx) {
-        *out_end_idx = (cpu->vcpu_id << 3) + prio;
+        *out_end_idx = spapr_xive_vcpu_id_to_end_idx(cpu->vcpu_id) + prio;
     }
 }
 
@@ -283,11 +292,13 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!xive->nr_ends) {
-        error_setg(errp, "Number of interrupt needs to be greater 0");
+    if (!xive->nr_servers) {
+        error_setg(errp, "Number of interrupt servers must be greater than 0");
         return;
     }
 
+    xive->nr_ends = spapr_xive_vcpu_id_to_end_idx(xive->nr_servers);
+
     /*
      * Initialize the internal sources, for IPIs and virtual devices.
      */
@@ -489,7 +500,7 @@ static const VMStateDescription vmstate_spapr_xive = {
 
 static Property spapr_xive_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
-    DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
+    DEFINE_PROP_UINT32("nr-servers", SpaprXive, nr_servers, 0),
     DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
     DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE),
     DEFINE_PROP_END_OF_LIST(),
@@ -1550,7 +1561,7 @@ void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
     /* Interrupt number ranges for the IPIs */
     uint32_t lisn_ranges[] = {
         cpu_to_be32(0),
-        cpu_to_be32(nr_servers),
+        cpu_to_be32(xive->nr_servers),
     };
     /*
      * EQ size - the sizes of pages supported by the system 4K, 64K,
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 457eabe24cda..025fd00143a2 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -591,7 +591,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
          * 8 XIVE END structures per CPU. One for each available
          * priority
          */
-        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
+        qdev_prop_set_uint32(dev, "nr-servers", nr_servers);
         qdev_init_nofail(dev);
 
         spapr->xive = SPAPR_XIVE(dev);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0df20a6590a5..4a4a6fc6be7f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -22,6 +22,7 @@ typedef struct SpaprXive {
     /* Internal interrupt source for IPIs and virtual devices */
     XiveSource    source;
     hwaddr        vc_base;
+    uint32_t      nr_servers;
 
     /* END ESB MMIOs */
     XiveENDSource end_source;


