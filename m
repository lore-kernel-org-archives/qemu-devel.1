Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFBA205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFBA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeW0-0003TZ-Rf
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNe5M-0002uR-K1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNe5J-0004bq-QS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNe5I-0004Zn-Qv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9OEO7Ot084739
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vucdrjaj8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:27 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 24 Oct 2019 15:27:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 15:27:23 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9OERMrO48627858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 14:27:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABBFBA4051;
 Thu, 24 Oct 2019 14:27:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70A6BA4053;
 Thu, 24 Oct 2019 14:27:22 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 14:27:22 +0000 (GMT)
Subject: [PATCH 1/3] ppc: Add intc_destroy() handlers to
 SpaprInterruptController/PnvChip
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 24 Oct 2019 16:27:22 +0200
In-Reply-To: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
References: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102414-0008-0000-0000-00000326DF19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102414-0009-0000-0000-00004A4612FB
Message-Id: <157192724208.3146912.7254684777515287626.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=713 adultscore=0 classifier=spam adjust=0 reason=mlx
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

SpaprInterruptControllerClass and PnvChipClass have an intc_create() method
that calls the appropriate routine, ie. icp_create() or xive_tctx_create(),
to establish the link between the VCPU and the presenter component of the
interrupt controller during realize.

There aren't any symmetrical call to be called when the VCPU gets unrealized
though. It is assumed that object_unparent() is the only thing to do.

This is questionable because the parenting logic around the CPU and
presenter objects is really an implementation detail of the interrupt
controller. It shouldn't be open-coded in the machine code.

Fix this by adding an intc_destroy() method that undoes what was done in
intc_create(). Also NULLify the presenter pointers to avoid having
stale pointers around. This will allow to reliably check if a vCPU has
a valid presenter.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c       |   10 ++++++++++
 hw/intc/xics.c             |    5 +++++
 hw/intc/xics_spapr.c       |   10 ++++++++++
 hw/intc/xive.c             |    5 +++++
 hw/ppc/pnv.c               |   21 +++++++++++++++++++++
 hw/ppc/pnv_core.c          |    7 ++++---
 hw/ppc/spapr_cpu_core.c    |    7 +------
 hw/ppc/spapr_irq.c         |   14 ++++++++++++++
 include/hw/ppc/pnv.h       |    1 +
 include/hw/ppc/spapr_irq.h |    2 ++
 include/hw/ppc/xics.h      |    1 +
 include/hw/ppc/xive.h      |    1 +
 12 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d8e1291905c3..9cb8d38a3bab 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -555,6 +555,15 @@ static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
     xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
 }
 
+static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
+                                        PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    xive_tctx_destroy(spapr_cpu->tctx);
+    spapr_cpu->tctx = NULL;
+}
+
 static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
@@ -692,6 +701,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
     sicc->deactivate = spapr_xive_deactivate;
     sicc->cpu_intc_create = spapr_xive_cpu_intc_create;
     sicc->cpu_intc_reset = spapr_xive_cpu_intc_reset;
+    sicc->cpu_intc_destroy = spapr_xive_cpu_intc_destroy;
     sicc->claim_irq = spapr_xive_claim_irq;
     sicc->free_irq = spapr_xive_free_irq;
     sicc->set_irq = spapr_xive_set_irq;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 6da05763f9db..935f325749cb 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -401,6 +401,11 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     return obj;
 }
 
+void icp_destroy(ICPState *icp)
+{
+    object_unparent(OBJECT(icp));
+}
+
 /*
  * ICS: Source layer
  */
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 7418fb9f370c..b3705dab0e8a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -352,6 +352,15 @@ static void xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
     icp_reset(spapr_cpu_state(cpu)->icp);
 }
 
+static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
+                                        PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    icp_destroy(spapr_cpu->icp);
+    spapr_cpu->icp = NULL;
+}
+
 static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
                                 bool lsi, Error **errp)
 {
@@ -440,6 +449,7 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
     sicc->deactivate = xics_spapr_deactivate;
     sicc->cpu_intc_create = xics_spapr_cpu_intc_create;
     sicc->cpu_intc_reset = xics_spapr_cpu_intc_reset;
+    sicc->cpu_intc_destroy = xics_spapr_cpu_intc_destroy;
     sicc->claim_irq = xics_spapr_claim_irq;
     sicc->free_irq = xics_spapr_free_irq;
     sicc->set_irq = xics_spapr_set_irq;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f066be5eb5e3..38257aa02083 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -696,6 +696,11 @@ error:
     return NULL;
 }
 
