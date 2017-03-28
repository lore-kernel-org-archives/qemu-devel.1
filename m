Received: from eggs.gnu.org ([2001:4830:134:3::10]:37430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmX-00059U-9m
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmU-0005BD-2n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csmmT-0005Aj-PW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8hhh5057052
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:47:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fm1jtbww-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:47:06 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Mar 2017 09:47:01 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Mar 2017 10:46:33 +0200
In-Reply-To: <1490690794-19023-1-git-send-email-groug@kaod.org>
References: <1490690794-19023-1-git-send-email-groug@kaod.org>
Message-Id: <1490690794-19023-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/2] 9pfs: fix file descriptor leak
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

The v9fs_create() and v9fs_lcreate() functions are used to create a file
on the backend and to associate it to a fid. The fid shouldn't be already
in-use, otherwise both functions may silently leak a file descriptor or
allocated memory. The current code doesn't check that.

This patch ensures that the fid isn't already associated to anything
before using it.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
(reworded the changelog, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b8c0b993580c..48babce836b6 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1550,6 +1550,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (fidp->fid_type != P9_FID_NONE) {
+        err = -EINVAL;
+        goto out;
+    }
 
     flags = get_dotl_openflags(pdu->s, flags);
     err = v9fs_co_open2(pdu, fidp, &name, gid,
@@ -2153,6 +2157,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         err = -EINVAL;
         goto out_nofid;
     }
+    if (fidp->fid_type != P9_FID_NONE) {
+        err = -EINVAL;
+        goto out;
+    }
     if (perm & P9_STAT_MODE_DIR) {
         err = v9fs_co_mkdir(pdu, fidp, &name, perm & 0777,
                             fidp->uid, -1, &stbuf);
-- 
2.7.4
