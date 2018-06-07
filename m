Received: from eggs.gnu.org ([2001:4830:134:3::10]:56980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk0-0001zP-2e
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjw-0000Ot-4u
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39348
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwjv-0000LR-Vy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJAgj105822
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5mhdnt1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:08 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:06 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:14 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/7] 9p: local: Properly set errp in fstatfs
 error path
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

In the review of

    9p: Avoid warning if FS_IOC_GETVERSION is not defined

Grep Kurz noted this error path was failing to set errp.
Fix that.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
[added local: to commit title, Greg Kurz]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b37b1db453da..7758c3850900 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1418,6 +1418,8 @@ static int local_init(FsContext *ctx, Error **errp)
      */
     if (fstatfs(data->mountfd, &stbuf) < 0) {
         close_preserve_errno(data->mountfd);
+        error_setg_errno(errp, errno,
+            "failed to stat file system at '%s'", ctx->fs_root);
         goto err;
     }
     switch (stbuf.f_type) {
-- 
2.14.4
