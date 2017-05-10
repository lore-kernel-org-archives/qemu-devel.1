Received: from eggs.gnu.org ([2001:4830:134:3::10]:35593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8PpO-0007tB-8B
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8PpN-0001pO-CC
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 10 May 2017 13:29:57 +0200
Message-Id: <1494415802-227633-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/18] numa: remove no longer need
 numa_post_machine_init()
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

CPUState::numa_node is still in use but now it's set by
board when it creates CPU objects. So there isn't any
need to set it again after all CPU's are created,
since it's been already set.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 include/sysemu/numa.h |  6 ------
 numa.c                | 15 ---------------
 vl.c                  |  2 --
 3 files changed, 23 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 027830c..8cb3ebc 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -27,7 +27,6 @@ struct node_info {
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
-void numa_post_machine_init(void);
 void query_numa_node_mem(uint64_t node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
@@ -37,9 +36,4 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
-
-
-/* on success returns node index in numa_info,
- * on failure returns nb_numa_nodes */
-int numa_get_node_for_cpu(int idx);
 #endif
diff --git a/numa.c b/numa.c
index f16a6a8..dc739ea 100644
--- a/numa.c
+++ b/numa.c
@@ -572,21 +572,6 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
-void numa_post_machine_init(void)
-{
-    CPUState *cpu;
-    int i;
-
-    CPU_FOREACH(cpu) {
-        for (i = 0; i < nb_numa_nodes; i++) {
-            assert(cpu->cpu_index < max_cpus);
-            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
-                cpu->numa_node = i;
-            }
-        }
-    }
-}
-
 static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                            const char *name,
                                            uint64_t ram_size)
diff --git a/vl.c b/vl.c
index c63f4d5..fe4741d 100644
--- a/vl.c
+++ b/vl.c
@@ -4595,8 +4595,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     rom_reset_order_override();
 
     /*
-- 
2.7.4
