Received: from eggs.gnu.org ([2001:4830:134:3::10]:32962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbn-00054O-DG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbj-00017p-JI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:15 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duRbj-00017g-EI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:11 -0400
Received: by mail-it0-x243.google.com with SMTP id e134so576517ite.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:07:11 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 19 Sep 2017 16:06:43 -0700
Message-Id: <20170919230643.87425-3-carenas@gmail.com>
In-Reply-To: <20170919230643.87425-1-carenas@gmail.com>
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] linux-user: add SO_LINGER to getsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, rth@twiddle.net, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ad689dad50..91bd27c63a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3178,7 +3178,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         level = SOL_SOCKET;
         switch (optname) {
         /* These don't just return a single integer */
-        case TARGET_SO_LINGER:
         case TARGET_SO_RCVTIMEO:
         case TARGET_SO_SNDTIMEO:
         case TARGET_SO_PEERNAME:
@@ -3216,6 +3215,39 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
-- 
2.14.1
