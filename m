Received: from eggs.gnu.org ([2001:4830:134:3::10]:49984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxaCa-0000kh-2s
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxaCW-0003Xk-5b
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42055
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxaCV-0003Xb-Uk
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3AEDvBD109808
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:21:51 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29r9qveemk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:21:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 10 Apr 2017 15:21:49 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 10 Apr 2017 16:21:35 +0200
In-Reply-To: <1491834095-6476-1-git-send-email-groug@kaod.org>
References: <1491834095-6476-1-git-send-email-groug@kaod.org>
Message-Id: <1491834095-6476-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL] 9pfs: xattr: fix memory leak in v9fs_list_xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liq3ea@gmail.com>

Free 'orig_value' in error path.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index eec160b3c2ac..d05c1a1c1df5 100644
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
2.7.4
