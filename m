Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C7C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4224321882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hik6u-0005Pr-Ck
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijft-0004PU-0N
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijfq-0000Qi-OQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijfq-0000OO-Fl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A455308FEC0;
 Wed,  3 Jul 2019 18:08:04 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 596461001B27;
 Wed,  3 Jul 2019 18:08:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:06:57 -0300
Message-Id: <20190703180726.31267-15-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 03 Jul 2019 18:08:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 14/43] i386: Update new x86_apicid parsing
 rules with die_offset support
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

In new sockets/dies/cores/threads model, the apicid of logical cpu could
imply die level info of guest cpu topology thus x86_apicid_from_cpu_idx()
need to be refactored with #dies value, so does apicid_*_offset().

To keep semantic compatibility, the legacy pkg_offset which helps to
generate CPUIDs such as 0x3 for L3 cache should be mapping to die_offset.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190612084104.34984-5-like.xu@linux.intel.com>
[ehabkost: squash unit test patch]
Message-Id: <20190612084104.34984-6-like.xu@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/topology.h | 76 ++++++++++++++++++++++++----------
 hw/i386/pc.c               | 29 ++++++++-----
 target/i386/cpu.c          | 13 +++---
 tests/test-x86-cpuid.c     | 84 ++++++++++++++++++++------------------
 4 files changed, 126 insertions(+), 76 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index c9fb41588e..4ff5b2da6c 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -63,88 +63,120 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
 
 /* Bit width of the SMT_ID (thread ID) field on the APIC ID
  */
