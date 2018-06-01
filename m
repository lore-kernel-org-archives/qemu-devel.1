Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr2-00032l-El
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqy-00031O-2l
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:44 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqx-00030m-Th
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:39 -0400
Received: by mail-qt0-x242.google.com with SMTP id e8-v6so30315164qth.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:39 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:03 -0400
Message-Id: <667649d1ce2e1a948a5be1103a21cb495eff2c13.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 08/20] 9p: Rename 9p-util -> 9p-util-linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

The current file only has the Linux versions of these functions.
Rename the file accordingly and update the Makefile to only build
it on Linux. A Darwin version of these will follow later in the
series.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1: New patch

 hw/9pfs/9p-util-linux.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.c       | 59 -------------------------------------------------
 hw/9pfs/Makefile.objs   |  3 ++-
 3 files changed, 61 insertions(+), 60 deletions(-)
 create mode 100644 hw/9pfs/9p-util-linux.c
 delete mode 100644 hw/9pfs/9p-util.c

diff --git a/hw/9pfs/9p-util-linux.c b/hw/9pfs/9p-util-linux.c
new file mode 100644
index 0000000..defa3a4
--- /dev/null
+++ b/hw/9pfs/9p-util-linux.c
@@ -0,0 +1,59 @@
+/*
+ * 9p utilities (Linux Implementation)
+ *
+ * Copyright IBM, Corp. 2017
+ *
+ * Authors:
+ *  Greg Kurz <groug@kaod.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/xattr.h"
+#include "9p-util.h"
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                             void *value, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lgetxattr(proc_path, name, value, size);
+    g_free(proc_path);
+    return ret;
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = llistxattr(proc_path, list, size);
+    g_free(proc_path);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lremovexattr(proc_path, name);
+    g_free(proc_path);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lsetxattr(proc_path, name, value, size, flags);
+    g_free(proc_path);
+    return ret;
+}
diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
deleted file mode 100644
index 614b7fc..0000000
--- a/hw/9pfs/9p-util.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * 9p utilities
- *
- * Copyright IBM, Corp. 2017
- *
- * Authors:
- *  Greg Kurz <groug@kaod.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/xattr.h"
-#include "9p-util.h"
-
-ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
-                             void *value, size_t size)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lgetxattr(proc_path, name, value, size);
-    g_free(proc_path);
-    return ret;
-}
-
-ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
-                              char *list, size_t size)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = llistxattr(proc_path, list, size);
-    g_free(proc_path);
-    return ret;
-}
-
-ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
-                                const char *name)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lremovexattr(proc_path, name);
-    g_free(proc_path);
-    return ret;
-}
-
-int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
-                         void *value, size_t size, int flags)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lsetxattr(proc_path, name, value, size, flags);
-    g_free(proc_path);
-    return ret;
-}
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index fd90b62..083508f 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -1,4 +1,5 @@
-common-obj-y  = 9p.o 9p-util.o
+common-obj-y  = 9p.o
+common-obj-$(CONFIG_LINUX) += 9p-util-linux.o
 common-obj-y += 9p-local.o 9p-xattr.o
 common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
 common-obj-y += coth.o cofs.o codir.o cofile.o
-- 
2.8.1
