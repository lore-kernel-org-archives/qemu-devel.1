Received: from eggs.gnu.org ([2001:4830:134:3::10]:44384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRy-00049u-Iq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRw-0004pW-CD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:10 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimRw-0004p2-1C
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:08 -0500
Received: by mail-wm0-x231.google.com with SMTP id f3so28128122wmc.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:15 +0100
Message-Id: <1517858941-5538-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/47] memory: update comments and fix some typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jay Zhou <jianjay.zhou@huawei.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Message-Id: <1515043788-38300-1-git-send-email-jianjay.zhou@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 07c5d6d..67e4ee3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -324,7 +324,7 @@ FlatView *address_space_to_flatview(AddressSpace *as);
  * MemoryRegionSection: describes a fragment of a #MemoryRegion
  *
  * @mr: the region, or %NULL if empty
- * @address_space: the address space the region is mapped in
+ * @fv: the flat view of the address space the region is mapped in
  * @offset_within_region: the beginning of the section, relative to @mr's start
  * @size: the size of the section; will not exceed @mr's boundaries
  * @offset_within_address_space: the address of the first byte of the section
@@ -610,6 +610,7 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -653,11 +654,10 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
  * An IOMMU region translates addresses and forwards accesses to a target
  * memory region.
  *
- * @typename: QOM class name
  * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
  * @instance_size: the IOMMUMemoryRegion subclass instance size
+ * @mrtypename: the type name of the #IOMMUMemoryRegion
  * @owner: the object that tracks the region's reference count
- * @ops: a function that translates addresses into the @target region
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
  */
@@ -827,8 +827,8 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
  * memory_region_get_iommu_class_nocheck: returns iommu memory region class
  *   if an iommu or NULL if not
  *
- * Returns pointer to IOMMUMemoryRegioniClass if a memory region is an iommu,
- * otherwise NULL. This is fast path avoinding QOM checking, use with caution.
+ * Returns pointer to IOMMUMemoryRegionClass if a memory region is an iommu,
+ * otherwise NULL. This is fast path avoiding QOM checking, use with caution.
  *
  * @mr: the memory region being queried
  */
@@ -993,7 +993,8 @@ int memory_region_get_fd(MemoryRegion *mr);
  * protecting the pointer, such as a reference to the region that includes
  * the incoming ram_addr_t.
  *
- * @mr: the memory region being queried.
+ * @ptr: the host pointer to be converted
+ * @offset: the offset within memory region
  */
 MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset);
 
@@ -1270,7 +1271,7 @@ void memory_region_clear_global_locking(MemoryRegion *mr);
  * @size: the size of the access to trigger the eventfd
  * @match_data: whether to match against @data, instead of just @addr
  * @data: the data to match against the guest write
- * @fd: the eventfd to be triggered when @addr, @size, and @data all match.
+ * @e: event notifier to be triggered when @addr, @size, and @data all match.
  **/
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
@@ -1290,7 +1291,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
  * @size: the size of the access to trigger the eventfd
  * @match_data: whether to match against @data, instead of just @addr
  * @data: the data to match against the guest write
- * @fd: the eventfd to be triggered when @addr, @size, and @data all match.
+ * @e: event notifier to be triggered when @addr, @size, and @data all match.
  */
 void memory_region_del_eventfd(MemoryRegion *mr,
                                hwaddr addr,
@@ -1526,7 +1527,7 @@ bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr);
  * will need to request the pointer again.
  *
  * @mr: #MemoryRegion associated to the pointer.
- * @addr: address within that region
+ * @offset: offset within the memory region
  * @size: size of that area.
  */
 void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
@@ -1595,6 +1596,7 @@ void address_space_destroy(AddressSpace *as);
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
  * @is_write: indicates the transfer direction
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
@@ -1612,6 +1614,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
@@ -1810,7 +1813,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * called from an RCU critical section, to avoid that the last reference
  * to the returned region disappears after address_space_translate returns.
  *
- * @as: #AddressSpace to be accessed
+ * @fv: #FlatView to be accessed
  * @addr: address within that address space
  * @xlat: pointer to address within the returned memory region section's
  * #MemoryRegion.
@@ -1868,7 +1871,7 @@ void *address_space_map(AddressSpace *as, hwaddr addr,
  * the amount of memory that was actually read or written by the caller.
  *
  * @as: #AddressSpace used
- * @addr: address within that address space
+ * @buffer: host pointer as returned by address_space_map()
  * @len: buffer length as returned by address_space_map()
  * @access_len: amount of data actually transferred
  * @is_write: indicates the transfer direction
@@ -1905,7 +1908,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * or failed (eg unassigned memory, device rejected the transaction,
  * IOMMU fault).
  *
- * @as: #AddressSpace to be accessed
+ * @fv: #FlatView to be accessed
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
-- 
1.8.3.1
