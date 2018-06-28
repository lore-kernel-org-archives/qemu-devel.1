Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAS-00076x-KA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAR-0000C5-Gb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:24 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAR-0000AL-7u
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:23 -0400
Received: by mail-wr0-x232.google.com with SMTP id c5-v6so6680844wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:18 +0200
Message-Id: <1530216310-52873-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/60] memory-device: turn alignment assert into
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

The start of the address space indicates which maximum alignment is
supported by our machine (e.g. ppc, x86 1GB). This is helpful to
catch fragmenting guest physical memory in strange fashions.

Right now we can crash QEMU by e.g. (there might be easier examples)

qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 \
 -object memory-backend-file,id=mem0,size=8192M,mem-path=/dev/zero,align=8192M \
 -device pc-dimm,id=dimm1,memdev=mem0

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180607154705.6316-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/memory-device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3e04f39..6de4f70 100644
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
1.8.3.1
