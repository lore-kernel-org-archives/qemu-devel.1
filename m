Received: from eggs.gnu.org ([2001:4830:134:3::10]:56967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjz-0001yq-FW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjw-0000Og-1j
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwjv-0000OI-SG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJD7h007749
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5ffx9ge-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:14 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:13 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:18 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-7-groug@kaod.org>
Subject: [Qemu-devel] [PULL 6/7] 9p: Properly check/translate flags in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

The 9p-local code previously relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR
having the same numerical value and deferred any errorchecking to the
syscall itself. However, while the former assumption is true on Linux,
it is not true in general. 9p-handle did this properly however. Move
the translation code to the generic 9p server code and add an error
if unrecognized flags are passed.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-handle.c |  8 +-------
 hw/9pfs/9p.c        | 13 +++++++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 4dc0d2bed1c1..f3641dbe4a92 100644
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
index 4386d698177b..c842ec555ea1 100644
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
2.14.4
