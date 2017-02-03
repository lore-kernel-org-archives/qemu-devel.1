Received: from eggs.gnu.org ([2001:4830:134:3::10]:60792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKX-0004fA-9A
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKW-0002gh-7V
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:25 -0500
Received: from greensocs.com ([193.104.36.180]:39100)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKV-0002gW-TB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:24 -0500
From: fred.konrad@greensocs.com
Date: Fri,  3 Feb 2017 18:06:36 +0100
Message-Id: <1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [RFC 4/5] exec: allow to get a pointer for some mmio
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

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
---
 cputlb.c              |  7 +++++++
 include/exec/memory.h | 35 +++++++++++++++++++++++++++++++++++
 memory.c              | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/cputlb.c b/cputlb.c
index 846341e..9077247 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -545,6 +545,13 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     if (memory_region_is_unassigned(mr)) {
         CPUClass *cc = CPU_GET_CLASS(cpu);
 
+        if (memory_region_request_mmio_ptr(mr, addr)) {
+            /* A MemoryRegion is potentially added so re-run the
+             * get_page_addr_code.
+             */
+            return get_page_addr_code(env, addr);
+        }
+
         if (cc->do_unassigned_access) {
             cc->do_unassigned_access(cpu, addr, false, true, 0, 4);
         } else {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 987f925..36b0eec 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -120,6 +120,15 @@ struct MemoryRegionOps {
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
@@ -1253,6 +1262,32 @@ void memory_global_dirty_log_stop(void);
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
index 6c58373..eb3e8ec 100644
--- a/memory.c
+++ b/memory.c
@@ -2375,6 +2375,51 @@ void memory_listener_unregister(MemoryListener *listener)
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
 }
 
+bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
+{
+    void *host;
+    unsigned size = 0;
+    unsigned offset = 0;
+    MemoryRegion *sub;
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
+    sub = g_new(MemoryRegion, 1);
+    memory_region_init_ram_ptr(sub, OBJECT(mr), "mmio-map", size, host);
+    memory_region_add_subregion(mr, offset, sub);
+    memory_region_transaction_commit();
+    return true;
+}
+
+void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
+                                       unsigned size)
+{
+    MemoryRegionSection section = memory_region_find(mr, offset, size);
+
+    if (section.mr != mr) {
+        memory_region_del_subregion(mr, section.mr);
+        /* memory_region_find add a ref on section.mr */
+        memory_region_unref(section.mr);
+        object_unparent(OBJECT(section.mr));
+    }
+}
+
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-- 
1.8.3.1
