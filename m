Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71AC47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DB120838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zs/mo7F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DB120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYjA-0000qR-D1
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYht-0007V4-Ht; Thu, 07 May 2020 01:04:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhr-00070M-Gv; Thu, 07 May 2020 01:04:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn4ztWz9sSm; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=F8qKptjSIPSTQGjLaBtQk0trTc8MzA+Ysu7dOVrTfrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zs/mo7F3SV4/XKhrlZPLffr/bhOQbYHWd40ncB3ddX6HFSSt+iU6TaBbjoCzKpQjU
 +xgdmNt2dwkxXGbJ3CXSXvcJBHGJhJq6qo0Ig4uKbCxlhyeCFwUmBUN2BLHCFXHzME
 OQVvplRn1Z7OZanjssfkZ9w3AuXwD8VBeTD0TZGA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/18] ppc/pnv: Add support for NMI interface
Date: Thu,  7 May 2020 15:02:14 +1000
Message-Id: <20200507050228.802395-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

This implements the NMI interface for the PNV machine, similarly to
commit 3431648272d ("spapr: Add support for new NMI interface") for
SPAPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200325144147.221875-3-npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c9cb6fa357..a3b7a8d0ff 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -27,6 +27,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/hw_accel.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "hw/ppc/fdt.h"
@@ -34,6 +35,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/loader.h"
+#include "hw/nmi.h"
 #include "exec/address-spaces.h"
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
@@ -1977,10 +1979,35 @@ static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
     }
 }
 
+static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    cpu_synchronize_state(cs);
+    ppc_cpu_do_system_reset(cs);
+    /*
+     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
+     * dependent. POWER processors use this for xscom triggered interrupts,
+     * which come from the BMC or NMI IPIs.
+     */
+    env->spr[SPR_SRR1] |= PPC_BIT(43);
+}
+
+static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    }
+}
+
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "IBM PowerNV (Non-Virtualized)";
     mc->init = pnv_init;
@@ -1997,6 +2024,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
+    nc->nmi_monitor_handler = pnv_nmi;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb,
@@ -2060,6 +2088,7 @@ static const TypeInfo types[] = {
         .class_size    = sizeof(PnvMachineClass),
         .interfaces = (InterfaceInfo[]) {
             { TYPE_INTERRUPT_STATS_PROVIDER },
+            { TYPE_NMI },
             { },
         },
     },
-- 
2.26.2


