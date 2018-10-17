Received: from eggs.gnu.org ([2001:4830:134:3::10]:52340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005IG-7h
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Xp-5A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:23 +0300
Message-Id: <9c4137858b9a012cbcb87441465ecba2e97ab13c.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 07/14] block: Use
 bdrv_reopen_set_read_only() in qmp_change_backing_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch replaces the bdrv_reopen() calls that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a8755bd908..f64569795c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4064,7 +4064,6 @@ void qmp_change_backing_file(const char *device,
     BlockDriverState *image_bs = NULL;
     Error *local_err = NULL;
     bool ro;
-    int open_flags;
     int ret;
 
     bs = qmp_get_root_bs(device, errp);
@@ -4106,13 +4105,10 @@ void qmp_change_backing_file(const char *device,
     }
 
     /* if not r/w, reopen to make r/w */
-    open_flags = image_bs->open_flags;
     ro = bdrv_is_read_only(image_bs);
 
     if (ro) {
-        bdrv_reopen(image_bs, open_flags | BDRV_O_RDWR, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (bdrv_reopen_set_read_only(image_bs, false, errp) != 0) {
             goto out;
         }
     }
@@ -4128,7 +4124,7 @@ void qmp_change_backing_file(const char *device,
     }
 
     if (ro) {
-        bdrv_reopen(image_bs, open_flags, &local_err);
+        bdrv_reopen_set_read_only(image_bs, true, &local_err);
         error_propagate(errp, local_err);
     }
 
-- 
2.11.0
