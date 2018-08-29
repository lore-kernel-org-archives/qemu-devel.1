Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wv-0004qX-85
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wu-000294-CT
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wu-00028z-6y
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:17 +0200
Message-Id: <20180829153624.12299-14-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/20] hw/acpi-build: only indicate nvdimm
 and pc-dimm
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

Once we have other memory devices that are not ACPI devices (e.g.
virtio based), we cannot indicate them via ACPI. So let's skip these
devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/acpi-build.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae9e0..2278522b87 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2266,7 +2266,6 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
     for (cur = base, info = info_list;
          cur < end;
          cur += size, info = info->next) {
-        numamem = acpi_data_push(table_data, sizeof *numamem);
 
         if (!info) {
             /*
@@ -2278,19 +2277,30 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
              * Memory devices may override proximity set by this entry,
              * providing _PXM method if necessary.
              */
+            numamem = acpi_data_push(table_data, sizeof *numamem);
             build_srat_memory(numamem, end - 1, 1, default_node,
                               MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
             break;
         }
 
         mi = info->value;
+        if (mi->type != MEMORY_DEVICE_INFO_KIND_DIMM &&
+            mi->type != MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            /*
+             * Don't indicate memory devices that are not proper ACPI devices,
+             * merge them with the empty ranges.
+             */
+            size = 0;
+            continue;
+        }
+
         is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
         di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
 
         if (cur < di->addr) {
+            numamem = acpi_data_push(table_data, sizeof *numamem);
             build_srat_memory(numamem, cur, di->addr - cur, default_node,
                               MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-            numamem = acpi_data_push(table_data, sizeof *numamem);
         }
 
         size = di->size;
@@ -2303,6 +2313,7 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
             flags |= MEM_AFFINITY_NON_VOLATILE;
         }
 
+        numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, di->addr, size, di->node, flags);
     }
 
-- 
2.17.1
