Received: from eggs.gnu.org ([209.51.188.92]:37294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnv-0006HP-26
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnt-0001GF-Qb
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:38 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnr-00017w-OG
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:37 -0500
Received: by mail-pf1-x444.google.com with SMTP id c123so9556670pfb.0
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:20 +1100
Message-Id: <20190114011122.5995-16-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/17] target/arm: Add allocation tag storage
 for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 82 +++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index b125f49258..87328c7a9a 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -25,16 +25,72 @@
 #include "exec/helper-proto.h"
 
 
-static int get_allocation_tag(CPUARMState *env, uint64_t ptr)
+static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
+    uint64_t clean_ptr = extract64(ptr, 0, 56);
+    uint8_t *tags = page_get_target_data(clean_ptr);
+
+    if (tags != NULL) {
+        uintptr_t index = extract64(clean_ptr, LOG2_TAG_GRANULE + 1,
+                                    TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+        return extract32(tags[index], (clean_ptr & 1) * 4, 4);
+    } else {
+        int flags = page_get_flags(clean_ptr);
+
+        if (flags & PAGE_SHARED) {
+            /* There may be multiple mappings; pretend not implemented.  */
+            return -1;
+        } else if (flags & PAGE_VALID) {
+            /* Page is good, but no tags have been written: all are 0.  */
+            return 0;
+        } else {
+            /* Page is invalid: SIGSEGV.  */
+            env->exception.vaddress = ptr;
+            cpu_restore_state(ENV_GET_CPU(env), ra, true);
+            raise_exception(env, EXCP_DATA_ABORT, 0, 1);
+        }
+    }
+#else
     /* Tag storage not implemented.  */
     return -1;
+#endif
 }
 
-static bool set_allocation_tag(CPUARMState *env, uint64_t ptr, int tag)
+static bool set_allocation_tag(CPUARMState *env, uint64_t ptr,
+                               int tag, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
+    uint64_t clean_ptr = extract64(ptr, 0, 56);
+    uint8_t *tags = page_get_target_data(clean_ptr);
+    uintptr_t index;
+
+    if (tags == NULL) {
+        int flags = page_get_flags(clean_ptr);
+        size_t alloc_size;
+
+        if (flags & PAGE_SHARED) {
+            /* There may be multiple mappings; pretend not implemented.  */
+            return false;
+        } else if (!(flags & PAGE_VALID)) {
+            /* Page is invalid: SIGSEGV.  */
+            env->exception.vaddress = ptr;
+            cpu_restore_state(ENV_GET_CPU(env), ra, true);
+            raise_exception(env, EXCP_DATA_ABORT, 0, 1);
+        }
+
+        alloc_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+        tags = page_alloc_target_data(clean_ptr, alloc_size);
+        assert(tags != NULL);
+    }
+    index = extract64(clean_ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    tags[index] = deposit32(tags[index], (clean_ptr & 1) * 4, 4, tag);
+    return true;
+#else
     /* Tag storage not implemented.  */
     return false;
+#endif
 }
 
 static int allocation_tag_from_addr(uint64_t ptr)
@@ -116,7 +172,7 @@ uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
      * access as unchecked.
      * This is similar to MemAttr != Tagged, which are also unchecked.
      */
-    mem_tag = get_allocation_tag(env, ptr);
+    mem_tag = get_allocation_tag(env, ptr, GETPC());
     if (mem_tag < 0) {
         goto pass;
     }
@@ -217,7 +273,7 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr)
     int rtag = 0;
 
     if (allocation_tag_access_enabled(env, el, sctlr)) {
-        rtag = get_allocation_tag(env, ptr);
+        rtag = get_allocation_tag(env, ptr, GETPC());
         if (rtag < 0) {
             rtag = 0;
         }
@@ -232,7 +288,7 @@ uint64_t HELPER(stg)(CPUARMState *env, uint64_t ptr)
 
     if (allocation_tag_access_enabled(env, el, sctlr)) {
         int tag = allocation_tag_from_addr(ptr);
-        set_allocation_tag(env, ptr, tag);
+        set_allocation_tag(env, ptr, tag, GETPC());
     }
 
     /* Clean the pointer for use by stgz.  */
@@ -247,8 +303,10 @@ uint64_t HELPER(st2g)(CPUARMState *env, uint64_t ptr)
 
     if (allocation_tag_access_enabled(env, el, sctlr)) {
         int tag = allocation_tag_from_addr(ptr);
-        if (set_allocation_tag(env, ptr, tag)) {
-            set_allocation_tag(env, ptr + (1 << LOG2_TAG_GRANULE), tag);
+        uintptr_t ra = GETPC();
+
+        if (set_allocation_tag(env, ptr, tag, ra)) {
+            set_allocation_tag(env, ptr + (1 << LOG2_TAG_GRANULE), tag, ra);
         }
     }
 
@@ -261,6 +319,7 @@ uint64_t HELPER(ldgv)(CPUARMState *env, uint64_t ptr)
 {
     int el = arm_current_el(env);
     uint64_t sctlr = arm_sctlr(env, el);
+    uintptr_t ra = GETPC();
     uint64_t ret;
     int rtag, i;
 
@@ -269,7 +328,7 @@ uint64_t HELPER(ldgv)(CPUARMState *env, uint64_t ptr)
     }
 
     ptr = QEMU_ALIGN_DOWN(ptr, 1 << LOG2_TAG_GRANULE);
-    rtag = get_allocation_tag(env, ptr);
+    rtag = get_allocation_tag(env, ptr, ra);
     if (rtag < 0) {
         /* The entire page does not have tags.  */
         return 0;
@@ -278,7 +337,7 @@ uint64_t HELPER(ldgv)(CPUARMState *env, uint64_t ptr)
     i = extract32(ptr, LOG2_TAG_GRANULE, 4);
     ret = (uint64_t)rtag << i;
     for (i++; i < 16; i++) {
-        rtag = get_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE));
+        rtag = get_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE), ra);
         ret |= (uint64_t)rtag << i;
     }
 
@@ -289,6 +348,7 @@ void HELPER(stgv)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
     int el = arm_current_el(env);
     uint64_t sctlr = arm_sctlr(env, el);
+    uintptr_t ra = GETPC();
     int rtag, i;
 
     if (!allocation_tag_access_enabled(env, el, sctlr)) {
@@ -297,13 +357,13 @@ void HELPER(stgv)(CPUARMState *env, uint64_t ptr, uint64_t val)
 
     rtag = allocation_tag_from_addr(ptr);
     ptr = QEMU_ALIGN_DOWN(ptr, 1 << LOG2_TAG_GRANULE);
-    if (!set_allocation_tag(env, ptr, rtag)) {
+    if (!set_allocation_tag(env, ptr, rtag, ra)) {
         /* The entire page does not have tags.  */
         return;
     }
 
     i = extract32(ptr, LOG2_TAG_GRANULE, 4);
     for (i++; i < 16; i++) {
-        set_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE), rtag);
+        set_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE), rtag, ra);
     }
 }
-- 
2.17.2
