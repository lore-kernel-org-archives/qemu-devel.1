Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE27C46477
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0D82086A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0D82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayzx-0000xu-65
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hayrw-0003Ht-7C
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hayru-0006Lr-Sd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:10702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hayru-0005vD-JD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 01:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184175072"
Received: from likexu-e5-2699-v4.sh.intel.com ([10.239.48.178])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 01:43:27 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jun 2019 16:40:56 +0800
Message-Id: <20190612084104.34984-2-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612084104.34984-1-like.xu@linux.intel.com>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 1/9] i386: Add die-level cpu topology to
 x86CPU on PCMachine
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

The die-level as the first PC-specific cpu topology is added to the leagcy
cpu topology model, which has one die per package implicitly and only the
numbers of sockets/cores/threads are configurable.

In the new model with die-level support, the total number of logical
processors (including offline) on board will be calculated as:

     #cpus = #sockets * #dies * #cores * #threads

and considering compatibility, the default value for #dies would be
initialized to one in x86_cpu_initfn() and pc_machine_initfn().

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/i386/pc.c         | 9 +++++++--
 include/hw/i386/pc.h | 2 ++
 target/i386/cpu.c    | 1 +
 target/i386/cpu.h    | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 12c1e08b85..9e9a42f007 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2308,9 +2308,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    /* if APIC ID is not set, set it based on socket/core/thread properties */
+    /*
+     * If APIC ID is not set,
+     * set it based on socket/die/core/thread properties.
+     */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (ms->smp.max_cpus - 1) / smp_threads / smp_cores;
+        int max_socket = (ms->smp.max_cpus - 1) /
+                                smp_threads / smp_cores / pcms->smp_dies;
 
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
@@ -2620,6 +2624,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->pit_enabled = true;
+    pcms->smp_dies = 1;
 
     pc_system_flash_create(pcms);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b260262640..fae9217e34 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -24,6 +24,7 @@
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
  * @boot_cpus: number of present VCPUs
+ * @smp_dies: number of dies per one package
  */
 struct PCMachineState {
     /*< private >*/
@@ -59,6 +60,7 @@ struct PCMachineState {
     bool apic_xrupt_override;
     unsigned apic_id_limit;
     uint16_t boot_cpus;
+    unsigned smp_dies;
 
     /* NUMA information: */
     uint64_t numa_nodes;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 23119699de..a16be205fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5619,6 +5619,7 @@ static void x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
     FeatureWord w;
 
+    env->nr_dies = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index edad6e1efb..5daa2eeafa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1349,6 +1349,8 @@ typedef struct CPUX86State {
     uint64_t xss;
 
     TPRAccess tpr_access_type;
+
+    unsigned nr_dies;
 } CPUX86State;
 
 struct kvm_msrs;
-- 
2.21.0


