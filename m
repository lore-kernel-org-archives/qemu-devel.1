Received: from eggs.gnu.org ([2001:4830:134:3::10]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1fuD5Z-0008Mx-Vh
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1fuD5W-0003fi-GM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:41:33 -0400
Received: from mail-db5eur03on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe0a::716]:52208
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Simon.Hausmann@qt.io>)
	id 1fuD5W-0003dJ-0B
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:41:30 -0400
From: Simon Hausmann <simon.hausmann@qt.io>
Date: Mon, 27 Aug 2018 10:40:37 +0200
Message-Id: <20180827084037.25316-1-simon.hausmann@qt.io>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] linux-user: add support for MADV_DONTNEED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Simon Hausmann <simon.hausmann@qt.io>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Sami Nurmenniemi <sami.nurmenniemi@qt.io>

Most flags to madvise() are just hints, so typically ignoring the
syscall and returning okay is fine. However applications exist that do
rely on MADV_DONTNEED behavior to guarantee that upon subsequent access
the mapping is refreshed from the backing file or zero for anonymous
mappings. The file backed mappings this is tricky - hence the original
comment - but for anonymous mappings it is safe to forward. We just need
to remember which those mappings are, which is now stored in the flags.

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Sami Nurmenniemi <sami.nurmenniemi@qt.io>
Signed-off-by: Simon Hausmann <simon.hausmann@qt.io>

--
v2:
  - align start and len on host page size
v3:
  - align start and len to target page size as it may be bigger than
    host
  - use immediate return in do_syscall
  - forward MADV_DONTNEED advice only for anonymously mapped pages
  - remember which mappings are anonymous in the page flags and preserve
    those bits across mprotect calls.
---
 accel/tcg/translate-all.c |  8 +++++--
 bsd-user/mmap.c           |  8 +++----
 include/exec/cpu-all.h    | 11 ++++++++-
 linux-user/elfload.c      |  3 ++-
 linux-user/mmap.c         | 49 +++++++++++++++++++++++++++++++++++----
 linux-user/qemu.h         |  1 +
 linux-user/syscall.c      | 12 ++++------
 7 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 898c3bb3d1..467fbd9aeb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2481,7 +2481,8 @@ int page_get_flags(target_ulong address)
 /* Modify the flags of a page and invalidate the code if necessary.
    The flag PAGE_WRITE_ORG is positioned automatically depending
    on PAGE_WRITE.  The mmap_lock should already be held.  */
-void page_set_flags(target_ulong start, target_ulong end, int flags)
+void page_set_flags(target_ulong start, target_ulong end, int flags,
+                    enum page_set_flags_mode mode)
 {
     target_ulong addr, len;
 
@@ -2513,7 +2514,10 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
             p->first_tb) {
             tb_invalidate_phys_page(addr, 0);
         }
-        p->flags = flags;
+        if (mode == PAGE_SET_ALL_FLAGS)
+            p->flags = flags;
+        else /* PAGE_SET_PROTECTION */
+            p->flags |= (p->flags & ~(PAGE_BITS - 1)) | (flags & PAGE_BITS);
     }
 }
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 17f4cd80aa..4bfac81af4 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -125,7 +125,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         if (ret != 0)
             goto error;
     }
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);
     mmap_unlock();
     return 0;
 error:
@@ -214,7 +214,7 @@ static abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
            to mmap.  */
         page_set_flags(last_brk & TARGET_PAGE_MASK,
                        TARGET_PAGE_ALIGN(new_brk),
-                       PAGE_RESERVED);
+                       PAGE_RESERVED, PAGE_SET_ALL_FLAGS);
     }
     last_brk = new_brk;
 
@@ -397,7 +397,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
     }
  the_end1:
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, prot | PAGE_VALID, PAGE_SET_ALL_FLAGS);
  the_end:
 #ifdef DEBUG_MMAP
     printf("ret=0x" TARGET_FMT_lx "\n", start);
@@ -460,7 +460,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     }
 
     if (ret == 0)
-        page_set_flags(start, start + len, 0);
+        page_set_flags(start, start + len, 0, PAGE_SET_ALL_FLAGS);
     mmap_unlock();
     return ret;
 }
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 117d2fbbca..100388dcd4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -249,6 +249,9 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+#if defined(CONFIG_LINUX) && defined(CONFIG_USER_ONLY)
+#define PAGE_MAP_ANONYMOUS 0x0080
+#endif
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
@@ -257,8 +260,14 @@ typedef int (*walk_memory_regions_fn)(void *, target_ulong,
                                       target_ulong, unsigned long);
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
+enum page_set_flags_mode {
+    PAGE_SET_ALL_FLAGS,
+    PAGE_SET_PROTECTION
+};
+
 int page_get_flags(target_ulong address);
