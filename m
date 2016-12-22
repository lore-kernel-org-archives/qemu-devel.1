Received: from eggs.gnu.org ([2001:4830:134:3::10]:37635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D6-0007IG-60
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D1-00075j-Lb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D1-00075N-9N
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A6B21C6B3D
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:06 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xF027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:03 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:37 +0100
Message-Id: <20161222152300.32395-3-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/25] exec: introduce memory_ldst.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Templatize the address_space_* and *_phys functions, so that we can add
similar functions in the next patch that work with a lightweight,
cache-like version of address_space_map/unmap.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                    | 681 +-------------------------------------------
 include/exec/cpu-common.h |  15 -
 include/exec/memory.h     |  15 +
 memory_ldst.inc.c         | 709 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 734 insertions(+), 686 deletions(-)
 create mode 100644 memory_ldst.inc.c

diff --git a/exec.c b/exec.c
index 1c62d01..8568a6f 100644
--- a/exec.c
+++ b/exec.c
@@ -3058,677 +3058,16 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
     return address_space_unmap(&address_space_memory, buffer, len, is_write, access_len);
 }
 
-/* warning: addr must be aligned */
-static inline uint32_t address_space_ldl_internal(AddressSpace *as, hwaddr addr,
-                                                  MemTxAttrs attrs,
-                                                  MemTxResult *result,
-                                                  enum device_endian endian)
-{
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l, false);
-    if (l < 4 || !memory_access_is_direct(mr, false)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            val = ldl_le_p(ptr);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            val = ldl_be_p(ptr);
-            break;
-        default:
-            val = ldl_p(ptr);
-            break;
-        }
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-    return val;
-}
-
-uint32_t address_space_ldl(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldl_internal(as, addr, attrs, result,
-                                      DEVICE_NATIVE_ENDIAN);
-}
-
-uint32_t address_space_ldl_le(AddressSpace *as, hwaddr addr,
-                              MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldl_internal(as, addr, attrs, result,
-                                      DEVICE_LITTLE_ENDIAN);
-}
-
-uint32_t address_space_ldl_be(AddressSpace *as, hwaddr addr,
-                              MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldl_internal(as, addr, attrs, result,
-                                      DEVICE_BIG_ENDIAN);
-}
-
-uint32_t ldl_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldl(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t ldl_le_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldl_le(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t ldl_be_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldl_be(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-/* warning: addr must be aligned */
-static inline uint64_t address_space_ldq_internal(AddressSpace *as, hwaddr addr,
-                                                  MemTxAttrs attrs,
-                                                  MemTxResult *result,
-                                                  enum device_endian endian)
-{
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l,
-                                 false);
-    if (l < 8 || !memory_access_is_direct(mr, false)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            val = ldq_le_p(ptr);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            val = ldq_be_p(ptr);
-            break;
-        default:
-            val = ldq_p(ptr);
-            break;
-        }
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-    return val;
-}
-
-uint64_t address_space_ldq(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldq_internal(as, addr, attrs, result,
-                                      DEVICE_NATIVE_ENDIAN);
-}
-
-uint64_t address_space_ldq_le(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldq_internal(as, addr, attrs, result,
-                                      DEVICE_LITTLE_ENDIAN);
-}
-
-uint64_t address_space_ldq_be(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_ldq_internal(as, addr, attrs, result,
-                                      DEVICE_BIG_ENDIAN);
-}
-
-uint64_t ldq_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldq(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint64_t ldq_le_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldq_le(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint64_t ldq_be_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldq_be(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t address_space_ldub(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result)
-{
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l, false);
-    if (!memory_access_is_direct(mr, false)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        val = ldub_p(ptr);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-    return val;
-}
-
-uint32_t ldub_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_ldub(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-/* warning: addr must be aligned */
-static inline uint32_t address_space_lduw_internal(AddressSpace *as,
-                                                   hwaddr addr,
-                                                   MemTxAttrs attrs,
-                                                   MemTxResult *result,
-                                                   enum device_endian endian)
-{
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 2;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l,
-                                 false);
-    if (l < 2 || !memory_access_is_direct(mr, false)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            val = lduw_le_p(ptr);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            val = lduw_be_p(ptr);
-            break;
-        default:
-            val = lduw_p(ptr);
-            break;
-        }
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-    return val;
-}
-
-uint32_t address_space_lduw(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_lduw_internal(as, addr, attrs, result,
-                                       DEVICE_NATIVE_ENDIAN);
-}
-
-uint32_t address_space_lduw_le(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_lduw_internal(as, addr, attrs, result,
-                                       DEVICE_LITTLE_ENDIAN);
-}
-
-uint32_t address_space_lduw_be(AddressSpace *as, hwaddr addr,
-                           MemTxAttrs attrs, MemTxResult *result)
-{
-    return address_space_lduw_internal(as, addr, attrs, result,
-                                       DEVICE_BIG_ENDIAN);
-}
-
-uint32_t lduw_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_lduw(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t lduw_le_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_lduw_le(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t lduw_be_phys(AddressSpace *as, hwaddr addr)
-{
-    return address_space_lduw_be(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-/* warning: addr must be aligned. The ram page is not masked as dirty
-   and the code inside is not invalidated. It is useful if the dirty
-   bits are used to track modified PTEs */
-void address_space_stl_notdirty(AddressSpace *as, hwaddr addr, uint32_t val,
-                                MemTxAttrs attrs, MemTxResult *result)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    uint8_t dirty_log_mask;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l,
-                                 true);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
-    } else {
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stl_p(ptr, val);
-
-        dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
-        cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
-                                            4, dirty_log_mask);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-}
-
-void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_notdirty(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-/* warning: addr must be aligned */
-static inline void address_space_stl_internal(AddressSpace *as,
-                                              hwaddr addr, uint32_t val,
-                                              MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l,
-                                 true);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
-        release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
-        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stl_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stl_be_p(ptr, val);
-            break;
-        default:
-            stl_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 4);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-}
-
-void address_space_stl(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stl_internal(as, addr, val, attrs, result,
-                               DEVICE_NATIVE_ENDIAN);
-}
-
-void address_space_stl_le(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stl_internal(as, addr, val, attrs, result,
-                               DEVICE_LITTLE_ENDIAN);
-}
-
-void address_space_stl_be(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stl_internal(as, addr, val, attrs, result,
-                               DEVICE_BIG_ENDIAN);
-}
-
-void stl_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stl_le_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_le(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stl_be_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_be(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void address_space_stb(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l, true);
-    if (!memory_access_is_direct(mr, true)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stb_p(ptr, val);
-        invalidate_and_set_dirty(mr, addr1, 1);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-}
-
-void stb_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-/* warning: addr must be aligned */
-static inline void address_space_stw_internal(AddressSpace *as,
-                                              hwaddr addr, uint32_t val,
-                                              MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 2;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l, true);
-    if (l < 2 || !memory_access_is_direct(mr, true)) {
-        release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
-        r = memory_region_dispatch_write(mr, addr1, val, 2, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stw_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stw_be_p(ptr, val);
-            break;
-        default:
-            stw_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 2);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-}
-
-void address_space_stw(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stw_internal(as, addr, val, attrs, result,
-                               DEVICE_NATIVE_ENDIAN);
-}
-
-void address_space_stw_le(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stw_internal(as, addr, val, attrs, result,
-                               DEVICE_LITTLE_ENDIAN);
-}
-
-void address_space_stw_be(AddressSpace *as, hwaddr addr, uint32_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stw_internal(as, addr, val, attrs, result,
-                               DEVICE_BIG_ENDIAN);
-}
-
-void stw_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stw(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stw_le_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stw_le(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stw_be_phys(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stw_be(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void address_space_stq_internal(AddressSpace *as,
-                                              hwaddr addr, uint64_t val,
-                                              MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr1, &l, true);
-    if (l < 8 || !memory_access_is_direct(mr, true)) {
-        release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
-        r = memory_region_dispatch_write(mr, addr1, val, 8, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stq_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stq_be_p(ptr, val);
-            break;
-        default:
-            stq_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 8);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        qemu_mutex_unlock_iothread();
-    }
-    rcu_read_unlock();
-}
-
-void address_space_stq(AddressSpace *as, hwaddr addr, uint64_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stq_internal(as, addr, val, attrs, result,
-                               DEVICE_NATIVE_ENDIAN);
-}
-
-void address_space_stq_le(AddressSpace *as, hwaddr addr, uint64_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stq_internal(as, addr, val, attrs, result,
-                               DEVICE_LITTLE_ENDIAN);
-}
-
-void address_space_stq_be(AddressSpace *as, hwaddr addr, uint64_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
-{
-    address_space_stq_internal(as, addr, val, attrs, result,
-                               DEVICE_BIG_ENDIAN);
-}
-
-void stq_phys(AddressSpace *as, hwaddr addr, uint64_t val)
-{
-    address_space_stq(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stq_le_phys(AddressSpace *as, hwaddr addr, uint64_t val)
-{
-    address_space_stq_le(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void stq_be_phys(AddressSpace *as, hwaddr addr, uint64_t val)
-{
-    address_space_stq_be(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
-}
+#define ARG1_DECL                AddressSpace *as
+#define ARG1                     as
+#define SUFFIX
+#define TRANSLATE(...)           address_space_translate(as, __VA_ARGS__)
+#define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
+#define MAP_RAM(mr, ofs)         qemu_map_ram_ptr((mr)->ram_block, ofs)
+#define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
+#define RCU_READ_LOCK(...)       rcu_read_lock()
+#define RCU_READ_UNLOCK(...)     rcu_read_unlock()
+#include "memory_ldst.inc.c"
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index cffdc13..bd15853 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -94,21 +94,6 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr);
  */
 void qemu_flush_coalesced_mmio_buffer(void);
 
-uint32_t ldub_phys(AddressSpace *as, hwaddr addr);
-uint32_t lduw_le_phys(AddressSpace *as, hwaddr addr);
-uint32_t lduw_be_phys(AddressSpace *as, hwaddr addr);
-uint32_t ldl_le_phys(AddressSpace *as, hwaddr addr);
-uint32_t ldl_be_phys(AddressSpace *as, hwaddr addr);
-uint64_t ldq_le_phys(AddressSpace *as, hwaddr addr);
-uint64_t ldq_be_phys(AddressSpace *as, hwaddr addr);
-void stb_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stw_le_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stw_be_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stl_le_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stl_be_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stq_le_phys(AddressSpace *as, hwaddr addr, uint64_t val);
-void stq_be_phys(AddressSpace *as, hwaddr addr, uint64_t val);
-
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
                                    const uint8_t *buf, int len);
 void cpu_flush_icache_range(hwaddr start, int len);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9728a2f..f35b612 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1404,6 +1404,21 @@ void address_space_stq_le(AddressSpace *as, hwaddr addr, uint64_t val,
 void address_space_stq_be(AddressSpace *as, hwaddr addr, uint64_t val,
                             MemTxAttrs attrs, MemTxResult *result);
 
+uint32_t ldub_phys(AddressSpace *as, hwaddr addr);
+uint32_t lduw_le_phys(AddressSpace *as, hwaddr addr);
+uint32_t lduw_be_phys(AddressSpace *as, hwaddr addr);
+uint32_t ldl_le_phys(AddressSpace *as, hwaddr addr);
+uint32_t ldl_be_phys(AddressSpace *as, hwaddr addr);
+uint64_t ldq_le_phys(AddressSpace *as, hwaddr addr);
+uint64_t ldq_be_phys(AddressSpace *as, hwaddr addr);
+void stb_phys(AddressSpace *as, hwaddr addr, uint32_t val);
+void stw_le_phys(AddressSpace *as, hwaddr addr, uint32_t val);
+void stw_be_phys(AddressSpace *as, hwaddr addr, uint32_t val);
+void stl_le_phys(AddressSpace *as, hwaddr addr, uint32_t val);
+void stl_be_phys(AddressSpace *as, hwaddr addr, uint32_t val);
+void stq_le_phys(AddressSpace *as, hwaddr addr, uint64_t val);
+void stq_be_phys(AddressSpace *as, hwaddr addr, uint64_t val);
+
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
  * called from an RCU critical section, to avoid that the last reference
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
new file mode 100644
index 0000000..5dbff9c
--- /dev/null
+++ b/memory_ldst.inc.c
@@ -0,0 +1,709 @@
+/*
+ *  Physical memory access templates
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2015 Linaro, Inc.
+ *  Copyright (c) 2016 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* warning: addr must be aligned */
+static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
+    enum device_endian endian)
+{
+    uint8_t *ptr;
+    uint64_t val;
+    MemoryRegion *mr;
+    hwaddr l = 4;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, false);
+    if (l < 4 || !IS_DIRECT(mr, false)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        /* I/O case */
+        r = memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap32(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap32(val);
+        }
+#endif
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            val = ldl_le_p(ptr);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            val = ldl_be_p(ptr);
+            break;
+        default:
+            val = ldl_p(ptr);
+            break;
+        }
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+    return val;
+}
+
+uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_NATIVE_ENDIAN);
+}
+
+uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_LITTLE_ENDIAN);
+}
+
+uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_BIG_ENDIAN);
+}
+
+uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl, SUFFIX)(ARG1, addr,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+/* warning: addr must be aligned */
+static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
+    enum device_endian endian)
+{
+    uint8_t *ptr;
+    uint64_t val;
+    MemoryRegion *mr;
+    hwaddr l = 8;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, false);
+    if (l < 8 || !IS_DIRECT(mr, false)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        /* I/O case */
+        r = memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap64(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap64(val);
+        }
+#endif
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            val = ldq_le_p(ptr);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            val = ldq_be_p(ptr);
+            break;
+        default:
+            val = ldq_p(ptr);
+            break;
+        }
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+    return val;
+}
+
+uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_NATIVE_ENDIAN);
+}
+
+uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_LITTLE_ENDIAN);
+}
+
+uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                    DEVICE_BIG_ENDIAN);
+}
+
+uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    uint64_t val;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, false);
+    if (!IS_DIRECT(mr, false)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        /* I/O case */
+        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        val = ldub_p(ptr);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+    return val;
+}
+
+uint32_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldub, SUFFIX)(ARG1, addr,
+                                            MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+/* warning: addr must be aligned */
+static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
+    enum device_endian endian)
+{
+    uint8_t *ptr;
+    uint64_t val;
+    MemoryRegion *mr;
+    hwaddr l = 2;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, false);
+    if (l < 2 || !IS_DIRECT(mr, false)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        /* I/O case */
+        r = memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap16(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap16(val);
+        }
+#endif
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            val = lduw_le_p(ptr);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            val = lduw_be_p(ptr);
+            break;
+        default:
+            val = lduw_p(ptr);
+            break;
+        }
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+    return val;
+}
+
+uint32_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                     DEVICE_NATIVE_ENDIAN);
+}
+
+uint32_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                                     DEVICE_LITTLE_ENDIAN);
+}
+
+uint32_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
+                                       DEVICE_BIG_ENDIAN);
+}
+
+uint32_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw, SUFFIX)(ARG1, addr,
+                                            MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint32_t glue(lduw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
+                                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+uint32_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
+                                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+/* warning: addr must be aligned. The ram page is not masked as dirty
+   and the code inside is not invalidated. It is useful if the dirty
+   bits are used to track modified PTEs */
+void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 4;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true);
+    if (l < 4 || !IS_DIRECT(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+    } else {
+        ptr = MAP_RAM(mr, addr1);
+        stl_p(ptr, val);
+
+        dirty_log_mask = memory_region_get_dirty_log_mask(mr);
+        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+        cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+                                            4, dirty_log_mask);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+}
+
+void glue(stl_phys_notdirty, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl_notdirty, SUFFIX)(ARG1, addr, val,
+                                             MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+/* warning: addr must be aligned */
+static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs,
+    MemTxResult *result, enum device_endian endian)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 4;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true);
+    if (l < 4 || !IS_DIRECT(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap32(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap32(val);
+        }
+#endif
+        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            stl_le_p(ptr, val);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            stl_be_p(ptr, val);
+            break;
+        default:
+            stl_p(ptr, val);
+            break;
+        }
+        INVALIDATE(mr, addr1, 4);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+}
+
+void glue(address_space_stl, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
+                                             result, DEVICE_NATIVE_ENDIAN);
+}
+
+void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
+                                             result, DEVICE_LITTLE_ENDIAN);
+}
+
+void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
+                                             result, DEVICE_BIG_ENDIAN);
+}
+
+void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(address_space_stb, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true);
+    if (!IS_DIRECT(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        stb_p(ptr, val);
+        INVALIDATE(mr, addr1, 1);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+}
+
+void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stb, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+/* warning: addr must be aligned */
+static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs,
+    MemTxResult *result, enum device_endian endian)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 2;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true);
+    if (l < 2 || !IS_DIRECT(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap16(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap16(val);
+        }
+#endif
+        r = memory_region_dispatch_write(mr, addr1, val, 2, attrs);
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            stw_le_p(ptr, val);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            stw_be_p(ptr, val);
+            break;
+        default:
+            stw_p(ptr, val);
+            break;
+        }
+        INVALIDATE(mr, addr1, 2);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+}
+
+void glue(address_space_stw, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                                             DEVICE_NATIVE_ENDIAN);
+}
+
+void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                                             DEVICE_LITTLE_ENDIAN);
+}
+
+void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                               DEVICE_BIG_ENDIAN);
+}
+
+void glue(stw_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs,
+    MemTxResult *result, enum device_endian endian)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 8;
+    hwaddr addr1;
+    MemTxResult r;
+    bool release_lock = false;
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true);
+    if (l < 8 || !IS_DIRECT(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+
+#if defined(TARGET_WORDS_BIGENDIAN)
+        if (endian == DEVICE_LITTLE_ENDIAN) {
+            val = bswap64(val);
+        }
+#else
+        if (endian == DEVICE_BIG_ENDIAN) {
+            val = bswap64(val);
+        }
+#endif
+        r = memory_region_dispatch_write(mr, addr1, val, 8, attrs);
+    } else {
+        /* RAM case */
+        ptr = MAP_RAM(mr, addr1);
+        switch (endian) {
+        case DEVICE_LITTLE_ENDIAN:
+            stq_le_p(ptr, val);
+            break;
+        case DEVICE_BIG_ENDIAN:
+            stq_be_p(ptr, val);
+            break;
+        default:
+            stq_p(ptr, val);
+            break;
+        }
+        INVALIDATE(mr, addr1, 8);
+        r = MEMTX_OK;
+    }
+    if (result) {
+        *result = r;
+    }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    RCU_READ_UNLOCK();
+}
+
+void glue(address_space_stq, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                                             DEVICE_NATIVE_ENDIAN);
+}
+
+void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                                             DEVICE_LITTLE_ENDIAN);
+}
+
+void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
+                                             DEVICE_BIG_ENDIAN);
+}
+
+void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+#undef ARG1_DECL
+#undef ARG1
+#undef SUFFIX
+#undef TRANSLATE
+#undef IS_DIRECT
+#undef MAP_RAM
+#undef INVALIDATE
+#undef RCU_READ_LOCK
+#undef RCU_READ_UNLOCK
-- 
2.9.3
