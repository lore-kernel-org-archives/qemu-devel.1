Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF8-0005yS-Np
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF7-0007mu-T4
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:06 -0400
Received: from mifritscher.de ([188.40.170.105]:32980
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF7-0007m7-Kw
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:05 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:12 +0200
Message-Id: <20170929111323.6308-8-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 07/18] Fix unused variable error and unsuded
 function if FS_IOC_GETVERSION is not defined.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p-local.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e51af87309..4c8e0f3296 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1372,10 +1372,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
     return ret;
 }
 
+#ifdef FS_IOC_GETVERSION
 static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
                                 mode_t st_mode, uint64_t *st_gen)
 {
-#ifdef FS_IOC_GETVERSION
     int err;
     V9fsFidOpenState fid_open;
 
@@ -1394,15 +1394,14 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
     err = ioctl(fid_open.fd, FS_IOC_GETVERSION, st_gen);
     local_close(ctx, &fid_open);
     return err;
-#else
-    errno = ENOTTY;
-    return -1;
-#endif
 }
+#endif
 
 static int local_init(FsContext *ctx)
 {
+#ifdef FS_IOC_GETVERSION
     struct statfs stbuf;
+#endif
     LocalData *data = g_malloc(sizeof(*data));
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
-- 
2.13.2.windows.1
