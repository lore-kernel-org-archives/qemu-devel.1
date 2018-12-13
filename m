Received: from eggs.gnu.org ([2001:4830:134:3::10]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1gXQhy-0000n9-TH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1gXQhs-0003TW-Em
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:07:18 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tom.deseyn@gmail.com>)
	id 1gXQhq-0003Q0-C6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:07:11 -0500
Received: by mail-ed1-x544.google.com with SMTP id f9so1938980eds.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 05:07:06 -0800 (PST)
From: tom.deseyn@gmail.com
Date: Thu, 13 Dec 2018 14:06:11 +0100
Message-Id: <20181213130611.7496-1-tom.deseyn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] Add getsockopt for settable SOL_IPV6 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Tom Deseyn <tom.deseyn@gmail.com>

From: Tom Deseyn <tom.deseyn@gmail.com>

Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
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
2.19.2
