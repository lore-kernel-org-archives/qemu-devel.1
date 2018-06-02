Received: from eggs.gnu.org ([2001:4830:134:3::10]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE70-0007wf-1s
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6z-0005oR-80
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPE6z-0005oF-2z
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:57 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so2611723qtn.7
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 14:30:57 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat,  2 Jun 2018 17:29:38 -0400
Message-Id: <437736e77ecd0d5ecd6bb430319a6b0e2dfb571d.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 4/5] 9p: Properly check/translate flags in
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

The 9p-local code previously relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR
having the same numerical value and deferred any errorchecking to the
syscall itself. However, while the former assumption is true on Linux,
it is not true in general. 9p-handle did this properly however. Move
the translation code to the generic 9p server code and add an error
if unrecognized flags are passed.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v2:
 * Remove 9p-handle code that did the same translation and is now incorrect.

 hw/9pfs/9p-handle.c |  8 +-------
 hw/9pfs/9p.c        | 13 +++++++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 4dc0d2b..f3641db 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -559,19 +559,13 @@ static int handle_unlinkat(FsContext *ctx, V9fsPath *dir,
 {
     int dirfd, ret;
     HandleData *data = (HandleData *) ctx->private;
-    int rflags;
 
     dirfd = open_by_handle(data->mountfd, dir->data, O_PATH);
     if (dirfd < 0) {
         return dirfd;
     }
 
-    rflags = 0;
-    if (flags & P9_DOTL_AT_REMOVEDIR) {
-        rflags |= AT_REMOVEDIR;
-    }
-
-    ret = unlinkat(dirfd, name, rflags);
+    ret = unlinkat(dirfd, name, flags);
 
     close(dirfd);
     return ret;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4386d69..c842ec5 100644
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
