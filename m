Received: from eggs.gnu.org ([2001:4830:134:3::10]:41277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt1-000306-UF
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsv-0001Li-JO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAsv-0001LG-7d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so24192267wmc.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:01 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	c15-v6sm14020129edr.78.2018.05.08.15.14.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 May 2018 15:14:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:24 +0200
Message-Id: <1525817687-34620-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/30] exec: move memory access declarations to
 a common header, inline *_phys functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For now, this reduces the text size very slightly due to the newly-added
inlining:

   text size before: 9301965
   text size after: 9300645

Later, however, the declarations in include/exec/memory_ldst.inc.h will be
reused for the MemoryRegionCache slow path functions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-all.h              |  75 +++++++-----------
 include/exec/memory.h               | 153 +++++++++++-------------------------
 include/exec/memory_ldst.inc.h      |  71 +++++++++++++++++
 include/exec/memory_ldst_phys.inc.h | 147 ++++++++++++++++++++++++++++++++++
 memory_ldst.inc.c                   | 126 -----------------------------
 5 files changed, 292 insertions(+), 280 deletions(-)
 create mode 100644 include/exec/memory_ldst.inc.h
 create mode 100644 include/exec/memory_ldst_phys.inc.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f4fa94e..173edd1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -168,51 +168,36 @@ extern unsigned long reserved_va;
 #else
 
 #include "exec/hwaddr.h"
