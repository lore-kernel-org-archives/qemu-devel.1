Received: from eggs.gnu.org ([2001:4830:134:3::10]:39791)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1e8XJC-0002le-03
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 16:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1e8XJ8-0000rN-V4
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 16:02:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:63495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1e8XJ8-0000qE-Ko
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 16:02:14 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sat, 28 Oct 2017 21:48:33 +0200
Message-Id: <20171028194833.23858-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>

NetBSD 8.0(beta) ships with KERN_PROC_PATHNAME in sysctl(2).
Older NetBSD versions can use argv[0] parsing fallback.

This code section is partly shared with FreeBSD.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 util/oslib-posix.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 382bd4a231..77369c92ce 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -49,6 +49,10 @@
 #include <libutil.h>
 #endif
 
+#ifdef __NetBSD__
+#include <sys/sysctl.h>
+#endif
+
 #include "qemu/mmap-alloc.h"
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -250,9 +254,14 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
-#elif defined(__FreeBSD__)
+#elif defined(__FreeBSD__) \
+      || (defined(__NetBSD__) && defined(KERN_PROC_PATHNAME))
     {
+#if defined(__FreeBSD__)
         static int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PATHNAME, -1};
+#else
+        static int mib[4] = {CTL_KERN, KERN_PROC_ARGS, -1, KERN_PROC_PATHNAME};
+#endif
         size_t len = sizeof(buf) - 1;
 
         *buf = '\0';
-- 
2.14.3
