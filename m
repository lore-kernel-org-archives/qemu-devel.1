Received: from eggs.gnu.org ([2001:4830:134:3::10]:46594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cpvQR-0007IB-NT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cpvQN-00020t-Oh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:35 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 20 Mar 2017 12:24:26 +0100
Message-Id: <20170320112426.4030-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] numa,
 spapr: align default numa node memory size to 256MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Since commit 224245b ("spapr: Add LMB DR connectors"), NUMA node
memory size must be aligned to 256MB (SPAPR_MEMORY_BLOCK_SIZE).

But when "-numa" option is provided without "mem" parameter,
the memory is equally divided between nodes, but 8MB aligned.
This can be not valid for pseries.

In that case we can have:
$ ./ppc64-softmmu/qemu-system-ppc64 -m 4G -numa node -numa node -numa node
qemu-system-ppc64: Node 0 memory size 0x55000000 is not aligned to 256 MiB

With this patch, we have:
(qemu) info numa
3 nodes
node 0 cpus: 0
node 0 size: 1280 MB
node 1 cpus:
node 1 size: 1280 MB
node 2 cpus:
node 2 size: 1536 MB

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 dtc    |  2 +-
 numa.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/dtc b/dtc
index 558cd81..fa8bc7f 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
+Subproject commit fa8bc7f928ac25f23532afc8beb2073efc8fb063
diff --git a/numa.c b/numa.c
index e01cb54..a911284 100644
--- a/numa.c
+++ b/numa.c
@@ -337,15 +337,19 @@ void parse_numa_opts(MachineClass *mc)
         }
         if (i == nb_numa_nodes) {
             uint64_t usedmem = 0;
-
-            /* On Linux, each node's border has to be 8MB aligned,
-             * the final node gets the rest.
-             */
+#if defined(TARGET_PPC64)
+            /* pseries requests each node's border has to be 256 MB aligned */
+            const uint64_t numa_mem_align_mask = ~((1 << 28UL) - 1);
+#else
+            /* On Linux, each node's border has to be 8MB aligned */
+            const uint64_t numa_mem_align_mask = ~((1 << 23UL)  - 1);
+#endif
             for (i = 0; i < nb_numa_nodes - 1; i++) {
                 numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
-                                        ~((1 << 23UL) - 1);
+                                        numa_mem_align_mask;
                 usedmem += numa_info[i].node_mem;
             }
+            /* the final node gets the rest. */
             numa_info[i].node_mem = ram_size - usedmem;
         }
 
-- 
2.9.3
