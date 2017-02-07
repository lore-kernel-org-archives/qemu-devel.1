Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavab-0003OY-GK
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaY-0005T6-To
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:05 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavaY-0005Sv-PM
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:02 -0500
Received: by mail-io0-x242.google.com with SMTP id c80so11559311iod.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:33:02 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  6 Feb 2017 18:32:26 -0800
Message-Id: <20170207023229.29431-3-rth@twiddle.net>
In-Reply-To: <20170207023229.29431-1-rth@twiddle.net>
References: <20170207023229.29431-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/5] linux-user: fix "apt-get update" on
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
Cc: peter.maydell@linaro.org, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <laurent@vivier.eu>

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
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-Id: <20170126080449.28255-3-laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
