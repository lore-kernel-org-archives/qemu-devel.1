Received: from eggs.gnu.org ([2001:4830:134:3::10]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjz-0001yr-FX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjv-0000OC-GW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41468
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwjv-0000Ny-Aj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJHST083868
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jf6vh9be4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:10 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:09 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:16 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-5-groug@kaod.org>
Subject: [Qemu-devel] [PULL 4/7] 9p: xattr: Fix crashes due to free of
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

If the size returned from llistxattr/lgetxattr is 0, we skipped
the malloc call, leaving xattr.value uninitialized. However, this
value is later passed to `g_free` without any further checks,
causing an error. Fix that by always calling g_malloc unconditionally.
If `size` is 0, it will return NULL, which is safe to pass to g_free.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d74302deeba5..4386d698177b 100644
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
2.14.4
