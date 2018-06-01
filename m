Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr3-00033n-3n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqz-000333-L5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:45 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqz-00032X-GU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:41 -0400
Received: by mail-qk0-x241.google.com with SMTP id j80-v6so16999940qke.9
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:41 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:04 -0400
Message-Id: <21ef05f216f09056c252d2d23a18dd75008e8c72.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 09/20] 9p: Properly check/translate flags in
 unlinkat
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

This code previously relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR
having the same numerical value and deferred any errorchecking to the
syscall itself. However, while the former assumption is true on Linux,
it is not true in general. Thus, add appropriate error checking and
translation to the 9p unlinkat server code.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1:
 * Code was moved from 9p-local.c to server entry point in 9p.c

 hw/9pfs/9p.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b80db65..a757374 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2522,7 +2522,7 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
 {
     int err = 0;
     V9fsString name;
-    int32_t dfid, flags;
+    int32_t dfid, flags, rflags = 0;
     size_t offset = 7;
     V9fsPath path;
     V9fsFidState *dfidp;
@@ -2549,6 +2549,15 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
         goto out_nofid;
     }
 
+    if (flags & ~P9_DOTL_AT_REMOVEDIR) {
+        err = -EINVAL;
+        goto out_nofid;
+    }
+
+    if (flags & P9_DOTL_AT_REMOVEDIR) {
+        rflags |= AT_REMOVEDIR;
+    }
+
     dfidp = get_fid(pdu, dfid);
     if (dfidp == NULL) {
         err = -EINVAL;
@@ -2567,7 +2576,7 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
     if (err < 0) {
         goto out_err;
     }
-    err = v9fs_co_unlinkat(pdu, &dfidp->path, &name, flags);
+    err = v9fs_co_unlinkat(pdu, &dfidp->path, &name, rflags);
     if (!err) {
         err = offset;
     }
-- 
2.8.1
