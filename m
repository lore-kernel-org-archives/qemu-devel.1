Received: from eggs.gnu.org ([209.51.188.92]:49944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOjm-00079o-TO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOd8-0002Wu-73
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:56:12 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Jan 2019 20:55:25 +0100
Message-Id: <20190123195527.29575-8-david@redhat.com>
In-Reply-To: <20190123195527.29575-1-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFCv2 7/9] hmp: Handle virtio-pmem when
 printing memory device infos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Print the memory device info just like for PCDIMM/NVDIMM.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hmp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8da5fd8760..25c32e0810 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2553,6 +2553,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
     MemoryDeviceInfoList *info;
+    VirtioPMEMDeviceInfo *vpi;
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
 
@@ -2562,19 +2563,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
         if (value) {
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
-                di = value->u.dimm.data;
-                break;
-
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
-                di = value->u.nvdimm.data;
-                break;
-
-            default:
-                di = NULL;
-                break;
-            }
-
-            if (di) {
+                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
+                     value->u.dimm.data : value->u.nvdimm.data;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                di->id ? di->id : "");
@@ -2587,6 +2578,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                                di->hotplugged ? "true" : "false");
                 monitor_printf(mon, "  hotpluggable: %s\n",
                                di->hotpluggable ? "true" : "false");
+                break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
+                vpi = value->u.virtio_pmem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               vpi->id ? vpi->id : "");
+                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
+                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
+                break;
+            default:
+                g_assert_not_reached();
             }
         }
     }
-- 
2.17.2
