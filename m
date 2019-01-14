Received: from eggs.gnu.org ([209.51.188.92]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3ZT-0006Ze-2E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3ZS-0007h6-3K
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:50:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3ZR-0007eV-98
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:50:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so23173325wrt.7
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 06:50:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 14:50:19 +0000
Message-Id: <20190114145019.22819-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] gcov: move gmon.h include
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

This got missed when preexit_cleanup got moved into it's own file and
is apparently can get included as a side-effect so is only noticeable
on some systems.

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
index b5786d4fc1..7bbedb305f 100644
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
2.17.1
