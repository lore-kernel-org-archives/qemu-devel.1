Received: from eggs.gnu.org ([2001:4830:134:3::10]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs5-00077S-5m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs0-0002QM-Cd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:21 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:61585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzs0-0002Ot-34
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:03 +0100
Message-Id: <20180123144807.5618-10-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 09/13] linux-user: Add getcpu() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Laurent Vivier <laurent@vivier.eu>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180112081435.21299-1-samuel.thibault@ens-lyon.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 143e4a959d..104408c050 100644
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
@@ -10491,6 +10493,23 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
         break;
+    case TARGET_NR_getcpu:
+        {
+            unsigned cpu, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+                                       arg2 ? &node : NULL,
+                                       NULL));
+            if (is_error(ret)) {
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
2.14.3
