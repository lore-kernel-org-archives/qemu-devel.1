Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B5C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6885F20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OleOt0fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6885F20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYjA-0000pn-Bx
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYht-0007Uu-58; Thu, 07 May 2020 01:04:25 -0400
Received: from ozlabs.org ([203.11.71.1]:46253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhr-0006zq-Fl; Thu, 07 May 2020 01:04:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn4Mp5z9sSk; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=uCaTANb2yoKIfc6GQwlTA7Oai6/KVGiIVGXK+qiTZ4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OleOt0fqrou/ANuF8RVMSOeB5eVN6/d51Tc1I9vm7CmN7K5v5eZIBqd/CxdbqnKLb
 PEjZW3ZwVCwuiKFuMlgXhiKd4Dp+kDG0bmT1m72qXSZHEXxpXiceZH5S3iBf/+8NrF
 b1y/R7ZUbaqHVua1FtA24lrfvP+lCMGqECWrl3vM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/18] ppc/spapr: tweak change system reset helper
Date: Thu,  7 May 2020 15:02:13 +1000
Message-Id: <20200507050228.802395-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Rather than have the helper take an optional vector address
override, instead have its caller modify env->nip itself.
This is more consistent when adding pnv nmi support, and also
with mce injection added later.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200325144147.221875-2-npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c           | 9 ++++++---
 target/ppc/cpu.h         | 2 +-
 target/ppc/excp_helper.c | 5 +----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..785c41d205 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3385,13 +3385,13 @@ static void spapr_machine_finalizefn(Object *obj)
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
 
     cpu_synchronize_state(cs);
     /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
     if (spapr->fwnmi_system_reset_addr != -1) {
         uint64_t rtas_addr, addr;
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *env = &cpu->env;
 
         /* get rtas addr from fdt */
         rtas_addr = spapr_get_rtas_addr();
@@ -3405,7 +3405,10 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
         stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
         env->gpr[3] = addr;
     }
-    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
+    ppc_cpu_do_system_reset(cs);
+    if (spapr->fwnmi_system_reset_addr != -1) {
+        env->nip = spapr->fwnmi_system_reset_addr;
+    }
 }
 
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 88d9449555..f4a5304d43 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
-void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
+void ppc_cpu_do_system_reset(CPUState *cs);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 81ee19ebae..1acc3786de 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -983,15 +983,12 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     }
 }
 
-void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
+void ppc_cpu_do_system_reset(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
-    if (vector != -1) {
-        env->nip = vector;
-    }
 }
 
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
-- 
2.26.2


