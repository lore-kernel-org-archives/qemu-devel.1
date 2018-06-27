Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2D-0003ci-Re
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2C-0003uM-VA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYA2C-0003u5-Oz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 13:58:43 +0100
Message-Id: <20180627125847.5413-3-stefanha@redhat.com>
In-Reply-To: <20180627125847.5413-1-stefanha@redhat.com>
References: <20180627125847.5413-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] trace: simplify trace_mem functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Add some defines for the mem_info bits, simplify
trace_mem_build_info, and also simplify trace_mem_get_info
by making it a wrapper around trace_mem_build_info.

This paves the way for increasing size_shift by one bit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 1527028012-21888-3-git-send-email-cota@braap.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/mem-internal.h | 46 ++++++++++++++++++++------------------------
 trace/mem.h          |  2 +-
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index ddda934253..b684e2750c 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -10,37 +10,33 @@
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
 
-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
-{
-    uint8_t res = op;
-    bool be = (op & MO_BSWAP) == MO_BE;
-
-    /* remove untraced fields */
-    res &= (1ULL << 4) - 1;
-    /* make endianness absolute */
-    res &= ~MO_BSWAP;
-    if (be) {
-        res |= 1ULL << 3;
-    }
-    /* add fields */
-    if (store) {
-        res |= 1ULL << 4;
-    }
-
-    return res;
-}
+#define TRACE_MEM_SZ_SHIFT_MASK 0x3 /* size shift mask */
+#define TRACE_MEM_SE (1ULL << 2)    /* sign extended (y/n) */
+#define TRACE_MEM_BE (1ULL << 3)    /* big endian (y/n) */
+#define TRACE_MEM_ST (1ULL << 4)    /* store (y/n) */
 
 static inline uint8_t trace_mem_build_info(
-    TCGMemOp size, bool sign_extend, TCGMemOp endianness, bool store)
+    int size_shift, bool sign_extend, TCGMemOp endianness, bool store)
 {
-    uint8_t res = 0;
-    res |= size;
-    res |= (sign_extend << 2);
+    uint8_t res;
+
+    res = size_shift & TRACE_MEM_SZ_SHIFT_MASK;
+    if (sign_extend) {
+        res |= TRACE_MEM_SE;
+    }
     if (endianness == MO_BE) {
-        res |= (1ULL << 3);
+        res |= TRACE_MEM_BE;
+    }
+    if (store) {
+        res |= TRACE_MEM_ST;
     }
-    res |= (store << 4);
     return res;
 }
 
+static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
+{
+    return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),
+                                op & MO_BSWAP, store);
+}
+
 #endif /* TRACE__MEM_INTERNAL_H */
diff --git a/trace/mem.h b/trace/mem.h
index 9c88bcb4e6..2b58196e53 100644
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
2.17.1
