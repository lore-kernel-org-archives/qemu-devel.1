Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXPJb-0000Wb-27
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXPJW-0003De-R4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:38:03 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXPJW-0003Cj-KY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:37:58 -0500
Received: by mail-pg1-x542.google.com with SMTP id z11so960877pgu.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:37:58 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Dec 2018 03:37:51 -0800
Message-Id: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2] util: check the return value of fcntl in
 qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Also add diagnostics info in 'qemu_set_cloexec' so that we can know
what happen when error occurs.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
Change since v1: add diagnostics info
 
 util/oslib-posix.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c1bee2a581..14cbef1e35 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -38,6 +38,7 @@
 #include <libgen.h>
 #include <sys/signal.h>
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
@@ -233,14 +234,32 @@ void qemu_set_block(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFL);
-    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
+    if (f < 0) {
+        error_report("Unable to get file status flag on fd %d: %s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
+    if (fcntl(fd, F_SETFL, f & ~O_NONBLOCK) < 0) {
+        error_report("Unable to set blocking flag on fd %d: %s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
 }
 
 void qemu_set_nonblock(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFL);
-    fcntl(fd, F_SETFL, f | O_NONBLOCK);
+    if (f < 0) {
+        error_report("Unable to get file status flag on fd %d: %s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
+    if (fcntl(fd, F_SETFL, f | O_NONBLOCK) < 0) {
+        error_report("Unable to set nonblocking flag on fd %d: %s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
 }
 
 int socket_set_fast_reuse(int fd)
@@ -259,9 +278,17 @@ void qemu_set_cloexec(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFD);
-    assert(f != -1);
-    f = fcntl(fd, F_SETFD, f | FD_CLOEXEC);
-    assert(f != -1);
+    if (f < 0) {
+        error_report("Unable to get fd flags on fd %d: %s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
+    if (fcntl(fd, F_SETFD, f | FD_CLOEXEC) < 0) {
+        error_report("Unable to set fd close-on-exec flag on fd %d:"
+                    "%s(errno=%d)",
+                    fd, strerror(errno), errno);
+        abort();
+    }
 }
 
 /*
-- 
2.11.0
