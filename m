Received: from eggs.gnu.org ([2001:4830:134:3::10]:39758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrd-0001Pp-UB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrZ-0003sJ-JA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:60770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ciTrZ-0003nK-9k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:49 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Feb 2017 23:33:32 +0100
Message-Id: <20170227223337.17434-2-laurent@vivier.eu>
In-Reply-To: <20170227223337.17434-1-laurent@vivier.eu>
References: <20170227223337.17434-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] linux-user: fix fork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Since commit 5ea2fc8 ("linux-user: Sanity check clone flags"),
trying to run fork() fails with old distro on some architectures.

This is the case with HP-PA and Debian 5 (Lenny).

It fails on:

         if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
             return -TARGET_EINVAL;
         }

because flags is 17, whereas on HP-PA, SIGCHLD is 18.
17 is the SIGCHLD value of my host (x86_64).

It appears that for TARGET_NR_fork and TARGET_NR_vfork, QEMU calls
do_fork() with SIGCHLD instead of TARGET_SIGCHLD.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170216173707.16209-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f569f82..4d85355 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7680,7 +7680,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
-        ret = get_errno(do_fork(cpu_env, SIGCHLD, 0, 0, 0, 0));
+        ret = get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
         break;
 #endif
 #ifdef TARGET_NR_waitpid
@@ -10490,7 +10490,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
-        ret = get_errno(do_fork(cpu_env, CLONE_VFORK | CLONE_VM | SIGCHLD,
+        ret = get_errno(do_fork(cpu_env,
+                        CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
                         0, 0, 0, 0));
         break;
 #endif
-- 
2.9.3
