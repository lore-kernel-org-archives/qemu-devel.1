Received: from eggs.gnu.org ([2001:4830:134:3::10]:53888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fdNMG-0008Cu-ID
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 18:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fdNMC-0006UR-IV
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 18:13:12 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonasschievink@gmail.com>)
	id 1fdNMC-0006TR-BW
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 18:13:08 -0400
Received: by mail-ed1-x543.google.com with SMTP id s24-v6so4114711edr.8
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 15:13:08 -0700 (PDT)
From: Jonas Schievink <jonasschievink@gmail.com>
Date: Thu, 12 Jul 2018 00:12:44 +0200
Message-Id: <20180711221244.31869-1-jonasschievink@gmail.com>
In-Reply-To: <5271d71e-794c-2db0-9046-183fd79dd902@amsat.org>
References: <5271d71e-794c-2db0-9046-183fd79dd902@amsat.org>
Subject: [Qemu-devel] [PATCH v2] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Jonas Schievink <jonasschievink@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

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
---
Changes in v2:
- put the memset right after the msg_control alloca
- added missing Signed-off-by line

 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4b1b7d7da..3c427500ef 100644
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
2.18.0
