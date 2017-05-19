Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBjEu-0004LH-CE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBjEr-0004Kh-9I
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44299
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBjEr-0004KV-39
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JETp9i139833
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:50:44 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aj2cah9qr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:50:44 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 10:50:43 -0400
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 16:50:38 +0200
In-Reply-To: <149520531371.9327.383828886525307842.stgit@bahia>
References: <149520531371.9327.383828886525307842.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149520543823.9327.7184796595968970706.stgit@bahia>
Subject: [Qemu-devel] [PATCH 1/2] 9pfs: assume utimensat() and futimens()
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
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

The utimensat() and futimens() syscalls have been around for ages (ie,
glibc 2.6 and linux 2.6.22), and the decision was already taken to
switch to utimensat() anyway when fixing CVE-2016-9602 in 2.9.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/virtfs-proxy-helper.c |    3 ++-
 hw/9pfs/9p-handle.c         |    5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 54f7ad1c48f0..617e19cd0b88 100644
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
 
