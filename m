Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcW-0002lr-Tf
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcW-0007xp-1g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcV-0007xf-RS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:35 -0300
Message-Id: <20170511191843.13784-22-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] numa: remove no longer need
 numa_post_machine_init()
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

CPUState::numa_node is still in use but now it's set by
board when it creates CPU objects. So there isn't any
need to set it again after all CPU's are created,
since it's been already set.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <1494415802-227633-14-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h |  6 ------
 numa.c                | 15 ---------------
 vl.c                  |  2 --
 3 files changed, 23 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 027830cf7e..8cb3ebc233 100644
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
index f16a6a8ade..dc739eadfa 100644
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
index c4705b3335..5cd0c17ba0 100644
--- a/vl.c
+++ b/vl.c
@@ -4592,8 +4592,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     rom_reset_order_override();
 
     /*
-- 
2.11.0.259.g40922b1
