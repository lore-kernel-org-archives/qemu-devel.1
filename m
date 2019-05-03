Received: from eggs.gnu.org ([209.51.188.92]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMCd-0008SZ-T4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMCc-00030R-Vr
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:27 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:50156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMMCc-0002zn-Ol
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:26 -0400
From: Cao Jiaxi <driver1998@foxmail.com>
Date: Fri,  3 May 2019 08:37:19 +0800
Message-Id: <20190503003719.10233-1-driver1998@foxmail.com>
In-Reply-To: <20190503002206.9751-1-driver1998@foxmail.com>
References: <20190503002206.9751-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation regarding
 stdio formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao Jiaxi <driver1998@foxmail.com>

I encountered the following compilation error on mingw:

/mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO' macro redefined [-Werror,-Wmacro-redefined]
 #define __USE_MINGW_ANSI_STDIO 1
        ^
/mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: previous definition is here
 #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be 0 */

It turns out that __USE_MINGW_ANSI_STDIO must be set before any
system headers are included, not just before stdio.h.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 include/qemu/osdep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 303d315c5d..af2b91f0b8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -85,17 +85,17 @@ extern int daemon(int, int);
 #endif
 #endif
 
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
-
-/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
-#ifdef __MINGW32__
-#define __USE_MINGW_ANSI_STDIO 1
-#endif
 #include <stdio.h>
 
 #include <string.h>
-- 
2.17.1
