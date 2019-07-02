Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4810C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9132D20989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9132D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLoF-0005lP-R1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpG-0007lF-Tn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpF-0005rZ-8K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKpE-0005qx-UY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24EB5308793A;
 Tue,  2 Jul 2019 15:36:04 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A27836F92A;
 Tue,  2 Jul 2019 15:36:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:06 -0300
Message-Id: <20190702153535.9851-14-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 15:36:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 13/42] i386/cpu: Consolidate die-id validity
 in smp context
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

The field die_id (default as 0) and has_die_id are introduced to X86CPU.
Following the legacy smp check rules, the die_id validity is added to
the same contexts as leagcy smp variables such as hmp_hotpluggable_cpus(),
machine_set_cpu_numa_node(), cpu_slot_to_string() and pc_cpu_pre_plug().

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190612084104.34984-4-like.xu@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json             |  6 ++++--
 include/hw/i386/topology.h |  2 ++
 target/i386/cpu.h          |  1 +
 hw/core/machine.c          | 12 ++++++++++++
 hw/i386/pc.c               | 14 ++++++++++++++
 monitor/hmp-cmds.c         |  3 +++
 target/i386/cpu.c          |  2 ++
 7 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index dc4cf9da20..577f7166f4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2920,10 +2920,11 @@
 #
 # @node-id: NUMA node ID the CPU belongs to
 # @socket-id: socket number within node/board the CPU belongs to
-# @core-id: core number within socket the CPU belongs to
+# @die-id: die number within node/board the CPU belongs to (Since 4.1)
+# @core-id: core number within die the CPU belongs to
 # @thread-id: thread number within core the CPU belongs to
 #
-# Note: currently there are 4 properties that could be present
+# Note: currently there are 5 properties that could be present
 # but management should be prepared to pass through other
 # properties with device_add command to allow for future
 # interface extension. This also requires the filed names to be kept in
@@ -2934,6 +2935,7 @@
 { 'struct': 'CpuInstanceProperties',
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
+            '*die-id': 'int',
             '*core-id': 'int',
             '*thread-id': 'int'
   }
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 1ebaee0f76..c9fb41588e 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,6 +47,7 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoInfo {
     unsigned pkg_id;
+    unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoInfo;
@@ -130,6 +131,7 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
     topo->core_id = (apicid >> apicid_core_offset(nr_cores, nr_threads)) &
                    ~(0xFFFFFFFFUL << apicid_core_width(nr_cores, nr_threads));
     topo->pkg_id = apicid >> apicid_pkg_offset(nr_cores, nr_threads);
+    topo->die_id = 0;
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14c19e61b1..4d2ae2384e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1500,6 +1500,7 @@ struct X86CPU {
 
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
+    int32_t die_id;
     int32_t core_id;
     int32_t thread_id;
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea5a01aa49..7a44adab39 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -682,6 +682,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
             return;
         }
 
+        if (props->has_die_id && !slot->props.has_die_id) {
+            error_setg(errp, "die-id is not supported");
+            return;
+        }
+
         /* skip slots with explicit mismatch */
         if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
                 continue;
@@ -691,6 +696,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
                 continue;
         }
 
+        if (props->has_die_id && props->die_id != slot->props.die_id) {
+                continue;
+        }
+
         if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
                 continue;
         }
@@ -948,6 +957,9 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     if (cpu->props.has_socket_id) {
         g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
     }
+    if (cpu->props.has_die_id) {
+        g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
+    }
     if (cpu->props.has_core_id) {
         if (s->len) {
             g_string_append_printf(s, ", ");
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 211015324a..98a314dcf0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2327,6 +2327,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
             error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
                        cpu->socket_id, max_socket);
             return;
+        } else if (cpu->die_id > pcms->smp_dies - 1) {
+            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
+                       cpu->die_id, max_socket);
+            return;
         }
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
@@ -2346,6 +2350,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         }
 
         topo.pkg_id = cpu->socket_id;
+        topo.die_id = cpu->die_id;
         topo.core_id = cpu->core_id;
         topo.smt_id = cpu->thread_id;
         cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
@@ -2383,6 +2388,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->socket_id = topo.pkg_id;
 
+    if (cpu->die_id != -1 && cpu->die_id != topo.die_id) {
+        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
+            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
+        return;
+    }
+    cpu->die_id = topo.die_id;
+
     if (cpu->core_id != -1 && cpu->core_id != topo.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
             " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_id);
@@ -2700,6 +2712,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
                                  ms->smp.cores, ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.has_die_id = true;
+        ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c283dde0e9..7f50c9d83a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -3114,6 +3114,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
         if (c->has_socket_id) {
             monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
         }
+        if (c->has_die_id) {
+            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
+        }
         if (c->has_core_id) {
             monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
         }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fac3cc028e..bd0f873883 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5865,11 +5865,13 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
+    DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
 #else
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
+    DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
-- 
2.18.0.rc1.1.g3f1ff2140


