Received: from eggs.gnu.org ([2001:4830:134:3::10]:60100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm9-0001HT-3D
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm8-0007sB-4p
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:53 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 17 Feb 2017 02:51:27 +0200
Message-Id: <20170217005127.21010-4-nirsof@gmail.com>
In-Reply-To: <20170217005127.21010-1-nirsof@gmail.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-img: Improve documentation for
 PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

Now that we are truncating the file in both PREALLOC_MODE_FULL and
PREALLOC_MODE_OFF, not truncating in PREALLOC_MODE_FALLOC looks odd.
Add a comment explaining why we do not truncate in this case.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/file-posix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d24e34b..20a261f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1594,9 +1594,14 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
     switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
     case PREALLOC_MODE_FALLOC:
-        /* posix_fallocate() doesn't set errno. */
+        /*
+         * Truncating before posix_fallocate() makes it about twice slower on
+         * file systems that do not support fallocate(), trying to check if a
+         * block is allocated before allocating it.
+         */
         result = -posix_fallocate(fd, 0, total_size);
         if (result != 0) {
+            /* posix_fallocate() doesn't set errno. */
             error_setg_errno(errp, -result,
                              "Could not preallocate data for the new file");
         }
-- 
2.9.3
