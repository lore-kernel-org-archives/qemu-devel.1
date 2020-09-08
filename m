Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF9C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C202137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yl1sDALQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C202137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWGT-0008WV-Q6
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW4E-00078D-7o; Tue, 08 Sep 2020 01:21:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW4C-00069Q-Dn; Tue, 08 Sep 2020 01:21:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltky3N0vz9sW8; Tue,  8 Sep 2020 15:20:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542410;
 bh=2aC+dbpWPHXzmmzWXPNnUhq2/bQ7N61TboTErZgIzVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yl1sDALQnIDlK+L0PXKtnj16VH0eyP2zFocoroTm9HNrcSitri4jgOQDD22Kt3xwb
 4srwZdkq8jl8nTJB0Fgu1XNbU8glqi8X5QfG2c/F1S/JpAk5QHWjPFZ258t1Qj72EG
 iY3yG39T11q+q7/ZpaeyZuaEEfzdMsq3CPVmIOnw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 32/33] spapr_numa: create a vcpu associativity helper
Date: Tue,  8 Sep 2020 15:19:52 +1000
Message-Id: <20200908051953.1616885-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The work to be done in h_home_node_associativity() intersects
with what is already done in spapr_numa_fixup_cpu_dt(). This
patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
be used for both spapr_numa_fixup_cpu_dt() and
h_home_node_associativity().

While we're at it, use memcpy() instead of loop assignment
to created the returned array.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200904172422.617460-3-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_numa.c    | 31 ++++++++++++++++++-------------
 include/hw/ppc/spapr.h |  7 ++++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index e60587ce81..066ffc2a5f 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -71,31 +71,36 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
-int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
-                            int offset, PowerPCCPU *cpu)
+static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
+                                           PowerPCCPU *cpu)
 {
-    int vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
-    uint32_t vcpu_assoc[vcpu_assoc_size];
+    uint32_t *vcpu_assoc = g_new(uint32_t, VCPU_ASSOC_SIZE);
     int index = spapr_get_vcpu_id(cpu);
-    int i;
 
     /*
      * VCPUs have an extra 'cpu_id' value in ibm,associativity
      * compared to other resources. Increment the size at index
-     * 0, copy all associativity domains already set, then put
-     * cpu_id last.
+     * 0, put cpu_id last, then copy the remaining associativity
+     * domains.
      */
     vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
+    vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);
+    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id] + 1,
+           (VCPU_ASSOC_SIZE - 2) * sizeof(uint32_t));
 
-    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
-        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
-    }
+    return vcpu_assoc;
+}
+
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu)
+{
+    g_autofree uint32_t *vcpu_assoc = NULL;
 
-    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu);
 
     /* Advertise NUMA via ibm,associativity */
-    return fdt_setprop(fdt, offset, "ibm,associativity",
-                       vcpu_assoc, sizeof(vcpu_assoc));
+    return fdt_setprop(fdt, offset, "ibm,associativity", vcpu_assoc,
+                       VCPU_ASSOC_SIZE * sizeof(uint32_t));
 }
 
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9a63380801..e50a2672e3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -107,13 +107,18 @@ typedef enum {
 
 /*
  * NUMA related macros. MAX_DISTANCE_REF_POINTS was taken
- * from Taken from Linux kernel arch/powerpc/mm/numa.h.
+ * from Linux kernel arch/powerpc/mm/numa.h. It represents the
+ * amount of associativity domains for non-CPU resources.
  *
  * NUMA_ASSOC_SIZE is the base array size of an ibm,associativity
  * array for any non-CPU resource.
+ *
+ * VCPU_ASSOC_SIZE represents the size of ibm,associativity array
+ * for CPUs, which has an extra element (vcpu_id) in the end.
  */
 #define MAX_DISTANCE_REF_POINTS    4
 #define NUMA_ASSOC_SIZE            (MAX_DISTANCE_REF_POINTS + 1)
+#define VCPU_ASSOC_SIZE            (NUMA_ASSOC_SIZE + 1)
 
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
-- 
2.26.2


