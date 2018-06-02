Received: from eggs.gnu.org ([2001:4830:134:3::10]:44475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE71-0007xr-Kl
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE70-0005pQ-M6
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPE70-0005pG-Hb
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:58 -0400
Received: by mail-qt0-x244.google.com with SMTP id q6-v6so2611766qtn.7
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 14:30:58 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat,  2 Jun 2018 17:29:39 -0400
Message-Id: <d2dc1eb0065de21e8223598051bb210697c4269c.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 5/5] 9p: xattr: Properly translate
 xattrcreate flags
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

As with unlinkat, these flags come from the client and need to
be translated to their host values. The protocol values happen
to match linux, but that need not be true in general.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v2: New patch

 hw/9pfs/9p.c | 17 +++++++++++++++--
 hw/9pfs/9p.h |  4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c842ec5..eef289e 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3327,7 +3327,7 @@ out_nofid:
 
 static void coroutine_fn v9fs_xattrcreate(void *opaque)
 {
-    int flags;
+    int flags, rflags = 0;
     int32_t fid;
     uint64_t size;
     ssize_t err = 0;
@@ -3344,6 +3344,19 @@ static void coroutine_fn v9fs_xattrcreate(void *opaque)
     }
     trace_v9fs_xattrcreate(pdu->tag, pdu->id, fid, name.data, size, flags);
 
+    if (flags & ~(P9_XATTR_CREATE | P9_XATTR_REPLACE)) {
+        err = -EINVAL;
+        goto out_nofid;
+    }
+
+    if (flags & P9_XATTR_CREATE) {
+        rflags |= XATTR_CREATE;
+    }
+
+    if (flags & P9_XATTR_REPLACE) {
+        rflags |= XATTR_REPLACE;
+    }
+
     if (size > XATTR_SIZE_MAX) {
         err = -E2BIG;
         goto out_nofid;
@@ -3365,7 +3378,7 @@ static void coroutine_fn v9fs_xattrcreate(void *opaque)
     xattr_fidp->fs.xattr.copied_len = 0;
     xattr_fidp->fs.xattr.xattrwalk_fid = false;
     xattr_fidp->fs.xattr.len = size;
-    xattr_fidp->fs.xattr.flags = flags;
+    xattr_fidp->fs.xattr.flags = rflags;
     v9fs_string_init(&xattr_fidp->fs.xattr.name);
     v9fs_string_copy(&xattr_fidp->fs.xattr.name, &name);
     xattr_fidp->fs.xattr.value = g_malloc0(size);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index bad8ee7..6081b0d 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -169,6 +169,10 @@ typedef struct V9fsConf
     char *fsdev_id;
 } V9fsConf;
 
+/* 9p2000.L xattr flags (matches Linux values) */
+#define P9_XATTR_CREATE 1
+#define P9_XATTR_REPLACE 2
+
 typedef struct V9fsXattr
 {
     uint64_t copied_len;
-- 
2.8.1
