Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9556C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648D02137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IU+WPk9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648D02137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWIw-0003pM-G4
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3v-0006wv-Pt; Tue, 08 Sep 2020 01:20:59 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57399 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3t-00067X-3y; Tue, 08 Sep 2020 01:20:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltky1CjRz9sW5; Tue,  8 Sep 2020 15:20:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542410;
 bh=fX7QZUTUPtMUGDf7k2tQmbRB6kOC1ryf16ziqC76d/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IU+WPk9pBQDvfZ6nMZhzuIapv5BzMbavSmitvae2W9Dwibrn97CN3iyjq5JmoBwRm
 qOtuzo+LYx6F5ecTJuKm+y0ik01vGJ0iYWROBFqqtxqenk7k54UrR+QgYXK7qrQEIH
 nSrI3cz4tBCYGNwJC8xb8JVKP4MVUrivTLsVDzNg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 31/33] spapr: move h_home_node_associativity to spapr_numa.c
Date: Tue,  8 Sep 2020 15:19:51 +1000
Message-Id: <20200908051953.1616885-32-david@gibson.dropbear.id.au>
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

The implementation of this hypercall will be modified to use
spapr->numa_assoc_arrays input. Moving it to spapr_numa.c makes
make more sense.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200904172422.617460-2-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 40 ---------------------------------------
 hw/ppc/spapr_numa.c  | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c1d01228c6..c2776b6a7d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1873,42 +1873,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return ret;
 }
 
-static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
-                                              SpaprMachineState *spapr,
-                                              target_ulong opcode,
-                                              target_ulong *args)
-{
-    target_ulong flags = args[0];
-    target_ulong procno = args[1];
-    PowerPCCPU *tcpu;
-    int idx;
-
-    /* only support procno from H_REGISTER_VPA */
-    if (flags != 0x1) {
-        return H_FUNCTION;
-    }
-
-    tcpu = spapr_find_cpu(procno);
-    if (tcpu == NULL) {
-        return H_P2;
-    }
-
-    /* sequence is the same as in the "ibm,associativity" property */
-
-    idx = 0;
-#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
-                             ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
-    args[idx++] = ASSOCIATIVITY(procno, -1);
-    for ( ; idx < 6; idx++) {
-        args[idx] = -1;
-    }
-#undef ASSOCIATIVITY
-
-    return H_SUCCESS;
-}
-
 static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
@@ -2139,10 +2103,6 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
-
-    /* Virtual Processor Home Node */
-    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
-                             h_home_node_associativity);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 9073dbbceb..e60587ce81 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -165,3 +165,48 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
 }
+
+static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
+                                              SpaprMachineState *spapr,
+                                              target_ulong opcode,
+                                              target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong procno = args[1];
+    PowerPCCPU *tcpu;
+    int idx;
+
+    /* only support procno from H_REGISTER_VPA */
+    if (flags != 0x1) {
+        return H_FUNCTION;
+    }
+
+    tcpu = spapr_find_cpu(procno);
+    if (tcpu == NULL) {
+        return H_P2;
+    }
+
+    /* sequence is the same as in the "ibm,associativity" property */
+
+    idx = 0;
+#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
+                             ((uint64_t)(b) & 0xffffffff))
+    args[idx++] = ASSOCIATIVITY(0, 0);
+    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
+    args[idx++] = ASSOCIATIVITY(procno, -1);
+    for ( ; idx < 6; idx++) {
+        args[idx] = -1;
+    }
+#undef ASSOCIATIVITY
+
+    return H_SUCCESS;
+}
+
+static void spapr_numa_register_types(void)
+{
+    /* Virtual Processor Home Node */
+    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
+                             h_home_node_associativity);
+}
+
+type_init(spapr_numa_register_types)
-- 
2.26.2


