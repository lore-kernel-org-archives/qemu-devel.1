Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216F020773
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pf8158Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216F020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPt4-0000Wo-1D
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnR-0001rh-Dp; Tue, 27 Oct 2020 10:18:00 -0400
Received: from ozlabs.org ([203.11.71.1]:47281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnP-0007aC-Hx; Tue, 27 Oct 2020 10:17:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLd1KN8z9shh; Wed, 28 Oct 2020 01:17:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808265;
 bh=Q3owrk20jMIlyNpF7GnocBDJgbDjYtAgDaW/I9KCRQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pf8158CpbEU37dkZgFLFS0CUnMVhvNtPY3MgDqNJjcZHzh63ukCUIj9PVsgYkYd6c
 3/qwhMn5OUx3fXU7qsDJ72qD9364yWlIE4uEVcNQuYhHQFs8fcFNlGyTOk9gg7vo7u
 E6nHePCrU2naTYHrmKTnuOXkDADg7DWLJQoVlQhs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/18] spapr: Unrealize vCPUs with qdev_unrealize()
Date: Wed, 28 Oct 2020 01:17:23 +1100
Message-Id: <20201027141735.728821-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Since we introduced CPU hot-unplug in sPAPR, we don't unrealize the
vCPU objects explicitly. Instead, we let QOM handle that for us under
object_property_del_all() when the CPU core object is finalized. The
only thing we do is calling cpu_remove_sync() to tear the vCPU thread
down.

This happens to work but it is ugly because:
- we call qdev_realize() but the corresponding qdev_unrealize() is
  buried deep in the QOM code
- we call cpu_remove_sync() to undo qemu_init_vcpu() called by
  ppc_cpu_realize() in target/ppc/translate_init.c.inc
- the CPU init and teardown paths aren't really symmetrical

The latter didn't bite us so far but a future patch that greatly
simplifies the CPU core realize path needs it to avoid a crash
in QOM.

For all these reasons, have ppc_cpu_unrealize() to undo the changes
of ppc_cpu_realize() by calling cpu_remove_sync() at the right place,
and have the sPAPR CPU core code to call qdev_unrealize().

This requires to add a missing stub because translate_init.c.inc is
also compiled for user mode.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160279671236.1808373.14732005038172874990.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/tcg/user-exec-stub.c      | 4 ++++
 hw/ppc/spapr_cpu_core.c         | 4 ++--
 target/ppc/translate_init.c.inc | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index f6d8c8fb6f..b876f5c1e4 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -9,6 +9,10 @@ void cpu_resume(CPUState *cpu)
 {
 }
 
+void cpu_remove_sync(CPUState *cpu)
+{
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c552112145..e4aeb93c02 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -187,7 +187,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
     }
     spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
-    cpu_remove_sync(CPU(cpu));
+    qdev_unrealize(DEVICE(cpu));
 }
 
 /*
@@ -255,7 +255,7 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     kvmppc_set_papr(cpu);
 
     if (spapr_irq_cpu_intc_create(spapr, cpu, errp) < 0) {
-        cpu_remove_sync(CPU(cpu));
+        qdev_unrealize(DEVICE(cpu));
         return false;
     }
 
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index bb66526280..d2a8204d60 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10328,6 +10328,8 @@ static void ppc_cpu_unrealize(DeviceState *dev)
 
     pcc->parent_unrealize(dev);
 
+    cpu_remove_sync(CPU(cpu));
+
     for (i = 0; i < PPC_CPU_OPCODES_LEN; i++) {
         if (cpu->opcodes[i] == &invalid_handler) {
             continue;
-- 
2.26.2