-uint32_t lduw_phys(AddressSpace *as, hwaddr addr);
-uint32_t ldl_phys(AddressSpace *as, hwaddr addr);
-uint64_t ldq_phys(AddressSpace *as, hwaddr addr);
-void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val);
-void stw_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stl_phys(AddressSpace *as, hwaddr addr, uint32_t val);
-void stq_phys(AddressSpace *as, hwaddr addr, uint64_t val);
-
-uint32_t address_space_lduw(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_notdirty(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq(AddressSpace *as, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-
-uint32_t lduw_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint32_t ldl_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint64_t ldq_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-void stl_phys_notdirty_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stw_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stl_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stq_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
-
-uint32_t address_space_lduw_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_notdirty_cached(MemoryRegionCache *cache, hwaddr addr,
-                            uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
+
+#define SUFFIX
+#define ARG1         as
+#define ARG1_DECL    AddressSpace *as
+#define TARGET_ENDIANNESS
+#include "exec/memory_ldst.inc.h"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#define TARGET_ENDIANNESS
+#include "exec/memory_ldst.inc.h"
+
+static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
+{
+    address_space_stl_notdirty(as, addr, val,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+#define SUFFIX
+#define ARG1         as
+#define ARG1_DECL    AddressSpace *as
+#define TARGET_ENDIANNESS
+#include "exec/memory_ldst_phys.inc.h"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#define TARGET_ENDIANNESS
+#include "exec/memory_ldst_phys.inc.h"
 #endif
 
 /* page related stuff */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 31eae0a..ca361bc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1676,49 +1676,16 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
  * @result: location to write the success/failure of the transaction;
  *   if NULL, this information is discarded
  */
-uint32_t address_space_ldub(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_lduw_le(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_lduw_be(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl_le(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl_be(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq_le(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq_be(AddressSpace *as, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stb(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw_le(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw_be(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_le(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_be(AddressSpace *as, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq_le(AddressSpace *as, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq_be(AddressSpace *as, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-
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
+
+#define SUFFIX
+#define ARG1         as
+#define ARG1_DECL    AddressSpace *as
+#include "exec/memory_ldst.inc.h"
+
+#define SUFFIX
+#define ARG1         as
+#define ARG1_DECL    AddressSpace *as
+#include "exec/memory_ldst_phys.inc.h"
 
 struct MemoryRegionCache {
     hwaddr xlat;
@@ -1728,6 +1695,40 @@ struct MemoryRegionCache {
 
 #define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .as = NULL })
 
+/* address_space_ld*_cached: load from a cached #MemoryRegion
+ * address_space_st*_cached: store into a cached #MemoryRegion
+ *
+ * These functions perform a load or store of the byte, word,
+ * longword or quad to the specified address.  The address is
+ * a physical address in the AddressSpace, but it must lie within
+ * a #MemoryRegion that was mapped with address_space_cache_init.
+ *
+ * The _le suffixed functions treat the data as little endian;
+ * _be indicates big endian; no suffix indicates "same endianness
+ * as guest CPU".
+ *
+ * The "guest CPU endianness" accessors are deprecated for use outside
+ * target-* code; devices should be CPU-agnostic and use either the LE
+ * or the BE accessors.
+ *
+ * @cache: previously initialized #MemoryRegionCache to be accessed
+ * @addr: address within the address space
+ * @val: data value, for stores
+ * @attrs: memory transaction attributes
+ * @result: location to write the success/failure of the transaction;
+ *   if NULL, this information is discarded
+ */
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "exec/memory_ldst.inc.h"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "exec/memory_ldst_phys.inc.h"
+
 /* address_space_cache_init: prepare for repeated access to a physical
  * memory region
  *
@@ -1772,72 +1773,6 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
  */
 void address_space_cache_destroy(MemoryRegionCache *cache);
 
-/* address_space_ld*_cached: load from a cached #MemoryRegion
- * address_space_st*_cached: store into a cached #MemoryRegion
- *
- * These functions perform a load or store of the byte, word,
- * longword or quad to the specified address.  The address is
- * a physical address in the AddressSpace, but it must lie within
- * a #MemoryRegion that was mapped with address_space_cache_init.
- *
- * The _le suffixed functions treat the data as little endian;
- * _be indicates big endian; no suffix indicates "same endianness
- * as guest CPU".
- *
- * The "guest CPU endianness" accessors are deprecated for use outside
- * target-* code; devices should be CPU-agnostic and use either the LE
- * or the BE accessors.
- *
- * @cache: previously initialized #MemoryRegionCache to be accessed
- * @addr: address within the address space
- * @val: data value, for stores
- * @attrs: memory transaction attributes
- * @result: location to write the success/failure of the transaction;
- *   if NULL, this information is discarded
- */
-uint32_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_lduw_le_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_lduw_be_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl_le_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint32_t address_space_ldl_be_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq_le_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-uint64_t address_space_ldq_be_cached(MemoryRegionCache *cache, hwaddr addr,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stb_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw_le_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stw_be_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_le_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stl_be_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq_le_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-void address_space_stq_be_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
-                            MemTxAttrs attrs, MemTxResult *result);
-
-uint32_t ldub_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint32_t lduw_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint32_t lduw_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint32_t ldl_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint32_t ldl_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint64_t ldq_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-uint64_t ldq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
-void stb_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stw_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stw_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stl_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stl_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
-void stq_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
-void stq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
  */
diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.inc.h
new file mode 100644
index 0000000..272c20f
--- /dev/null
+++ b/include/exec/memory_ldst.inc.h
@@ -0,0 +1,71 @@
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
+#ifdef TARGET_ENDIANNESS
+extern uint32_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stq, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+#else
+extern uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stb, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+extern void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+#endif
+
+#undef ARG1_DECL
+#undef ARG1
+#undef SUFFIX
+#undef TARGET_ENDIANNESS
diff --git a/include/exec/memory_ldst_phys.inc.h b/include/exec/memory_ldst_phys.inc.h
new file mode 100644
index 0000000..91f7297
--- /dev/null
+++ b/include/exec/memory_ldst_phys.inc.h
@@ -0,0 +1,147 @@
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
+#ifdef TARGET_ENDIANNESS
+static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl, SUFFIX)(ARG1, addr,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint32_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw, SUFFIX)(ARG1, addr,
+                                            MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stw_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+#else
+static inline uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint32_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_ldub, SUFFIX)(ARG1, addr,
+                                            MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint32_t glue(lduw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
+                                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline uint32_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
+{
+    return glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
+                                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stb, SUFFIX)(ARG1, addr, val,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    glue(address_space_stw_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+}
+#endif
+
+#undef ARG1_DECL
+#undef ARG1
+#undef SUFFIX
+#undef TARGET_ENDIANNESS
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 5dbff9c..25d6125 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -95,24 +95,6 @@ uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
                                                     DEVICE_BIG_ENDIAN);
 }
 
-uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
@@ -189,24 +171,6 @@ uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
                                                     DEVICE_BIG_ENDIAN);
 }
 
-uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -241,12 +205,6 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint32_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldub, SUFFIX)(ARG1, addr,
-                                            MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
@@ -323,24 +281,6 @@ uint32_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
                                        DEVICE_BIG_ENDIAN);
 }
 
-uint32_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw, SUFFIX)(ARG1, addr,
-                                            MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t glue(lduw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
-                                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-uint32_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
-                                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 /* warning: addr must be aligned. The ram page is not masked as dirty
    and the code inside is not invalidated. It is useful if the dirty
    bits are used to track modified PTEs */
@@ -380,12 +320,6 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(stl_phys_notdirty, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_notdirty, SUFFIX)(ARG1, addr, val,
-                                             MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
@@ -460,24 +394,6 @@ void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
                                              result, DEVICE_BIG_ENDIAN);
 }
 
-void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -509,12 +425,6 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stb, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 /* warning: addr must be aligned */
 static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
@@ -589,24 +499,6 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-void glue(stw_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stw, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stw_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stw_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
@@ -680,24 +572,6 @@ void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
                                              DEVICE_BIG_ENDIAN);
 }
 
-void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-- 
1.8.3.1
