Received: from eggs.gnu.org ([2001:4830:134:3::10]:58289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYV3b-00057F-8V
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYV3a-00070D-90
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:21:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Jul 2017 18:20:59 +0800
Message-Id: <20170721102059.14663-3-famz@redhat.com>
In-Reply-To: <20170721102059.14663-1-famz@redhat.com>
References: <20170721102059.14663-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] file-posix: Do runtime check for ofd lock
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

It is reported that on Windows Subsystem for Linux, ofd operations fail
with -EINVAL. In other words, QEMU binary built with system headers that
exports F_OFD_SETLK doesn't necessarily run in an environment that
actually supports it:

$ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 \
    -device virtio-blk-pci,drive=hd0
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to lock byte 100

Let's do a runtime check to cope with that.

Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cfbb236f6f..5ddf2729eb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -457,22 +457,19 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     switch (locking) {
     case ON_OFF_AUTO_ON:
         s->use_lock = true;
-#ifndef F_OFD_SETLK
-        fprintf(stderr,
-                "File lock requested but OFD locking syscall is unavailable, "
-                "falling back to POSIX file locks.\n"
-                "Due to the implementation, locks can be lost unexpectedly.\n");
-#endif
+        if (!qemu_has_ofd_lock()) {
+            fprintf(stderr,
+                    "File lock requested but OFD locking syscall is "
+                    "unavailable, falling back to POSIX file locks.\n"
+                    "Due to the implementation, locks can be lost "
+                    "unexpectedly.\n");
+        }
         break;
     case ON_OFF_AUTO_OFF:
         s->use_lock = false;
         break;
     case ON_OFF_AUTO_AUTO:
-#ifdef F_OFD_SETLK
-        s->use_lock = true;
-#else
-        s->use_lock = false;
-#endif
+        s->use_lock = qemu_has_ofd_lock();
         break;
     default:
         abort();
-- 
2.13.3
