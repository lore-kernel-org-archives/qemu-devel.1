Received: from eggs.gnu.org ([2001:4830:134:3::10]:57036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk5-00022W-U6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk1-0000S5-W1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44064
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwk1-0000NN-QL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJlCe105261
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5pew66q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:13 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:11 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:19 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-8-groug@kaod.org>
Subject: [Qemu-devel] [PULL 7/7] 9p: xattr: Properly translate xattrcreate
 flags
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

As with unlinkat, these flags come from the client and need to
be translated to their host values. The protocol values happen
to match linux, but that need not be true in general.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 17 +++++++++++++++--
 hw/9pfs/9p.h |  4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c842ec555ea1..eef289e394d4 100644
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
index bad8ee719c4b..8883761b2c1d 100644
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
2.14.4
