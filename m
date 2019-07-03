Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83EC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296E6218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296E6218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1himXZ-0007zS-Cx
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1himUg-0005sx-Hu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1himUf-0006ft-9j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1himUf-0006fO-21
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3BCA308339E;
 Wed,  3 Jul 2019 21:08:43 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79561891A4;
 Wed,  3 Jul 2019 21:08:42 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 18:07:44 -0300
Message-Id: <20190703210821.27550-7-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
References: <20190703210821.27550-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 21:08:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v5 06/43] hw/s390x: Replace global smp variables
 with machine smp properties
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The global smp variables in s390x are replaced with smp machine properties.

A local variable of the same name would be introduced in the declaration
phase if it's used widely in the context OR replace it on the spot if it's
only used once. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190518205428.90532-7-like.xu@linux.intel.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[ehabkost: fix build failure at VCPU_IRQ_BUF_SIZE]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

fixup! hw/s390x: Replace global smp variables with machine smp properties

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c |  3 ++-
 hw/s390x/sclp.c            |  2 +-
 target/s390x/cpu.c         |  3 +++
 target/s390x/excp_helper.c |  5 +++++
 target/s390x/kvm.c         | 10 ++++++----
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e09bf8f1b6..5b6a9a4e55 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -84,7 +84,7 @@ static void s390_init_cpus(MachineState *machine)
     /* initialize possible_cpus */
     mc->possible_cpu_arch_ids(machine);
 
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < machine->smp.cpus; i++) {
         s390x_new_cpu(machine->cpu_type, i, &error_fatal);
     }
 }
@@ -411,6 +411,7 @@ static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
 static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
+    unsigned int max_cpus = ms->smp.max_cpus;
 
     if (ms->possible_cpus) {
         g_assert(ms->possible_cpus && ms->possible_cpus->len == max_cpus);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a800cb..fac7c3bb6c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -64,7 +64,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
     read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
-    read_info->highest_cpu = cpu_to_be16(max_cpus - 1);
+    read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8540e7a2cb..736a7903e2 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
+#include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
@@ -197,6 +198,8 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int max_cpus = ms->smp.max_cpus;
     if (cpu->env.core_id >= max_cpus) {
         error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
                    ", maximum core-id: %d", cpu->env.core_id,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 202456cdc5..892f659d5a 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -31,6 +31,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/boards.h"
 #endif
 
 void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
@@ -315,6 +316,10 @@ static void do_ext_interrupt(CPUS390XState *env)
         g_assert(cpu_addr < S390_MAX_CPUS);
         lowcore->cpu_addr = cpu_to_be16(cpu_addr);
         clear_bit(cpu_addr, env->emergency_signals);
+#ifndef CONFIG_USER_ONLY
+        MachineState *ms = MACHINE(qdev_get_machine());
+        unsigned int max_cpus = ms->smp.max_cpus;
+#endif
         if (bitmap_empty(env->emergency_signals, max_cpus)) {
             env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
         }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0267c6c2f6..6e814c230b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -119,8 +119,8 @@
  * Needs to be big enough to contain max_cpus emergency signals
  * and in addition NR_LOCAL_IRQS interrupts
  */
-#define VCPU_IRQ_BUF_SIZE (sizeof(struct kvm_s390_irq) * \
-                           (max_cpus + NR_LOCAL_IRQS))
+#define VCPU_IRQ_BUF_SIZE(max_cpus) (sizeof(struct kvm_s390_irq) * \
+                                     (max_cpus + NR_LOCAL_IRQS))
 
 static CPUWatchpoint hw_watchpoint;
 /*
@@ -362,9 +362,10 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
+    unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
     kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
-    cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE);
+    cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE(max_cpus));
     return 0;
 }
 
@@ -1950,9 +1951,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
 {
+    unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     struct kvm_s390_irq_state irq_state = {
         .buf = (uint64_t) cpu->irqstate,
-        .len = VCPU_IRQ_BUF_SIZE,
+        .len = VCPU_IRQ_BUF_SIZE(max_cpus),
     };
     CPUState *cs = CPU(cpu);
     int32_t bytes;
-- 
2.18.0.rc1.1.g3f1ff2140


