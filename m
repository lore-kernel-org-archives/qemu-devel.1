Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQr-0006Mu-DH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQq-0002m6-GF
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:16:58 +0100
Message-Id: <1487960230-18054-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/19] qemu-img: Improve documentation for
 PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Nir Soffer <nirsof@gmail.com>

Now that we are truncating the file in both PREALLOC_MODE_FULL and
PREALLOC_MODE_OFF, not truncating in PREALLOC_MODE_FALLOC looks odd.
Add a comment explaining why we do not truncate in this case.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d24e34b..4de1abd 100644
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
+         * block is allocated before allocating it, so don't do that here.
+         */
         result = -posix_fallocate(fd, 0, total_size);
         if (result != 0) {
+            /* posix_fallocate() doesn't set errno. */
             error_setg_errno(errp, -result,
                              "Could not preallocate data for the new file");
         }
-- 
1.8.3.1
