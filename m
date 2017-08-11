Received: from eggs.gnu.org ([2001:4830:134:3::10]:57164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZo-0001Ef-N3
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZk-0002kr-FL
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:35 +0200
Message-Id: <20170811140536.2792-7-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] file-posix: Do runtime check for ofd lock
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

It is reported that on Windows Subsystem for Linux, ofd operations fail
with -EINVAL. In other words, QEMU binary built with system headers that
exports F_OFD_SETLK doesn't necessarily run in an environment that
actually supports it:

$ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 \
    -device virtio-blk-pci,drive=hd0
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to lock byte 100

As a matter of fact this is not WSL specific. It can happen when running
a QEMU compiled against a newer glibc on an older kernel, such as in
a containerized environment.

Let's do a runtime check to cope with that.

Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f4de022ae0..cb3bfce147 100644
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
2.13.4
