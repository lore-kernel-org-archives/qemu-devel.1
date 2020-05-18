Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF644C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8152C205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1janZe-0002xt-KE
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1janYk-0001tC-Rd; Mon, 18 May 2020 17:44:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1janYj-0002cH-VG; Mon, 18 May 2020 17:44:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04ILXCHR008552; Mon, 18 May 2020 17:44:22 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312bg6h66e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 17:44:22 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04ILdMWG016511;
 Mon, 18 May 2020 21:44:21 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 313whab91d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 21:44:21 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04ILiKtI30081506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 21:44:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3E13AC05F;
 Mon, 18 May 2020 21:44:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 733E3AC059;
 Mon, 18 May 2020 21:44:20 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.65.195.60])
 by b01ledav006.gho.pok.ibm.com (Postfix) with SMTP;
 Mon, 18 May 2020 21:44:20 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id 97B1A46018A; Mon, 18 May 2020 16:44:18 -0500 (CDT)
From: Reza Arbab <arbab@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] spapr: Add a new level of NUMA for GPUs
Date: Mon, 18 May 2020 16:44:18 -0500
Message-Id: <20200518214418.18248-2-arbab@linux.ibm.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200518214418.18248-1-arbab@linux.ibm.com>
References: <20200518214418.18248-1-arbab@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180183
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 17:44:27
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>
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
 hw/ppc/spapr.c             | 11 +++++++++--
 hw/ppc/spapr_pci_nvlink2.c |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 88b4a1f17716..1d9193d5ee49 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -893,7 +893,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
     uint32_t nr_refpoints;
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
@@ -4544,7 +4548,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
     smc->nr_xirqs = SPAPR_NR_XIRQS;
-    smc->nr_assoc_refpoints = 2;
+    smc->nr_assoc_refpoints = 3;
     xfc->match_nvt = spapr_match_nvt;
 }
 
@@ -4611,8 +4615,11 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    smc->nr_assoc_refpoints = 2;
 }
 
 DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 8332d5694e46..247fd48731e2 100644
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
-- 
2.18.2


