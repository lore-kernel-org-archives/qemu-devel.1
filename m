Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595EEC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C90620700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C90620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzsU-0005Kj-0M
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFzo8-0000Uv-Nu
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFzo7-0008MZ-7p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37692
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFzo6-0008LV-Vr
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93Bvn4c094432
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:02:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vdfcjtq24-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:02:05 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:02:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:02:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C206V44105894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:02:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CA8B52073;
 Thu,  3 Oct 2019 12:02:00 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B33752069;
 Thu,  3 Oct 2019 12:02:00 +0000 (GMT)
Subject: [PATCH 7/7] spapr: Set VSMT to smp_threads by default
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:02:00 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-4275-0000-0000-0000036DAAD0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-4276-0000-0000-00003880B0E1
Message-Id: <157010411885.246126.12610015369068227139.stgit@bahia.lan>
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

Support for setting VSMT is available in KVM since linux-4.13. Most distros
that support KVM on POWER already have it. It thus seem reasonable enough
to have the default machine to set VSMT to smp_threads.

This brings contiguous VCPU ids and thus brings their upper bound down to
the machine's max_cpus. This is especially useful for XIVE KVM devices,
which may thus allocate only one VP descriptor per VCPU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |    7 ++++++-
 include/hw/ppc/spapr.h |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8f59f08c102e..473ce1d04775 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2503,6 +2503,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *ms = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err = NULL;
     bool vsmt_user = !!spapr->vsmt;
     int kvm_smt = kvmppc_smt_threads();
@@ -2529,7 +2530,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
             goto out;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else {
+    } else if (!smc->smp_threads_vsmt) {
         /*
          * Default VSMT value is tricky, because we need it to be as
          * consistent as possible (for migration), but this requires
@@ -2538,6 +2539,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
          * overwhelmingly common case in production systems.
          */
         spapr->vsmt = MAX(8, smp_threads);
+    } else {
+        spapr->vsmt = smp_threads;
     }
 
     /* KVM: If necessary, set the SMT mode: */
@@ -4452,6 +4455,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
+    smc->smp_threads_vsmt = true;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -4519,6 +4523,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
     spapr_machine_4_2_class_options(mc);
     smc->linux_pci_probe = false;
+    smc->smp_threads_vsmt = false;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cbd1a4c9f390..2009eb64f9cb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -122,6 +122,7 @@ struct SpaprMachineClass {
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
+    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 


