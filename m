Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z4N-0005vJ-P0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z4M-0002pe-3e
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1g9z4L-0002ls-T3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue,  9 Oct 2018 22:56:51 +0200
Message-Id: <20181009205652.10605-7-david@redhat.com>
In-Reply-To: <20181009205652.10605-1-david@redhat.com>
References: <20181009205652.10605-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/7] memory-device: avoid overflows on very
 huge devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Should not be a problem right now, but it could theoretically happen
in the future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 996ad1490f..8be63c8032 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -85,7 +85,8 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
 
     /* will we exceed the total amount of memory specified */
     memory_device_used_region_size(OBJECT(ms), &used_region_size);
-    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
+    if (used_region_size + size < used_region_size ||
+        used_region_size + size > ms->maxram_size - ms->ram_size) {
         error_setg(errp, "not enough space, currently 0x%" PRIx64
                    " in use of total space for memory devices 0x" RAM_ADDR_FMT,
                    used_region_size, ms->maxram_size - ms->ram_size);
-- 
2.17.1
