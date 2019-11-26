Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C812C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF28220659
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF28220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZe1W-0008Qb-39
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZdyx-0006LB-OT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZdyw-0006ZN-7K
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZdyv-0006Yi-SU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:30 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQGK7Lw121884
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wh0nj3hsk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:28 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 26 Nov 2019 16:46:26 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Nov 2019 16:46:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAQGkNwt29426020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 16:46:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E6AFA405B;
 Tue, 26 Nov 2019 16:46:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C50CA405C;
 Tue, 26 Nov 2019 16:46:23 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 16:46:23 +0000 (GMT)
Subject: [for-5.0 PATCH v2 2/4] spapr: Pass the maximum number of vCPUs to
 the KVM interrupt controller
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Nov 2019 17:46:23 +0100
In-Reply-To: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112616-0020-0000-0000-0000038F4BA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112616-0021-0000-0000-000021E64FCB
Message-Id: <157478678301.67101.2717368060417156338.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_04:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1034 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=2 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260139
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

The XIVE and XICS-on-XIVE KVM devices on POWER9 hosts can greatly reduce
their consumption of some scarce HW resources, namely Virtual Presenter
identifiers, if they know the maximum number of vCPUs that may run in the
VM.

Prepare ground for this by passing the value down to xics_kvm_connect()
and kvmppc_xive_connect(). This is purely mechanical, no functional
change.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    6 ++++--
 hw/intc/spapr_xive_kvm.c    |    3 ++-
 hw/intc/xics_kvm.c          |    3 ++-
 hw/intc/xics_spapr.c        |    5 +++--
 hw/ppc/spapr_irq.c          |    8 +++++---
 include/hw/ppc/spapr_irq.h  |   10 ++++++++--
 include/hw/ppc/spapr_xive.h |    3 ++-
 include/hw/ppc/xics_spapr.h |    3 ++-
 8 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 729246e906c9..8364f61c786c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -651,12 +651,14 @@ static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
                      plat_res_int_priorities, sizeof(plat_res_int_priorities)));
 }
 
-static int spapr_xive_activate(SpaprInterruptController *intc, Error **errp)
+static int spapr_xive_activate(SpaprInterruptController *intc,
+                               uint32_t nr_servers, Error **errp)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
 
     if (kvm_enabled()) {
-        int rc = spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
+        int rc = spapr_irq_init_kvm(kvmppc_xive_connect, intc, nr_servers,
+                                    errp);
         if (rc < 0) {
             return rc;
         }
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 69e73552f1ef..46c7609bd8d0 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -728,7 +728,8 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
  * All the XIVE memory regions are now backed by mappings from the KVM
  * XIVE device.
  */
-int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
+int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
+                        Error **errp)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc = &xive->source;
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 954c424b3652..a1f1b7b0d37c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -342,7 +342,8 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
     }
 }
 
-int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
+int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
+                     Error **errp)
 {
     ICSState *ics = ICS_SPAPR(intc);
     int rc;
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index b3705dab0e8a..8ae4f41459c3 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -422,10 +422,11 @@ static int xics_spapr_post_load(SpaprInterruptController *intc, int version_id)
     return 0;
 }
 
-static int xics_spapr_activate(SpaprInterruptController *intc, Error **errp)
+static int xics_spapr_activate(SpaprInterruptController *intc,
+                               uint32_t nr_servers, Error **errp)
 {
     if (kvm_enabled()) {
-        return spapr_irq_init_kvm(xics_kvm_connect, intc, errp);
+        return spapr_irq_init_kvm(xics_kvm_connect, intc, nr_servers, errp);
     }
     return 0;
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d4a54afc8662..07e08d6544a0 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -70,15 +70,16 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
 
-int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
+int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
                        SpaprInterruptController *intc,
+                       uint32_t nr_servers,
                        Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     Error *local_err = NULL;
 
     if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        if (fn(intc, &local_err) < 0) {
+        if (fn(intc, nr_servers, &local_err) < 0) {
             if (machine_kernel_irqchip_required(machine)) {
                 error_prepend(&local_err,
                               "kernel_irqchip requested but unavailable: ");
@@ -481,6 +482,7 @@ static void set_active_intc(SpaprMachineState *spapr,
                             SpaprInterruptController *new_intc)
 {
     SpaprInterruptControllerClass *sicc;
+    uint32_t nr_servers = spapr_max_server_number(spapr);
 
     assert(new_intc);
 
@@ -498,7 +500,7 @@ static void set_active_intc(SpaprMachineState *spapr,
 
     sicc = SPAPR_INTC_GET_CLASS(new_intc);
     if (sicc->activate) {
-        sicc->activate(new_intc, &error_fatal);
+        sicc->activate(new_intc, nr_servers, &error_fatal);
     }
 
     spapr->active_intc = new_intc;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ff814d13de37..ca8cb4421374 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -43,7 +43,8 @@ typedef struct SpaprInterruptController SpaprInterruptController;
 typedef struct SpaprInterruptControllerClass {
     InterfaceClass parent;
 
-    int (*activate)(SpaprInterruptController *intc, Error **errp);
+    int (*activate)(SpaprInterruptController *intc, uint32_t nr_servers,
+                    Error **errp);
     void (*deactivate)(SpaprInterruptController *intc);
 
     /*
@@ -98,8 +99,13 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
 void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
 int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp);
-int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
+
+typedef int (*SpaprInterruptControllerInitKvm)(SpaprInterruptController *,
+                                               uint32_t, Error **);
+
+int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
                        SpaprInterruptController *intc,
+                       uint32_t nr_servers,
                        Error **errp);
 
 /*
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 742b7e834f2a..3a103c224d44 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -66,7 +66,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
 /*
  * KVM XIVE device helpers
  */
-int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
+int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
+                        Error **errp);
 void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
 void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 28b87038c89a..1c65c96e3c7a 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,7 +32,8 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
 
-int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
+int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
+                     Error **errp);
 void xics_kvm_disconnect(SpaprInterruptController *intc);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
 


