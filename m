Received: from eggs.gnu.org ([2001:4830:134:3::10]:54614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMo-0005l5-US
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMn-00015G-Ji
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:07 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:32874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLCMn-00014w-8d
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:05 -0400
Received: by mail-lf0-x22b.google.com with SMTP id m77so6470025lfe.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:46:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 14 Jun 2017 19:45:52 +0200
Message-Id: <1497462353-3432-7-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 6/7] exec: allow to get a pointer for some
 mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: fred.konrad@greensocs.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This introduces a special callback which allows to run code from some MMIO
devices.

SysBusDevice with a MemoryRegion which implements the request_ptr callback will
be notified when the guest try to execute code from their offset. Then it will
be able to eg: pre-load some code from an SPI device or ask a pointer from an
external simulator, etc..

When the pointer or the data in it are no longer valid the device has to
invalidate it.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V2 -> V3:
  * Put the invalidate in an async work.
  * Clear the dirty flag before dropping the mmio interface.
  * Rebase against recent cpu_handle_unaligned changes.
RFC -> V1:
  * Use mmio-interface instead of directly creating the subregion.
---
 cputlb.c              |  10 +++++
 include/exec/memory.h |  35 ++++++++++++++++
 memory.c              | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)

diff --git a/cputlb.c b/cputlb.c
index 95265a0..1900936 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -858,6 +858,16 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
     mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
     if (memory_region_is_unassigned(mr)) {
+        qemu_mutex_lock_iothread();
+        if (memory_region_request_mmio_ptr(mr, addr)) {
+            qemu_mutex_unlock_iothread();
+            /* A MemoryRegion is potentially added so re-run the
+             * get_page_addr_code.
+             */
+            return get_page_addr_code(env, addr);
+        }
+        qemu_mutex_unlock_iothread();
+
         cpu_unassigned_access(cpu, addr, false, true, 0, 4);
         /* The CPU's unassigned access hook might have longjumped out
          * with an exception. If it didn't (or there was no hook) then
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 80e605a..137339a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -137,6 +137,15 @@ struct MemoryRegionOps {
                                     uint64_t data,
                                     unsigned size,
                                     MemTxAttrs attrs);
+    /* Instruction execution pre-callback:
+     * @addr is the address of the access relative to the @mr.
+     * @size is the size of the area returned by the callback.
+     * @offset is the location of the pointer inside @mr.
+     *
+     * Returns a pointer to a location which contains guest code.
+     */
+    void *(*request_ptr)(void *opaque, hwaddr addr, unsigned *size,
+                         unsigned *offset);
 
     enum device_endian endianness;
     /* Guest-visible constraints: */
@@ -1354,6 +1363,32 @@ void memory_global_dirty_log_stop(void);
 void mtree_info(fprintf_function mon_printf, void *f, bool flatview);
 
 /**
+ * memory_region_request_mmio_ptr: request a pointer to an mmio
+ * MemoryRegion. If it is possible map a RAM MemoryRegion with this pointer.
+ * When the device wants to invalidate the pointer it will call
+ * memory_region_invalidate_mmio_ptr.
+ *
+ * @mr: #MemoryRegion to check
+ * @addr: address within that region
+ *
+ * Returns true on success, false otherwise.
+ */
+bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr);
+
+/**
+ * memory_region_invalidate_mmio_ptr: invalidate the pointer to an mmio
+ * previously requested.
+ * In the end that means that if something wants to execute from this area it
+ * will need to request the pointer again.
+ *
+ * @mr: #MemoryRegion associated to the pointer.
+ * @addr: address within that region
+ * @size: size of that area.
+ */
+void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
+                                       unsigned size);
+
+/**
  * memory_region_dispatch_read: perform a read directly to the specified
  * MemoryRegion.
  *
diff --git a/memory.c b/memory.c
index 0ddc4cc..9c89dd4 100644
--- a/memory.c
+++ b/memory.c
@@ -30,6 +30,8 @@
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "hw/misc/mmio_interface.h"
+#include "hw/qdev-properties.h"
 
 //#define DEBUG_UNASSIGNED
 
@@ -2424,6 +2426,115 @@ void memory_listener_unregister(MemoryListener *listener)
     listener->address_space = NULL;
 }
 
+bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
+{
+    void *host;
+    unsigned size = 0;
+    unsigned offset = 0;
+    Object *new_interface;
+
+    if (!mr || !mr->ops->request_ptr) {
+        return false;
+    }
+
+    /*
+     * Avoid an update if the request_ptr call
+     * memory_region_invalidate_mmio_ptr which seems to be likely when we use
+     * a cache.
+     */
+    memory_region_transaction_begin();
+
+    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
+
+    if (!host || !size) {
+        memory_region_transaction_commit();
+        return false;
+    }
+
+    new_interface = object_new("mmio_interface");
+    qdev_prop_set_uint64(DEVICE(new_interface), "start", offset);
+    qdev_prop_set_uint64(DEVICE(new_interface), "end", offset + size - 1);
+    qdev_prop_set_bit(DEVICE(new_interface), "ro", true);
+    qdev_prop_set_ptr(DEVICE(new_interface), "host_ptr", host);
+    qdev_prop_set_ptr(DEVICE(new_interface), "subregion", mr);
+    object_property_set_bool(OBJECT(new_interface), true, "realized", NULL);
+
+    memory_region_transaction_commit();
+    return true;
+}
+
+typedef struct MMIOPtrInvalidate {
+    MemoryRegion *mr;
+    hwaddr offset;
+    unsigned size;
+    int busy;
+    int allocated;
+} MMIOPtrInvalidate;
+
+#define MAX_MMIO_INVALIDATE 10
+static MMIOPtrInvalidate mmio_ptr_invalidate_list[MAX_MMIO_INVALIDATE];
+
+static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
+                                                 run_on_cpu_data data)
+{
+    MMIOPtrInvalidate *invalidate_data = (MMIOPtrInvalidate *)data.host_ptr;
+    MemoryRegion *mr = invalidate_data->mr;
+    hwaddr offset = invalidate_data->offset;
+    unsigned size = invalidate_data->size;
+    MemoryRegionSection section = memory_region_find(mr, offset, size);
+
+    qemu_mutex_lock_iothread();
+
+    /* Reset dirty so this doesn't happen later. */
+    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
+
+    if (section.mr != mr) {
+        /* memory_region_find add a ref on section.mr */
+        memory_region_unref(section.mr);
+        if (MMIO_INTERFACE(section.mr->owner)) {
+            /* We found the interface just drop it. */
+            object_property_set_bool(section.mr->owner, false, "realized",
+                                     NULL);
+            object_unref(section.mr->owner);
+            object_unparent(section.mr->owner);
+        }
+    }
+
+    qemu_mutex_unlock_iothread();
+
+    if (invalidate_data->allocated) {
+        g_free(invalidate_data);
+    } else {
+        invalidate_data->busy = 0;
+    }
+}
+
+void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
+                                       unsigned size)
+{
+    size_t i;
+    MMIOPtrInvalidate *invalidate_data = NULL;
+
+    for (i = 0; i < MAX_MMIO_INVALIDATE; i++) {
+        if (atomic_cmpxchg(&(mmio_ptr_invalidate_list[i].busy), 0, 1) == 0) {
+            invalidate_data = &mmio_ptr_invalidate_list[i];
+            break;
+        }
+    }
+
+    if (!invalidate_data) {
+        invalidate_data = g_malloc0(sizeof(MMIOPtrInvalidate));
+        invalidate_data->allocated = 1;
+    }
+
+    invalidate_data->mr = mr;
+    invalidate_data->offset = offset;
+    invalidate_data->size = size;
+
+    async_safe_run_on_cpu(first_cpu, memory_region_do_invalidate_mmio_ptr,
+                          RUN_ON_CPU_HOST_PTR(invalidate_data));
+}
+
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-- 
2.7.4
