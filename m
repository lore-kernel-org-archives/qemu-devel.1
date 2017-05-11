Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA7-0001ne-94
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA6-00072L-EH
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:22 +0200
Message-Id: <1494513181-7900-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/58] osdep: Add qemu_lock_fd and qemu_unlock_fd
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

They are wrappers of POSIX fcntl "file private locking", with a
convenient "try lock" wrapper implemented with F_OFD_GETLK.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/osdep.h |  3 +++
 util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 122ff06..1c9f5e2 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -341,6 +341,9 @@ int qemu_close(int fd);
 #ifndef _WIN32
 int qemu_dup(int fd);
 #endif
+int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
+int qemu_unlock_fd(int fd, int64_t start, int64_t len);
+int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
diff --git a/util/osdep.c b/util/osdep.c
index 06fb1cf..3de4a18 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -140,6 +140,54 @@ static int qemu_parse_fdset(const char *param)
 {
     return qemu_parse_fd(param);
 }
+
+static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
+{
+#ifdef F_OFD_SETLK
+    int ret;
+    struct flock fl = {
+        .l_whence = SEEK_SET,
+        .l_start  = start,
+        .l_len    = len,
+        .l_type   = fl_type,
+    };
+    ret = fcntl(fd, F_OFD_SETLK, &fl);
+    return ret == -1 ? -errno : 0;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive)
+{
+    return qemu_lock_fcntl(fd, start, len, exclusive ? F_WRLCK : F_RDLCK);
+}
+
+int qemu_unlock_fd(int fd, int64_t start, int64_t len)
+{
+    return qemu_lock_fcntl(fd, start, len, F_UNLCK);
+}
+
+int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
+{
+#ifdef F_OFD_SETLK
+    int ret;
+    struct flock fl = {
+        .l_whence = SEEK_SET,
+        .l_start  = start,
+        .l_len    = len,
+        .l_type   = exclusive ? F_WRLCK : F_RDLCK,
+    };
+    ret = fcntl(fd, F_OFD_GETLK, &fl);
+    if (ret == -1) {
+        return -errno;
+    } else {
+        return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
+    }
+#else
+    return -ENOTSUP;
+#endif
+}
 #endif
 
 /*
-- 
1.8.3.1
