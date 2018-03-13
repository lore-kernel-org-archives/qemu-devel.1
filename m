Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoW-0008PG-KS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoU-0007ih-0T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:43 +0100
Message-Id: <20180313173355.4468-7-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 06/18] linux-user: fix assertion in shmdt
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
---
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8cbe4499b2..6a38542cb1 100644
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
2.14.3
