Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqu-0002xW-2B
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqt-0002vY-9C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:36 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:34667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqt-0002v8-4X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:35 -0400
Received: by mail-qt0-x230.google.com with SMTP id m5-v6so30317154qti.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:35 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:00 -0400
Message-Id: <fa15d00fe0d36af827be442684658b2565e6d368.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 05/20] 9p: Properly set errp in fstatfs
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

In the review of

    9p: Avoid warning if FS_IOC_GETVERSION is not defined

Grep Kurz noted this error path was failing to set errp.
Fix that.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1: New patch

 hw/9pfs/9p-local.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index adc169a..576c8e3 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1420,6 +1420,8 @@ static int local_init(FsContext *ctx, Error **errp)
      */
     if (fstatfs(data->mountfd, &stbuf) < 0) {
         close_preserve_errno(data->mountfd);
+        error_setg_errno(errp, errno,
+            "failed to stat file system at '%s'", ctx->fs_root);
         goto err;
     }
     switch (stbuf.f_type) {
-- 
2.8.1
