Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4YZ-00015K-H1
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4YW-0000Ft-FL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:15 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 18:09:25 +0200
Message-Id: <20170403160936.28293-6-mreitz@redhat.com>
In-Reply-To: <20170403160936.28293-1-mreitz@redhat.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 05/16] block/file-posix: Small
 fixes in raw_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Variables should be declared at the start of a block, and if a certain
parameter value is not supported it may be better to return -ENOTSUP
instead of -EINVAL.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3e9c416668..cab77db963 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1693,6 +1693,8 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     case PREALLOC_MODE_FULL:
     {
+        int64_t num = 0, left = total_size;
+
         /*
          * Knowing the final size from the beginning could allow the file
          * system driver to do less allocations and possibly avoid
@@ -1704,7 +1706,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
             goto out_close;
         }
 
-        int64_t num = 0, left = total_size;
         buf = g_malloc0(65536);
 
         while (left > 0) {
@@ -1736,7 +1737,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
         }
         break;
     default:
-        result = -EINVAL;
+        result = -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
                    PreallocMode_lookup[prealloc]);
         break;
-- 
2.12.1
