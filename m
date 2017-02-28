Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tim@hentenaar.com>) id 1ciXsw-0003dR-ND
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tim@hentenaar.com>) id 1ciXst-00041L-Mp
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:51:30 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tim@hentenaar.com>) id 1ciXst-000412-GZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:51:27 -0500
Received: by mail-wr0-x244.google.com with SMTP id u48so2520450wrc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:51:25 -0800 (PST)
From: Tim Hentenaar <tim@hentenaar.com>
Date: Tue, 28 Feb 2017 03:51:57 +0100
Message-Id: <20170228025157.3499-1-tim@hentenaar.com>
Subject: [Qemu-devel] [PATCH] linux-user: Fix fork() and vfork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Tim Hentenaar <tim@hentenaar.com>

A check was introduced in 5ea2fc84da1bffce749c9d0848f5336def2818bb which
causes fork() and vfork() to fail if TARGET_SIGCHLD != SIGCHLD.

Signed-off-by: Tim Hentenaar <tim@hentenaar.com>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f569f82..ac4106a 100644
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
@@ -10490,7 +10490,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
-        ret = get_errno(do_fork(cpu_env, CLONE_VFORK | CLONE_VM | SIGCHLD,
+        ret = get_errno(do_fork(cpu_env, CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
                         0, 0, 0, 0));
         break;
 #endif
-- 
2.10.2
