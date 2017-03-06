Received: from eggs.gnu.org ([2001:4830:134:3::10]:50709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqR-0005Qg-Of
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqO-0005fn-Is
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53312
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwqO-0005fh-C2
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26Hrcre042226
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 290bhnngt8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:47 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:45 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:10 +0100
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
Message-Id: <1488822850-23070-7-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 6/6] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

We should pass O_NOFOLLOW otherwise openat() will follow symlinks and make
QEMU vulnerable.

While here, we also fix local_unlinkat_common() to use openat_dir() for
the same reasons (it was a leftover in the original patchset actually).

This fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p-local.c | 2 +-
 hw/9pfs/9p-util.h  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0ca4c94ee4a8..45e9a1f9b0ca 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -960,7 +960,7 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
         if (flags == AT_REMOVEDIR) {
             int fd;
 
-            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            fd = openat_dir(dirfd, name);
             if (fd == -1) {
                 goto err_out;
             }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index cb7b2072d3ac..517027c52032 100644
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
