Received: from eggs.gnu.org ([2001:4830:134:3::10]:36544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAC-0001uw-2W
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA6-00072S-I9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:23 +0200
Message-Id: <1494513181-7900-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/58] osdep: Fall back to posix lock when OFD
 lock is unavailable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/osdep.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 3de4a18..a2863c8 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -38,6 +38,14 @@ extern int madvise(caddr_t, size_t, int);
 #include "qemu/error-report.h"
 #include "monitor/monitor.h"
 
+#ifdef F_OFD_SETLK
+#define QEMU_SETLK F_OFD_SETLK
+#define QEMU_GETLK F_OFD_GETLK
+#else
+#define QEMU_SETLK F_SETLK
+#define QEMU_GETLK F_GETLK
+#endif
+
 static bool fips_enabled = false;
 
 static const char *hw_version = QEMU_HW_VERSION;
@@ -143,7 +151,6 @@ static int qemu_parse_fdset(const char *param)
 
 static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
 {
-#ifdef F_OFD_SETLK
     int ret;
     struct flock fl = {
         .l_whence = SEEK_SET,
@@ -151,11 +158,8 @@ static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
         .l_len    = len,
         .l_type   = fl_type,
     };
-    ret = fcntl(fd, F_OFD_SETLK, &fl);
+    ret = fcntl(fd, QEMU_SETLK, &fl);
     return ret == -1 ? -errno : 0;
-#else
-    return -ENOTSUP;
-#endif
 }
 
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive)
@@ -170,7 +174,6 @@ int qemu_unlock_fd(int fd, int64_t start, int64_t len)
 
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 {
-#ifdef F_OFD_SETLK
     int ret;
     struct flock fl = {
         .l_whence = SEEK_SET,
@@ -178,15 +181,12 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
         .l_len    = len,
         .l_type   = exclusive ? F_WRLCK : F_RDLCK,
     };
-    ret = fcntl(fd, F_OFD_GETLK, &fl);
+    ret = fcntl(fd, QEMU_GETLK, &fl);
     if (ret == -1) {
         return -errno;
     } else {
         return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
     }
-#else
-    return -ENOTSUP;
-#endif
 }
 #endif
 
-- 
1.8.3.1
