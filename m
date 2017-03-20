Received: from eggs.gnu.org ([2001:4830:134:3::10]:40899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qi-0001fe-9H
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qd-0004uc-34
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47032
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qc-0004te-S1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Vor084308
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2ab47-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:29 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:58 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-35-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 34/81] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

We should pass O_NOFOLLOW otherwise openat() will follow symlinks and make
QEMU vulnerable.

While here, we also fix local_unlinkat_common() to use openat_dir() for
the same reasons (it was a leftover in the original patchset actually).

This fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit b003fc0d8aa5e7060dbf7e5862b8013c73857c7f)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 2 +-
 hw/9pfs/9p-util.h  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f282bb7..227de61 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -961,7 +961,7 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
         if (flags == AT_REMOVEDIR) {
             int fd;
 
-            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            fd = openat_dir(dirfd, name);
             if (fd == -1) {
                 goto err_out;
             }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index cb7b207..517027c 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -27,7 +27,8 @@ static inline int openat_dir(int dirfd, const char *name)
 #else
 #define OPENAT_DIR_O_PATH 0
 #endif
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | OPENAT_DIR_O_PATH);
+    return openat(dirfd, name,
+                  O_DIRECTORY | O_RDONLY | O_NOFOLLOW | OPENAT_DIR_O_PATH);
 }
 
 static inline int openat_file(int dirfd, const char *name, int flags,
-- 
2.7.4
