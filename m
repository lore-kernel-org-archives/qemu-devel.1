Received: from eggs.gnu.org ([2001:4830:134:3::10]:46415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmg-0001Dl-Dt
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0008Sl-71
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpma-0008Rt-U5
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:27 -0400
Message-Id: <1500235468-15341-45-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 44/45] translate-all: do not allocate a
 guard page for code_gen_buffer
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

TCG regions already have a guard page.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c30d400..98aa63e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -608,19 +608,11 @@ static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
 static inline void *alloc_code_gen_buffer(void)
 {
     void *buf = static_code_gen_buffer;
-    size_t full_size, size;
-
-    /* The size of the buffer, rounded down to end on a page boundary.  */
-    full_size = (((uintptr_t)buf + sizeof(static_code_gen_buffer))
-                 & qemu_real_host_page_mask) - (uintptr_t)buf;
-
-    /* Reserve a guard page.  */
-    size = full_size - qemu_real_host_page_size;
+    size_t size = sizeof(static_code_gen_buffer);
 
     /* Honor a command-line option limiting the size of the buffer.  */
     if (size > tcg_ctx->code_gen_buffer_size) {
-        size = (((uintptr_t)buf + tcg_ctx->code_gen_buffer_size)
-                & qemu_real_host_page_mask) - (uintptr_t)buf;
+        size = tcg_ctx->code_gen_buffer_size;
     }
     tcg_ctx->code_gen_buffer_size = size;
 
@@ -634,9 +626,6 @@ static inline void *alloc_code_gen_buffer(void)
     if (qemu_mprotect_rwx(buf, size)) {
         abort();
     }
-    if (qemu_mprotect_none(buf + size, qemu_real_host_page_size)) {
-        abort();
-    }
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
     return buf;
@@ -645,22 +634,16 @@ static inline void *alloc_code_gen_buffer(void)
 static inline void *alloc_code_gen_buffer(void)
 {
     size_t size = tcg_ctx->code_gen_buffer_size;
-    void *buf1, *buf2;
-
-    /* Perform the allocation in two steps, so that the guard page
-       is reserved but uncommitted.  */
-    buf1 = VirtualAlloc(NULL, size + qemu_real_host_page_size,
-                        MEM_RESERVE, PAGE_NOACCESS);
-    if (buf1 != NULL) {
-        buf2 = VirtualAlloc(buf1, size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
-        assert(buf1 == buf2);
-    }
+    void *buf;
 
-    return buf1;
+    buf = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
+                        PAGE_EXECUTE_READWRITE);
+    return buf;
 }
 #else
 static inline void *alloc_code_gen_buffer(void)
 {
+    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     uintptr_t start = 0;
     size_t size = tcg_ctx->code_gen_buffer_size;
@@ -694,8 +677,7 @@ static inline void *alloc_code_gen_buffer(void)
 #  endif
 # endif
 
-    buf = mmap((void *)start, size + qemu_real_host_page_size,
-               PROT_NONE, flags, -1, 0);
+    buf = mmap((void *)start, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         return NULL;
     }
@@ -705,24 +687,23 @@ static inline void *alloc_code_gen_buffer(void)
         /* Try again, with the original still mapped, to avoid re-acquiring
            that 256mb crossing.  This time don't specify an address.  */
         size_t size2;
-        void *buf2 = mmap(NULL, size + qemu_real_host_page_size,
-                          PROT_NONE, flags, -1, 0);
+        void *buf2 = mmap(NULL, size, prot, flags, -1, 0);
         switch ((int)(buf2 != MAP_FAILED)) {
         case 1:
             if (!cross_256mb(buf2, size)) {
                 /* Success!  Use the new buffer.  */
-                munmap(buf, size + qemu_real_host_page_size);
+                munmap(buf, size);
                 break;
             }
             /* Failure.  Work with what we had.  */
-            munmap(buf2, size + qemu_real_host_page_size);
+            munmap(buf2, size);
             /* fallthru */
         default:
             /* Split the original buffer.  Free the smaller half.  */
             buf2 = split_cross_256mb(buf, size);
             size2 = tcg_ctx->code_gen_buffer_size;
             if (buf == buf2) {
-                munmap(buf + size2 + qemu_real_host_page_size, size - size2);
+                munmap(buf + size2, size - size2);
             } else {
                 munmap(buf, size - size2);
             }
@@ -733,10 +714,6 @@ static inline void *alloc_code_gen_buffer(void)
     }
 #endif
 
-    /* Make the final buffer accessible.  The guard page at the end
-       will remain inaccessible with PROT_NONE.  */
-    mprotect(buf, size, PROT_WRITE | PROT_READ | PROT_EXEC);
-
     /* Request large pages for the buffer.  */
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
-- 
2.7.4
