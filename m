Received: from eggs.gnu.org ([2001:4830:134:3::10]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1l-0003Q1-AD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1h-0003R7-5p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:45 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:44317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1erA1g-0003PB-Mx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:40 -0500
Received: by mail-lf0-x243.google.com with SMTP id v9so5848903lfa.11
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:16:40 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 14:16:06 -0800
Message-Id: <20180228221609.11265-9-jcmvbkbc@gmail.com>
In-Reply-To: <20180228221609.11265-1-jcmvbkbc@gmail.com>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 08/11] linux-user: drop unused target_msync
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

target_msync is not used, remove its declaration and implementation.

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/mmap.c | 17 -----------------
 linux-user/qemu.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 84b15c9a1699..9168a2051c34 100644
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
index f4b4ca72adb0..23712bbca860 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -428,7 +428,6 @@ int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
-int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
-- 
2.11.0
