Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F8C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F88A2465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F88A2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjkQ-0007ob-SZ
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjbz-0007Ha-NN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjby-00040x-9Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjby-000408-0l
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBuw3r008357
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsdnqhh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:56 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 11:59:54 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 11:59:52 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDBxp4058327072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 11:59:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6927042042;
 Fri, 13 Dec 2019 11:59:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 379FE42041;
 Fri, 13 Dec 2019 11:59:51 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 11:59:51 +0000 (GMT)
Subject: [PATCH 04/13] ppc/pnv: Introduce PnvMachineClass and
 PnvMachineClass::compat
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 12:59:50 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121311-0028-0000-0000-000003C82A48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121311-0029-0000-0000-0000248B6789
Message-Id: <157623839085.360005.4046508784077843216.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1034 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The pnv_dt_create() function generates different contents for the
"compatible" property of the root node in the DT, depending on the
CPU type. This is open coded with multiple ifs using pnv_is_powerXX()
helpers.

It seems cleaner to achieve with QOM. Introduce a base class for the
powernv machine and a compat attribute that each child class can use
to provide the value for the "compatible" property.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c         |   33 +++++++++++++++++++--------------
 include/hw/ppc/pnv.h |   13 +++++++++++++
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0be0b6b411c3..5ac149b149d8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -484,9 +484,7 @@ static void pnv_dt_power_mgt(void *fdt)
 
 static void *pnv_dt_create(MachineState *machine)
 {
-    const char plat_compat8[] = "qemu,powernv8\0qemu,powernv\0ibm,powernv";
-    const char plat_compat9[] = "qemu,powernv9\0ibm,powernv";
-    const char plat_compat10[] = "qemu,powernv10\0ibm,powernv";
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     PnvMachineState *pnv = PNV_MACHINE(machine);
     void *fdt;
     char *buf;
@@ -504,17 +502,8 @@ static void *pnv_dt_create(MachineState *machine)
     _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));
     _FDT((fdt_setprop_string(fdt, 0, "model",
                              "IBM PowerNV (emulated by qemu)")));
-    if (pnv_is_power10(pnv)) {
-        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat10,
-                          sizeof(plat_compat10))));
-    } else if (pnv_is_power9(pnv)) {
-        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat9,
-                          sizeof(plat_compat9))));
-    } else {
-        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat8,
-                          sizeof(plat_compat8))));
-    }
-
+    _FDT((fdt_setprop(fdt, 0, "compatible", pmc->compat,
+                      sizeof(pmc->compat))));
 
     buf =  qemu_uuid_unparse_strdup(&qemu_uuid);
     _FDT((fdt_setprop_string(fdt, 0, "vm,uuid", buf)));
@@ -1692,6 +1681,8 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     XICSFabricClass *xic = XICS_FABRIC_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv8\0qemu,powernv\0ibm,powernv";
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER8";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
@@ -1699,26 +1690,39 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
     xic->icp_get = pnv_icp_get;
     xic->ics_get = pnv_ics_get;
     xic->ics_resend = pnv_ics_resend;
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
 }
 
 static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv9\0ibm,powernv";
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     xfc->match_nvt = pnv_match_nvt;
 
     mc->alias = "powernv";
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
 }
 
 static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv10\0ibm,powernv";
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v1.0");
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
 }
 
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
@@ -1796,6 +1800,7 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(PnvMachineState),
         .instance_init = pnv_machine_instance_init,
         .class_init    = pnv_machine_class_init,
+        .class_size    = sizeof(PnvMachineClass),
         .interfaces = (InterfaceInfo[]) {
             { TYPE_INTERRUPT_STATS_PROVIDER },
             { },
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 92f80b1ccead..d534746bd493 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -185,6 +185,19 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
 #define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
 #define PNV_MACHINE(obj) \
     OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
+#define PNV_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(PnvMachineClass, obj, TYPE_PNV_MACHINE)
+#define PNV_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(PnvMachineClass, klass, TYPE_PNV_MACHINE)
+
+typedef struct PnvMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+
+    /*< public >*/
+    const char *compat;
+    int compat_size;
+} PnvMachineClass;
 
 typedef struct PnvMachineState {
     /*< private >*/


