Received: from eggs.gnu.org ([2001:4830:134:3::10]:55254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoW-0008PT-Pp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoV-0007kV-A3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:42 +0100
Message-Id: <20180313173355.4468-6-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 05/18] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

From: Max Filippov <jcmvbkbc@gmail.com>

In linux-user QEMU that runs for a target with TARGET_ABI_BITS bigger
than L1_MAP_ADDR_SPACE_BITS an assertion in page_set_flags fires when
mmap, munmap, mprotect, mremap or shmat is called for an address outside
the guest address space. mmap and mprotect should return ENOMEM in such
case.

Change definition of GUEST_ADDR_MAX to always be the last valid guest
address. Account for this change in open_self_maps.
Add macro guest_addr_valid that verifies if the guest address is valid.
Add function guest_range_valid that verifies if address range is within
guest address space and does not wrap around. Use that macro in
mmap/munmap/mprotect/mremap/shmat for error checking.

Cc: qemu-stable@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180307215010.30706-1-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/cpu-all.h  |  6 +++++-
 include/exec/cpu_ldst.h | 16 +++++++---------
 linux-user/mmap.c       | 20 +++++++++++++++-----
 linux-user/syscall.c    |  5 ++++-
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 0b141683f0..f4fa94e966 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -159,8 +159,12 @@ extern unsigned long guest_base;
 extern int have_guest_base;
 extern unsigned long reserved_va;
 
-#define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
+#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
+#define GUEST_ADDR_MAX (~0ul)
+#else
+#define GUEST_ADDR_MAX (reserved_va ? reserved_va - 1 : \
                                     (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
+#endif
 #else
 
 #include "exec/hwaddr.h"
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 191f2e962a..5de8c8a5af 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -51,15 +51,13 @@
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
 #define g2h(x) ((void *)((unsigned long)(target_ulong)(x) + guest_base))
 
-#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
-#define h2g_valid(x) 1
-#else
-#define h2g_valid(x) ({ \
-    unsigned long __guest = (unsigned long)(x) - guest_base; \
-    (__guest < (1ul << TARGET_VIRT_ADDR_SPACE_BITS)) && \
-    (!reserved_va || (__guest < reserved_va)); \
-})
-#endif
+#define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
+#define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
+
+static inline int guest_range_valid(unsigned long start, unsigned long len)
+{
+    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
+}
 
 #define h2g_nocheck(x) ({ \
     unsigned long __ret = (unsigned long)(x) - guest_base; \
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0fbfd6dff2..df81f9b803 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -80,8 +80,9 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         return -EINVAL;
     len = TARGET_PAGE_ALIGN(len);
     end = start + len;
-    if (end < start)
-        return -EINVAL;
+    if (!guest_range_valid(start, len)) {
+        return -ENOMEM;
+    }
     prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
     if (len == 0)
         return 0;
@@ -481,8 +482,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
 	 * It can fail only on 64-bit host with 32-bit target.
 	 * On any other target/host host mmap() handles this error correctly.
 	 */
-        if ((unsigned long)start + len - 1 > (abi_ulong) -1) {
-            errno = EINVAL;
+        if (!guest_range_valid(start, len)) {
+            errno = ENOMEM;
             goto fail;
         }
 
@@ -622,8 +623,10 @@ int target_munmap(abi_ulong start, abi_ulong len)
     if (start & ~TARGET_PAGE_MASK)
         return -EINVAL;
     len = TARGET_PAGE_ALIGN(len);
-    if (len == 0)
+    if (len == 0 || !guest_range_valid(start, len)) {
         return -EINVAL;
+    }
+
     mmap_lock();
     end = start + len;
     real_start = start & qemu_host_page_mask;
@@ -678,6 +681,13 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     int prot;
     void *host_addr;
 
+    if (!guest_range_valid(old_addr, old_size) ||
+        ((flags & MREMAP_FIXED) &&
+         !guest_range_valid(new_addr, new_size))) {
+        errno = ENOMEM;
+        return -1;
+    }
+
     mmap_lock();
 
     if (flags & MREMAP_FIXED) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e1c3127bdc..8cbe4499b2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4900,6 +4900,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
             return -TARGET_EINVAL;
         }
     }
+    if (!guest_range_valid(shmaddr, shm_info.shm_segsz)) {
+        return -TARGET_EINVAL;
+    }
 
     mmap_lock();
 
@@ -7468,7 +7471,7 @@ static int open_self_maps(void *cpu_env, int fd)
         }
         if (h2g_valid(min)) {
             int flags = page_get_flags(h2g(min));
-            max = h2g_valid(max - 1) ? max : (uintptr_t)g2h(GUEST_ADDR_MAX);
+            max = h2g_valid(max - 1) ? max : (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
             if (page_check_range(h2g(min), max - min, flags) == -1) {
                 continue;
             }
-- 
2.14.3
