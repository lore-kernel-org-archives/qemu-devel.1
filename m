Received: from eggs.gnu.org ([2001:4830:134:3::10]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006I8-L5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007ir-8X
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:37957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1B-0007eZ-U2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: by mail-ot1-x331.google.com with SMTP id e12so4121394otl.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:20:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:21 -0600
Message-Id: <20181214031923.29527-32-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/32] exec: introduce qemu_xxhash{2,4,5,6,7}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Before moving them all to include/qemu/xxhash.h.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-hash-xx.h | 41 +++++++++++++++++++++++++++++----------
 include/exec/tb-hash.h    |  2 +-
 tests/qht-bench.c         |  2 +-
 util/qsp.c                | 12 ++++++------
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 747a9a612c..98ce4b628a 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -42,23 +42,23 @@
 #define PRIME32_4    668265263U
 #define PRIME32_5    374761393U
 
-#define TB_HASH_XX_SEED 1
+#define QEMU_XXHASH_SEED 1
 
 /*
  * xxhash32, customized for input variables that are not guaranteed to be
  * contiguous in memory.
  */
 static inline uint32_t
-tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g)
+qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
 {
-    uint32_t v1 = TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
-    uint32_t v2 = TB_HASH_XX_SEED + PRIME32_2;
-    uint32_t v3 = TB_HASH_XX_SEED + 0;
-    uint32_t v4 = TB_HASH_XX_SEED - PRIME32_1;
-    uint32_t a = a0 >> 32;
-    uint32_t b = a0;
-    uint32_t c = b0 >> 32;
-    uint32_t d = b0;
+    uint32_t v1 = QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
+    uint32_t v2 = QEMU_XXHASH_SEED + PRIME32_2;
+    uint32_t v3 = QEMU_XXHASH_SEED + 0;
+    uint32_t v4 = QEMU_XXHASH_SEED - PRIME32_1;
+    uint32_t a = ab >> 32;
+    uint32_t b = ab;
+    uint32_t c = cd >> 32;
+    uint32_t d = cd;
     uint32_t h32;
 
     v1 += a * PRIME32_2;
@@ -98,4 +98,25 @@ tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g)
     return h32;
 }
 
+static inline uint32_t qemu_xxhash2(uint64_t ab)
+{
+    return qemu_xxhash7(ab, 0, 0, 0, 0);
+}
+
+static inline uint32_t qemu_xxhash4(uint64_t ab, uint64_t cd)
+{
+    return qemu_xxhash7(ab, cd, 0, 0, 0);
+}
+
+static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
+{
+    return qemu_xxhash7(ab, cd, e, 0, 0);
+}
+
+static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
+                                    uint32_t f)
+{
+    return qemu_xxhash7(ab, cd, e, f, 0);
+}
+
 #endif /* EXEC_TB_HASH_XX_H */
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 0526c4f678..731ba4c272 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -61,7 +61,7 @@ static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
                       uint32_t cf_mask, uint32_t trace_vcpu_dstate)
 {
-    return tb_hash_func7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
+    return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
 }
 
 #endif
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 636750d39f..0278f4da04 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -105,7 +105,7 @@ static bool is_equal(const void *ap, const void *bp)
 
 static uint32_t h(unsigned long v)
 {
-    return tb_hash_func7(v, 0, 0, 0, 0);
+    return qemu_xxhash2(v);
 }
 
 static uint32_t hval(unsigned long v)
diff --git a/util/qsp.c b/util/qsp.c
index a848b09c6d..dc29c41fde 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -135,13 +135,13 @@ QemuCondWaitFunc qemu_cond_wait_func = qemu_cond_wait_impl;
  * without it we still get a pretty unique hash.
  */
 static inline
-uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t a)
+uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t ab)
 {
-    uint64_t b = (uint64_t)(uintptr_t)callsite->obj;
+    uint64_t cd = (uint64_t)(uintptr_t)callsite->obj;
     uint32_t e = callsite->line;
     uint32_t f = callsite->type;
 
-    return tb_hash_func7(a, b, e, f, 0);
+    return qemu_xxhash6(ab, cd, e, f);
 }
 
 static inline
@@ -169,11 +169,11 @@ static uint32_t qsp_entry_no_thread_hash(const QSPEntry *entry)
 static uint32_t qsp_entry_no_thread_obj_hash(const QSPEntry *entry)
 {
     const QSPCallSite *callsite = entry->callsite;
-    uint64_t a = g_str_hash(callsite->file);
-    uint64_t b = callsite->line;
+    uint64_t ab = g_str_hash(callsite->file);
+    uint64_t cd = callsite->line;
     uint32_t e = callsite->type;
 
-    return tb_hash_func7(a, b, e, 0, 0);
+    return qemu_xxhash5(ab, cd, e);
 }
 
 static bool qsp_callsite_cmp(const void *ap, const void *bp)
-- 
2.17.2
