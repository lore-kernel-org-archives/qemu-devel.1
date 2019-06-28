Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DAC5B577
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB552086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB552086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggKQ-0006B6-AQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7r-0000CF-1o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7p-0007mQ-R6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg7p-0007kW-IU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC74583F40;
 Fri, 28 Jun 2019 01:56:28 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 602B319C70;
 Fri, 28 Jun 2019 01:56:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:55:43 -0300
Message-Id: <20190628015606.32107-7-ehabkost@redhat.com>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
References: <20190628015606.32107-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 01:56:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/29] hw/s390x: Replace global smp variables
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
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
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ++-
 hw/s390x/sclp.c            | 2 +-
 target/s390x/cpu.c         | 3 +++
 target/s390x/excp_helper.c | 5 +++++
 4 files changed, 11 insertions(+), 2 deletions(-)

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
index f2d93644d5..cafb8fe3f0 100644
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
-- 
2.18.0.rc1.1.g3f1ff2140


