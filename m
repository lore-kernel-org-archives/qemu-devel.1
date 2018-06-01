Received: from eggs.gnu.org ([2001:4830:134:3::10]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqs-0002wl-Mn
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqq-0002sA-By
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:34 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqq-0002ri-7W
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so30289075qtn.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:32 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:25:58 -0400
Message-Id: <d837331570879a9fe9e4f1e466905213099f7bf0.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 03/20] 9p: xattr: Fix crash due to free of
 uninitialized value
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

If the size returned from llistxattr is 0, we skipped the malloc
call, leaving xattr.value uninitialized. However, this value is
later passed to `g_free` without any further checks, causing an
error. Fix that by always calling g_malloc unconditionally. If
`size` is 0, it will return a pointer that is safe to pass to g_free,
likely NULL.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1: New patch

 hw/9pfs/9p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d74302d..b80db65 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3256,8 +3256,8 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fs.xattr.len = size;
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
+        xattr_fidp->fs.xattr.value = g_malloc0(size);
         if (size) {
-            xattr_fidp->fs.xattr.value = g_malloc0(size);
             err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
                                      xattr_fidp->fs.xattr.value,
                                      xattr_fidp->fs.xattr.len);
-- 
2.8.1
