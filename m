Received: from eggs.gnu.org ([2001:4830:134:3::10]:55813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1emrpi-0005Dx-Nq
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1emrpi-0003UO-2t
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:02:34 -0500
Received: from mail.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]:41779
	helo=smtp.gentoo.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vapier@gentoo.org>) id 1emrph-0003Tw-SY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:02:34 -0500
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 16 Feb 2018 21:02:30 -0500
Message-Id: <20180217020230.1759-1-vapier@gentoo.org>
In-Reply-To: <20180217020122.1469-1-vapier@gentoo.org>
References: <20180217020122.1469-1-vapier@gentoo.org>
Subject: [Qemu-devel] [PATCH v2] linux-user: make getcpu optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: samuel.thibault@ens-lyon.org

Not all arches implement this, and the kernel doesn't require them to.
Add ifdef logic to disable it when not available.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 799c8e2800ea..a9904fac791f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -290,8 +290,10 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
 #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
 _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
+#ifdef TARGET_NR_getcpu
 #define __NR_sys_getcpu __NR_getcpu
 _syscall3(int, sys_getcpu, unsigned *, cpu, unsigned *, node, void *, tcache);
+#endif
 _syscall4(int, reboot, int, magic1, int, magic2, unsigned int, cmd,
           void *, arg);
 _syscall2(int, capget, struct __user_cap_header_struct *, header,
@@ -10595,6 +10597,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
         break;
+#ifdef TARGET_NR_getcpu
     case TARGET_NR_getcpu:
         {
             unsigned cpu, node;
@@ -10612,6 +10615,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             }
         }
         break;
+#endif
     case TARGET_NR_sched_setparam:
         {
             struct sched_param *target_schp;
-- 
2.16.1
