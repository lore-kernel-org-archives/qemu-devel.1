Received: from eggs.gnu.org ([209.51.188.92]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM83F-0001eA-Q4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM82u-0002CA-LJ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM82j-0008MA-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id e28so2362489wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:27:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 May 2019 10:27:28 +0100
Message-Id: <20190502092728.32727-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

When linux-user/exit was introduced we failed to move the gprof
include at the same time. The CI didn't notice because it only builds
system emulation. Fix it for those that still find gprof useful.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/exit.c    | 3 +++
 linux-user/syscall.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index 14e94e28fa..bdda720553 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -18,6 +18,9 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
+#ifdef TARGET_GPROF
+#include <sys/gmon.h>
+#endif
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf86d..f2d9883aef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -59,9 +59,6 @@
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
 #endif
-#ifdef TARGET_GPROF
-#include <sys/gmon.h>
-#endif
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #endif
-- 
2.20.1
