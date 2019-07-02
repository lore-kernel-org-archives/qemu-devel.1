Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7C5C46478
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF11B21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF11B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLbC-00026D-7T
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpA-0007VE-B8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp8-0005iF-KH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKp8-0005eo-77
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AC988830B;
 Tue,  2 Jul 2019 15:36:00 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4635D6A9;
 Tue,  2 Jul 2019 15:35:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:04 -0300
Message-Id: <20190702153535.9851-12-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 15:36:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 11/42] i386: Add die-level cpu topology to
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The die-level as the first PC-specific cpu topology is added to the leagcy
cpu topology model, which has one die per package implicitly and only the
numbers of sockets/cores/threads are configurable.

In the new model with die-level support, the total number of logical
processors (including offline) on board will be calculated as:

     #cpus = #sockets * #dies * #cores * #threads

and considering compatibility, the default value for #dies would be
initialized to one in x86_cpu_initfn() and pc_machine_initfn().

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190612084104.34984-2-like.xu@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 2 ++
 target/i386/cpu.h    | 2 ++
 hw/i386/pc.c         | 9 +++++++--
 target/i386/cpu.c    | 1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 884e35b9b2..764996e6b4 100644
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 93345792f4..14c19e61b1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1385,6 +1385,8 @@ typedef struct CPUX86State {
     uint64_t xss;
 
     TPRAccess tpr_access_type;
+
+    unsigned nr_dies;
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73de30cc20..e18b1bade2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2306,9 +2306,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -2619,6 +2623,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->pit_enabled = true;
+    pcms->smp_dies = 1;
 
     pc_system_flash_create(pcms);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 78830d403a..fac3cc028e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5639,6 +5639,7 @@ static void x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
     FeatureWord w;
 
+    env->nr_dies = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
-- 
2.18.0.rc1.1.g3f1ff2140


