Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2155324655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2155324655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBX89-0004Pc-Bj
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 01:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7L-0003Sy-BR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7J-0000In-55
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:07:46 -0400
Received: from [107.174.27.60] (port=46198 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1jBX7I-0000Ea-Md; Tue, 10 Mar 2020 01:07:44 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id EAF6CAE80062;
 Tue, 10 Mar 2020 01:06:00 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v8 1/3] ppc/spapr: Move GPRs setup to one place
Date: Tue, 10 Mar 2020 16:07:31 +1100
Message-Id: <20200310050733.29805-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310050733.29805-1-aik@ozlabs.ru>
References: <20200310050733.29805-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment "pseries" starts in SLOF which only expects the FDT blob
pointer in r3. As we are going to introduce a OpenFirmware support in
QEMU, we will be booting OF clients directly and these expect a stack
pointer in r1, Linux looks at r3/r4 for the initramdisk location
(although vmlinux can find this from the device tree but zImage from
distro kernels cannot).

This extends spapr_cpu_set_entry_state() to take more registers. This
should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v7:
* removed r5 as it points to prom entry which is now provided by
a new firmware in later patches
---
 include/hw/ppc/spapr_cpu_core.h | 4 +++-
 hw/ppc/spapr.c                  | 2 +-
 hw/ppc/spapr_cpu_core.c         | 6 +++++-
 hw/ppc/spapr_rtas.c             | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 1c4cc6559c52..7aed8f555b4f 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
 } SpaprCpuCoreClass;
 
 const char *spapr_get_cpu_core_type(const char *cpu_type);
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4);
 
 typedef struct SpaprCpuState {
     uint64_t vpa_addr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2eb0d8f70de6..64bc8b83e91e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1698,7 +1698,7 @@ static void spapr_machine_reset(MachineState *machine)
     spapr->fdt_blob = fdt;
 
     /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
+    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_addr, 0);
     first_ppc_cpu->env.gpr[5] = 0;
 
     spapr->cas_reboot = false;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 36ed3a2b665b..ac1c10942771 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -76,13 +76,17 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
 
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 
     env->nip = nip;
+    env->gpr[1] = r1;
     env->gpr[3] = r3;
+    env->gpr[4] = r4;
     kvmppc_set_reg_ppc_online(cpu, 1);
     CPU(cpu)->halted = 0;
     /* Enable Power-saving mode Exit Cause exceptions */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 656fdd221665..fe83b50c6629 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
      */
     newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
 
-    spapr_cpu_set_entry_state(newcpu, start, r3);
+    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0);
 
     qemu_cpu_kick(CPU(newcpu));
 
-- 
2.17.1


