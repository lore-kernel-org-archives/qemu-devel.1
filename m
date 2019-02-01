Received: from eggs.gnu.org ([209.51.188.92]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDr-0003gm-OG
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDr-0007oj-1n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:39 -0500
Received: from m50-111.126.com ([123.125.50.111]:54039)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDp-0007m9-C0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:38 -0500
From: Fei Li <lifei1214@126.com>
Date: Fri,  1 Feb 2019 13:18:03 +0800
Message-Id: <20190201051806.53183-9-lifei1214@126.com>
In-Reply-To: <20190201051806.53183-1-lifei1214@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH v11 for-4.0 08/11] qemu_thread: supplement
 error handling for qemu_signalfd_compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

From: Fei Li <shirley17fei@gmail.com>

For qemu_signalfd_compat: set errno, do some cleanup, and return
-1 to replace the temporary &error_abort when failing to create
sigwait_compat.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Fei Li <shirley17fei@gmail.com>
---
 util/compatfd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/compatfd.c b/util/compatfd.c
index c3d8448264..9d642475fc 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -71,6 +71,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     struct sigfd_compat_info *info;
     QemuThread thread;
     int fds[2];
+    int ret;
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
@@ -89,9 +90,15 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
-                       info, QEMU_THREAD_DETACHED, &error_abort);
+    ret = qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                             info, QEMU_THREAD_DETACHED, NULL);
+    if (ret < 0) {
+        close(fds[0]);
+        close(fds[1]);
+        free(info);
+        errno = -ret;
+        return -1;
+    }
 
     return fds[0];
 }
-- 
2.17.2 (Apple Git-113)
