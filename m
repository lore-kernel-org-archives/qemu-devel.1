Received: from eggs.gnu.org ([2001:4830:134:3::10]:37978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e475i-0000Qx-Gc
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e475c-0001Ki-AW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58070
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e475c-0001K7-4K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GFAJsr117232
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:13:58 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dmvgdhahn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:13:57 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 16 Oct 2017 16:13:56 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 16 Oct 2017 17:13:37 +0200
In-Reply-To: <20171016151337.4121-1-groug@kaod.org>
References: <20171016151337.4121-1-groug@kaod.org>
Message-Id: <20171016151337.4121-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/1] 9pfs: use g_malloc0 to allocate space for
 xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

9p back-end first queries the size of an extended attribute,
allocates space for it via g_malloc() and then retrieves its
value into allocated buffer. Race between querying attribute
size and retrieving its could lead to memory bytes disclosure.
Use g_malloc0() to avoid it.

Reported-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 23ac7bb532f0..f8bbac251dc9 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3234,7 +3234,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         if (size) {
-            xattr_fidp->fs.xattr.value = g_malloc(size);
+            xattr_fidp->fs.xattr.value = g_malloc0(size);
             err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
                                      xattr_fidp->fs.xattr.value,
                                      xattr_fidp->fs.xattr.len);
@@ -3267,7 +3267,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         if (size) {
-            xattr_fidp->fs.xattr.value = g_malloc(size);
+            xattr_fidp->fs.xattr.value = g_malloc0(size);
             err = v9fs_co_lgetxattr(pdu, &xattr_fidp->path,
                                     &name, xattr_fidp->fs.xattr.value,
                                     xattr_fidp->fs.xattr.len);
-- 
2.13.6
