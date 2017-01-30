Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAqe-00007M-Ur
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAqb-000126-RC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAqb-00011w-H5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:13 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCDXos124083
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:12 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a119jcay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:12 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:14:11 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:14:04 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577844477.10533.14637643179764541959.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 35/36] 9pfs: local: lsetxattr: don't follow
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
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-posix-acl.c  |   18 ++++--------------
 hw/9pfs/9p-xattr-user.c |    8 +-------
 hw/9pfs/9p-xattr.c      |    8 +-------
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 9435e27a368c..0154e2a7605f 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -50,13 +50,8 @@ static ssize_t mp_pacl_listxattr(FsContext *ctx, const char *path,
 static int mp_pacl_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, MAP_ACL_ACCESS, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, MAP_ACL_ACCESS, value, size,
+                                   flags);
 }
 
 static int mp_pacl_removexattr(FsContext *ctx,
@@ -108,13 +103,8 @@ static ssize_t mp_dacl_listxattr(FsContext *ctx, const char *path,
 static int mp_dacl_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, MAP_ACL_DEFAULT, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, MAP_ACL_DEFAULT, value, size,
+                                   flags);
 }
 
 static int mp_dacl_removexattr(FsContext *ctx,
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index 4071fbc4c086..1840a5db66f3 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -67,9 +67,6 @@ static ssize_t mp_user_listxattr(FsContext *ctx, const char *path,
 static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
     if (strncmp(name, "user.virtfs.", 12) == 0) {
         /*
          * Don't allow fetch of user.virtfs namesapce
@@ -78,10 +75,7 @@ static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
         errno = EACCES;
         return -1;
     }
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, name, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
 static int mp_user_removexattr(FsContext *ctx,
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 08df02e0bab2..053ab6eff692 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -326,13 +326,7 @@ ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
 int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
                 size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, name, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
 int pt_removexattr(FsContext *ctx, const char *path, const char *name)
