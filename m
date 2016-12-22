Received: from eggs.gnu.org ([2001:4830:134:3::10]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D2-0007HE-OC
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5Cy-00074d-Eu
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5Cy-00074P-5t
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:04 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 689ABC01B126
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:03 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xE027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:02 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:36 +0100
Message-Id: <20161222152300.32395-2-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/25] exec: optimize remaining address_space_*
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Do them right before the next patch generalizes them into a multi-included
file.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 103 insertions(+), 23 deletions(-)

diff --git a/exec.c b/exec.c
index 08c558e..1c62d01 100644
--- a/exec.c
+++ b/exec.c
@@ -3243,17 +3243,37 @@ uint64_t ldq_be_phys(AddressSpace *as, hwaddr addr)
     return address_space_ldq_be(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-/* XXX: optimize */
 uint32_t address_space_ldub(AddressSpace *as, hwaddr addr,
                             MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t val;
+    uint8_t *ptr;
+    uint64_t val;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+    hwaddr addr1;
     MemTxResult r;
+    bool release_lock = false;
 
-    r = address_space_rw(as, addr, attrs, &val, 1, 0);
+    rcu_read_lock();
+    mr = address_space_translate(as, addr, &addr1, &l, false);
+    if (!memory_access_is_direct(mr, false)) {
+        release_lock |= prepare_mmio_access(mr);
+
+        /* I/O case */
+        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
+    } else {
+        /* RAM case */
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+        val = ldub_p(ptr);
+        r = MEMTX_OK;
+    }
     if (result) {
         *result = r;
     }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    rcu_read_unlock();
     return val;
 }
 
@@ -3493,17 +3513,35 @@ void stl_be_phys(AddressSpace *as, hwaddr addr, uint32_t val)
     address_space_stl_be(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-/* XXX: optimize */
 void address_space_stb(AddressSpace *as, hwaddr addr, uint32_t val,
                        MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t v = val;
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+    hwaddr addr1;
     MemTxResult r;
+    bool release_lock = false;
 
-    r = address_space_rw(as, addr, attrs, &v, 1, 1);
+    rcu_read_lock();
+    mr = address_space_translate(as, addr, &addr1, &l, true);
+    if (!memory_access_is_direct(mr, true)) {
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
+    } else {
+        /* RAM case */
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+        stb_p(ptr, val);
+        invalidate_and_set_dirty(mr, addr1, 1);
+        r = MEMTX_OK;
+    }
     if (result) {
         *result = r;
     }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    rcu_read_unlock();
 }
 
 void stb_phys(AddressSpace *as, hwaddr addr, uint32_t val)
@@ -3602,37 +3640,79 @@ void stw_be_phys(AddressSpace *as, hwaddr addr, uint32_t val)
     address_space_stw_be(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-/* XXX: optimize */
-void address_space_stq(AddressSpace *as, hwaddr addr, uint64_t val,
-                       MemTxAttrs attrs, MemTxResult *result)
+static inline void address_space_stq_internal(AddressSpace *as,
+                                              hwaddr addr, uint64_t val,
+                                              MemTxAttrs attrs,
+                                              MemTxResult *result,
+                                              enum device_endian endian)
 {
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 8;
+    hwaddr addr1;
     MemTxResult r;
-    val = tswap64(val);
-    r = address_space_rw(as, addr, attrs, (void *) &val, 8, 1);
+    bool release_lock = false;
+
+    rcu_read_lock();
+    mr = address_space_translate(as, addr, &addr1, &l, true);
+    if (l < 8 || !memory_access_is_direct(mr, true)) {
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
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
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
+        invalidate_and_set_dirty(mr, addr1, 8);
+        r = MEMTX_OK;
+    }
     if (result) {
         *result = r;
     }
+    if (release_lock) {
+        qemu_mutex_unlock_iothread();
+    }
+    rcu_read_unlock();
+}
+
+void address_space_stq(AddressSpace *as, hwaddr addr, uint64_t val,
+                       MemTxAttrs attrs, MemTxResult *result)
+{
+    address_space_stq_internal(as, addr, val, attrs, result,
+                               DEVICE_NATIVE_ENDIAN);
 }
 
 void address_space_stq_le(AddressSpace *as, hwaddr addr, uint64_t val,
                        MemTxAttrs attrs, MemTxResult *result)
 {
-    MemTxResult r;
-    val = cpu_to_le64(val);
-    r = address_space_rw(as, addr, attrs, (void *) &val, 8, 1);
-    if (result) {
-        *result = r;
-    }
+    address_space_stq_internal(as, addr, val, attrs, result,
+                               DEVICE_LITTLE_ENDIAN);
 }
+
 void address_space_stq_be(AddressSpace *as, hwaddr addr, uint64_t val,
                        MemTxAttrs attrs, MemTxResult *result)
 {
-    MemTxResult r;
-    val = cpu_to_be64(val);
-    r = address_space_rw(as, addr, attrs, (void *) &val, 8, 1);
-    if (result) {
-        *result = r;
-    }
+    address_space_stq_internal(as, addr, val, attrs, result,
+                               DEVICE_BIG_ENDIAN);
 }
 
 void stq_phys(AddressSpace *as, hwaddr addr, uint64_t val)
-- 
2.9.3
