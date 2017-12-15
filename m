Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePnmF-0002pf-WB
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePnmB-0001lf-RX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:03:40 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 15 Dec 2017 12:03:23 +0100
Message-Id: <20171215110323.16400-2-cohuck@redhat.com>
In-Reply-To: <20171215110323.16400-1-cohuck@redhat.com>
References: <20171215110323.16400-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 46/46] s390-ccw-virtio: allow for systems
 larger that 7.999TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm must
be a multiple of 1MB we need start a new memory region if we cross
8TB-1M.

With that (and optimistic overcommitment in the kernel) I was able to
start a 24TB guest on a 1TB system.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171211122146.162430-1-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[CH: 1UL -> 1ULL in KVM_MEM_MAX_NR_PAGES; build fix on 32 bit hosts]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 466e45343c..35df7e19c5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -152,14 +152,38 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
+/*
+ * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
+ * as the dirty bitmap must be managed by bitops that take an int as
+ * position indicator. If we have a guest beyond that we will split off
+ * new subregions. The split must happen on a segment boundary (1MB).
+ */
+#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
+#define SEG_MSK (~0xfffffULL)
+#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    ram_addr_t chunk, offset = 0;
+    unsigned int number = 0;
+    gchar *name;
 
     /* allocate RAM for core */
-    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    name = g_strdup_printf("s390.ram");
+    while (mem_size) {
+        MemoryRegion *ram = g_new(MemoryRegion, 1);
+        uint64_t size = mem_size;
+
+        /* KVM does not allow memslots >= 8 TB */
+        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
+        memory_region_allocate_system_memory(ram, NULL, name, chunk);
+        memory_region_add_subregion(sysmem, offset, ram);
+        mem_size -= chunk;
+        offset += chunk;
+        g_free(name);
+        name = g_strdup_printf("s390.ram.%u", ++number);
+    }
+    g_free(name);
 
     /* Initialize storage key device */
     s390_skeys_init();
-- 
2.13.6
