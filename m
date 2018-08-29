Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2X7-0004z8-Hb
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2X5-0002F4-Vk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2X5-0002Ee-Pv
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:23 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:22 +0200
Message-Id: <20180829153624.12299-19-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/20] numa: handle virtio-pmem in NUMA stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

Account the memory to node 0 for now. Once (if ever) virtio-pmem
supports NUMA, we can account it to the right node.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 numa.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/numa.c b/numa.c
index 81542d4ebb..8aa9b21a22 100644
--- a/numa.c
+++ b/numa.c
@@ -544,30 +544,31 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 {
     MemoryDeviceInfoList *info_list = qmp_memory_device_list();
     MemoryDeviceInfoList *info;
-    PCDIMMDeviceInfo     *pcdimm_info;
+    VirtioPMemDeviceInfo *vpi;
 
     for (info = info_list; info; info = info->next) {
         MemoryDeviceInfo *value = info->value;
+        PCDIMMDeviceInfo *pcdimm_info = NULL;
 
         if (value) {
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
                 pcdimm_info = value->u.dimm.data;
-                break;
-
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
-                pcdimm_info = value->u.nvdimm.data;
-                break;
-
-            default:
-                pcdimm_info = NULL;
-                break;
-            }
-
-            if (pcdimm_info) {
+                if (!pcdimm_info) {
+                    pcdimm_info = value->u.nvdimm.data;
+                }
                 node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
                 node_mem[pcdimm_info->node].node_plugged_mem +=
                     pcdimm_info->size;
+                break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
+                vpi = value->u.virtio_pmem.data;
+                /* TODO: once we support numa, assign to right node */
+                node_mem[0].node_mem += vpi->size;
+                node_mem[0].node_plugged_mem += vpi->size;
+            default:
+                break;
             }
         }
     }
-- 
2.17.1
