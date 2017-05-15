Received: from eggs.gnu.org ([2001:4830:134:3::10]:52315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAGcP-0003sd-0K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAGcO-0002X2-5G
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:00 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 May 2017 15:04:08 +0100
Message-Id: <20170515140410.14172-3-berrange@redhat.com>
In-Reply-To: <20170515140410.14172-1-berrange@redhat.com>
References: <20170515140410.14172-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v9 2/4] qemu-img: fix --image-opts usage with
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The --image-opts flag can only be used to affect the parsing
of the source image. The target image has to be specified in
the traditional style regardless, since it needs to be passed
to the bdrv_create() API which does not support the new style
opts.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 181f499..4dc1d56 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4316,8 +4316,13 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
-    blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false, false);
+    /* TODO, we can't honour --image-opts for the target,
+     * since it needs to be given in a format compatible
+     * with the bdrv_create() call above which does not
+     * support image-opts style.
+     */
+    blk2 = img_open_file(out.filename, out_fmt, BDRV_O_RDWR,
+                         false, false, false);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
