Received: from eggs.gnu.org ([209.51.188.92]:40707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu01-0007bP-Cd
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gitzt-0002X4-5z
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:15387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gitzp-0002SG-S2
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:10 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:55 +0800
Message-Id: <1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel]  [PATCH v1 1/5] cpu: introduce die,
 the new cpu toppolgy emulation level
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

Following codes on smp_cores, the smp_dies/nr_dies/die-id is added to
machine and CPUState. In addition to enable_cpuid_0xb, enable_cpuid_0x1f
is introduced to track wether host is a new MCP macine or just ignored.
The number for die level_type on Intel is 5 while core type keeps 2.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 cpus.c                | 1 +
 include/qom/cpu.h     | 1 +
 include/sysemu/cpus.h | 1 +
 qapi/misc.json        | 1 +
 target/i386/cpu.h     | 5 +++++
 5 files changed, 9 insertions(+)

diff --git a/cpus.c b/cpus.c
index b09b702..503558d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2066,6 +2066,7 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
 
 void qemu_init_vcpu(CPUState *cpu)
 {
+    cpu->nr_dies = smp_dies;
     cpu->nr_cores = smp_cores;
     cpu->nr_threads = smp_threads;
     cpu->stopped = true;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 16bbed1..ee53862 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -332,6 +332,7 @@ struct CPUState {
     DeviceState parent_obj;
     /*< public >*/
 
+    int nr_dies;
     int nr_cores;
     int nr_threads;
 
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 731756d..4243c8f 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -34,6 +34,7 @@ void qtest_clock_warp(int64_t dest);
 #ifndef CONFIG_USER_ONLY
 /* vl.c */
 /* *-user doesn't have configurable SMP topology */
+extern int smp_dies;
 extern int smp_cores;
 extern int smp_threads;
 #endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 24d20a8..a01a9fe 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3229,6 +3229,7 @@
 { 'struct': 'CpuInstanceProperties',
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
+            '*die-id': 'int',
             '*core-id': 'int',
             '*thread-id': 'int'
   }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ef41a03..aa2ee8a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -732,6 +732,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_TOPOLOGY_LEVEL_INVALID  (0U << 8)
 #define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
 #define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
+#define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
 
 /* MSR Feature Bits */
 #define MSR_ARCH_CAP_RDCL_NO    (1U << 0)
@@ -1450,6 +1451,9 @@ struct X86CPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Compatibility bits for new machine types: */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -1475,6 +1479,7 @@ struct X86CPU {
 
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
+    int32_t die_id;
     int32_t core_id;
     int32_t thread_id;
 
-- 
1.8.3.1
