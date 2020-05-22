Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801ECC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466262070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466262070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDkY-00056U-Cr
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jcDjt-0004aE-Ov; Fri, 22 May 2020 15:53:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jcDjs-0005lZ-Eq; Fri, 22 May 2020 15:53:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04MJ2ted102490; Fri, 22 May 2020 15:53:39 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mm9u2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 15:53:38 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MJp8Tn003433;
 Fri, 22 May 2020 19:53:38 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 313wgshqjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 19:53:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04MJrbQr46858726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 19:53:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 365C9124052;
 Fri, 22 May 2020 19:53:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EEF2124054;
 Fri, 22 May 2020 19:53:36 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.65.206.192])
 by b01ledav002.gho.pok.ibm.com (Postfix) with SMTP;
 Fri, 22 May 2020 19:53:36 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id 0664C4607D4; Fri, 22 May 2020 14:53:34 -0500 (CDT)
From: Reza Arbab <arbab@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3] spapr: Add a new level of NUMA for GPUs
Date: Fri, 22 May 2020 14:53:33 -0500
Message-Id: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-22_07:2020-05-22,
 2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 suspectscore=2 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 15:53:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NUMA nodes corresponding to GPU memory currently have the same
affinity/distance as normal memory nodes. Add a third NUMA associativity
reference point enabling us to give GPU nodes more distance.

This is guest visible information, which shouldn't change under a
running guest across migration between different qemu versions, so make
the change effective only in new (pseries > 5.0) machine types.

Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):

node distances:
node   0   1   2   3   4   5
  0:  10  40  40  40  40  40
  1:  40  10  40  40  40  40
  2:  40  40  10  40  40  40
  3:  40  40  40  10  40  40
  4:  40  40  40  40  10  40
  5:  40  40  40  40  40  10

After:

node distances:
node   0   1   2   3   4   5
  0:  10  40  80  80  80  80
  1:  40  10  80  80  80  80
  2:  80  80  10  80  80  80
  3:  80  80  80  10  80  80
  4:  80  80  80  80  10  80
  5:  80  80  80  80  80  10

These are the same distances as on the host, mirroring the change made
to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
Add a new level of NUMA for GPU's").

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
v3:
* Squash into one patch
* Add PHB compat property
---
 hw/ppc/spapr.c              | 21 +++++++++++++++++++--
 hw/ppc/spapr_pci.c          |  2 ++
 hw/ppc/spapr_pci_nvlink2.c  |  7 ++++++-
 include/hw/pci-host/spapr.h |  1 +
 include/hw/ppc/spapr.h      |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c18eab0a2305..7c304b6c389d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -889,10 +889,16 @@ static int spapr_dt_rng(void *fdt)
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
+    uint32_t nr_refpoints = 3;
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
@@ -944,8 +950,12 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                      qemu_hypertas->str, qemu_hypertas->len));
     g_string_free(qemu_hypertas, TRUE);
 
+    if (smc->pre_5_1_assoc_refpoints) {
+        nr_refpoints = 2;
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-                     refpoints, sizeof(refpoints)));
+                     refpoints, nr_refpoints * sizeof(refpoints[0])));
 
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
@@ -4607,8 +4617,15 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+    static GlobalProperty compat[] = {
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-5.1-associativity", "on" },
+    };
+
     spapr_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    smc->pre_5_1_assoc_refpoints = true;
 }
 
 DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 61b84a392d65..bcdf1a25ae8b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2092,6 +2092,8 @@ static Property spapr_phb_properties[] = {
                      pcie_ecs, true),
     DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
     DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
+    DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
+                     pre_5_1_assoc, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 8332d5694e46..3394ac425eee 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         uint32_t associativity[] = {
             cpu_to_be32(0x4),
             SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
+            cpu_to_be32(nvslot->numa_id),
             SPAPR_GPU_NUMA_ID,
             cpu_to_be32(nvslot->numa_id)
         };
@@ -374,6 +374,11 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         _FDT(off);
         _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
         _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
+
+        if (sphb->pre_5_1_assoc) {
+            associativity[2] = SPAPR_GPU_NUMA_ID;
+        }
+
         _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
                           sizeof(associativity))));
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 8877ff51fbf7..600eb55c3488 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -94,6 +94,7 @@ struct SpaprPhbState {
     hwaddr nv2_gpa_win_addr;
     hwaddr nv2_atsd_win_addr;
     SpaprPhbPciNvGpuConfig *nvgpus;
+    bool pre_5_1_assoc;
 };
 
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e579eaf28c05..8316d9eea405 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -129,6 +129,7 @@ struct SpaprMachineClass {
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
+    bool pre_5_1_assoc_refpoints;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
-- 
2.18.2