-static inline unsigned apicid_smt_width(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_smt_width(unsigned nr_dies,
+                                        unsigned nr_cores,
+                                        unsigned nr_threads)
 {
     return apicid_bitwidth_for_count(nr_threads);
 }
 
 /* Bit width of the Core_ID field
  */
-static inline unsigned apicid_core_width(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_core_width(unsigned nr_dies,
+                                         unsigned nr_cores,
+                                         unsigned nr_threads)
 {
     return apicid_bitwidth_for_count(nr_cores);
 }
 
+/* Bit width of the Die_ID field */
+static inline unsigned apicid_die_width(unsigned nr_dies,
+                                        unsigned nr_cores,
+                                        unsigned nr_threads)
+{
+    return apicid_bitwidth_for_count(nr_dies);
+}
+
 /* Bit offset of the Core_ID field
  */
-static inline unsigned apicid_core_offset(unsigned nr_cores,
+static inline unsigned apicid_core_offset(unsigned nr_dies,
+                                          unsigned nr_cores,
                                           unsigned nr_threads)
 {
-    return apicid_smt_width(nr_cores, nr_threads);
+    return apicid_smt_width(nr_dies, nr_cores, nr_threads);
+}
+
+/* Bit offset of the Die_ID field */
+static inline unsigned apicid_die_offset(unsigned nr_dies,
+                                          unsigned nr_cores,
+                                           unsigned nr_threads)
+{
+    return apicid_core_offset(nr_dies, nr_cores, nr_threads) +
+           apicid_core_width(nr_dies, nr_cores, nr_threads);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field
  */
-static inline unsigned apicid_pkg_offset(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_pkg_offset(unsigned nr_dies,
+                                         unsigned nr_cores,
+                                         unsigned nr_threads)
 {
-    return apicid_core_offset(nr_cores, nr_threads) +
-           apicid_core_width(nr_cores, nr_threads);
+    return apicid_die_offset(nr_dies, nr_cores, nr_threads) +
+           apicid_die_width(nr_dies, nr_cores, nr_threads);
 }
 
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(unsigned nr_cores,
+static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
+                                             unsigned nr_cores,
                                              unsigned nr_threads,
                                              const X86CPUTopoInfo *topo)
 {
-    return (topo->pkg_id  << apicid_pkg_offset(nr_cores, nr_threads)) |
-           (topo->core_id << apicid_core_offset(nr_cores, nr_threads)) |
+    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
+          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
            topo->smt_id;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
  * based on (contiguous) CPU index
  */
-static inline void x86_topo_ids_from_idx(unsigned nr_cores,
+static inline void x86_topo_ids_from_idx(unsigned nr_dies,
+                                         unsigned nr_cores,
                                          unsigned nr_threads,
                                          unsigned cpu_index,
                                          X86CPUTopoInfo *topo)
 {
-    unsigned core_index = cpu_index / nr_threads;
+    topo->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo->core_id = cpu_index / nr_threads % nr_cores;
     topo->smt_id = cpu_index % nr_threads;
-    topo->core_id = core_index % nr_cores;
-    topo->pkg_id = core_index / nr_cores;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
  * based on APIC ID
  */
 static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
+                                            unsigned nr_dies,
                                             unsigned nr_cores,
                                             unsigned nr_threads,
                                             X86CPUTopoInfo *topo)
 {
     topo->smt_id = apicid &
-                   ~(0xFFFFFFFFUL << apicid_smt_width(nr_cores, nr_threads));
-    topo->core_id = (apicid >> apicid_core_offset(nr_cores, nr_threads)) &
-                   ~(0xFFFFFFFFUL << apicid_core_width(nr_cores, nr_threads));
-    topo->pkg_id = apicid >> apicid_pkg_offset(nr_cores, nr_threads);
-    topo->die_id = 0;
+            ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
+    topo->core_id =
+            (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
+    topo->die_id =
+            (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
+    topo->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
  *
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
-static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_cores,
+static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
+                                                unsigned nr_cores,
                                                 unsigned nr_threads,
                                                 unsigned cpu_index)
 {
     X86CPUTopoInfo topo;
-    x86_topo_ids_from_idx(nr_cores, nr_threads, cpu_index, &topo);
-    return apicid_from_topo_ids(nr_cores, nr_threads, &topo);
+    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo);
+    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 98a314dcf0..9921ce4f5e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -931,10 +931,11 @@ void enable_compat_apic_id_mode(void)
 static uint32_t x86_cpu_apic_id_from_index(MachineState *ms,
                                            unsigned int cpu_index)
 {
+    PCMachineState *pcms = PC_MACHINE(ms);
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(ms->smp.cores,
+    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
                                          ms->smp.threads, cpu_index);
     if (compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
@@ -2353,18 +2354,21 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo.die_id = cpu->die_id;
         topo.core_id = cpu->core_id;
         topo.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
+        cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
+                                            smp_threads, &topo);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
-        error_setg(errp, "Invalid CPU [socket: %u, core: %u, thread: %u] with"
-                  " APIC ID %" PRIu32 ", valid index range 0:%d",
-                   topo.pkg_id, topo.core_id, topo.smt_id, cpu->apic_id,
-                   ms->possible_cpus->len - 1);
+        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+                                 smp_cores, smp_threads, &topo);
+        error_setg(errp,
+            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
+            " APIC ID %" PRIu32 ", valid index range 0:%d",
+            topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
+            cpu->apic_id, ms->possible_cpus->len - 1);
         return;
     }
 
@@ -2380,7 +2384,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
+    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+                             smp_cores, smp_threads, &topo);
     if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
@@ -2678,10 +2683,12 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoInfo topo;
+   PCMachineState *pcms = PC_MACHINE(ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            ms->smp.cores, ms->smp.threads, &topo);
+                            pcms->smp_dies, ms->smp.cores,
+                            ms->smp.threads, &topo);
    return topo.pkg_id % nb_numa_nodes;
 }
 
@@ -2689,6 +2696,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
     unsigned int max_cpus = ms->smp.max_cpus;
+    PCMachineState *pcms = PC_MACHINE(ms);
 
     if (ms->possible_cpus) {
         /*
@@ -2709,7 +2717,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 ms->smp.cores, ms->smp.threads, &topo);
+                                 pcms->smp_dies, ms->smp.cores,
+                                 ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
         ms->possible_cpus->cpus[i].props.has_die_id = true;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bd0f873883..3a38fe3633 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4267,7 +4267,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 {
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    uint32_t pkg_offset;
+    uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
 
@@ -4356,10 +4356,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
+                die_offset = apicid_die_offset(env->nr_dies,
+                                        cs->nr_cores, cs->nr_threads);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << pkg_offset), cs->nr_cores,
+                                        (1 << die_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -4441,12 +4442,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(cs->nr_cores, cs->nr_threads);
+            *eax = apicid_core_offset(env->nr_dies,
+                                      cs->nr_cores, cs->nr_threads);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
+            *eax = apicid_pkg_offset(env->nr_dies,
+                                     cs->nr_cores, cs->nr_threads);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index ff225006e4..1942287f33 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -28,74 +28,80 @@
 
 static void test_topo_bits(void)
 {
-    /* simple tests for 1 thread per core, 1 core per socket */
-    g_assert_cmpuint(apicid_smt_width(1, 1), ==, 0);
-    g_assert_cmpuint(apicid_core_width(1, 1), ==, 0);
+    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
+    g_assert_cmpuint(apicid_smt_width(1, 1, 1), ==, 0);
+    g_assert_cmpuint(apicid_core_width(1, 1, 1), ==, 0);
+    g_assert_cmpuint(apicid_die_width(1, 1, 1), ==, 0);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 2), ==, 2);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 3), ==, 3);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 3), ==, 3);
 
 
     /* Test field width calculation for multiple values
      */
