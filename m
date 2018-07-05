Received: from eggs.gnu.org ([2001:4830:134:3::10]:58499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T2-00070p-Et
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T1-0004yy-Ht
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:26:03 +0200
Message-Id: <20180705102604.4986-12-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/12] file-posix: Fix creation locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

raw_apply_lock_bytes() takes a bit mask of "permissions that are NOT
shared".

Also, make the "perm" and "shared" variables uint64_t, because I do not
particularly like using ~ on signed integers (and other permission masks
are usually uint64_t, too).

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 829ee538d8..b57c58e80f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2112,7 +2112,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
     BlockdevCreateOptionsFile *file_opts;
     int fd;
-    int perm, shared;
+    uint64_t perm, shared;
     int result = 0;
 
     /* Validate options and set default values */
@@ -2148,7 +2148,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     shared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
 
     /* Step one: Take locks */
-    result = raw_apply_lock_bytes(fd, perm, shared, false, errp);
+    result = raw_apply_lock_bytes(fd, perm, ~shared, false, errp);
     if (result < 0) {
         goto out_close;
     }
-- 
2.13.6
