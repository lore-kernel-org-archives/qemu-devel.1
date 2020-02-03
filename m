Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC9C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ACA20679
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ACA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iySUW-00075b-RT
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iySRP-0002jC-6F
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iySRN-0006nV-Ac
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:30:27 -0500
Received: from [107.174.27.60] (port=38982 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iySRL-0006lD-Fk; Sun, 02 Feb 2020 22:30:24 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 870BAAE801F8;
 Sun,  2 Feb 2020 22:28:25 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v6 2/6] ppc/spapr: Move GPRs setup to one place
Date: Mon,  3 Feb 2020 14:29:39 +1100
Message-Id: <20200203032943.121178-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203032943.121178-1-aik@ozlabs.ru>
References: <20200203032943.121178-1-aik@ozlabs.ru>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment "pseries" starts in SLOF which only expects the FDT blob
pointer in r3. As we are going to introduce a OpenFirmware support in
QEMU, we will be booting OF clients directly and these expect a stack
pointer in r1, the OF entry point in r5 and in addition to this, Linux
looks at r3/r4 for the initramdisk location (although vmlinux can find
this from the device tree but zImage from distro kernels cannot).

This extends spapr_cpu_set_entry_state() to take more registers. This
should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr_cpu_core.h | 4 +++-
 hw/ppc/spapr.c                  | 4 ++--
 hw/ppc/spapr_cpu_core.c         | 7 ++++++-
 hw/ppc/spapr_rtas.c             | 2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 1c4cc6559c52..edd7214fafcf 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
 } SpaprCpuCoreClass;
 
 const char *spapr_get_cpu_core_type(const char *cpu_type);
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4, target_ulong r5);
 
 typedef struct SpaprCpuState {
     uint64_t vpa_addr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c9b2e0a5e060..660a4b60e072 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1674,8 +1674,8 @@ static void spapr_machine_reset(MachineState *machine)
     spapr->fdt_blob = fdt;
 
     /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
-    first_ppc_cpu->env.gpr[5] = 0;
+    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
+                              0, fdt_addr, 0, 0);
 
     spapr->cas_reboot = false;
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d09125d9afd4..696b76598dd7 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -84,13 +84,18 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
 
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4, target_ulong r5)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 
     env->nip = nip;
+    env->gpr[1] = r1;
     env->gpr[3] = r3;
+    env->gpr[4] = r4;
+    env->gpr[5] = r5;
     kvmppc_set_reg_ppc_online(cpu, 1);
     CPU(cpu)->halted = 0;
     /* Enable Power-saving mode Exit Cause exceptions */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 656fdd221665..9e3cbd70bbd9 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
      */
     newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
 
-    spapr_cpu_set_entry_state(newcpu, start, r3);
+    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0, 0);
 
     qemu_cpu_kick(CPU(newcpu));
 
-- 
2.17.1


