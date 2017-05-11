Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcf-0002rJ-Jm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcc-00080O-DJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcc-00080C-3m
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:38 -0300
Message-Id: <20170511191843.13784-25-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 24/29] numa: remove node_cpu bitmaps as they are
 no longer used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Postfactum "CPU(s) present in multiple NUMA nodes" check
was the last user of node_cpu bitmaps, but it's not need
as machine_set_cpu_numa_node() does the similar check at
the time mapping is set for cpus (i.e. when -numa cpus=
is parsed) and ensures that cpu can be mapped only to
one node.

Remove duplicate check based on node_cpu bitmaps and
since the last user is gone remove node_cpu as well,
which completes internal transition from legacy bitmap
based mapping storage to possible_cpus storage.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <1494415802-227633-17-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h |  1 -
 numa.c                | 43 -------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 8cb3ebc233..7ffde5b119 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -18,7 +18,6 @@ struct numa_addr_range {
 
 struct node_info {
     uint64_t node_mem;
-    unsigned long *node_cpu;
     struct HostMemoryBackend *node_memdev;
     bool present;
     QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
diff --git a/numa.c b/numa.c
index 63bff5a54d..ca122ccb13 100644
--- a/numa.c
+++ b/numa.c
@@ -178,7 +178,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                        cpus->value, max_cpus);
             return;
         }
-        bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
         props = mc->cpu_index_to_instance_props(ms, cpus->value);
         props.node_id = nodenr;
         props.has_node_id = true;
@@ -305,41 +304,6 @@ end:
     return 0;
 }
 
-static char *enumerate_cpus(unsigned long *cpus, int max_cpus)
-{
-    int cpu;
-    bool first = true;
-    GString *s = g_string_new(NULL);
-
-    for (cpu = find_first_bit(cpus, max_cpus);
-        cpu < max_cpus;
-        cpu = find_next_bit(cpus, max_cpus, cpu + 1)) {
-        g_string_append_printf(s, "%s%d", first ? "" : " ", cpu);
-        first = false;
-    }
-    return g_string_free(s, FALSE);
-}
-
-static void validate_numa_cpus(void)
-{
-    int i;
-    unsigned long *seen_cpus = bitmap_new(max_cpus);
-
-    for (i = 0; i < nb_numa_nodes; i++) {
-        if (bitmap_intersects(seen_cpus, numa_info[i].node_cpu, max_cpus)) {
-            bitmap_and(seen_cpus, seen_cpus,
-                       numa_info[i].node_cpu, max_cpus);
-            error_report("CPU(s) present in multiple NUMA nodes: %s",
-                         enumerate_cpus(seen_cpus, max_cpus));
-            g_free(seen_cpus);
-            exit(EXIT_FAILURE);
-        }
-        bitmap_or(seen_cpus, seen_cpus,
-                  numa_info[i].node_cpu, max_cpus);
-    }
-    g_free(seen_cpus);
-}
-
 /* If all node pair distances are symmetric, then only distances
  * in one direction are enough. If there is even one asymmetric
  * pair, though, then all distances must be provided. The
@@ -451,10 +415,6 @@ void parse_numa_opts(MachineState *ms)
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    for (i = 0; i < MAX_NODES; i++) {
-        numa_info[i].node_cpu = bitmap_new(max_cpus);
-    }
-
     if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
         exit(1);
     }
@@ -531,13 +491,10 @@ void parse_numa_opts(MachineState *ms)
                 props = mc->cpu_index_to_instance_props(ms, i);
                 props.has_node_id = true;
 
-                set_bit(i, numa_info[props.node_id].node_cpu);
                 machine_set_cpu_numa_node(ms, &props, &error_fatal);
             }
         }
 
-        validate_numa_cpus();
-
         /* QEMU needs at least all unique node pair distances to build
          * the whole NUMA distance table. QEMU treats the distance table
          * as symmetric by default, i.e. distance A->B == distance B->A.
-- 
2.11.0.259.g40922b1
