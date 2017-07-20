Received: from eggs.gnu.org ([2001:4830:134:3::10]:60402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qT-0001A6-96
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qN-0005wu-Eq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qN-0005w5-80
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:26 -0400
Message-Id: <1500520169-23367-41-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 40/43] translate-all: use
 qemu_protect_rwx/none helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

The helpers require the address and size to be page-aligned, so
do that before calling them.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 61 ++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 36b17ac..e930bac 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -604,63 +604,24 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
 static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
     __attribute__((aligned(CODE_GEN_ALIGN)));
 
-# ifdef _WIN32
-static inline void do_protect(void *addr, long size, int prot)
-{
-    DWORD old_protect;
-    VirtualProtect(addr, size, prot, &old_protect);
-}
-
-static inline void map_exec(void *addr, long size)
-{
-    do_protect(addr, size, PAGE_EXECUTE_READWRITE);
-}
-
-static inline void map_none(void *addr, long size)
-{
-    do_protect(addr, size, PAGE_NOACCESS);
-}
-# else
-static inline void do_protect(void *addr, long size, int prot)
-{
-    uintptr_t start, end;
-
-    start = (uintptr_t)addr;
-    start &= qemu_real_host_page_mask;
-
-    end = (uintptr_t)addr + size;
-    end = ROUND_UP(end, qemu_real_host_page_size);
-
-    mprotect((void *)start, end - start, prot);
-}
-
-static inline void map_exec(void *addr, long size)
-{
-    do_protect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
-}
-
-static inline void map_none(void *addr, long size)
-{
-    do_protect(addr, size, PROT_NONE);
-}
-# endif /* WIN32 */
-
 static inline void *alloc_code_gen_buffer(void)
 {
     void *buf = static_code_gen_buffer;
+    void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
     size_t full_size, size;
 
-    /* The size of the buffer, rounded down to end on a page boundary.  */
-    full_size = (((uintptr_t)buf + sizeof(static_code_gen_buffer))
-                 & qemu_real_host_page_mask) - (uintptr_t)buf;
+    /* page-align the beginning and end of the buffer */
+    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
+    end = QEMU_ALIGN_PTR_DOWN(end, qemu_real_host_page_size);
 
     /* Reserve a guard page.  */
+    full_size = end - buf;
     size = full_size - qemu_real_host_page_size;
 
     /* Honor a command-line option limiting the size of the buffer.  */
     if (size > tcg_ctx->code_gen_buffer_size) {
-        size = (((uintptr_t)buf + tcg_ctx->code_gen_buffer_size)
-                & qemu_real_host_page_mask) - (uintptr_t)buf;
+        size = QEMU_ALIGN_DOWN(tcg_ctx->code_gen_buffer_size,
+                               qemu_real_host_page_size);
     }
     tcg_ctx->code_gen_buffer_size = size;
 
@@ -671,8 +632,12 @@ static inline void *alloc_code_gen_buffer(void)
     }
 #endif
 
-    map_exec(buf, size);
-    map_none(buf + size, qemu_real_host_page_size);
+    if (qemu_mprotect_rwx(buf, size)) {
+        abort();
+    }
+    if (qemu_mprotect_none(buf + size, qemu_real_host_page_size)) {
+        abort();
+    }
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
     return buf;
-- 
2.7.4
