Received: from eggs.gnu.org ([2001:4830:134:3::10]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbh-00051A-Ku
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbg-00015M-NT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:09 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:35503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duRbg-00014s-HX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:08 -0400
Received: by mail-io0-x244.google.com with SMTP id d16so1153269ioj.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:07:08 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 19 Sep 2017 16:06:42 -0700
Message-Id: <20170919230643.87425-2-carenas@gmail.com>
In-Reply-To: <20170919230643.87425-1-carenas@gmail.com>
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] linux-user: add SO_LINGER to setsockopt
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

Original implementation by Chen Gang; all bugs mine

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c      | 15 +++++++++++++++
 linux-user/syscall_defs.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..ad689dad50 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3071,6 +3071,21 @@ set_timeout:
 		unlock_user (dev_ifname, optval_addr, 0);
 		return ret;
 	}
+        case TARGET_SO_LINGER:
+        {
+                struct linger lg;
+                struct target_linger *tlg;
+
+                if (!lock_user_struct(VERIFY_READ, tlg, optval_addr, 1)) {
+                    return -TARGET_EFAULT;
+                }
+                __get_user(lg.l_onoff, &tlg->l_onoff);
+                __get_user(lg.l_linger, &tlg->l_linger);
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, SO_LINGER,
+                                &lg, optlen));
+                unlock_user_struct(tlg, optval_addr, 0);
+                return ret;
+        }
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
2.14.1
