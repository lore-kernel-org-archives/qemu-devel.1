Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg8NM-0004mu-Oj
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg8NL-0001Lk-DM
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:45:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 11 Aug 2017 19:44:46 +0800
Message-Id: <20170811114447.25187-2-famz@redhat.com>
In-Reply-To: <20170811114447.25187-1-famz@redhat.com>
References: <20170811114447.25187-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10? v3 1/2] osdep: Add runtime OFD lock
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, christian.ehrhardt@canonical.com, Andrew Baumann <Andrew.Baumann@microsoft.com>, eblake@redhat.com

Build time check of OFD lock is not sufficient and can cause image open
errors when the runtime environment doesn't support it.

Add a helper function to probe it at runtime, additionally. Also provide
a qemu_has_ofd_lock() for callers to check the status.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/osdep.h |  1 +
 util/osdep.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3b74f6fcb2..6855b94bbf 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -357,6 +357,7 @@ int qemu_dup(int fd);
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
+bool qemu_has_ofd_lock(void);
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
diff --git a/util/osdep.c b/util/osdep.c
index a2863c8e53..a479fedc4a 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -38,14 +38,6 @@ extern int madvise(caddr_t, size_t, int);
 #include "qemu/error-report.h"
 #include "monitor/monitor.h"
 
-#ifdef F_OFD_SETLK
-#define QEMU_SETLK F_OFD_SETLK
-#define QEMU_GETLK F_OFD_GETLK
-#else
-#define QEMU_SETLK F_SETLK
-#define QEMU_GETLK F_GETLK
-#endif
-
 static bool fips_enabled = false;
 
 static const char *hw_version = QEMU_HW_VERSION;
@@ -82,6 +74,10 @@ int qemu_madvise(void *addr, size_t len, int advice)
 }
 
 #ifndef _WIN32
+
+static int fcntl_op_setlk = -1;
+static int fcntl_op_getlk = -1;
+
 /*
  * Dups an fd and sets the flags
  */
@@ -149,6 +145,54 @@ static int qemu_parse_fdset(const char *param)
     return qemu_parse_fd(param);
 }
 
+static void qemu_probe_lock_ops(void)
+{
+    if (fcntl_op_setlk == -1) {
+#ifdef F_OFD_SETLK
+        int fd;
+        int ret;
+        struct flock fl = {
+            .l_whence = SEEK_SET,
+            .l_start  = 0,
+            .l_len    = 0,
+            .l_type   = F_WRLCK,
+        };
+
+        fd = open("/dev/null", O_RDWR);
+        if (fd < 0) {
+            fprintf(stderr,
+                    "Failed to open /dev/null for OFD lock probing: %s\n",
+                    strerror(errno));
+            fcntl_op_setlk = F_SETLK;
+            fcntl_op_getlk = F_GETLK;
+            return;
+        }
+        ret = fcntl(fd, F_OFD_GETLK, &fl);
+        close(fd);
+        if (!ret) {
+            fcntl_op_setlk = F_OFD_SETLK;
+            fcntl_op_getlk = F_OFD_GETLK;
+        } else {
+            fcntl_op_setlk = F_SETLK;
+            fcntl_op_getlk = F_GETLK;
+        }
+#else
+        fcntl_op_setlk = F_SETLK;
+        fcntl_op_getlk = F_GETLK;
+#endif
+    }
+}
+
+bool qemu_has_ofd_lock(void)
+{
+    qemu_probe_lock_ops();
+#ifdef F_OFD_SETLK
+    return fcntl_op_setlk == F_OFD_SETLK;
+#else
+    return false;
+#endif
+}
+
 static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
 {
     int ret;
@@ -158,7 +202,8 @@ static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
         .l_len    = len,
         .l_type   = fl_type,
     };
-    ret = fcntl(fd, QEMU_SETLK, &fl);
+    qemu_probe_lock_ops();
+    ret = fcntl(fd, fcntl_op_setlk, &fl);
     return ret == -1 ? -errno : 0;
 }
 
@@ -181,7 +226,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
         .l_len    = len,
         .l_type   = exclusive ? F_WRLCK : F_RDLCK,
     };
-    ret = fcntl(fd, QEMU_GETLK, &fl);
+    qemu_probe_lock_ops();
+    ret = fcntl(fd, fcntl_op_getlk, &fl);
     if (ret == -1) {
         return -errno;
     } else {
-- 
2.13.4
