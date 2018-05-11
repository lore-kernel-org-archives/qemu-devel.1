Received: from eggs.gnu.org ([2001:4830:134:3::10]:35259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7y4-0000pv-Bn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7xy-0003ie-Rh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:37 +0200
Message-Id: <20180511131953.12905-2-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/17] memory-device: drop assert related to
 align and start of address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

The start of the address space does not have to be aligned for the
search. Handly this case explicitly when starting the search for a new
address.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3e04f3954e..361d38bfc5 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -116,7 +116,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
     address_space_start = ms->device_memory->base;
     address_space_end = address_space_start +
                         memory_region_size(&ms->device_memory->mr);
-    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
     g_assert(address_space_end >= address_space_start);
 
     memory_device_check_addable(ms, size, errp);
@@ -149,7 +148,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
             return 0;
         }
     } else {
-        new_addr = address_space_start;
+        new_addr = QEMU_ALIGN_UP(address_space_start, align);
     }
 
     /* find address range that will fit new memory device */
-- 
2.14.3
