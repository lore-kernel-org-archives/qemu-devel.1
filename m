Received: from eggs.gnu.org ([2001:4830:134:3::10]:54894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cwRS0-0006Eo-LZ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cwRRx-0001vV-KN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:49:08 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cwRRx-0001vL-Eb
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:49:05 -0400
Received: by mail-pg0-x243.google.com with SMTP id g2so14719326pge.2
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 03:49:05 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Fri,  7 Apr 2017 03:48:52 -0700
Message-Id: <1491562132-69066-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] 9pfs: xattr: fix memory leak in v9fs_list_xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: qemu-devel@nongnu.org, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

Free 'orig_value' in error path.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/9pfs/9p-xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index eec160b..d05c1a1 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -108,6 +108,7 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path,
     g_free(name);
     close_preserve_errno(dirfd);
     if (xattr_len < 0) {
+        g_free(orig_value);
         return -1;
     }
 
-- 
1.8.3.1
