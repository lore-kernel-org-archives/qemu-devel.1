Received: from eggs.gnu.org ([2001:4830:134:3::10]:38911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1Q-0001zH-1k
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1O-0003Cd-DI
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frW1O-0003B5-5H
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:06 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 00:17:05 +0200
Message-Id: <20180819221707.20693-5-laurent@vivier.eu>
In-Reply-To: <20180819221707.20693-1-laurent@vivier.eu>
References: <20180819221707.20693-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/6] linux-user: fix recvmsg()/recvfrom() with
 netlink and MSG_TRUNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

If recvmsg()/recvfrom() are used with the MSG_TRUNC flag, they return the
real length even if it was longer than the passed buffer.
So when we translate the buffer we must check we don't go beyond the
end of the buffer.

Bug: https://github.com/vivier/qemu-m68k/issues/33
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180806211806.29845-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1806b33b02..e66faf1c62 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3892,7 +3892,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
             len = ret;
             if (fd_trans_host_to_target_data(fd)) {
                 ret = fd_trans_host_to_target_data(fd)(msg.msg_iov->iov_base,
-                                                       len);
+                                               MIN(msg.msg_iov->iov_len, len));
             } else {
                 ret = host_to_target_cmsg(msgp, &msg);
             }
@@ -4169,7 +4169,12 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
     }
     if (!is_error(ret)) {
         if (fd_trans_host_to_target_data(fd)) {
-            ret = fd_trans_host_to_target_data(fd)(host_msg, ret);
+            abi_long trans;
+            trans = fd_trans_host_to_target_data(fd)(host_msg, MIN(ret, len));
+            if (is_error(trans)) {
+                ret = trans;
+                goto fail;
+            }
         }
         if (target_addr) {
             host_to_target_sockaddr(target_addr, addr, addrlen);
-- 
2.17.1
