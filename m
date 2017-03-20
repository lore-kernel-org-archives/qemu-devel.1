Received: from eggs.gnu.org ([2001:4830:134:3::10]:40789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qh-0001dq-5U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qb-0004sY-EM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qb-0004ra-5H
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Wkv125171
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:28 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ajjr0e3g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:28 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:27 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:57 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-34-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 33/81] 9pfs: fix O_PATH build break with older
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

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

(cherry picked from commit 918112c02aff2bac4cb72dc2feba0cb05305813e)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-util.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce..cb7b207 100644
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
