Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1ft8dA-0007Om-UH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1ft8d7-0002SE-N8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:43:48 -0400
Received: from mail-db5eur01on0100.outbound.protection.outlook.com
	([104.47.2.100]:54966
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Simon.Hausmann@qt.io>)
	id 1ft8d7-0002RD-CG
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:43:45 -0400
From: Simon Hausmann <simon.hausmann@qt.io>
Date: Fri, 24 Aug 2018 11:43:30 +0200
Message-Id: <20180824094330.8908-1-simon.hausmann@qt.io>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] linux-user: add support for MADV_DONTNEED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Sami Nurmenniemi <sami.nurmenniemi@qt.io>, Simon Hausmann <simon.hausmann@qt.io>

Most flags to madvise() are just hints, so typically ignoring the
syscall and returning okay is fine. However applications exist that do
rely on MADV_DONTNEED behavior to guarantee that upon subsequent access
the mapping is refreshed from the backing file or zero for anonymous
mappings.

Signed-off-by: Simon Hausmann <simon.hausmann@qt.io>
---
 linux-user/mmap.c    | 21 +++++++++++++++++++++
 linux-user/qemu.h    |  1 +
 linux-user/syscall.c |  6 +-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 41e0983ce8..6b308d4e13 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -762,3 +762,24 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     mmap_unlock();
     return new_addr;
 }
+
+int target_madvise(abi_ulong start, abi_ulong len, int flags)
+{
+    len = HOST_PAGE_ALIGN(len);
+    start &= qemu_host_page_mask;
+
+    if (!guest_range_valid(start, len)) {
+        errno = TARGET_EINVAL;
+        return -1;
+    }
+
+    /* A straight passthrough may not be safe because qemu sometimes
+       turns private file-backed mappings into anonymous mappings.
+       Most flags are hints, except for MADV_DONTNEED that applications
+       may rely on to zero out pages, so we pass that through.
+       Otherwise returning success is ok. */
+    if (flags & MADV_DONTNEED) {
+        return madvise(g2h(start), len, MADV_DONTNEED);
+    }
+    return 0;
+}
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index b4959e41c6..4b68019904 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -437,6 +437,7 @@ int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
+int target_madvise(abi_ulong start, abi_ulong len, int flags);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 202aa777ad..023874ac8c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11874,11 +11874,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_madvise
     case TARGET_NR_madvise:
-        /* A straight passthrough may not be safe because qemu sometimes
-           turns private file-backed mappings into anonymous mappings.
-           This will break MADV_DONTNEED.
-           This is a hint, so ignoring and returning success is ok.  */
-        ret = get_errno(0);
+        ret = get_errno(target_madvise(arg1, arg2, arg3));
         break;
 #endif
 #if TARGET_ABI_BITS == 32
-- 
2.17.1
