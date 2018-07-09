Received: from eggs.gnu.org ([2001:4830:134:3::10]:34842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcbdI-0008Nz-Di
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcbdF-0004ZO-6z
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:15:36 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcbdE-0004Xt-Qq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:15:33 -0400
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so6464891plq.6
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 12:15:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Jul 2018 12:15:29 -0700
Message-Id: <20180709191529.13080-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Fix shmat emulation by honoring
 host SHMLBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

For those hosts with SHMLBA > getpagesize, we don't automatically
select a guest address that is compatible with the host.  We can
achieve this by boosting the alignment of guest_base and by adding
an extra alignment argument to mmap_find_vma.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Found by running check-tcg on an arm32 host, which defines (host) SHMLBA
as 16K, executing the "native" or "non-cross-compiled" linux-test.
Pushing that back to x86 snuffled out more fixes required for mips, which
defines (guest) SHMLBA as 256k.

While this is newly exposed by check-tcg, the problem has been latent
for quite a while.  It probably doesn't warrent rushing in for 3.0.


r~

---
 linux-user/qemu.h    |  2 +-
 linux-user/elfload.c | 17 +++++-----
 linux-user/mmap.c    | 74 +++++++++++++++++++++++---------------------
 linux-user/syscall.c |  3 +-
 4 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index bb85c81aa4..b79ac8bd01 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -436,7 +436,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
+abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 942a1b661f..3467e3512e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3,6 +3,7 @@
 #include <sys/param.h>
 
 #include <sys/resource.h>
+#include <sys/shm.h>
 
 #include "qemu.h"
 #include "disas/disas.h"
@@ -1929,6 +1930,8 @@ unsigned long init_guest_space(unsigned long host_start,
                                unsigned long guest_start,
                                bool fixed)
 {
+    /* In order to use host shmat, we must be able to honor SHMLBA.  */
+    unsigned long align = MAX(SHMLBA, qemu_host_page_size);
     unsigned long current_start, aligned_start;
     int flags;
 
@@ -1946,7 +1949,7 @@ unsigned long init_guest_space(unsigned long host_start,
     }
 
     /* Setup the initial flags and start address.  */
-    current_start = host_start & qemu_host_page_mask;
+    current_start = host_start & -align;
     flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
     if (fixed) {
         flags |= MAP_FIXED;
@@ -1982,8 +1985,8 @@ unsigned long init_guest_space(unsigned long host_start,
             return (unsigned long)-1;
         }
         munmap((void *)real_start, host_full_size);
-        if (real_start & ~qemu_host_page_mask) {
-            /* The same thing again, but with an extra qemu_host_page_size
+        if (real_start & (align - 1)) {
+            /* The same thing again, but with extra
              * so that we can shift around alignment.
              */
             unsigned long real_size = host_full_size + qemu_host_page_size;
@@ -1996,7 +1999,7 @@ unsigned long init_guest_space(unsigned long host_start,
                 return (unsigned long)-1;
             }
             munmap((void *)real_start, real_size);
-            real_start = HOST_PAGE_ALIGN(real_start);
+            real_start = ROUND_UP(real_start, align);
         }
         current_start = real_start;
     }
@@ -2023,7 +2026,7 @@ unsigned long init_guest_space(unsigned long host_start,
         }
 
         /* Ensure the address is properly aligned.  */
-        if (real_start & ~qemu_host_page_mask) {
+        if (real_start & (align - 1)) {
             /* Ideally, we adjust like
              *
              *    pages: [  ][  ][  ][  ][  ]
@@ -2051,7 +2054,7 @@ unsigned long init_guest_space(unsigned long host_start,
             if (real_start == (unsigned long)-1) {
                 return (unsigned long)-1;
             }
-            aligned_start = HOST_PAGE_ALIGN(real_start);
+            aligned_start = ROUND_UP(real_start, align);
         } else {
             aligned_start = real_start;
         }
@@ -2088,7 +2091,7 @@ unsigned long init_guest_space(unsigned long host_start,
          * because of trouble with ARM commpage setup.
          */
         munmap((void *)real_start, real_size);
-        current_start += qemu_host_page_size;
+        current_start += align;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
              * aligned areas.  Normally the first mmap will fail.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d0c50e4888..c800c9ab82 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -202,49 +202,52 @@ unsigned long last_brk;
 
 /* Subroutine of mmap_find_vma, used when we have pre-allocated a chunk
    of guest address space.  */
-static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
+static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
+                                        abi_ulong align)
 {
-    abi_ulong addr;
-    abi_ulong end_addr;
+    abi_ulong addr, end_addr, incr = qemu_host_page_size;
     int prot;
-    int looped = 0;
+    bool looped = false;
 
     if (size > reserved_va) {
         return (abi_ulong)-1;
     }
 
-    size = HOST_PAGE_ALIGN(size);
-    end_addr = start + size;
-    if (end_addr > reserved_va) {
-        end_addr = reserved_va;
-    }
-    addr = end_addr - qemu_host_page_size;
+    /* Note that start and size have already been aligned by mmap_find_vma. */
 
+    end_addr = start + size;
+    if (start > reserved_va - size) {
+        /* Start at the top of the address space.  */
+        end_addr = ((reserved_va - size) & -align) + size;
+        looped = true;
+    }
+
+    /* Search downward from END_ADDR, checking to see if a page is in use.  */
+    addr = end_addr;
     while (1) {
+        addr -= incr;
         if (addr > end_addr) {
             if (looped) {
+                /* Failure.  The entire address space has been searched.  */
                 return (abi_ulong)-1;
             }
-            end_addr = reserved_va;
-            addr = end_addr - qemu_host_page_size;
-            looped = 1;
-            continue;
+            /* Re-start at the top of the address space.  */
+            addr = end_addr = ((reserved_va - size) & -align) + size;
+            looped = true;
+        } else {
+            prot = page_get_flags(addr);
+            if (prot) {
+                /* Page in use.  Restart below this page.  */
+                addr = end_addr = ((addr - size) & -align) + size;
+            } else if (addr && addr + size == end_addr) {
+                /* Success!  All pages between ADDR and END_ADDR are free.  */
+                if (start == mmap_next_start) {
+                    mmap_next_start = addr;
+                }
+                return addr;
+            }
         }
-        prot = page_get_flags(addr);
-        if (prot) {
-            end_addr = addr;
-        }
-        if (addr && addr + size == end_addr) {
-            break;
-        }
-        addr -= qemu_host_page_size;
     }
-
-    if (start == mmap_next_start) {
-        mmap_next_start = addr;
-    }
-
-    return addr;
 }
 
 /*
@@ -253,7 +256,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
  * It must be called with mmap_lock() held.
  * Return -1 if error.
  */
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 {
     void *ptr, *prev;
     abi_ulong addr;
@@ -265,11 +268,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
     } else {
         start &= qemu_host_page_mask;
     }
+    start = ROUND_UP(start, align);
 
     size = HOST_PAGE_ALIGN(size);
 
     if (reserved_va) {
-        return mmap_find_vma_reserved(start, size);
+        return mmap_find_vma_reserved(start, size, align);
     }
 
     addr = start;
@@ -299,7 +303,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
         if (h2g_valid(ptr + size - 1)) {
             addr = h2g(ptr);
 
-            if ((addr & ~TARGET_PAGE_MASK) == 0) {
+            if ((addr & (align - 1)) == 0) {
                 /* Success.  */
                 if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
                     mmap_next_start = addr + size;
@@ -313,12 +317,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
                 /* Assume the result that the kernel gave us is the
                    first with enough free space, so start again at the
                    next higher target page.  */
-                addr = TARGET_PAGE_ALIGN(addr);
+                addr = ROUND_UP(addr, align);
                 break;
             case 1:
                 /* Sometimes the kernel decides to perform the allocation
                    at the top end of memory instead.  */
-                addr &= TARGET_PAGE_MASK;
+                addr &= align - 1;
                 break;
             case 2:
                 /* Start over at low memory.  */
@@ -407,7 +411,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     if (!(flags & MAP_FIXED)) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
-        start = mmap_find_vma(real_start, host_len);
+        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
@@ -701,7 +705,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
 
-        mmap_start = mmap_find_vma(0, new_size);
+        mmap_start = mmap_find_vma(0, new_size, TARGET_PAGE_SIZE);
 
         if (mmap_start == -1) {
             errno = ENOMEM;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5822e03e28..b6c37cbb97 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5000,7 +5000,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
     else {
         abi_ulong mmap_start;
 
-        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+        /* In order to use the host shmat, we need to honor host SHMLBA.  */
+        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
 
         if (mmap_start == -1) {
             errno = ENOMEM;
-- 
2.17.1
