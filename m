Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tra-0000ZD-0z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5trZ-0001Ju-4e
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:38 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  3 May 2017 14:57:16 +0200
Message-Id: <1493816238-33120-23-git-send-email-imammedo@redhat.com>
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/24] numa: remove node_cpu bitmaps as they
 are no longer used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

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
---
 include/sysemu/numa.h |  1 -
 numa.c                | 42 ------------------------------------------
 2 files changed, 43 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 0b0a044..7f2d397 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -17,7 +17,6 @@ struct numa_addr_range {
 
 typedef struct node_info {
     uint64_t node_mem;
-    unsigned long *node_cpu;
     struct HostMemoryBackend *node_memdev;
     bool present;
     QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
diff --git a/numa.c b/numa.c
index d7aa662..40e9f44 100644
--- a/numa.c
+++ b/numa.c
@@ -177,7 +177,6 @@ static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
                        cpus->value, max_cpus);
             return;
         }
-        bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
         props = mc->cpu_index_to_instance_props(ms, cpus->value);
         props.node_id = nodenr;
         props.has_node_id = true;
@@ -261,51 +260,12 @@ end:
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
 void parse_numa_opts(MachineState *ms)
 {
     int i;
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    for (i = 0; i < MAX_NODES; i++) {
-        numa_info[i].node_cpu = bitmap_new(max_cpus);
-    }
-
     if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
         exit(1);
     }
@@ -397,12 +357,10 @@ void parse_numa_opts(MachineState *ms)
                 props = mc->cpu_index_to_instance_props(ms, i);
                 props.has_node_id = true;
 
-                set_bit(i, numa_info[props.node_id].node_cpu);
                 machine_set_cpu_numa_node(ms, &props, &error_fatal);
             }
         }
 
-        validate_numa_cpus();
     } else {
         numa_set_mem_node_id(0, ram_size, 0);
     }
-- 
2.7.4
