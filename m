Received: from eggs.gnu.org ([209.51.188.92]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvs-00047D-Ae
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvq-0007W5-To
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:19 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvp-0007UO-2w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:48 +0100
Message-Id: <20190307100656.14044-2-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/9] linux-user: fix recvmsg emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Andreas Schwab <schwab@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Andreas Schwab <schwab@suse.de>

Set msg_flags in the returned struct msghdr.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <mvmimxprmn8.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5bbb72f3d5fc..f380048cbd8b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2759,6 +2759,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
             }
             if (!is_error(ret)) {
                 msgp->msg_namelen = tswap32(msg.msg_namelen);
+                msgp->msg_flags = tswap32(msg.msg_flags);
                 if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
                     ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
                                     msg.msg_name, msg.msg_namelen);
-- 
2.20.1
