Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duDhx-0000yp-KP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duDhu-00080S-T1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:16:41 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duDhu-0007zn-N7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:16:38 -0400
Received: by mail-pf0-x242.google.com with SMTP id i23so1221514pfi.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 01:16:37 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 19 Sep 2017 01:15:49 -0700
Message-Id: <20170919081549.82541-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] linux-user: syscall: Add SO_LINGER for
 setsockopt
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

Original implementation from Chen Gang; code moved around as per v2

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c      | 16 ++++++++++++++++
 linux-user/syscall_defs.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..d3c500ca78 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2829,6 +2829,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
     int val;
     struct ip_mreqn *ip_mreq;
     struct ip_mreq_source *ip_mreq_source;
+    struct linger lg;
+    struct target_linger *tlg;
 
     switch(level) {
     case SOL_TCP:
@@ -3071,6 +3073,20 @@ set_timeout:
 		unlock_user (dev_ifname, optval_addr, 0);
 		return ret;
 	}
+        case TARGET_SO_LINGER:
+                optname = SO_LINGER;
+                if (optlen != sizeof(struct target_linger)) {
+                    return -TARGET_EINVAL;
+                }
+                if (!lock_user_struct(VERIFY_READ, tlg, optval_addr, 1)) {
+                    return -TARGET_EFAULT;
+                }
+                __get_user(lg.l_onoff, &tlg->l_onoff);
+                __get_user(lg.l_linger, &tlg->l_linger);
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
+                                &lg, sizeof(lg)));
+                unlock_user_struct(tlg, optval_addr, 0);
+                return ret;
             /* Options with 'int' argument.  */
         case TARGET_SO_DEBUG:
 		optname = SO_DEBUG;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40c5027e93..a60d6bb163 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -202,6 +202,11 @@ struct target_ip_mreq_source {
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
2.11.0 (Apple Git-81)
