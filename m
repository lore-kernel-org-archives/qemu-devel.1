Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjen-0000iM-Bg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjei-0000jO-FQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjei-0000j6-6c
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:55 -0200
Message-Id: <20170112175356.21701-6-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] numa: make -numa parser dynamically
 allocate CPUs masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

so it won't impose an additional limits on max_cpus limits
supported by different targets.

It removes global MAX_CPUMASK_BITS constant and need to
bump it up whenever max_cpus is being increased for
a target above MAX_CPUMASK_BITS value.

Use runtime max_cpus value instead to allocate sufficiently
sized node_cpu bitmasks in numa parser.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1479466974-249781-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: Added asserts to ensure cpu_index < max_cpus]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h   |  2 +-
 include/sysemu/sysemu.h |  7 -------
 numa.c                  | 21 ++++++++++++++-------
 vl.c                    |  5 -----
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 4da808a6e9..8f09dcf918 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -17,7 +17,7 @@ struct numa_addr_range {
 
 typedef struct node_info {
     uint64_t node_mem;
-    DECLARE_BITMAP(node_cpu, MAX_CPUMASK_BITS);
+    unsigned long *node_cpu;
     struct HostMemoryBackend *node_memdev;
     bool present;
     QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 66c6f1577e..cccde56454 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -168,13 +168,6 @@ extern int mem_prealloc;
 #define MAX_NODES 128
 #define NUMA_NODE_UNASSIGNED MAX_NODES
 
-/* The following shall be true for all CPUs:
- *   cpu->cpu_index < max_cpus <= MAX_CPUMASK_BITS
- *
- * Note that cpu->get_arch_id() may be larger than MAX_CPUMASK_BITS.
- */
-#define MAX_CPUMASK_BITS 288
-
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/numa.c b/numa.c
index f5fc7da3e9..379bc8a140 100644
--- a/numa.c
+++ b/numa.c
@@ -266,20 +266,19 @@ static char *enumerate_cpus(unsigned long *cpus, int max_cpus)
 static void validate_numa_cpus(void)
 {
     int i;
-    DECLARE_BITMAP(seen_cpus, MAX_CPUMASK_BITS);
+    unsigned long *seen_cpus = bitmap_new(max_cpus);
 
-    bitmap_zero(seen_cpus, MAX_CPUMASK_BITS);
     for (i = 0; i < nb_numa_nodes; i++) {
-        if (bitmap_intersects(seen_cpus, numa_info[i].node_cpu,
-                              MAX_CPUMASK_BITS)) {
+        if (bitmap_intersects(seen_cpus, numa_info[i].node_cpu, max_cpus)) {
             bitmap_and(seen_cpus, seen_cpus,
-                       numa_info[i].node_cpu, MAX_CPUMASK_BITS);
+                       numa_info[i].node_cpu, max_cpus);
             error_report("CPU(s) present in multiple NUMA nodes: %s",
                          enumerate_cpus(seen_cpus, max_cpus));
+            g_free(seen_cpus);
             exit(EXIT_FAILURE);
         }
         bitmap_or(seen_cpus, seen_cpus,
-                  numa_info[i].node_cpu, MAX_CPUMASK_BITS);
+                  numa_info[i].node_cpu, max_cpus);
     }
 
     if (!bitmap_full(seen_cpus, max_cpus)) {
@@ -291,12 +290,17 @@ static void validate_numa_cpus(void)
                      "in NUMA config");
         g_free(msg);
     }
+    g_free(seen_cpus);
 }
 
 void parse_numa_opts(MachineClass *mc)
 {
     int i;
 
+    for (i = 0; i < MAX_NODES; i++) {
+        numa_info[i].node_cpu = bitmap_new(max_cpus);
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, NULL, NULL)) {
         exit(1);
     }
@@ -362,7 +366,7 @@ void parse_numa_opts(MachineClass *mc)
         numa_set_mem_ranges();
 
         for (i = 0; i < nb_numa_nodes; i++) {
-            if (!bitmap_empty(numa_info[i].node_cpu, MAX_CPUMASK_BITS)) {
+            if (!bitmap_empty(numa_info[i].node_cpu, max_cpus)) {
                 break;
             }
         }
@@ -397,6 +401,7 @@ void numa_post_machine_init(void)
 
     CPU_FOREACH(cpu) {
         for (i = 0; i < nb_numa_nodes; i++) {
+            assert(cpu->cpu_index < max_cpus);
             if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
                 cpu->numa_node = i;
             }
@@ -558,6 +563,8 @@ int numa_get_node_for_cpu(int idx)
 {
     int i;
 
+    assert(idx < max_cpus);
+
     for (i = 0; i < nb_numa_nodes; i++) {
         if (test_bit(idx, numa_info[i].node_cpu)) {
             break;
diff --git a/vl.c b/vl.c
index a23de18fa9..c643d3ff3a 100644
--- a/vl.c
+++ b/vl.c
@@ -1277,11 +1277,6 @@ static void smp_parse(QemuOpts *opts)
 
         max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
 
-        if (max_cpus > MAX_CPUMASK_BITS) {
-            error_report("unsupported number of maxcpus");
-            exit(1);
-        }
-
         if (max_cpus < cpus) {
             error_report("maxcpus must be equal to or greater than smp");
             exit(1);
-- 
2.11.0.259.g40922b1
