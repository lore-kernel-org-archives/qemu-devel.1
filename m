Received: from eggs.gnu.org ([209.51.188.92]:55289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghW3h-00009F-5c
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghVqk-000151-99
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:48513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghVqi-00014V-En
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 Jan 2019 09:37:36 +0100
Message-Id: <20190110083737.5036-2-laurent@vivier.eu>
In-Reply-To: <20190110083737.5036-1-laurent@vivier.eu>
References: <20190110083737.5036-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] Add getsockopt for settable SOL_IPV6 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Tom Deseyn <tom.deseyn@gmail.com>

From: Tom Deseyn <tom.deseyn@gmail.com>

Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
Message-Id: <20181213130611.7496-1-tom.deseyn@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 280137da8c..29bac79b61 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2352,6 +2352,45 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             break;
         }
         break;
+    case SOL_IPV6:
+        switch (optname) {
+        case IPV6_MTU_DISCOVER:
+        case IPV6_MTU:
+        case IPV6_V6ONLY:
+        case IPV6_RECVPKTINFO:
+        case IPV6_UNICAST_HOPS:
+        case IPV6_MULTICAST_HOPS:
+        case IPV6_MULTICAST_LOOP:
+        case IPV6_RECVERR:
+        case IPV6_RECVHOPLIMIT:
+        case IPV6_2292HOPLIMIT:
+        case IPV6_CHECKSUM:
+            if (get_user_u32(len, optlen))
+                return -TARGET_EFAULT;
+            if (len < 0)
+                return -TARGET_EINVAL;
+            lv = sizeof(lv);
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0)
+                return ret;
+            if (len < sizeof(int) && len > 0 && val >= 0 && val < 255) {
+                len = 1;
+                if (put_user_u32(len, optlen)
+                    || put_user_u8(val, optval_addr))
+                    return -TARGET_EFAULT;
+            } else {
+                if (len > sizeof(int))
+                    len = sizeof(int);
+                if (put_user_u32(len, optlen)
+                    || put_user_u32(val, optval_addr))
+                    return -TARGET_EFAULT;
+            }
+            break;
+        default:
+            ret = -TARGET_ENOPROTOOPT;
+            break;
+        }
+        break;
     default:
     unimplemented:
         gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-- 
2.20.1
