Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D90C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83078206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hnUlETa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83078206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2uA-0007th-Ka
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i2-0003f1-Sd; Thu, 03 Sep 2020 23:48:18 -0400
Received: from ozlabs.org ([203.11.71.1]:53445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i0-0004zF-Qi; Thu, 03 Sep 2020 23:48:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNsv2gKJz9sWJ; Fri,  4 Sep 2020 13:47:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191251;
 bh=XKIMjGNwIAfcg9KlNAGb8EphqdBFc6RwVmnv8aujmlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hnUlETa1n3F7bmjTUE6sW2CLIO4BiATkiFApVie+8zdQDPk3Ia0dgiNapfbe0sPWZ
 FSRlS+Y51+DPCdDu4WoqzMX/6qTxJDoPSjlpPyy2IP0GQKEj7bUupe4ZGSdXGXiM53
 p/0fQbB8MWFDsfVHSW4su03xvu5JoxMdPZBLyyV4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 29/30] spapr,
 spapr_numa: move lookup-arrays handling to spapr_numa.c
Date: Fri,  4 Sep 2020 13:47:18 +1000
Message-Id: <20200904034719.673626-30-david@gibson.dropbear.id.au>
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

In a similar fashion as the previous patch, let's move the
handling of ibm,associativity-lookup-arrays from spapr.c to
spapr_numa.c. A spapr_numa_write_assoc_lookup_arrays() helper was
created, and spapr_dt_dynamic_reconfiguration_memory() can now
use it to advertise the lookup-arrays.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200903220639.563090-4-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 25 ++-----------------------
 hw/ppc/spapr_numa.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  2 ++
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index badfa86319..9bce1892b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -535,13 +535,10 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
                                                    void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
-    int nb_numa_nodes = machine->numa_state->num_nodes;
-    int ret, i, offset;
+    int ret, offset;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t prop_lmb_size[] = {cpu_to_be32(lmb_size >> 32),
                                 cpu_to_be32(lmb_size & 0xffffffff)};
-    uint32_t *int_buf, *cur_index, buf_len;
-    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
     MemoryDeviceInfoList *dimms = NULL;
 
     /*
@@ -582,25 +579,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
         return ret;
     }
 
-    /* ibm,associativity-lookup-arrays */
-    buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
-    cur_index = int_buf = g_malloc0(buf_len);
-    int_buf[0] = cpu_to_be32(nr_nodes);
-    int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
-    cur_index += 2;
-    for (i = 0; i < nr_nodes; i++) {
-        uint32_t associativity[] = {
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
-            cpu_to_be32(i)
-        };
-        memcpy(cur_index, associativity, sizeof(associativity));
-        cur_index += 4;
-    }
-    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
-            (cur_index - int_buf) * sizeof(uint32_t));
-    g_free(int_buf);
+    ret = spapr_numa_write_assoc_lookup_arrays(spapr, fdt, offset);
 
     return ret;
 }
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 1a1ec8bcff..5a82a84438 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -72,6 +72,40 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                        vcpu_assoc, sizeof(vcpu_assoc));
 }
 
+
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset)
+{
+    MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state->num_nodes;
+    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
+    uint32_t *int_buf, *cur_index, buf_len;
+    int ret, i;
+
+    /* ibm,associativity-lookup-arrays */
+    buf_len = (nr_nodes * MAX_DISTANCE_REF_POINTS + 2) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
+    int_buf[0] = cpu_to_be32(nr_nodes);
+     /* Number of entries per associativity list */
+    int_buf[1] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+    cur_index += 2;
+    for (i = 0; i < nr_nodes; i++) {
+        /*
+         * For the lookup-array we use the ibm,associativity array,
+         * from numa_assoc_array. without the first element (size).
+         */
+        uint32_t *associativity = spapr->numa_assoc_array[i];
+        memcpy(cur_index, ++associativity,
+               sizeof(uint32_t) * MAX_DISTANCE_REF_POINTS);
+        cur_index += MAX_DISTANCE_REF_POINTS;
+    }
+    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
+                      (cur_index - int_buf) * sizeof(uint32_t));
+    g_free(int_buf);
+
+    return ret;
+}
+
 /*
  * Helper that writes ibm,associativity-reference-points and
  * max-associativity-domains in the RTAS pointed by @rtas
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index 43c6a16fe3..b3fd950634 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -29,5 +29,7 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                                        int offset, int nodeid);
 int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                             int offset, PowerPCCPU *cpu);
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset);
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


