Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7923C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8874820578
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oeXikVsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8874820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2o0-0006sx-NJ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 23:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i1-0003a5-9Y; Thu, 03 Sep 2020 23:48:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52997 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hy-0004yo-S1; Thu, 03 Sep 2020 23:48:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNst2qq9z9sWB; Fri,  4 Sep 2020 13:47:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191250;
 bh=w0gaD0fnoCPcwqc7oF2cauElCoYD0AjnH+kJtJ0zhA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oeXikVsbn7fL4HGFTA7ZroWs+X+eBrFTFiblMNPWgI2hKueaYdxeNNuQZnTg5Na6f
 aS/mD+AI2X9OWrBPc/LSg6B7cXoJ08BUDyB70rS/+X5Zxm+MitnGo3LTBYZ6GML0vr
 s4ioB+LIBVmcZO8FMKrfFrFQhvVs5F3asUu9U1/k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/30] ppc: introducing spapr_numa.c NUMA code helper
Date: Fri,  4 Sep 2020 13:47:14 +1000
Message-Id: <20200904034719.673626-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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

We're going to make changes in how spapr handles all
ibm,associativity* related properties to enhance our current NUMA
support.

At this moment we have associativity code scattered all around
spapr_* files, with hardcoded values and array sizes. This
makes it harder to change any NUMA specific parameters in
the future. Having everything in the same place allows not
only for easier tuning, but also easier understanding since all
NUMA related code is on the same file.

This patch introduces a new file to gather all NUMA/associativity
handling code in spapr, spapr_numa.c. To get things started, let's
remove associativity-reference-points and max-associativity-domains
code from spapr_dt_rtas() to a new helper called spapr_numa_write_rtas_dt().
This will decouple spapr_dt_rtas() from the NUMA changes that
are going to happen in those two properties.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200901125645.118026-2-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/meson.build          |  3 ++-
 hw/ppc/spapr.c              | 26 ++-----------------
 hw/ppc/spapr_numa.c         | 50 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h | 20 +++++++++++++++
 4 files changed, 74 insertions(+), 25 deletions(-)
 create mode 100644 hw/ppc/spapr_numa.c
 create mode 100644 include/hw/ppc/spapr_numa.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 918969b320..ffa2ec37fa 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -25,7 +25,8 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_irq.c',
   'spapr_tpm_proxy.c',
   'spapr_nvdimm.c',
-  'spapr_rtas_ddw.c'
+  'spapr_rtas_ddw.c',
+  'spapr_numa.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0a04443fb..a45912acac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -81,6 +81,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
+#include "hw/ppc/spapr_numa.h"
 
 #include "monitor/monitor.h"
 
@@ -891,16 +892,9 @@ static int spapr_dt_rng(void *fdt)
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = {
-        cpu_to_be32(0x4),
-        cpu_to_be32(0x4),
-        cpu_to_be32(0x2),
-    };
-    uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
@@ -910,14 +904,6 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
         cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
     };
-    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
-    uint32_t maxdomains[] = {
-        cpu_to_be32(4),
-        maxdomain,
-        maxdomain,
-        maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
-    };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
@@ -953,15 +939,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                      qemu_hypertas->str, qemu_hypertas->len));
     g_string_free(qemu_hypertas, TRUE);
 
-    if (smc->pre_5_1_assoc_refpoints) {
-        nr_refpoints = 2;
-    }
-
-    _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-                     refpoints, nr_refpoints * sizeof(refpoints[0])));
-
-    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
-                     maxdomains, sizeof(maxdomains)));
+    spapr_numa_write_rtas_dt(spapr, fdt, rtas);
 
     /*
      * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
new file mode 100644
index 0000000000..cdf3288cbd
--- /dev/null
+++ b/hw/ppc/spapr_numa.c
@@ -0,0 +1,50 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition NUMA associativity handling
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Authors:
+ *  Daniel Henrique Barboza      <danielhb413@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/ppc/spapr_numa.h"
+#include "hw/ppc/fdt.h"
+
+/*
+ * Helper that writes ibm,associativity-reference-points and
+ * max-associativity-domains in the RTAS pointed by @rtas
+ * in the DT @fdt.
+ */
+void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
+{
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
+    uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
+    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+    uint32_t maxdomains[] = {
+        cpu_to_be32(4),
+        maxdomain,
+        maxdomain,
+        maxdomain,
+        cpu_to_be32(spapr->gpu_numa_id),
+    };
+
+    if (smc->pre_5_1_assoc_refpoints) {
+        nr_refpoints = 2;
+    }
+
+    _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
+                     refpoints, nr_refpoints * sizeof(refpoints[0])));
+
+    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
+                     maxdomains, sizeof(maxdomains)));
+}
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
new file mode 100644
index 0000000000..7a370a8768
--- /dev/null
+++ b/include/hw/ppc/spapr_numa.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition NUMA associativity handling
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Authors:
+ *  Daniel Henrique Barboza      <danielhb413@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPAPR_NUMA_H
+#define HW_SPAPR_NUMA_H
+
+#include "hw/ppc/spapr.h"
+
+void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
+
+#endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


