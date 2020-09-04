Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6531206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oNMRcjlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6531206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2xU-0006GV-1l
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i3-0003h1-JD; Thu, 03 Sep 2020 23:48:19 -0400
Received: from ozlabs.org ([203.11.71.1]:46167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i1-000516-8g; Thu, 03 Sep 2020 23:48:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNsv6fFdz9sWM; Fri,  4 Sep 2020 13:47:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191251;
 bh=XSpBWmFyYj88nACJUCsf9h+Hs9cFaKkV5n5bNRH2Dkw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oNMRcjlMa6IOHqgRAo6PvHFr1KaJgHRFWy62x0vPUv1F1Zkqa6thqBKsg69VomKv+
 pH72mZPQFu0bBtjcVkpmfTnmYZ1IObwAA4fi4U9nOLwSIsu5EBde5aKsI8OphRfoyB
 lmuB1FvKcZadUGlaV/g/ZU6YLlk1uUNsN1FAiFnE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 30/30] spapr_numa: move NVLink2 associativity handling to
 spapr_numa.c
Date: Fri,  4 Sep 2020 13:47:19 +1000
Message-Id: <20200904034719.673626-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 23:47:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The NVLink2 GPUs works like a regular NUMA node with its
own associativity values, regardless of user input.

This can be handled inside spapr_numa_associativity_init(),
initializing NVGPU_MAX_NUM associativity arrays that can
be used by the GPUs.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200903220639.563090-5-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_numa.c        | 28 +++++++++++++++++++++++++++-
 hw/ppc/spapr_pci_nvlink2.c | 20 +++-----------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 5a82a84438..93a000b729 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -13,14 +13,18 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/ppc/spapr_numa.h"
+#include "hw/pci-host/spapr.h"
 #include "hw/ppc/fdt.h"
 
+/* Moved from hw/ppc/spapr_pci_nvlink2.c */
+#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
 
 void spapr_numa_associativity_init(SpaprMachineState *spapr,
                                    MachineState *machine)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int nb_numa_nodes = machine->numa_state->num_nodes;
-    int i;
+    int i, j, max_nodes_with_gpus;
 
     /*
      * For all associativity arrays: first position is the size,
@@ -35,6 +39,28 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
         spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
         spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
     }
+
+    /*
+     * Initialize NVLink GPU associativity arrays. We know that
+     * the first GPU will take the first available NUMA id, and
+     * we'll have a maximum of NVGPU_MAX_NUM GPUs in the machine.
+     * At this point we're not sure if there are GPUs or not, but
+     * let's initialize the associativity arrays and allow NVLink
+     * GPUs to be handled like regular NUMA nodes later on.
+     */
+    max_nodes_with_gpus = nb_numa_nodes + NVGPU_MAX_NUM;
+
+    for (i = nb_numa_nodes; i < max_nodes_with_gpus; i++) {
+        spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+
+        for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
+            uint32_t gpu_assoc = smc->pre_5_1_assoc_refpoints ?
+                                 SPAPR_GPU_NUMA_ID : cpu_to_be32(i);
+            spapr->numa_assoc_array[i][j] = gpu_assoc;
+        }
+
+        spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
+    }
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 76ae77ebc8..8ef9b40a18 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/spapr.h"
+#include "hw/ppc/spapr_numa.h"
 #include "qemu/error-report.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
@@ -37,8 +38,6 @@
 #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
                                      ((gn) << 4) | (nn))
 
-#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
-
 typedef struct SpaprPhbPciNvGpuSlot {
         uint64_t tgt;
         uint64_t gpa;
@@ -360,13 +359,6 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
                                                     "nvlink2-mr[0]",
                                                     &error_abort);
-        uint32_t associativity[] = {
-            cpu_to_be32(0x4),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id)
-        };
         uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
         uint64_t mem_reg[2] = { cpu_to_be64(nvslot->gpa), cpu_to_be64(size) };
         char *mem_name = g_strdup_printf("memory@%"PRIx64, nvslot->gpa);
@@ -376,14 +368,8 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
         _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
 
-        if (sphb->pre_5_1_assoc) {
-            associativity[1] = SPAPR_GPU_NUMA_ID;
-            associativity[2] = SPAPR_GPU_NUMA_ID;
-            associativity[3] = SPAPR_GPU_NUMA_ID;
-        }
-
-        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
-                          sizeof(associativity))));
+        spapr_numa_write_associativity_dt(SPAPR_MACHINE(qdev_get_machine()),
+                                          fdt, off, nvslot->numa_id);
 
         _FDT((fdt_setprop_string(fdt, off, "compatible",
                                  "ibm,coherent-device-memory")));
-- 
2.26.2


