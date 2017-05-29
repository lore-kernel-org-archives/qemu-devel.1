Received: from eggs.gnu.org ([2001:4830:134:3::10]:36153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGct-0001gW-Kg
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGco-0006CE-L1
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFGco-0006Br-Ab
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4T94H5L102873
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:05 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2arfakbjx5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:04 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 29 May 2017 10:06:02 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 29 May 2017 11:05:35 +0200
In-Reply-To: <1496048740-26578-1-git-send-email-groug@kaod.org>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
Message-Id: <1496048740-26578-7-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 06/11] 9pfs: assume utimensat() and futimens()
 are present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

The utimensat() and futimens() syscalls have been around for ages (ie,
glibc 2.6 and linux 2.6.22), and the decision was already taken to
switch to utimensat() anyway when fixing CVE-2016-9602 in 2.9.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 fsdev/virtfs-proxy-helper.c | 3 ++-
 hw/9pfs/9p-handle.c         | 5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 4c4238f62e53..6c066ec9a0ce 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -945,7 +945,8 @@ static int process_requests(int sock)
                                      &spec[0].tv_sec, &spec[0].tv_nsec,
                                      &spec[1].tv_sec, &spec[1].tv_nsec);
             if (retval > 0) {
-                retval = qemu_utimens(path.data, spec);
+                retval = utimensat(AT_FDCWD, path.data, spec,
+                                   AT_SYMLINK_NOFOLLOW);
                 if (retval < 0) {
                     retval = -errno;
                 }
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 1687661bc95a..9875f1894cc5 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -378,7 +378,6 @@ static int handle_utimensat(FsContext *ctx, V9fsPath *fs_path,
                             const struct timespec *buf)
 {
     int ret;
-#ifdef CONFIG_UTIMENSAT
     int fd;
     struct handle_data *data = (struct handle_data *)ctx->private;
 
@@ -388,10 +387,6 @@ static int handle_utimensat(FsContext *ctx, V9fsPath *fs_path,
     }
     ret = futimens(fd, buf);
     close(fd);
-#else
-    ret = -1;
-    errno = ENOSYS;
-#endif
     return ret;
 }
 
-- 
2.7.4
