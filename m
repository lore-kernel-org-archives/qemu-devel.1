Received: from eggs.gnu.org ([2001:4830:134:3::10]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1ft7tx-0001iH-A4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1ft7tu-0005Rs-49
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:57:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1ft7tt-0005RV-RZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:57:02 -0400
Received: by mail-pf1-x442.google.com with SMTP id p12-v6so4241536pfh.2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 01:57:01 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Fri, 24 Aug 2018 01:56:01 -0700
Message-Id: <20180824085601.6259-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: add SO_LINGER to {g,s}etsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: schwab@suse.de, gang.chen.5i5j@gmail.com, laurent@vivier.eu, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Original implementation for setsockopt by Chen Gang[1]; all bugs mine,
including removing assignment for optname which hopefully makes the
logic easier to follow and moving some variables to make the code
more selfcontained.

[1] http://patchwork.ozlabs.org/patch/565659/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Co-Authored-By: Chen Gang <gang.chen.5i5j@gmail.com>
---
 linux-user/syscall.c      | 52 ++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  5 ++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 02fba7606d..43f2839540 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3290,6 +3290,24 @@ set_timeout:
 		unlock_user (dev_ifname, optval_addr, 0);
 		return ret;
 	}
+        case TARGET_SO_LINGER:
+        {
+                struct linger lg;
+                struct target_linger *tlg;
+
+                if (optlen != sizeof(struct target_linger)) {
+                    return -TARGET_EINVAL;
+                }
+                if (!lock_user_struct(VERIFY_READ, tlg, optval_addr, 1)) {
+                    return -TARGET_EFAULT;
+                }
+                __get_user(lg.l_onoff, &tlg->l_onoff);
+                __get_user(lg.l_linger, &tlg->l_linger);
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, SO_LINGER,
+                                &lg, sizeof(lg)));
+                unlock_user_struct(tlg, optval_addr, 0);
+                return ret;
+        }
             /* Options with 'int' argument.  */
         case TARGET_SO_DEBUG:
 		optname = SO_DEBUG;
@@ -3381,7 +3399,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         level = SOL_SOCKET;
         switch (optname) {
         /* These don't just return a single integer */
-        case TARGET_SO_LINGER:
         case TARGET_SO_RCVTIMEO:
         case TARGET_SO_SNDTIMEO:
         case TARGET_SO_PEERNAME:
@@ -3419,6 +3436,39 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             }
             break;
         }
+        case TARGET_SO_LINGER:
+        {
+            struct linger lg;
+            socklen_t lglen;
+            struct target_linger *tlg;
+
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+
+            lglen = sizeof(lg);
+            ret = get_errno(getsockopt(sockfd, level, SO_LINGER,
+                                       &lg, &lglen));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len > lglen) {
+                len = lglen;
+            }
+            if (!lock_user_struct(VERIFY_WRITE, tlg, optval_addr, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(lg.l_onoff, &tlg->l_onoff);
+            __put_user(lg.l_linger, &tlg->l_linger);
+            unlock_user_struct(tlg, optval_addr, 1);
+            if (put_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+        }
         /* Options with 'int' argument.  */
         case TARGET_SO_DEBUG:
             optname = SO_DEBUG;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40bb60ef4c..18d434d6dc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -203,6 +203,11 @@ struct target_ip_mreq_source {
     uint32_t imr_sourceaddr;
 };
 
+struct target_linger {
+    abi_int l_onoff;        /* Linger active                */
+    abi_int l_linger;       /* How long to linger for       */
+};
+
 struct target_timeval {
     abi_long tv_sec;
     abi_long tv_usec;
-- 
2.18.0
