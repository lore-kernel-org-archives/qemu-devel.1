Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F2C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B17208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B17208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7dw-0004Mg-Qg
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jX7Hi-0004io-Jf; Fri, 08 May 2020 13:59:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jX7Hh-0002k1-61; Fri, 08 May 2020 13:59:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048HXm7c056383; Fri, 8 May 2020 13:59:32 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt449a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 13:59:32 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048HtLYx023932;
 Fri, 8 May 2020 17:59:31 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 30s0g88vgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 17:59:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048HxUOb55050590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 17:59:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC370AC05B;
 Fri,  8 May 2020 17:59:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31B3FAC059;
 Fri,  8 May 2020 17:59:30 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.65.228.143])
 by b01ledav006.gho.pok.ibm.com (Postfix) with SMTP;
 Fri,  8 May 2020 17:59:30 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id C0D854606EE; Fri,  8 May 2020 12:59:27 -0500 (CDT)
From: Reza Arbab <arbab@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] spapr: Add a new level of NUMA for GPUs
Date: Fri,  8 May 2020 12:59:27 -0500
Message-Id: <20200508175927.21791-1-arbab@linux.ibm.com>
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_16:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080147
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 13:59:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 May 2020 14:22:03 -0400
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
 hw/ppc/spapr.c             | 6 +++++-
 hw/ppc/spapr_pci_nvlink2.c | 8 +++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c18eab0a2305..53567f98f0c6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -892,7 +892,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 8332d5694e46..f2cb26019e88 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -37,8 +37,6 @@
 #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
                                      ((gn) << 4) | (nn))
 
-#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
-
 typedef struct SpaprPhbPciNvGpuSlot {
         uint64_t tgt;
         uint64_t gpa;
@@ -361,9 +359,9 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
                                                     "nvlink2-mr[0]", NULL);
         uint32_t associativity[] = {
             cpu_to_be32(0x4),
-            SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
+            cpu_to_be32(nvslot->numa_id),
+            cpu_to_be32(nvslot->numa_id),
+            cpu_to_be32(nvslot->numa_id),
             cpu_to_be32(nvslot->numa_id)
         };
         uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
-- 
2.18.1


