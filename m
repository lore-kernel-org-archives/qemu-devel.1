Received: from eggs.gnu.org ([2001:4830:134:3::10]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1j-0003OZ-K9
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1e-0003NG-KY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:43 -0500
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 14:16:05 -0800
Message-Id: <20180228221609.11265-8-jcmvbkbc@gmail.com>
In-Reply-To: <20180228221609.11265-1-jcmvbkbc@gmail.com>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 07/11] linux-user: fix
 target_mprotect/target_munmap error return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

target_mprotect/target_munmap return value goes through get_errno at the
call site, thus the functions must either set errno to host error code
and return -1 or return negative guest error code. Do the latter.

Cc: qemu-stable@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index df81f9b803b6..84b15c9a1699 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -77,11 +77,11 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
 #endif
 
     if ((start & ~TARGET_PAGE_MASK) != 0)
-        return -EINVAL;
+        return -TARGET_EINVAL;
     len = TARGET_PAGE_ALIGN(len);
     end = start + len;
     if (!guest_range_valid(start, len)) {
-        return -ENOMEM;
+        return -TARGET_ENOMEM;
     }
     prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
     if (len == 0)
@@ -621,10 +621,10 @@ int target_munmap(abi_ulong start, abi_ulong len)
            start, len);
 #endif
     if (start & ~TARGET_PAGE_MASK)
-        return -EINVAL;
+        return -TARGET_EINVAL;
     len = TARGET_PAGE_ALIGN(len);
     if (len == 0 || !guest_range_valid(start, len)) {
-        return -EINVAL;
+        return -TARGET_EINVAL;
     }
 
     mmap_lock();
-- 
2.11.0
