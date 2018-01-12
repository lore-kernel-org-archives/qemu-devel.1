Received: from eggs.gnu.org ([2001:4830:134:3::10]:54814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZn0P-0000Nl-PM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 19:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZn0O-0006BI-NU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 19:15:33 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZn0O-0006Ae-Ay
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 19:15:32 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 12 Jan 2018 01:15:28 +0100
Message-Id: <20180112001528.14420-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCHv3] linux-user: Add getcpu() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Difference between v1 and v2: handle failure of put_user_u32 with goto efault;
Difference between v2 and v3: handle failure of sys_getcpu system call
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..f8cfaf043a 100644
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
@@ -10403,6 +10405,23 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
         break;
+    case TARGET_NR_getcpu:
+        {
+            unsigned cpu, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+                                       arg2 ? &node : NULL,
+                                       NULL));
+            if (ret < 0) {
+                goto fail;
+            }
+            if (arg1 && put_user_u32(cpu, arg1)) {
+                goto efault;
+            }
+            if (arg2 && put_user_u32(node, arg2)) {
+                goto efault;
+            }
+        }
+        break;
     case TARGET_NR_sched_setparam:
         {
             struct sched_param *target_schp;
-- 
2.15.1
