Received: from eggs.gnu.org ([2001:4830:134:3::10]:45408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5he-0001EY-I4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ha-00088Z-9c
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:02 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:51 -0500
Message-Id: <20180619014319.28272-26-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 025/113] linux-user: fix
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
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Max Filippov <jcmvbkbc@gmail.com>

target_mprotect/target_munmap return value goes through get_errno at the
call site, thus the functions must either set errno to host error code
and return -1 or return negative guest error code. Do the latter.

Cc: qemu-stable@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180228221609.11265-8-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 78cf339039c325b336442f1d7f3ccc531b22c4a0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 33a73cd29c..e0c946eae6 100644
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