-    g_assert_cmpuint(apicid_smt_width(1, 2), ==, 1);
-    g_assert_cmpuint(apicid_smt_width(1, 3), ==, 2);
-    g_assert_cmpuint(apicid_smt_width(1, 4), ==, 2);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 2), ==, 1);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 3), ==, 2);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 4), ==, 2);
 
-    g_assert_cmpuint(apicid_smt_width(1, 14), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 15), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 16), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 17), ==, 5);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 14), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 15), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 16), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 17), ==, 5);
 
 
-    g_assert_cmpuint(apicid_core_width(30, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(31, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(32, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(33, 2), ==, 6);
+    g_assert_cmpuint(apicid_core_width(1, 30, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 31, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 32, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 33, 2), ==, 6);
 
+    g_assert_cmpuint(apicid_die_width(1, 30, 2), ==, 0);
+    g_assert_cmpuint(apicid_die_width(2, 30, 2), ==, 1);
+    g_assert_cmpuint(apicid_die_width(3, 30, 2), ==, 2);
+    g_assert_cmpuint(apicid_die_width(4, 30, 2), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
      */
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    g_assert_cmpuint(apicid_smt_width(6, 3), ==, 2);
-    g_assert_cmpuint(apicid_core_width(6, 3), ==, 3);
-    g_assert_cmpuint(apicid_pkg_offset(6, 3), ==, 5);
+    g_assert_cmpuint(apicid_smt_width(1, 6, 3), ==, 2);
+    g_assert_cmpuint(apicid_core_offset(1, 6, 3), ==, 2);
+    g_assert_cmpuint(apicid_die_offset(1, 6, 3), ==, 5);
+    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), ==, 5);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2), ==, 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 1), ==,
                      (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 2), ==,
                      (1 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 0), ==,
                      (2 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 1), ==,
                      (2 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 2), ==,
                      (2 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 0), ==,
                      (5 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 1), ==,
                      (5 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 2), ==,
                      (5 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 0 * 3 + 0), ==,
-                     (1 << 5));
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 1 * 3 + 1), ==,
-                     (1 << 5) | (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 3 * 6 * 3 + 5 * 3 + 2), ==,
-                     (3 << 5) | (5 << 2) | 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
 }
 
 int main(int argc, char **argv)
-- 
2.18.0.rc1.1.g3f1ff2140


