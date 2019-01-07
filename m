Received: from eggs.gnu.org ([209.51.188.92]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1ggR94-0007te-Aa
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1ggR8z-0001xl-7w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:24:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tom.deseyn@gmail.com>)
	id 1ggR8t-0001tq-LL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:24:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so189926wmj.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 01:24:16 -0800 (PST)
From: tom.deseyn@gmail.com
Date: Mon,  7 Jan 2019 10:24:00 +0100
Message-Id: <20190107092400.8038-1-tom.deseyn@gmail.com>
In-Reply-To: <199d2900-1f2c-4940-ae2a-d6832501f1f0@vivier.eu>
References: <199d2900-1f2c-4940-ae2a-d6832501f1f0@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5] Add getsockopt for settable SOL_IPV6 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, laurent@vivier.eu
Cc: riku.voipio@iki.fi, Tom Deseyn <tom.deseyn@gmail.com>

From: Tom Deseyn <tom.deseyn@gmail.com>

v2: default to unimplemented
v3: match kernel behavior
v4: braces code-style
v5: pointer code-style

Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
---
 linux-user/syscall.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 280137da8c..a6f6e9c1f7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2352,6 +2352,47 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
+        case IPV6_CHECKSUM: {
+            void *target_addr;
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            lv = sizeof(val);
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (lv < len) {
+                len = lv;
+            }
+            if (put_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            target_addr = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+            tswap32s((uint32_t *)&val);
+            memcpy(target_addr, &val, len);
+            unlock_user(target_addr, optval_addr, len);
+            break;
+        }
+        default:
+            goto unimplemented;
+        }
+        break;
     default:
     unimplemented:
         gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-- 
2.19.2
