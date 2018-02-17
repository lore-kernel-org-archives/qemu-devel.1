Received: from eggs.gnu.org ([2001:4830:134:3::10]:55656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1emroi-0004Ml-VY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1emroi-0003Ft-5E
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:01:33 -0500
Received: from mail.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]:56681
	helo=smtp.gentoo.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vapier@gentoo.org>) id 1emroh-0003FL-JB
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 21:01:32 -0500
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 16 Feb 2018 21:01:22 -0500
Message-Id: <20180217020122.1469-1-vapier@gentoo.org>
Subject: [Qemu-devel] [PATCH] linux-user: make getcpu optional
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
 linux-user/syscall.c    | 4 ++++
 target/bfin/op_helper.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

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
diff --git a/target/bfin/op_helper.c b/target/bfin/op_helper.c
index 5b80aea23bc6..abb3e9301814 100644
--- a/target/bfin/op_helper.c
+++ b/target/bfin/op_helper.c
@@ -18,8 +18,8 @@
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-- 
2.16.1
