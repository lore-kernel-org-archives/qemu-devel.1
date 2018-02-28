Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vu-0005iK-B5
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vt-0000ZU-C1
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:38 -0500
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 13:06:11 -0800
Message-Id: <20180228210616.2756-7-jcmvbkbc@gmail.com>
In-Reply-To: <20180228210616.2756-1-jcmvbkbc@gmail.com>
References: <20180228210616.2756-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 06/11] linux-user: fix assertion in shmdt
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

shmdt fails to call mmap_lock/mmap_unlock around page_set_flags,
resulting in the following assertion:
  page_set_flags: Assertion `have_mmap_lock()' failed.

Wrap shmdt internals into mmap_lock/mmap_unlock.

Cc: qemu-stable@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 79245e73784f..595b26fdd8f3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4947,6 +4947,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 static inline abi_long do_shmdt(abi_ulong shmaddr)
 {
     int i;
+    abi_long rv;
+
+    mmap_lock();
 
     for (i = 0; i < N_SHM_REGIONS; ++i) {
         if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
@@ -4955,8 +4958,11 @@ static inline abi_long do_shmdt(abi_ulong shmaddr)
             break;
         }
     }
+    rv = get_errno(shmdt(g2h(shmaddr)));
+
+    mmap_unlock();
 
-    return get_errno(shmdt(g2h(shmaddr)));
+    return rv;
 }
 
 #ifdef TARGET_NR_ipc
-- 
2.11.0
