Received: from eggs.gnu.org ([2001:4830:134:3::10]:55333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoY-0008R8-VN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoW-0007lh-8b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnoV-0007kL-VY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:45 +0100
Message-Id: <20180313173355.4468-9-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 08/18] linux-user: drop unused target_msync
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

target_msync is not used, remove its declaration and implementation.

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180228221609.11265-9-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 17 -----------------
 linux-user/qemu.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 84b15c9a16..9168a2051c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -754,20 +754,3 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     mmap_unlock();
     return new_addr;
 }
-
-int target_msync(abi_ulong start, abi_ulong len, int flags)
-{
-    abi_ulong end;
-
-    if (start & ~TARGET_PAGE_MASK)
-        return -EINVAL;
-    len = TARGET_PAGE_ALIGN(len);
-    end = start + len;
-    if (end < start)
-        return -EINVAL;
-    if (end == start)
-        return 0;
-
-    start &= qemu_host_page_mask;
-    return msync(g2h(start), end - start, flags);
-}
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 7a1a1ff57a..192a0d2fef 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -425,7 +425,6 @@ int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
-int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
-- 
2.14.3
