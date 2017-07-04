Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRE1-0001Pq-KH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRE0-0005aZ-Hx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dSRE0-0005KD-Aq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Jul 2017 18:02:41 +0100
Message-Id: <1499187763-8211-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] include/hw/boards.h: Document
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Add a documentation comment for memory_region_allocate_system_memory().

In particular, the reason for this function's existence and the
requirement on board code to call it exactly once are non-obvious.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 76ce021..1bc5389 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -9,6 +9,34 @@
 #include "qom/object.h"
 #include "qom/cpu.h"
 
+/**
+ * memory_region_allocate_system_memory - Allocate a board's main memory
+ * @mr: the #MemoryRegion to be initialized
+ * @owner: the object that tracks the region's reference count
+ * @name: name of the memory region
+ * @ram_size: size of the region in bytes
+ *
+ * This function allocates the main memory for a board model, and
+ * initializes @mr appropriately. It also arranges for the memory
+ * to be migrated (by calling vmstate_register_ram_global()).
+ *
+ * Memory allocated via this function will be backed with the memory
+ * backend the user provided using -mem-path if appropriate; this
+ * is typically used to cause host huge pages to be used.
+ * This function should therefore be called by a board exactly once,
+ * for the primary or largest RAM area it implements.
+ *
+ * For boards where the major RAM is split into two parts in the memory
+ * map, you can deal with this by calling memory_region_allocate_system_memory()
+ * once to get a MemoryRegion with enough RAM for both parts, and then
+ * creating alias MemoryRegions via memory_region_init_alias() which
+ * alias into different parts of the RAM MemoryRegion and can be mapped
+ * into the memory map in the appropriate places.
+ *
+ * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
+ * to be backed via the -mem-path memory backend and can simply
+ * be created via memory_region_init_ram().
+ */
 void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
                                           const char *name,
                                           uint64_t ram_size);
-- 
2.7.4
