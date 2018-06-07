Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx8A-0007x9-DQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx86-0001FX-P1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQx86-0001FK-JQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 17:47:04 +0200
Message-Id: <20180607154705.6316-2-david@redhat.com>
In-Reply-To: <20180607154705.6316-1-david@redhat.com>
References: <20180607154705.6316-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] memory-device: turn alignment assert
 into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com

The start of the address space indicates which maximum alignment is
supported by our machine (e.g. ppc, x86 1GB). This is helpful to
catch fragmenting guest physical memory in strange fashions.

Right now we can crash QEMU by e.g. (there might be easier examples)

qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 \
 -object memory-backend-file,id=mem0,size=8192M,mem-path=/dev/zero,align=8192M \
 -device pc-dimm,id=dimm1,memdev=mem0

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3e04f3954e..6de4f70bb4 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -116,9 +116,15 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
     address_space_start = ms->device_memory->base;
     address_space_end = address_space_start +
                         memory_region_size(&ms->device_memory->mr);
-    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
     g_assert(address_space_end >= address_space_start);
 
+    /* address_space_start indicates the maximum alignment we expect */
+    if (QEMU_ALIGN_UP(address_space_start, align) != address_space_start) {
+        error_setg(errp, "the alignment (0%" PRIx64 ") is not supported",
+                   align);
+        return 0;
+    }
+
     memory_device_check_addable(ms, size, errp);
     if (*errp) {
         return 0;
-- 
2.17.0
