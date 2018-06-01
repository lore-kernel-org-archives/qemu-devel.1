Received: from eggs.gnu.org ([2001:4830:134:3::10]:40378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf98-0000RL-Ui
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf94-0000Gx-3F
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:20629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fOf93-0000F3-Pq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:46 -0400
From: junyan.he@gmx.com
Date: Fri,  1 Jun 2018 16:10:23 +0800
Message-Id: <1527840629-18648-2-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH V6 1/7] memory,
 exec: Expose all memory block related flags.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We need to use these flags in other files rather than just in exec.c,
For example, RAM_SHARED should be used when create a ram block from file.
We expose them the exec/memory.h

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 exec.c                | 17 -----------------
 include/exec/memory.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/exec.c b/exec.c
index c30f905..302c04b 100644
--- a/exec.c
+++ b/exec.c
@@ -87,23 +87,6 @@ AddressSpace address_space_memory;
 
 MemoryRegion io_mem_rom, io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
-
-/* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
-#define RAM_PREALLOC   (1 << 0)
-
-/* RAM is mmap-ed with MAP_SHARED */
-#define RAM_SHARED     (1 << 1)
-
-/* Only a portion of RAM (used_length) is actually used, and migrated.
- * This used_length size can change across reboots.
- */
-#define RAM_RESIZEABLE (1 << 2)
-
-/* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
- * zero the page and wake waiting processes.
- * (Set during postcopy)
- */
-#define RAM_UF_ZEROPAGE (1 << 3)
 #endif
 
 #ifdef TARGET_PAGE_BITS_VARY
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 67ea7fe..3da315e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -102,6 +102,23 @@ struct IOMMUNotifier {
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
 
+/* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
+#define RAM_PREALLOC   (1 << 0)
+
+/* RAM is mmap-ed with MAP_SHARED */
+#define RAM_SHARED     (1 << 1)
+
+/* Only a portion of RAM (used_length) is actually used, and migrated.
+ * This used_length size can change across reboots.
+ */
+#define RAM_RESIZEABLE (1 << 2)
+
+/* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
+ * zero the page and wake waiting processes.
+ * (Set during postcopy)
+ */
+#define RAM_UF_ZEROPAGE (1 << 3)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end)
-- 
2.7.4