+void xive_tctx_destroy(XiveTCTX *tctx)
+{
+    object_unparent(OBJECT(tctx));
+}
+
 /*
  * XIVE ESB helpers
  */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4a51fb65a834..68cc3c81aa75 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -778,6 +778,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
     pnv_cpu->intc = obj;
 }
 
+
 static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
 {
     PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
@@ -785,6 +786,14 @@ static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
     icp_reset(ICP(pnv_cpu->intc));
 }
 
+static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    icp_destroy(ICP(pnv_cpu->intc));
+    pnv_cpu->intc = NULL;
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -829,6 +838,14 @@ static void pnv_chip_power9_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
     xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
 }
 
+static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
+    pnv_cpu->intc = NULL;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -999,6 +1016,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->core_pir = pnv_chip_core_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
+    k->intc_destroy = pnv_chip_power8_intc_destroy;
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1019,6 +1037,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->core_pir = pnv_chip_core_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
+    k->intc_destroy = pnv_chip_power8_intc_destroy;
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1039,6 +1058,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->core_pir = pnv_chip_core_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
+    k->intc_destroy = pnv_chip_power8_intc_destroy;
     k->isa_create = pnv_chip_power8nvl_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1209,6 +1229,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     k->core_pir = pnv_chip_core_pir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
+    k->intc_destroy = pnv_chip_power9_intc_destroy;
     k->isa_create = pnv_chip_power9_isa_create;
     k->dt_populate = pnv_chip_power9_dt_populate;
     k->pic_print_info = pnv_chip_power9_pic_print_info;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e81cd3a3e047..61b3d3ce2250 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -269,11 +269,12 @@ err:
     error_propagate(errp, local_err);
 }
 
-static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
+static void pnv_core_cpu_unrealize(PowerPCCPU *cpu, PnvChip *chip)
 {
     PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
 
-    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
+    pcc->intc_destroy(chip, cpu);
     cpu_remove_sync(CPU(cpu));
     cpu->machine_data = NULL;
     g_free(pnv_cpu);
@@ -289,7 +290,7 @@ static void pnv_core_unrealize(DeviceState *dev, Error **errp)
     qemu_unregister_reset(pnv_core_reset, pc);
 
     for (i = 0; i < cc->nr_threads; i++) {
-        pnv_core_cpu_unrealize(pc->threads[i]);
+        pnv_core_cpu_unrealize(pc->threads[i], pc->chip);
     }
     g_free(pc->threads);
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ef7b27a66d56..8339c4c0f86b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -195,12 +195,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
     if (!sc->pre_3_0_migration) {
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
     }
-    if (spapr_cpu_state(cpu)->icp) {
-        object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
-    }
-    if (spapr_cpu_state(cpu)->tctx) {
-        object_unparent(OBJECT(spapr_cpu_state(cpu)->tctx));
-    }
+    spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b941608b69ba..168044be853a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -234,6 +234,20 @@ void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)
     }
 }
 
+void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cpu)
+{
+    SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(intcs); i++) {
+        SpaprInterruptController *intc = intcs[i];
+        if (intc) {
+            SpaprInterruptControllerClass *sicc = SPAPR_INTC_GET_CLASS(intc);
+            sicc->cpu_intc_destroy(intc, cpu);
+        }
+    }
+}
+
 static void spapr_set_irq(void *opaque, int irq, int level)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(opaque);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2a780e633f23..0b4c722e6b48 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,7 @@ typedef struct PnvChipClass {
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
+    void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 09232999b07e..ff814d13de37 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -53,6 +53,7 @@ typedef struct SpaprInterruptControllerClass {
     int (*cpu_intc_create)(SpaprInterruptController *intc,
                             PowerPCCPU *cpu, Error **errp);
     void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *cpu);
+    void (*cpu_intc_destroy)(SpaprInterruptController *intc, PowerPCCPU *cpu);
     int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
                      Error **errp);
     void (*free_irq)(SpaprInterruptController *intc, int irq);
@@ -70,6 +71,7 @@ void spapr_irq_update_active_intc(SpaprMachineState *spapr);
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
 void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu);
+void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cpu);
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 602173c12250..48a75aa4ab75 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -181,6 +181,7 @@ void icp_resend(ICPState *ss);
 
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
                    Error **errp);
+void icp_destroy(ICPState *icp);
 
 /* KVM */
 void icp_get_kvm_state(ICPState *icp);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 99381639f50c..8fd439ec9bba 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -416,6 +416,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size);
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
+void xive_tctx_destroy(XiveTCTX *tctx);
 
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_idx)
 {


