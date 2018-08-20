Received: from eggs.gnu.org ([2001:4830:134:3::10]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjC-0001Fq-DC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqj6-00089h-PV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqj1-00084t-CC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:33 -0400
Date: Mon, 20 Aug 2018 23:24:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-2-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] memory,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Junyan He <junyan.he@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Junyan He <junyan.he@intel.com>

We need to use these flags in other files rather than just in exec.c,
For example, RAM_SHARED should be used when create a ram block from file.
We expose them the exec/memory.h

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 20 ++++++++++++++++++++
 exec.c                | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 448d41a752..6d0af29155 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -103,6 +103,26 @@ struct IOMMUNotifier {
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
+/* RAM can be migrated */
+#define RAM_MIGRATABLE (1 << 4)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/exec.c b/exec.c
index 4f5df07b6a..cc042dcefd 100644
--- a/exec.c
+++ b/exec.c
@@ -87,26 +87,6 @@ AddressSpace address_space_memory;
 
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
-
-/* RAM can be migrated */
-#define RAM_MIGRATABLE (1 << 4)
 #endif
 
 #ifdef TARGET_PAGE_BITS_VARY
-- 
MST
