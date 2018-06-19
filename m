Received: from eggs.gnu.org ([2001:4830:134:3::10]:45345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hY-00018O-UT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hY-00087W-1f
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:57 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:50 -0500
Message-Id: <20180619014319.28272-25-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 024/113] linux-user: fix assertion in shmdt
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

shmdt fails to call mmap_lock/mmap_unlock around page_set_flags,
resulting in the following assertion:
  page_set_flags: Assertion `have_mmap_lock()' failed.

Wrap shmdt internals into mmap_lock/mmap_unlock.

Cc: qemu-stable@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180228221609.11265-7-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 3c5f6a5f888729f9fbc64211298f7c3e2fb42b64)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9872de7221..74d56e2ee6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4918,6 +4918,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 static inline abi_long do_shmdt(abi_ulong shmaddr)
 {
     int i;
+    abi_long rv;
+
+    mmap_lock();
 
     for (i = 0; i < N_SHM_REGIONS; ++i) {
         if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
@@ -4926,8 +4929,11 @@ static inline abi_long do_shmdt(abi_ulong shmaddr)
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
