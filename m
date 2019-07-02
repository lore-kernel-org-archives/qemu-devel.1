Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BE9C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566EF21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566EF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLw4-0005nk-En
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpB-0007XU-5l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp9-0005jY-9h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKp8-0005hi-W8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23A983082E8F;
 Tue,  2 Jul 2019 15:36:02 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8E6760C43;
 Tue,  2 Jul 2019 15:36:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:05 -0300
Message-Id: <20190702153535.9851-13-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 15:36:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 12/42] hw/i386: Adjust nr_dies with
 configured smp_dies for PCMachine
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

To support multiple dies configuration on PCMachine, the best place to
set CPUX86State->nr_dies with requested PCMachineState->smp_dies is in
pc_new_cpu() and pc_cpu_pre_plug(). Refactoring pc_new_cpu() is applied
and redundant parameter "const char *typename" would be removed.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190612084104.34984-3-like.xu@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e18b1bade2..211015324a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1518,12 +1518,16 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }
 
-static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
+static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
 {
     Object *cpu = NULL;
     Error *local_err = NULL;
+    CPUX86State *env = NULL;
 
-    cpu = object_new(typename);
+    cpu = object_new(MACHINE(pcms)->cpu_type);
+
+    env = &X86_CPU(cpu)->env;
+    env->nr_dies = pcms->smp_dies;
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
@@ -1549,7 +1553,7 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
         return;
     }
 
-    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
+    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1574,8 +1578,7 @@ void pc_cpus_init(PCMachineState *pcms)
                                                      ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
-        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
-                   &error_fatal);
+        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -2295,6 +2298,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
     X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     unsigned int smp_cores = ms->smp.cores;
@@ -2306,6 +2310,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    env->nr_dies = pcms->smp_dies;
+
     /*
      * If APIC ID is not set,
      * set it based on socket/die/core/thread properties.
-- 
2.18.0.rc1.1.g3f1ff2140


