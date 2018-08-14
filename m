Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpd98-0001Db-1Y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpd8k-0001SP-32
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:30:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fpd8j-0001Pp-QH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:29:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 14 Aug 2018 18:19:02 +0200
Message-Id: <20180814161904.12216-2-laurent@vivier.eu>
In-Reply-To: <20180814161904.12216-1-laurent@vivier.eu>
References: <20180814161904.12216-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/3] linux-user: fix recvmsg()/recvfrom() with
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

If recvmsg()/recvfrom() are used with the MSG_TRUNC flag, they return the
real length even if it was longer than the passed buffer.
So when we translate the buffer we must check we don't go beyond the
end of the buffer.

Bug: https://github.com/vivier/qemu-m68k/issues/33
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851cc35..399da09f38 100644
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
