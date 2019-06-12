Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39BAC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E242206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E242206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayw0-0005R8-Lg
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hayrm-00038N-Nk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hayri-0006DR-Ig
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:10704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hayqz-0005vT-K9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 01:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184175079"
Received: from likexu-e5-2699-v4.sh.intel.com ([10.239.48.178])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 01:43:28 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jun 2019 16:40:57 +0800
Message-Id: <20190612084104.34984-3-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612084104.34984-1-like.xu@linux.intel.com>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 2/9] hw/i386: Adjust nr_dies with configured
 smp_dies for PCMachine
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, like.xu@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support multiple dies configuration on PCMachine, the best place to
set CPUX86State->nr_dies with requested PCMachineState->smp_dies is in
pc_new_cpu() and pc_cpu_pre_plug(). Refactoring pc_new_cpu() is applied
and redundant parameter "const char *typename" would be removed.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/i386/pc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9e9a42f007..af2e95a1b9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1520,12 +1520,16 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
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
@@ -1551,7 +1555,7 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
         return;
     }
 
-    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
+    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1576,8 +1580,7 @@ void pc_cpus_init(PCMachineState *pcms)
                                                      ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
-        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
-                   &error_fatal);
+        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -2297,6 +2300,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
     X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     unsigned int smp_cores = ms->smp.cores;
@@ -2308,6 +2312,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    env->nr_dies = pcms->smp_dies;
+
     /*
      * If APIC ID is not set,
      * set it based on socket/die/core/thread properties.
-- 
2.21.0


