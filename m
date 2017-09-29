Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF8-0005xe-2U
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF7-0007mJ-1d
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:06 -0400
Received: from mifritscher.de ([188.40.170.105]:32962
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF6-0007lW-Nq
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:04 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:13 +0200
Message-Id: <20170929111323.6308-9-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 08/18] Stub 9pfs xattr functions for Windows.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p-local.c |  4 +++-
 hw/9pfs/9p-xattr.h | 30 ++++++++++++++++++++++++++++++
 hw/9pfs/9p.c       |  4 +++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4c8e0f3296..c4feca27bd 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -22,7 +22,9 @@
 #include <grp.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include "qemu/xattr.h"
+#ifndef _WIN32
+# include "qemu/xattr.h"
+#endif
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include <libgen.h>
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 0d83996575..1c42c8dba0 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -14,7 +14,9 @@
 #ifndef QEMU_9P_XATTR_H
 #define QEMU_9P_XATTR_H
 
+#ifndef _WIN32
 #include "qemu/xattr.h"
+#endif
 
 typedef struct xattr_operations
 {
@@ -49,6 +51,33 @@ extern XattrOperations *mapped_xattr_ops[];
 extern XattrOperations *passthrough_xattr_ops[];
 extern XattrOperations *none_xattr_ops[];
 
+#ifdef _WIN32
+static inline ssize_t v9fs_get_xattr(FsContext *ctx, const char *path,
+                                     const char *name, void *value, size_t size)
+{
+    return 0;
+}
+
+static inline ssize_t v9fs_list_xattr(FsContext *ctx, const char *path,
+                                      void *value, size_t vsize)
+{
+    return 0;
+}
+
+static inline int v9fs_set_xattr(FsContext *ctx, const char *path,
+                                 const char *name, void *value, size_t size,
+                                 int flags)
+{
+    return 0;
+}
+
+static inline int v9fs_remove_xattr(FsContext *ctx, const char *path,
+                                    const char *name)
+{
+    return 0;
+}
+
+#else
 ssize_t v9fs_get_xattr(FsContext *ctx, const char *path, const char *name,
                        void *value, size_t size);
 ssize_t v9fs_list_xattr(FsContext *ctx, const char *path, void *value,
@@ -56,6 +85,7 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path, void *value,
 int v9fs_set_xattr(FsContext *ctx, const char *path, const char *name,
                           void *value, size_t size, int flags);
 int v9fs_remove_xattr(FsContext *ctx, const char *path, const char *name);
+#endif
 
 ssize_t pt_listxattr(FsContext *ctx, const char *path, char *name, void *value,
                      size_t size);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 23ac7bb532..53f812ec06 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -20,7 +20,9 @@
 #include "qemu/sockets.h"
 #include "virtio-9p.h"
 #include "fsdev/qemu-fsdev.h"
-#include "9p-xattr.h"
+#ifndef _WIN32
+# include "9p-xattr.h"
+#endif
 #include "coth.h"
 #include "trace.h"
 #include "migration/blocker.h"
-- 
2.13.2.windows.1
