Received: from eggs.gnu.org ([2001:4830:134:3::10]:47029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1cww76-0005pG-Qb
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 15:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1cww73-0006Sk-NP
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 15:33:36 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slyfox@gentoo.org>) id 1cww73-0006SM-Gl
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 15:33:33 -0400
From: Sergei Trofimovich <slyfox@gentoo.org>
Date: Sat,  8 Apr 2017 20:33:22 +0100
Message-Id: <20170408193322.16631-1-slyfox@gentoo.org>
Subject: [Qemu-devel] [PATCH] alpha-user: wire epoll_create, epoll_ctl,
 epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Sergei Trofimovich <slyfox@gentoo.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

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
anywhere else in qemu.

After this change GHC works fine under qemu-alpha:
    $ ./alpha-linux-user/qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
    ...

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 linux-user/alpha/syscall_nr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.12.2
