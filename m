Received: from eggs.gnu.org ([2001:4830:134:3::10]:43609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFkB-0003Im-Td
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFk7-000729-03
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fLFk6-00071Z-Ql
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 May 2018 18:26:49 -0400
Message-Id: <1527028012-21888-3-git-send-email-cota@braap.org>
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/5] trace: simplify trace_mem functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add some defines for the mem_info bits, simplify
trace_mem_build_info, and also simplify trace_mem_get_info
by making it a wrapper around trace_mem_build_info.

This paves the way for increasing size_shift by one bit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace/mem-internal.h | 40 ++++++++++++++++++----------------------
 trace/mem.h          |  2 +-
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index ddda934..b684e27 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -10,37 +10,33 @@
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
 
-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
+#define TRACE_MEM_SZ_SHIFT_MASK 0x3 /* size shift mask */
+#define TRACE_MEM_SE (1ULL << 2)    /* sign extended (y/n) */
+#define TRACE_MEM_BE (1ULL << 3)    /* big endian (y/n) */
+#define TRACE_MEM_ST (1ULL << 4)    /* store (y/n) */
+
+static inline uint8_t trace_mem_build_info(
+    int size_shift, bool sign_extend, TCGMemOp endianness, bool store)
 {
-    uint8_t res = op;
-    bool be = (op & MO_BSWAP) == MO_BE;
+    uint8_t res;
 
-    /* remove untraced fields */
-    res &= (1ULL << 4) - 1;
-    /* make endianness absolute */
-    res &= ~MO_BSWAP;
-    if (be) {
-        res |= 1ULL << 3;
+    res = size_shift & TRACE_MEM_SZ_SHIFT_MASK;
+    if (sign_extend) {
+        res |= TRACE_MEM_SE;
+    }
+    if (endianness == MO_BE) {
+        res |= TRACE_MEM_BE;
     }
-    /* add fields */
     if (store) {
-        res |= 1ULL << 4;
+        res |= TRACE_MEM_ST;
     }
-
     return res;
 }
 
-static inline uint8_t trace_mem_build_info(
-    TCGMemOp size, bool sign_extend, TCGMemOp endianness, bool store)
+static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
 {
-    uint8_t res = 0;
-    res |= size;
-    res |= (sign_extend << 2);
-    if (endianness == MO_BE) {
-        res |= (1ULL << 3);
-    }
-    res |= (store << 4);
-    return res;
+    return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),
+                                op & MO_BSWAP, store);
 }
 
 #endif /* TRACE__MEM_INTERNAL_H */
diff --git a/trace/mem.h b/trace/mem.h
index 9c88bcb..2b58196 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -25,7 +25,7 @@ static uint8_t trace_mem_get_info(TCGMemOp op, bool store);
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_build_info(TCGMemOp size, bool sign_extend,
+static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,
                                     TCGMemOp endianness, bool store);
 
 
-- 
2.7.4
