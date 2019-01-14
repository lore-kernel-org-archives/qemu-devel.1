Received: from eggs.gnu.org ([209.51.188.92]:40752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu0B-0007g9-KU
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu01-0002ag-VG
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:15387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gitzz-0002SG-Fs
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:21 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:58 +0800
Message-Id: <1547468699-17633-5-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 4/5] i386: enable CPUID.1F leaf generation
 based on spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This patch uses the new socket/die/core/thread model to generate
cpuid.1f eax/ebx/ecx/edx values especially the subleaf 2 which
keeps die level information and adds an option in the cpu_x86_cpuid.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/cpu.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa37203..85f9074 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4137,7 +4137,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 {
     X86CPU *cpu = x86_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    uint32_t pkg_offset;
+    uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
 
@@ -4152,7 +4152,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         limit = env->cpuid_level;
     }
 
-    if (index > limit) {
+    if (index > limit && index != 0x1F) {
         /* Intel documentation states that invalid EAX input will
          * return the same information as EAX=cpuid_level
          * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
@@ -4226,10 +4226,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
+                die_offset = apicid_die_offset(cs->nr_dies, cs->nr_cores,
+                                                            cs->nr_threads);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << pkg_offset), cs->nr_cores,
+                                        (1 << die_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -4311,12 +4312,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(cs->nr_cores, cs->nr_threads);
+            *eax = apicid_core_offset(cs->nr_dies, cs->nr_cores,
+                                                   cs->nr_threads);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
+            *eax = apicid_pkg_offset(cs->nr_dies, cs->nr_cores,
+                                                  cs->nr_threads);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -4325,7 +4328,46 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = 0;
             *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
         }
+        assert(!(*eax & ~0x1f));
+        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+        break;
+    case 0x1F:
+        if (cs->nr_dies > 1 && !cpu->enable_cpuid_0x1f) {
+            printf("Host CPU may not use multi-chip packaging technology.\n");
+            exit(0);
+        }
 
+        if (cs->nr_dies < 2) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        *ecx = count & 0xff;
+        *edx = cpu->apic_id;
+        switch (count) {
+        case 0:
+            *eax = apicid_core_offset(cs->nr_dies, cs->nr_cores,
+                                                   cs->nr_threads);
+            *ebx = cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            break;
+        case 1:
+            *eax = apicid_die_offset(cs->nr_dies, cs->nr_cores,
+                                                  cs->nr_threads);
+            *ebx = cs->nr_cores * cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            break;
+        case 2:
+            *eax = apicid_pkg_offset(cs->nr_dies, cs->nr_cores,
+                                                  cs->nr_threads);
+            *ebx = cs->nr_dies * cs->nr_cores * cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
+            break;
+        default:
+            *eax = 0;
+            *ebx = 0;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+        }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
@@ -5709,11 +5751,13 @@ static Property x86_cpu_properties[] = {
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
@@ -5748,6 +5792,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-- 
1.8.3.1
