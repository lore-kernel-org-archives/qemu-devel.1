Received: from eggs.gnu.org ([2001:4830:134:3::10]:59546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1gXpca-0000Rw-V8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1gXpcW-0003Yc-O3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:43:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tom.deseyn@gmail.com>)
	id 1gXpcU-0003TO-NX
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:43:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so5428666wrt.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 07:43:17 -0800 (PST)
From: tom.deseyn@gmail.com
Date: Fri, 14 Dec 2018 16:41:31 +0100
Message-Id: <20181214154130.4069-1-tom.deseyn@gmail.com>
In-Reply-To: <b95d4a9c-4bee-5e0d-5ec6-02edf3aefcc1@vivier.eu>
References: <b95d4a9c-4bee-5e0d-5ec6-02edf3aefcc1@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] Add getsockopt for settable SOL_IPV6 options
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

Thank you for reviewing Laurant.
Sorry for missing history, I'm not used to sending patches via mail.
I got an email about code style. For now, I'm sticking to the style
that is used in the function.

v2: default to unimplemented
v3: match kernel behavior

Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 280137da8c..f103437f26 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2352,6 +2352,42 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
+            void* target_addr;
+            if (get_user_u32(len, optlen))
+                return -TARGET_EFAULT;
+            if (len < 0)
+                return -TARGET_EINVAL;
+            lv = sizeof(val);
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0)
+                return ret;
+            if (lv < len)
+                len = lv;
+            if (put_user_u32(len, optlen))
+                return -TARGET_EFAULT;
+            target_addr = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+            tswap32s((uint32_t*)&val);
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
