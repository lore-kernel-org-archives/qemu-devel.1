Received: from eggs.gnu.org ([2001:4830:134:3::10]:40181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWULb-0005YM-CV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWULY-0007RT-9i
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:15 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWULX-0007R3-VU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 25 Jan 2017 21:38:52 +0100
Message-Id: <20170125203852.19254-3-laurent@vivier.eu>
In-Reply-To: <20170125203852.19254-1-laurent@vivier.eu>
References: <20170125203852.19254-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: fix "apt-get update" on
 linux-user hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

apt-get was hanging on linux-user hppa.

strace has shown the netlink data stream was not correctly byte swapped.

It appears the fd translator function is unregistered just after it
has been registered, so the translator function is not called.

This patch removes the fd_trans_unregister() after the do_socket()
in the TARGET_NR_socket case.

This fd_trans_unregister() was added by commit
    e36800c linux-user: add signalfd/signalfd4 syscalls
when do_socket() was not registering any fd translator.
And as now it is, we must remove this fd_trans_unregister() to keep them.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11a311f..9be8e95 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9343,7 +9343,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_socket
     case TARGET_NR_socket:
         ret = do_socket(arg1, arg2, arg3);
-        fd_trans_unregister(ret);
         break;
 #endif
 #ifdef TARGET_NR_socketpair
-- 
2.9.3
