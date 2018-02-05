Received: from eggs.gnu.org ([2001:4830:134:3::10]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eif8p-0006oR-0e
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eif8k-0001mF-53
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:40:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1eif8j-0001m4-VT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:40:50 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id DE004ACE6
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 11:40:48 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 05 Feb 2018 12:40:48 +0100
Message-ID: <mvmtvuvk6kf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: Implement setsockopt
 SOL_SOCKET/SO_LINGER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff89016adc..82848fd97d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3130,6 +3130,29 @@ set_timeout:
 		unlock_user (dev_ifname, optval_addr, 0);
 		return ret;
 	}
+        case TARGET_SO_LINGER:
+        {
+                struct linger {
+                    int l_onoff;
+                    int l_linger;
+                } linger;
+
+                optname = SO_LINGER;
+
+                if (optlen != sizeof(linger)) {
+                    return -TARGET_EINVAL;
+                }
+                if (copy_from_user(&linger, optval_addr, optlen)) {
+                    return -TARGET_EFAULT;
+                }
+
+                linger.l_onoff = tswap32(linger.l_onoff);
+                linger.l_linger = tswap32(linger.l_linger);
+
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
+                                           &linger, sizeof(linger)));
+                return ret;
+        }
             /* Options with 'int' argument.  */
         case TARGET_SO_DEBUG:
 		optname = SO_DEBUG;
-- 
2.16.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
