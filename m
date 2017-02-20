Received: from eggs.gnu.org ([2001:4830:134:3::10]:34803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkY-0008GQ-Mi
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkX-0007FE-Rt
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:38 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 20 Feb 2017 15:19:19 +0000
Message-Id: <20170220151921.22842-3-berrange@redhat.com>
In-Reply-To: <20170220151921.22842-1-berrange@redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] qemu-img: fix --image-opts usage with
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The --image-opts flag can only be used to affect the parsing
of the source image. The target image has to be specified in
the traditional style regardless, since it needs to be passed
to the bdrv_create() API which does not support the new style
opts.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 739345e..d8a737f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4102,8 +4102,13 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
-    blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+    /* TODO, we can't honour --image-opts for the target,
+     * since it needs to be given in a format compatible
+     * with the bdrv_create() call above which does not
+     * support image-opts style.
+     */
+    blk2 = img_open_file(out.filename, out_fmt, BDRV_O_RDWR,
+                         false, false);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
