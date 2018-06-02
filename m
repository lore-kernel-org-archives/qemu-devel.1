Received: from eggs.gnu.org ([2001:4830:134:3::10]:44433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6y-0007wa-Hu
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6v-0005mX-Sr
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:56 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:39436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPE6v-0005mB-Nu
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id g14-v6so10239920qkm.6
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 14:30:53 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat,  2 Jun 2018 17:29:36 -0400
Message-Id: <cb0205334adbf17155eeb172c4885e8f295fe5cc.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 2/5] 9p: xattr: Fix crashes due to free of
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

If the size returned from llistxattr/lgetxattr is 0, we skipped
the malloc call, leaving xattr.value uninitialized. However, this
value is later passed to `g_free` without any further checks,
causing an error. Fix that by always calling g_malloc unconditionally.
If `size` is 0, it will return NULL, which is safe to pass to g_free.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v2:
 * Fix another instance of the problematic pattern later in the same function.

 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d74302d..4386d69 100644
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
@@ -3289,8 +3289,8 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fs.xattr.len = size;
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
+        xattr_fidp->fs.xattr.value = g_malloc0(size);
         if (size) {
-            xattr_fidp->fs.xattr.value = g_malloc0(size);
             err = v9fs_co_lgetxattr(pdu, &xattr_fidp->path,
                                     &name, xattr_fidp->fs.xattr.value,
                                     xattr_fidp->fs.xattr.len);
-- 
2.8.1
