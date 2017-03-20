Received: from eggs.gnu.org ([2001:4830:134:3::10]:40501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cq27A-000575-U5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cq27A-00027n-2I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:33:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 18:33:04 +0000
Message-Id: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9?] block/file-posix.c: Fix unused
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

On OpenBSD none of the ioctls probe_logical_blocksize() tries
exist, so the variable sector_size is unused. Refactor the
code to avoid this (and reduce the duplicated code).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The alternative would be to move the variable so it was
local to a code block inside each #ifdef, but this seemed
a bit nicer anyway.

Tentatively tagged 'for-2.9' just because this is the only
warning in the OpenBSD build, but I don't insist on it.

I've opted to retain the existing behaviour of "try every
ioctl available and use the last one that works" rather
than "stop as soon as something worked".

---
 block/file-posix.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 53febd3..b980d23 100644
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
+    unsigned long ioctl_list[] = {
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
+    for (i = 0; i < ARRAY_SIZE(ioctl_list); i++) {
+        if (ioctl(fd, ioctl_list[i], &sector_size) >= 0) {
+            *sector_size_p = sector_size;
+            success = true;
+        }
+    }
 
     return success ? 0 : -errno;
 }
-- 
2.7.4
