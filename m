Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cYaUH-0001gp-3v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cYaUC-0005xv-PI
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:36:53 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54890 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cYaUC-0005wq-Fj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:36:48 -0500
From: Peter Lieven <pl@kamp.de>
Date: Tue, 31 Jan 2017 16:36:34 +0100
Message-Id: <1485876994-14555-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, ct@flyingcircus.io, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

the current implementation fails if we try to freeze an
already frozen filesystem. This can happen if a filesystem
is mounted more than once (e.g. with a bind mount).

Suggested-by: Christian Theune <ct@flyingcircus.io>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qga/commands-posix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ea37c09..73d93eb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1243,6 +1243,9 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
          * filesystems may not implement fsfreeze for less obvious reasons.
          * these will report EOPNOTSUPP. we simply ignore these when tallying
          * the number of frozen filesystems.
+         * if a filesystem is mounted more than once (aka bind mount) a
+         * consecutive attempt to freeze an already frozen filesystem will
+         * return EBUSY.
          *
          * any other error means a failure to freeze a filesystem we
          * expect to be freezable, so return an error in those cases
@@ -1250,7 +1253,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
          */
         ret = ioctl(fd, FIFREEZE);
         if (ret == -1) {
-            if (errno != EOPNOTSUPP) {
+            if (errno != EOPNOTSUPP && errno != EBUSY) {
                 error_setg_errno(errp, errno, "failed to freeze %s",
                                  mount->dirname);
                 close(fd);
-- 
1.9.1
