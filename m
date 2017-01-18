Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYs-0000tE-NF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYr-0003a5-6a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:58 -0500
Received: from [59.151.112.132] (port=61481 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYq-0003Wn-N2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:57 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 20:40:06 +0800
Message-ID: <1484743207-10721-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] numa: Remove the numa_post_machine_init
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Current default way of seting the CPUState::numa_node in the
numa_post_machine_init() and calling it in vl.c:main() would
make the data incorrect in case on cold/hot-plug CPUs.

Now, we move it to the qom/cpu.c:cpu_common_realizefn().
So, Here we remove it.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 include/sysemu/numa.h |  1 -
 numa.c                | 15 ---------------
 vl.c                  |  2 --
 3 files changed, 18 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 8f09dcf..b8015a5 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -25,7 +25,6 @@ typedef struct node_info {
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineClass *mc);
-void numa_post_machine_init(void);
 void query_numa_node_mem(uint64_t node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
diff --git a/numa.c b/numa.c
index 379bc8a..5f68497 100644
--- a/numa.c
+++ b/numa.c
@@ -394,21 +394,6 @@ void parse_numa_opts(MachineClass *mc)
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
index c643d3f..afe40ce 100644
--- a/vl.c
+++ b/vl.c
@@ -4549,8 +4549,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
-- 
2.5.5