-void page_set_flags(target_ulong start, target_ulong end, int flags);
+void page_set_flags(target_ulong start, target_ulong end, int flags,
+                    enum page_set_flags_mode);
 int page_check_range(target_ulong start, target_ulong len, int flags);
 #endif
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..c59cf4359c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1702,7 +1702,8 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
 
     /* Ensure that the bss page(s) are valid */
     if ((page_get_flags(last_bss-1) & prot) != prot) {
-        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot | PAGE_VALID);
+        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot,
+                       PAGE_SET_PROTECTION);
     }
 
     if (host_start < host_map_start) {
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 41e0983ce8..fff29ee04b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -124,7 +124,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         if (ret != 0)
             goto error;
     }
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);
     mmap_unlock();
     return 0;
 error:
@@ -362,6 +362,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset)
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
+    int page_flags;
 
     mmap_lock();
 #ifdef DEBUG_MMAP
@@ -562,7 +563,11 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
     }
  the_end1:
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_flags = prot | PAGE_VALID;
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_MAP_ANONYMOUS;
+    }
+    page_set_flags(start, start + len, page_flags, PAGE_SET_ALL_FLAGS);
  the_end:
 #ifdef DEBUG_MMAP
     printf("ret=0x" TARGET_ABI_FMT_lx "\n", start);
@@ -675,7 +680,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     }
 
     if (ret == 0) {
-        page_set_flags(start, start + len, 0);
+        page_set_flags(start, start + len, 0, PAGE_SET_ALL_FLAGS);
         tb_invalidate_phys_range(start, start + len);
     }
     mmap_unlock();
@@ -755,10 +760,44 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     } else {
         new_addr = h2g(host_addr);
         prot = page_get_flags(old_addr);
-        page_set_flags(old_addr, old_addr + old_size, 0);
-        page_set_flags(new_addr, new_addr + new_size, prot | PAGE_VALID);
+        page_set_flags(old_addr, old_addr + old_size, 0,
+                       PAGE_SET_ALL_FLAGS);
+        page_set_flags(new_addr, new_addr + new_size, prot | PAGE_VALID,
+                       PAGE_SET_ALL_FLAGS);
     }
     tb_invalidate_phys_range(new_addr, new_addr + new_size);
     mmap_unlock();
     return new_addr;
 }
+
+int target_madvise(abi_ulong start, abi_ulong len, int advice)
+{
+    abi_ulong end, addr;
+    int ret;
+
+    len = TARGET_PAGE_ALIGN(len);
+    start &= TARGET_PAGE_MASK;
+
+    if (!guest_range_valid(start, len)) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    /* A straight passthrough may not be safe because qemu sometimes
+       turns private file-backed mappings into anonymous mappings.
+       Most flags are hints so we ignore them.
+       One exception is made for MADV_DONTNEED on anonymous mappings,
+       that applications may rely on to zero out pages. */
+    if (advice & MADV_DONTNEED) {
+        end = start + len;
+        for (addr = start; addr < end; addr += TARGET_PAGE_SIZE) {
+            if (page_get_flags(addr) & PAGE_MAP_ANONYMOUS) {
+                ret = madvise(g2h(addr), TARGET_PAGE_SIZE, MADV_DONTNEED);
+                if (ret != 0) {
+                    return ret;
+                }
+            }
+        }
+    }
+    return 0;
+}
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index b4959e41c6..e5ac5e9c6a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -437,6 +437,7 @@ int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
+int target_madvise(abi_ulong start, abi_ulong len, int advice);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 850b72a0c7..4478de5fc8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5124,7 +5124,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     page_set_flags(raddr, raddr + shm_info.shm_segsz,
                    PAGE_VALID | PAGE_READ |
-                   ((shmflg & SHM_RDONLY)? 0 : PAGE_WRITE));
+                   ((shmflg & SHM_RDONLY) ? 0 : PAGE_WRITE),
+                   PAGE_SET_ALL_FLAGS);
 
     for (i = 0; i < N_SHM_REGIONS; i++) {
         if (!shm_regions[i].in_use) {
@@ -5150,7 +5151,8 @@ static inline abi_long do_shmdt(abi_ulong shmaddr)
     for (i = 0; i < N_SHM_REGIONS; ++i) {
         if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
             shm_regions[i].in_use = false;
-            page_set_flags(shmaddr, shmaddr + shm_regions[i].size, 0);
+            page_set_flags(shmaddr, shmaddr + shm_regions[i].size, 0,
+                           PAGE_SET_ALL_FLAGS);
             break;
         }
     }
@@ -11559,11 +11561,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_madvise
     case TARGET_NR_madvise:
-        /* A straight passthrough may not be safe because qemu sometimes
-           turns private file-backed mappings into anonymous mappings.
-           This will break MADV_DONTNEED.
-           This is a hint, so ignoring and returning success is ok.  */
-        return 0;
+        return get_errno(target_madvise(arg1, arg2, arg3));
 #endif
 #if TARGET_ABI_BITS == 32
     case TARGET_NR_fcntl64:
-- 
2.17.1
