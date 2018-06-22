Received: from eggs.gnu.org ([2001:4830:134:3::10]:46307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWNF7-00059Z-6D
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWNF4-0002UV-1R
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fWNF3-0002UJ-SW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 22 Jun 2018 16:40:45 +0200
Message-Id: <20180622144045.737-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] numa: report all DIMM/NVDIMMs as plugged
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eugene Crosser <evgenii.cherkashin@profitbricks.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, David Hildenbrand <david@redhat.com>

Right now, there is some inconsistency between hotplugged and
coldplugged memory. DIMMs added via "-device" result in different stats
than DIMMs added using "device_add".

E.g.
    [...]
    -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
    -m 4G,maxmem=20G,slots=2 \
    -object memory-backend-ram,id=mem0,size=8G \
    -device pc-dimm,id=dimm0,memdev=mem0 \
    -object memory-backend-ram,id=mem1,size=8G \
    -device nvdimm,id=dimm1,memdev=mem1,node=1

Results in NUMA info
    (qemu) info numa
    info numa
    2 nodes
    node 0 cpus: 0 1
    node 0 size: 10240 MB
    node 0 plugged: 0 MB
    node 1 cpus: 2 3
    node 1 size: 10240 MB
    node 1 plugged: 0 MB

But in memory size summary:
    (qemu) info memory_size_summary
    info memory_size_summary
    base memory: 4294967296
    plugged memory: 17179869184

Make this consistent by reporting all hot and coldplugged
memory a.k.a. DIMM and NVDIMM as "plugged".

Fixes: 31959e82fb0 ("hmp: extend "info numa" with hotplugged memory information")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 numa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/numa.c b/numa.c
index 94f758c757..5f6367b989 100644
--- a/numa.c
+++ b/numa.c
@@ -566,10 +566,8 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 
             if (pcdimm_info) {
                 node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
-                if (pcdimm_info->hotpluggable && pcdimm_info->hotplugged) {
-                    node_mem[pcdimm_info->node].node_plugged_mem +=
-                        pcdimm_info->size;
-                }
+                node_mem[pcdimm_info->node].node_plugged_mem +=
+                    pcdimm_info->size;
             }
         }
     }
-- 
2.17.1
