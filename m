Received: from eggs.gnu.org ([2001:4830:134:3::10]:54997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cr3qr-0004XJ-Nb
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cr3qq-0007z0-VL
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:36:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 14:36:28 +0000
Message-Id: <1490279788-12995-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.9 v2] block/file-posix.c: Fix unused
 variable warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On OpenBSD none of the ioctls probe_logical_blocksize() tries
exist, so the variable sector_size is unused. Refactor the
code to avoid this (and reduce the duplicated code).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
v2: add (int) cast to avoid compiler warnings on some
systems when the array is empty; use 'static const'.
---
 block/file-posix.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 53febd3..db8f0a8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -219,28 +219,28 @@ static int probe_logical_blocksize(int fd, unsigned int *sector_size_p)
 {
     unsigned int sector_size;
     bool success = false;
+    int i;
 
     errno = ENOTSUP;
-
-    /* Try a few ioctls to get the right size */
+    static const unsigned long ioctl_list[] = {
 #ifdef BLKSSZGET
-    if (ioctl(fd, BLKSSZGET, &sector_size) >= 0) {
-        *sector_size_p = sector_size;
-        success = true;
-    }
+        BLKSSZGET,
 #endif
 #ifdef DKIOCGETBLOCKSIZE
-    if (ioctl(fd, DKIOCGETBLOCKSIZE, &sector_size) >= 0) {
-        *sector_size_p = sector_size;
-        success = true;
-    }
+        DKIOCGETBLOCKSIZE,
 #endif
 #ifdef DIOCGSECTORSIZE
-    if (ioctl(fd, DIOCGSECTORSIZE, &sector_size) >= 0) {
-        *sector_size_p = sector_size;
-        success = true;
-    }
+        DIOCGSECTORSIZE,
 #endif
+    };
+
+    /* Try a few ioctls to get the right size */
+    for (i = 0; i < (int)ARRAY_SIZE(ioctl_list); i++) {
+        if (ioctl(fd, ioctl_list[i], &sector_size) >= 0) {
+            *sector_size_p = sector_size;
+            success = true;
+        }
+    }
 
     return success ? 0 : -errno;
 }
-- 
2.7.4
