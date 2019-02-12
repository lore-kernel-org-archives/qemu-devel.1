Received: from eggs.gnu.org ([209.51.188.92]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1gtb27-00059p-9D
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1gtb1L-0000hj-2C
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:34:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51294 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1gtb1K-0000Ih-QC
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:34:54 -0500
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 12 Feb 2019 17:34:35 +0100
Message-ID: <mvmimxprmn8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: fix recvmsg emulation
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

Set msg_flags in the returned struct msghdr.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 90bfda3563..b6b566a6fa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2797,6 +2797,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
             }
             if (!is_error(ret)) {
                 msgp->msg_namelen = tswap32(msg.msg_namelen);
+                msgp->msg_flags = tswap32(msg.msg_flags);
                 if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
                     ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
                                     msg.msg_name, msg.msg_namelen);
-- 
2.20.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
