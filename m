Received: from eggs.gnu.org ([2001:4830:134:3::10]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fd0zz-0004cg-19
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 18:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fd0zr-0001ZE-KQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 18:20:42 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonasschievink@gmail.com>)
	id 1fd0zr-0001YU-4m
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 18:20:35 -0400
Received: by mail-ed1-x543.google.com with SMTP id i20-v6so4670608eds.12
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:20:33 -0700 (PDT)
From: jonasschievink@gmail.com
Date: Wed, 11 Jul 2018 00:20:27 +0200
Message-Id: <20180710222027.31188-1-jonasschievink@gmail.com>
Subject: [Qemu-devel] [PATCH] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jonas Schievink <jonasschievink@gmail.com>

From: Jonas Schievink <jonasschievink@gmail.com>

If this is not done, qemu would drop any control message after the first
one.

This is because glibc's `CMSG_NXTHDR` macro accesses the uninitialized
cmsghdr's length field in order to find out if the message fits into the
`msg_control` buffer. This is fine for completed messages we receive
from the kernel, but is - as far as I know - not needed since the
kernel won't return such an invalid cmsghdr in the first place.

It's probably also a good idea to bail with an error if `CMSG_NXTHDR`
returns NULL but `TARGET_CMSG_NXTHDR` doesn't (ie. we still expect
cmsgs).
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4b1b7d7da..77ce173b27 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3845,6 +3845,8 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
     msg.msg_control = alloca(msg.msg_controllen);
     msg.msg_flags = tswap32(msgp->msg_flags);
 
+    memset(msg.msg_control, 0, msg.msg_controllen);
+
     count = tswapal(msgp->msg_iovlen);
     target_vec = tswapal(msgp->msg_iov);
 
-- 
2.18.0
