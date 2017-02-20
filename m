Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8m-0006QZ-K5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8j-0003eT-8X
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp8j-0003eL-1Z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:33 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcs87126955
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:32 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r012ptp2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:31 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:40:31 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:40:23 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760162344.31154.691252878759862885.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 08/29] 9pfs: local: lgetxattr: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

The local_lgetxattr() callback is vulnerable to symlink attacks because
it calls lgetxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch converts local_lgetxattr() to rely on opendir_nofollow() and
fgetxattrat_nofollow() instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-posix-acl.c  |   16 ++--------------
 hw/9pfs/9p-xattr-user.c |    8 +-------
 hw/9pfs/9p-xattr.c      |    8 +-------
 3 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index ec003181cd33..9435e27a368c 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -25,13 +25,7 @@
 static ssize_t mp_pacl_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, MAP_ACL_ACCESS, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, MAP_ACL_ACCESS, value, size);
 }
 
 static ssize_t mp_pacl_listxattr(FsContext *ctx, const char *path,
@@ -89,13 +83,7 @@ static int mp_pacl_removexattr(FsContext *ctx,
 static ssize_t mp_dacl_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, MAP_ACL_DEFAULT, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, MAP_ACL_DEFAULT, value, size);
 }
 
 static ssize_t mp_dacl_listxattr(FsContext *ctx, const char *path,
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index f87530c8b526..4071fbc4c086 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -20,9 +20,6 @@
 static ssize_t mp_user_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
     if (strncmp(name, "user.virtfs.", 12) == 0) {
         /*
          * Don't allow fetch of user.virtfs namesapce
@@ -31,10 +28,7 @@ static ssize_t mp_user_getxattr(FsContext *ctx, const char *path,
         errno = ENOATTR;
         return -1;
     }
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, name, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
 static ssize_t mp_user_listxattr(FsContext *ctx, const char *path,
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 62993624ff64..4c3c0046bd47 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -304,13 +304,7 @@ int v9fs_remove_xattr(FsContext *ctx,
 ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
                     void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, name, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
 int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
