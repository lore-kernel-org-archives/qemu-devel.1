Received: from eggs.gnu.org ([2001:4830:134:3::10]:50676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqO-0005Pa-Kv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqL-0005fD-Ft
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36398
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwqL-0005f7-8m
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26HraCp063901
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2918mm4fwt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:43 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:41 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:09 +0100
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
Message-Id: <1488822850-23070-6-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 5/6] 9pfs: fix O_PATH build break with older
 glibc versions
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

When O_PATH is used with O_DIRECTORY, it only acts as an optimization: the
openat() syscall simply finds the name in the VFS, and doesn't trigger the
underlying filesystem.

On systems that don't define O_PATH, because they have glibc version 2.13
or older for example, we can safely omit it. We don't want to deactivate
O_PATH globally though, in case it is used without O_DIRECTORY. The is done
with a dedicated macro.

Systems without O_PATH may thus fail to resolve names that involve
unreadable directories, compared to newer systems succeeding, but such
corner case failure is our only option on those older systems to avoid
the security hole of chasing symlinks inappropriately.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
(added last paragraph to changelog as suggested by Eric Blake)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce88e15..cb7b2072d3ac 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -22,7 +22,12 @@ static inline void close_preserve_errno(int fd)
 
 static inline int openat_dir(int dirfd, const char *name)
 {
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+#ifdef O_PATH
+#define OPENAT_DIR_O_PATH O_PATH
+#else
+#define OPENAT_DIR_O_PATH 0
+#endif
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | OPENAT_DIR_O_PATH);
 }
 
 static inline int openat_file(int dirfd, const char *name, int flags,
-- 
2.7.4
