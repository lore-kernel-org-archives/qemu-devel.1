Received: from eggs.gnu.org ([2001:4830:134:3::10]:42815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1dFyWZ-00039g-9h
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1dFyWW-0003jl-N8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:58:35 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:47312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slyfox@gentoo.org>) id 1dFyWW-0003jM-Fx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:58:32 -0400
From: Sergei Trofimovich <slyfox@gentoo.org>
Date: Wed, 31 May 2017 08:58:14 +0100
Message-Id: <20170531075814.4851-1-slyfox@gentoo.org>
In-Reply-To: <CAFEAcA9hGET8EyWYUwLvtnMEWzWJn0WCGEdz=nDhO4BCyxS8zg@mail.gmail.com>
References: <CAFEAcA9hGET8EyWYUwLvtnMEWzWJn0WCGEdz=nDhO4BCyxS8zg@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v2] alpha-user: wire epoll_create, epoll_ctl,
 epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sergei Trofimovich <slyfox@gentoo.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Noticed when ran GHC on alpha:
    $ qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
    qemu: Unsupported syscall: 407

linux-user/syscall.c does have 'epoll_create' wiring,
but under nondeprecated name.

Instead of defining both
    TARGET_NR_sys_epoll_create
and
    TARGET_NR_epoll_create
I've renamed former to later as old name is not used
anywhere else in qemu (except the linux-user/strace.list).

After this change GHC works fine under qemu-alpha:
    $ ./alpha-linux-user/qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
    ...

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
Change since v1:
- cleaned up 'linux-user/strace.list' from deprecated defines
 linux-user/alpha/syscall_nr.h | 6 +++---
 linux-user/strace.list        | 9 ---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
index 00e14bb6b3..e848154663 100644
--- a/linux-user/alpha/syscall_nr.h
+++ b/linux-user/alpha/syscall_nr.h
@@ -343,9 +343,9 @@
 #define TARGET_NR_io_cancel			402
 #define TARGET_NR_exit_group			405
 #define TARGET_NR_lookup_dcookie		406
-#define TARGET_NR_sys_epoll_create		407
-#define TARGET_NR_sys_epoll_ctl		408
-#define TARGET_NR_sys_epoll_wait		409
+#define TARGET_NR_epoll_create			407
+#define TARGET_NR_epoll_ctl			408
+#define TARGET_NR_epoll_wait			409
 #define TARGET_NR_remap_file_pages		410
 #define TARGET_NR_set_tid_address		411
 #define TARGET_NR_restart_syscall		412
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3b1282ec1a..ccfb58b7f4 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1467,15 +1467,6 @@
 #ifdef TARGET_NR__sysctl
 { TARGET_NR__sysctl, "_sysctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sys_epoll_create
-{ TARGET_NR_sys_epoll_create, "sys_epoll_create" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_sys_epoll_ctl
-{ TARGET_NR_sys_epoll_ctl, "sys_epoll_ctl" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_sys_epoll_wait
-{ TARGET_NR_sys_epoll_wait, "sys_epoll_wait" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sysfs
 { TARGET_NR_sysfs, "sysfs" , NULL, NULL, NULL },
 #endif
-- 
2.13.0
