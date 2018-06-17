Received: from eggs.gnu.org ([2001:4830:134:3::10]:56780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0R-0005h2-Ll
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0N-0003Ej-I0
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0N-0003EX-D3
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:19 -0400
Received: by mail-qk0-x242.google.com with SMTP id g14-v6so7673997qkm.6
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:19 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:45 -0400
Message-Id: <603b0ffda828e4c6a7ac9799853df0d6a5be3822.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 01/13] 9p: linux: Fix a couple Linux
 assumptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

 - Guard Linux only headers.
 - Add qemu/statfs.h header to abstract over the which
   headers are needed for struct statfs
 - Define `ENOATTR` only if not only defined
   (it's defined in system headers on Darwin).

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 fsdev/file-op-9p.h          |  2 +-
 fsdev/virtfs-proxy-helper.c |  4 +++-
 hw/9pfs/9p-local.c          |  2 ++
 include/qemu/statfs.h       | 19 +++++++++++++++++++
 include/qemu/xattr.h        |  4 +++-
 5 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 include/qemu/statfs.h

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 3fa062b..111f804 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -16,7 +16,7 @@
 
 #include <dirent.h>
 #include <utime.h>
-#include <sys/vfs.h>
+#include "qemu/statfs.h"
 #include "qemu-fsdev-throttle.h"
 
 #define SM_LOCAL_MODE_BITS    0600
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 6f132c5..94fb069 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -13,17 +13,19 @@
 #include <sys/resource.h>
 #include <getopt.h>
 #include <syslog.h>
+#ifdef CONFIG_LINUX
 #include <sys/capability.h>
 #include <sys/fsuid.h>
-#include <sys/vfs.h>
 #include <sys/ioctl.h>
 #include <linux/fs.h>
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
 #endif
+#endif
 #include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/xattr.h"
+#include "qemu/statfs.h"
 #include "9p-iov-marshal.h"
 #include "hw/9pfs/9p-proxy.h"
 #include "fsdev/9p-iov-marshal.h"
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 828e8d6..d713983 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -27,10 +27,12 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include <libgen.h>
+#ifdef CONFIG_LINUX
 #include <linux/fs.h>
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
 #endif
+#endif
 #include <sys/ioctl.h>
 
 #ifndef XFS_SUPER_MAGIC
diff --git a/include/qemu/statfs.h b/include/qemu/statfs.h
new file mode 100644
index 0000000..dde289f
--- /dev/null
+++ b/include/qemu/statfs.h
@@ -0,0 +1,19 @@
+/*
+ * Host statfs header abstraction
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2, or any
+ * later version.  See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef QEMU_STATFS_H
+#define QEMU_STATFS_H
+
+#ifdef CONFIG_LINUX
+# include <sys/vfs.h>
+#endif
+#ifdef CONFIG_DARWIN
+# include <sys/param.h>
+# include <sys/mount.h>
+#endif
+
+#endif
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index a83fe8e..f1d0f7b 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -22,7 +22,9 @@
 #ifdef CONFIG_LIBATTR
 #  include <attr/xattr.h>
 #else
-#  define ENOATTR ENODATA
+#  if !defined(ENOATTR)
+#    define ENOATTR ENODATA
+#  endif
 #  include <sys/xattr.h>
 #endif
 
-- 
2.8.1
