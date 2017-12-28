Received: from eggs.gnu.org ([2001:4830:134:3::10]:54305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUZfx-0004ko-Dj
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 10:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUZfu-0000Aq-Ds
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 10:00:53 -0500
Received: from [2a01:474::1] (port=58407 helo=hera.aquilenet.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eUZfu-00009p-6W
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 10:00:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 28 Dec 2017 16:00:38 +0100
Message-Id: <20171228150038.16450-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] linux-user: Add getcpu() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8ec7de96ce..bb8cb726f5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -296,6 +296,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
 #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
 _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
+#define __NR_sys_getcpu __NR_getcpu
+_syscall3(int, sys_getcpu, unsigned *, cpu, unsigned *, node, void *, tcache);
 _syscall4(int, reboot, int, magic1, int, magic2, unsigned int, cmd,
           void *, arg);
 _syscall2(int, capget, struct __user_cap_header_struct *, header,
@@ -10443,6 +10445,20 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
         break;
+    case TARGET_NR_getcpu:
+        {
+            unsigned cpu, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+                                       arg2 ? &node : NULL,
+                                       NULL));
+            if (arg1) {
+                put_user(cpu, arg1, abi_uint);
+            }
+            if (arg2) {
+                put_user(node, arg2, abi_uint);
+            }
+        }
+        break;
     case TARGET_NR_sched_setparam:
         {
             struct sched_param *target_schp;
-- 
2.15.1
