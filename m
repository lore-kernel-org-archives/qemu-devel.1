Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0CC00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3483C24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483C24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjr6-0008C8-FI
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjcH-0007YS-N9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjcG-0004Xd-4o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjcF-0004Vk-RL
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBuvPT002806
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wupyt0nj1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:00:14 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDC083757999486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:00:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 133A9A4068;
 Fri, 13 Dec 2019 12:00:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F7AA4064;
 Fri, 13 Dec 2019 12:00:07 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:00:07 +0000 (GMT)
Subject: [PATCH 07/13] ppc/pnv: Introduce PnvChipClass::intc_print_info()
 method
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:07 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0016-0000-0000-000002D47154
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0017-0000-0000-000033369CBB
Message-Id: <157623840755.360005.5002022339473369934.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1034
 adultscore=0 mlxlogscore=810 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130097
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

The pnv_pic_print_info() callback checks the type of the chip in order
to forward to the request appropriate interrupt controller. This can
be achieved with QOM. Introduce a method for this in the base chip class
and implement it in child classes.

This also prepares ground for the upcoming interrupt controller of POWER10
chips.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c         |   30 +++++++++++++++++++++++++-----
 include/hw/ppc/pnv.h |    1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index efc00f4cb67a..2a53e99bda2e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -832,6 +832,12 @@ static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
     pnv_cpu->intc = NULL;
 }
 
+static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                            Monitor *mon)
+{
+    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -889,6 +895,12 @@ static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
     pnv_cpu->intc = NULL;
 }
 
+static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                            Monitor *mon)
+{
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
+}
+
 static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
@@ -910,6 +922,11 @@ static void pnv_chip_power10_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
     pnv_cpu->intc = NULL;
 }
 
+static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                             Monitor *mon)
+{
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -1086,6 +1103,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
+    k->intc_print_info = pnv_chip_power8_intc_print_info;
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1107,6 +1125,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
+    k->intc_print_info = pnv_chip_power8_intc_print_info;
     k->isa_create = pnv_chip_power8_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1128,6 +1147,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
+    k->intc_print_info = pnv_chip_power8_intc_print_info;
     k->isa_create = pnv_chip_power8nvl_isa_create;
     k->dt_populate = pnv_chip_power8_dt_populate;
     k->pic_print_info = pnv_chip_power8_pic_print_info;
@@ -1299,6 +1319,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
+    k->intc_print_info = pnv_chip_power9_intc_print_info;
     k->isa_create = pnv_chip_power9_isa_create;
     k->dt_populate = pnv_chip_power9_dt_populate;
     k->pic_print_info = pnv_chip_power9_pic_print_info;
@@ -1379,6 +1400,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
+    k->intc_print_info = pnv_chip_power10_intc_print_info;
     k->isa_create = pnv_chip_power10_isa_create;
     k->dt_populate = pnv_chip_power10_dt_populate;
     k->pic_print_info = pnv_chip_power10_pic_print_info;
@@ -1575,11 +1597,9 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        if (pnv_chip_is_power9(pnv->chips[0])) {
-            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
-        } else {
-            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
-        }
+        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() */
+        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
+                                                           mon);
     }
 
     for (i = 0; i < pnv->num_chips; i++) {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c213bdd5ecd3..7d2402784d4b 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -133,6 +133,7 @@ typedef struct PnvChipClass {
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
+    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, Monitor *mon);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);


