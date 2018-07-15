Received: from eggs.gnu.org ([2001:4830:134:3::10]:54028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen51-00036i-Ra
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen4x-00065L-JO
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fen4x-00064A-9P
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 15 Jul 2018 21:52:42 +0200
Message-Id: <20180715195242.6645-5-laurent@vivier.eu>
In-Reply-To: <20180715195242.6645-1-laurent@vivier.eu>
References: <20180715195242.6645-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/4] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Jonas Schievink <jonasschievink@gmail.com>

From: Jonas Schievink <jonasschievink@gmail.com>

If this is not done, qemu would drop any control message after the first
one.

This is because glibc's `CMSG_NXTHDR` macro accesses the uninitialized
cmsghdr's length field in order to find out if the message fits into the
`msg_control` buffer, wrongly assuming that it doesn't because the
length field contains garbage. Accessing the length field is fine for
completed messages we receive from the kernel, but is - as far as I know
- not needed since the kernel won't return such an invalid cmsghdr in
the first place.

This is tracked as this glibc bug:
https://sourceware.org/bugzilla/show_bug.cgi?id=13500

It's probably also a good idea to bail with an error if `CMSG_NXTHDR`
returns NULL but `TARGET_CMSG_NXTHDR` doesn't (ie. we still expect
cmsgs).

Signed-off-by: Jonas Schievink <jonasschievink@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180711221244.31869-1-jonasschievink@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index aa4f3eb1c8..3df3bdffb2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3843,6 +3843,8 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
     }
     msg.msg_controllen = 2 * tswapal(msgp->msg_controllen);
     msg.msg_control = alloca(msg.msg_controllen);
+    memset(msg.msg_control, 0, msg.msg_controllen);
+
     msg.msg_flags = tswap32(msgp->msg_flags);
 
     count = tswapal(msgp->msg_iovlen);
-- 
2.17.1
